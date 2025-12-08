FROM container-registry.oracle.com/database/express:21.3.0-xe

# Copy initialization scripts
COPY SQL/init.sh /docker-entrypoint-initdb.d/
COPY SQL/01-login-schema.sql /docker-entrypoint-initdb.d/
COPY SQL/02-app-schema.sql /docker-entrypoint-initdb.d/

# Make init script executable
RUN chmod +x /docker-entrypoint-initdb.d/init.sh

ENV ORACLE_CHARACTERSET=AL32UTF8