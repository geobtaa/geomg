# GEOMG

An experimental UI for administering BTAA Geoblacklight JSON documents.

## Requirements

* Ruby 2.7+
* Ruby on Rails 6+
* Yarn
* Bundler
* PostgreSQL 12+

## Installation

* clone repo
* yarn install
* bundle
* bundle exec rails db:create
* bundle exec rails db:migrate
* RAILS_ENV=test bundle exec rails db:migrate

## Development

Run Solr and Rails server:

```bash
bundle exec rake geomg:server
```

Run test suite:

```bash
bundle exec rake ci
```

## TODOS

* Basic BTAA/GBL Form
  - Better labels
  - Form validation
  - -Input datepickers-
  - Controlled vocabulary lists

* Test Suite
* Auth (Devise)
* Document Versioning (Paper Trail)
* Search
* CSV Import Workflow

## PostgreSQL Notes

### Via Homebrew
* brew install postgresql
* brew services start postgresql

### Via Docker
This basic setup does not preserve postgresql data! When the container is stopped, data will be purged.

```
# Start a postgres image named "geomg-postgres" on the local interface
# and a password "mysecretpassword"
$ docker run --name geomg-postgres -p127.0.0.1:5432:5432 -e POSTGRES_PASSWORD=mysecretpassword -d postgres
```
Sample `config/database.yml` for docker connectivity:
```yaml
development:
  adapter: postgresql
  encoding: unicode
  database: geomg_development
  pool: 5
  username: postgres
  password: mysecretpassword
  hostname: 127.0.0.1
  host: 127.0.0.1
  port: 5432
```

### Common database initialization

```
$ bundle exec rails db:create
$ bundle exec rails db:migrate
$ RAILS_ENV=test bundle exec rails db:migrate
```
