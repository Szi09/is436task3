# Database Setup Guide

This guide explains how to set up and run the MySQL database for this project using Docker Compose.

## Prerequisites
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed
- [Docker Compose](https://docs.docker.com/compose/) (included with Docker Desktop)

## Files Overview
- `docker-compose.yaml`: Defines the MySQL service, volumes, network, and health check.
- `.env`: Stores sensitive MySQL credentials and configuration variables.
- `initdb/`: Place any SQL scripts here to initialize the database automatically on first run.

## Steps

### 1. Configure Environment Variables
Edit the `.env` file in the `database/` folder to set your database name, user, and passwords:

```
MYSQL_DATABASE=IS436
MYSQL_USER=user
MYSQL_PASSWORD=your_secure_password
MYSQL_ROOT_PASSWORD=your_secure_root_password
```

### 2. (Optional) Add Initialization Scripts
Place any `.sql` files you want to run on first startup in the `initdb/` directory. These scripts will be executed automatically by MySQL.

### 3. Start the Database
Open a terminal in the `database/` directory and run:

```
docker compose up -d --build
```

- This will build and start the MySQL container in the background.
- The database will be accessible on port 3307 of your host machine.

### 4. Check Database Health
Docker Compose includes a health check for MySQL. To see the health status:

```
docker ps
```
- Look for the `STATUS` column. If it says `(healthy)`, the database is ready.
- If it says `(unhealthy)`, check your configuration or logs.

To see detailed health check logs:
```
docker inspect --format='{{json .State.Health}}' mysql-IS436
```

### 5. Stopping and Removing the Database
To stop the database:
```
docker compose down
```
This will stop and remove the container, but your data will persist in the `db_data` volume.

### 6. Resetting the Database
To remove all data and start fresh:
```
docker compose down -v
```
This will delete the container and the persistent data volume.

## 7. Accessing the Database Using MySQL Client

You can connect to the running MySQL database using the MySQL client from your host machine or from inside the container.

### Option 1: Using MySQL Client Installed on Your Host

1. Make sure you have the MySQL client installed. You can download it from https://dev.mysql.com/downloads/mysql/.
2. Run the following command in your terminal (replace `user` and `your_secure_password` with your actual credentials):

```
mysql -h 127.0.0.1 -P 3307 -u user -p
```
- When prompted, enter your password (`your_secure_password`).
- You should now be connected to the `IS436` database.

### Option 2: Using MySQL Client from Inside the Container

1. Open a shell inside the running MySQL container:
```
docker exec -it mysql-IS436 sh
```
2. Connect to MySQL using the client inside the container:
```
mysql -u user -p
```
- Enter your password when prompted.

### Option 3: Using MySQL Workbench or Other GUI Tools

- Hostname: 127.0.0.1
- Port: 3307
- Username: user
- Password: your_secure_password
- Database: IS436

You can use these settings to connect with MySQL Workbench, DBeaver, or any other database GUI tool.

### Option 4: Accessing the Database Using MySQL Workbench (GUI)

1. Download and install [MySQL Workbench](https://dev.mysql.com/downloads/workbench/) if you don't have it already.
2. Open MySQL Workbench and click the "+" button next to "MySQL Connections" to create a new connection.
3. Fill in the connection details:
   - **Connection Name:** IS436 (or any name you like)
   - **Hostname:** 127.0.0.1
   - **Port:** 3307
   - **Username:** user
   - **Password:** Click "Store in Vault..." and enter your password (`your_secure_password`)
4. Click "Test Connection" to verify the connection works.
5. Click "OK" to save the connection.
6. Double-click your new connection to connect to the database. You can now browse tables, run queries, and manage your database using the GUI.

#### MySQL Workbench GUI Example Screenshots (Placeholders)

Below are example placeholders for what you will see in MySQL Workbench at each step. Replace these with your own screenshots if needed.

1. **Create New Connection**
   
   ![Create New Connection - MySQL Workbench](https://raw.githubusercontent.com/placeholder/mysql-workbench-new-connection.png)
   
   _You will see a dialog to enter connection details. Fill in Hostname, Port, Username, and Password as described above._

2. **Test Connection**
   
   ![Test Connection - MySQL Workbench](https://raw.githubusercontent.com/placeholder/mysql-workbench-test-connection.png)
   
   _Click "Test Connection" to verify your settings. You should see a success message if everything is correct._

3. **Connected to Database**
   
   ![Connected - MySQL Workbench](https://raw.githubusercontent.com/placeholder/mysql-workbench-connected.png)
   
   _Once connected, you can browse your database, tables, and run SQL queries using the GUI._

## Notes
- The database data is stored in a Docker volume named `db_data` for persistence.
- The health check ensures the database is running and ready before other services connect.
- Never commit your real passwords to version control. The `.env` file should be in `.gitignore`.

---
