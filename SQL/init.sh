#!/bin/bash
set -e

echo "Waiting for Oracle to be ready..."
until echo "SELECT 1 FROM DUAL;" | sqlplus -s SYS/${ORACLE_PWD}@XE > /dev/null 2>&1; do
  sleep 5
done

echo "Creating database users..."

sqlplus -s SYS/${ORACLE_PWD}@XE <<EOF
-- Create users
CREATE USER java_user IDENTIFIED BY ${LOGIN_DB_PASSWORD};
CREATE USER csc_cocktails IDENTIFIED BY ${APP_DB_PASSWORD};

-- Grant privileges
GRANT CONNECT, RESOURCE, CREATE SESSION TO java_user;
GRANT CONNECT, RESOURCE, CREATE SESSION TO csc_cocktails;
GRANT UNLIMITED TABLESPACE TO java_user;
GRANT UNLIMITED TABLESPACE TO csc_cocktails;
GRANT CREATE TABLE TO java_user;
GRANT CREATE TABLE TO csc_cocktails;

EXIT;
EOF

echo "Running schema setup scripts..."
sqlplus -s java_user/${LOGIN_DB_PASSWORD}@XE @/docker-entrypoint-initdb.d/01-login-schema.sql
sqlplus -s csc_cocktails/${APP_DB_PASSWORD}@XE @/docker-entrypoint-initdb.d/02-app-schema.sql

echo "Database initialization complete!"