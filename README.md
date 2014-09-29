#Roster

### Requirements:
1. Ruby v. 2.1.1
2. Rails v. 4.1.1
3. PostgreSQL v.9.3.3

### Setting up the database:
1. Set up your database admin role in PostgreSQL:
    `CREATE ROLE roster_admin WITH PASSWORD 'roster_admin' CREATEDB LOGIN;`
2. Migrate your database: `rake db:create db:migrate db:seed`