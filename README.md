# Bash DBMS

## Description

- This project was made as a requirement to pass the bash scripting course in the intensive code camp
  DevOps track in ITI.
- It is a database management system that is made entirely with Bash scripting.

## Features

1. create database
2. drop database
3. list available databases
4. create table with primary keys support
5. drop table
6. insert into table
7. update table records
8. delete values from table
9. delete records from tables
10. select table
11. select certain columns from a table
12. live preview a table

## To fire it up

1. navigate to the directory final_project
2. make sure the files has the execute premission by typing `ls -l`
3. if they don't have execute permission run `chmod u+x .`
4. run the main_menu.sh: `./main_menu.sh`
5. voila! now the application is running

## Validation rules

### Database

1. The first character must be within the range 0-9a-zA-Z\_ characters
2. The rest of the name will be within a-zA-Z\_ characters range
3. The name can't be empty

### Table

1. The first character must be within the range 0-9a-zA-Z\_ characters
2. The rest of the name will be within a-zA-Z\_ characters range
3. The name can't be empty

### Table columns

1. The first character must be within the range 0-9a-zA-Z\_ characters
2. The rest of the name will be within a-zA-Z\_ characters range
3. The name can't be empty

### Column types

1. Integer represented by an i character to store digits
2. String repesented by an s character to store a series of characters as a string

### Database

## Authors

[Bassem Kamel](https://www.linkedin.com/in/bassem-kamel-22900) &
[Alaa Ahmed Amin](https://www.linkedin.com/in/alaaamin-swe/)
