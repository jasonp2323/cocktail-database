FROM container-registry.oracle.com/database/express:21.3.0-xe

# Copy files
# COPY init.sh /docker-entrypoint-initdb.d/
COPY 01-login-schema.sql /docker-entrypoint-initdb.d/
COPY 02-app-schema.sql /docker-entrypoint-initdb.d/

# Change ownership to oracle user and make executable
# USER root
# RUN chmod +x /opt/oracle/scripts/startup/init.sh


ENV ORACLE_CHARACTERSET=AL32UTF8