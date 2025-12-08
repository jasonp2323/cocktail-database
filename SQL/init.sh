#!/bin/bash
set -e

# Create a log file
LOGFILE=/tmp/init-script.log
echo "===== Init script started at $(date) =====" > $LOGFILE

echo "Waiting for Oracle to be ready..." | tee -a $LOGFILE
for i in {1..30}; do
  if echo "SELECT 1 FROM DUAL;" | sqlplus -s system/${ORACLE_PWD}@XE >/dev/null 2>&1; then
    echo "Oracle is ready!" | tee -a $LOGFILE
    break
  fi
  echo "Attempt $i: Oracle not ready yet, waiting..." | tee -a $LOGFILE
  sleep 10
done

echo "Creating database users..." | tee -a $LOGFILE
sqlplus system/${ORACLE_PWD}@XE >> $LOGFILE 2>&1 <<EOF
CREATE USER java_user IDENTIFIED BY ${LOGIN_DB_PASSWORD};
CREATE USER csc_cocktails IDENTIFIED BY ${APP_DB_PASSWORD};
GRANT CONNECT, RESOURCE, CREATE SESSION TO java_user;
GRANT CONNECT, RESOURCE, CREATE SESSION TO csc_cocktails;
GRANT UNLIMITED TABLESPACE TO java_user;
GRANT UNLIMITED TABLESPACE TO csc_cocktails;
GRANT CREATE TABLE TO java_user;
GRANT CREATE TABLE TO csc_cocktails;
EXIT;
EOF

echo "Running schema setup scripts..." | tee -a $LOGFILE
sqlplus java_user/${LOGIN_DB_PASSWORD}@XE @/docker-entrypoint-initdb.d/01-login-schema.sql >> $LOGFILE 2>&1
sqlplus csc_cocktails/${APP_DB_PASSWORD}@XE @/docker-entrypoint-initdb.d/02-app-schema.sql >> $LOGFILE 2>&1

echo "===== Database initialization complete at $(date) =====" | tee -a $LOGFILE