# Project review app

mono repository
 
## Server side

Requirements: 
- [golang](https://go.dev/dl/) 1.18 or high 
- [posgresql](https://www.postgresql.org/download/)

### build & run

Run shell commands on root path on server project 

### Get requirements

`go tidy`

### Run project

`go run main.go`

## Client side

Requirements:
- flutter 3.0 or high

### Run project

`flutter run -d {target platform}`

### Rebuild auto-generated code

`flutter pub run build_runner build --delete-conflicting-outputs`