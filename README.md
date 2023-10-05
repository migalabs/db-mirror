# db-mirror
Docker Compose to mirror our databases



# Source db
## Env file

Replica user credentials must be configured.
Also, please configure the public port for the database


## Execution

### Step 1. Launch the `source-db` service.
This process will create the database folder and will initialize the service. If you already have a running database, please move to `./data/source_db`

### Step 2. Launch the `source-db-setup` service.
This process will modify the `postgresql.conf` file and the `pg_hba.conf` file. It will also create the replica user.

### Step 3. Restart `source-db` service so changes take effect.
Some of the step 2 changes need a restart, please restart the container

# Mirror db
## Env file

Replica user credentials must be configured.
Also, please configure the public port for the database.
Additionally, one must configure the host and port where the source database is hosted. Keep in mind the container needs access to it.

## Execution
### Step 1. Launch the `mirror-db-setup` service
This process should backup the source database and create the folder with the needed configuration.

### Step 2. Launch the `mirror-db` service
