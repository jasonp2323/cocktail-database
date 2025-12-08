FROM container-registry.oracle.com/database/express:21.3.0-xe

# Copy initialization scripts
COPY init.sh /docker-entrypoint-initdb.d/
COPY 01-login-schema.sql /docker-entrypoint-initdb.d/
COPY 02-app-schema.sql /docker-entrypoint-initdb.d/

# Make init script executable
RUN chmod +x /docker-entrypoint-initdb.d/init.sh

ENV ORACLE_CHARACTERSET=AL32UTF8