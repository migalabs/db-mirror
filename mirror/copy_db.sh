#!/bin/bash

PGPASSWORD=$REPLICA_PASSWORD pg_basebackup \
	-h $SOURCE_HOST \
	-p $SOURCE_PORT \
	-U $REPLICA_USERNAME \
	-X stream \
	-C \
	-S replica_1 \
	-v -R -W \
	-D /var/lib/postgresql/data

echo "Keep in mind the same host and port configured here will be used inside he container."
echo "This might need to be chanaged it the source db is located in the same machine"
echo "In that case, please view the ./data/mirror_db/postgresql.auto.conf file"

# docker-compose up -d mirror-db
