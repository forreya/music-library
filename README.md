# Music Library Database System

_**This is a music library system that uses PostgreSQL to store, update, delete & display data on various albums & artists.**_

## Used components:

* **Ruby and RSpec**  
  The programming language and test framework.
* **The `pg` gem**  
  This gem is used to send SQL queries to the database, and retrieve result sets.
* **A class `DatabaseConnection`**  
  This class acts as a thin layer with methods to connect to PostgreSQL and send SQL queries to it.

## How to use:

#### Create the 'music_library' database on your system

```
$ cd music-library
$ psql -h 127.0.0.1
$ CREATE DATABASE music_library
```

#### Seed the 'music_library' database

```
$ psql -h 127.0.0.1 music_library < ./seeds/music_database.sql
```

#### Run the app

```
$ ruby app.rb
```