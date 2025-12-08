#!/bin/bash
set -e

echo "Creating database users..."
sqlplus sqlplus system/${ORACLE_PWD}@XEPDB1 <<EOF
CREATE USER java_user IDENTIFIED BY ${LOGIN_DB_PASSWORD};
CREATE USER csc_cocktails IDENTIFIED BY ${APP_DB_PASSWORD};
GRANT CONNECT, RESOURCE, CREATE SESSION TO java_user;
GRANT CONNECT, RESOURCE, CREATE SESSION TO csc_cocktails;
GRANT UNLIMITED TABLESPACE TO java_user;
GRANT CREATE TABLE TO java_user;
GRANT CREATE TABLE TO csc_cocktails;
EXIT;
EOF

echo "Database initialization complete!"