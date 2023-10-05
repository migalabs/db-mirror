#!/bin/bash
# Override configuration

echo "Overriding the postgresql conf"

sed -i -e 's/wal_level/# wal_level/g' /var/lib/postgresql/data/postgresql.conf
sed -i -e 's/wal_log_hints/# wal_log_hints/g' /var/lib/postgresql/data/postgresql.conf
sed -i -e 's/max_wal_senders/# max_wal_senders/g' /var/lib/postgresql/data/postgresql.conf
sed -i -e 's/max_wal_size/# max_wal_size/g' /var/lib/postgresql/data/postgresql.conf
sed -i -e 's/hot_standby/# hot_standby/g' /var/lib/postgresql/data/postgresql.conf

echo "wal_level = logical" >> /var/lib/postgresql/data/postgresql.conf
echo "wal_log_hints = on" >> /var/lib/postgresql/data/postgresql.conf
echo "max_wal_senders = 8" >> /var/lib/postgresql/data/postgresql.conf
echo "max_wal_size = 1GB" >> /var/lib/postgresql/data/postgresql.conf
echo "hot_standby = on" >> /var/lib/postgresql/data/postgresql.conf

# Add pg_hba conf entry

echo "Overriding the pg_hba conf"

echo "host replication $REPLICA_USERNAME 0.0.0.0/0 md5" >> /var/lib/postgresql/data/pg_hba.conf

# Create Replica user

echo "Creating replica user"

echo "CREATE USER $REPLICA_USERNAME REPLICATION LOGIN ENCRYPTED PASSWORD '$REPLICA_PASSWORD';" | PGPASSWORD=$POSTGRES_PASSWORD psql -h source-db -U user


echo "select pg_reload_conf();" | PGPASSWORD=$POSTGRES_PASSWORD psql -h source-db -U user
