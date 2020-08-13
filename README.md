# GEOMG

An experimental UI for administering BTAA Geoblacklight JSON documents.

![geomg](https://user-images.githubusercontent.com/69827/84302126-7940a300-ab1a-11ea-9cfc-9dd3c48a0cee.gif)

## Requirements

* Ruby 2.7+
* Ruby on Rails 6+
* Bundler
* Yarn (JS)
* PostgreSQL 12+ (Kithe datastore)
* Apache Solr  (GeoBlacklight index)
* Redis / Sidekiq (Background queue)

## Installation

* clone repo
* yarn install
* bundle
* bundle exec rails db:create
* bundle exec rails db:migrate
* RAILS_ENV=test bundle exec rails db:migrate
* Update dotenv files

## Development

### Run the app

1. Run Solr and Rails server:

```bash
bundle exec rake geomg:server
```

2. Run the BTAA/B1G Geoportal on port 3001
```bash
cd ~/Rails/geoportal
bundle exec rails server --port=3001
```

3. Open [localhost:3000](http://localhost:3000)


### Test suite

Run test suite:

```bash
bundle exec rake ci
```

## TODOS

* Basic BTAA/GBL Form
  - -Better labels (via I18n)-
  - -Form validation-
  - -Input datepickers-
  - Controlled vocabulary lists

* Document Versioning
  - -Paper Trail-

* CSV Import Workflow
  - -BTAA CSV-
  - SOLR CSV
  - DCAT CSV

* Auth (Devise)
  - Remove registerable
  - Add invitable
  - Seed initial users

* Search
  - -Via Blacklight JSON-API-

* Test Suite

* Publish/Unpublish Toggle
  - -Add Admin::API controller to Geoportal (plugin candidate)-
  - Add published boolean attribute
  - Add default filter for Geoportal's CatalogController

## PostgreSQL Notes

### Via Homebrew
* brew install postgresql
* brew services start postgresql

### Via Docker
This basic setup does not preserve postgresql data! When the container is stopped, data will be purged.

#### One-off Postgresql docker container
```
# Start a postgres image named "geomg-postgres" on the local interface
# and a password "mysecretpassword"
$ docker run --name geomg-postgres -p127.0.0.1:5432:5432 -e POSTGRES_PASSWORD=mysecretpassword -d postgres
```

#### Persistent development database with docker-compose
Requires installation of`docker-compose`

```
# Start postgresql with a persistent data volume via docker-compose
$ docker-compose up
```
Sample `config/database.yml` for docker connectivity:
```yaml
development:
  adapter: postgresql
  encoding: unicode
  database: geomg_development
  pool: 5
  username: geomg
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
