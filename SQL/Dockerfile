FROM container-registry.oracle.com/database/express:21.3.0-xe

COPY 00-setup.sql /docker-entrypoint-initdb.d/

ENV ORACLE_CHARACTERSET=AL32UTF8