# Server side

Requirements: 
- [golang](https://go.dev/dl/) 1.18 or high 
- [posgresql](https://www.postgresql.org/download/)
- [Insomnia](https://insomnia.rest/)

## Getting Started

- Create database in pgAdmin

- Create `.env` file from `.envexample`

By example .env

```
JWT='JFASDHUb32d38B'            # random string
DB_USER=postgres                # postgres admin username
DB_PASSWORD=yanachemto          # postgres admin password
DB_ADDRESS=127.0.0.1:5432       # postgres address 
DB_NAME=reviewdb                # database name
```

## Build & run

Run shell commands on root path on server project 

### Get requirements

`go tidy`

### Run project

`go run main.go`

## Test API in Insomnia rest

- open Insomnia and create new project
- click on project name, select `import/export`
- chose `insomnia_config.json` in this project folder