# GEOMG

An experimental UI for administering BTAA Geoblacklight JSON documents.

![geomg](https://user-images.githubusercontent.com/69827/84302126-7940a300-ab1a-11ea-9cfc-9dd3c48a0cee.gif)

## Requirements

* Ruby 2.7+
* Ruby on Rails 6+
* Bundler
* Yarn (JS) / Node (Latest LTS release)
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
cd ~/Rails/geomg
bundle exec rake geomg:server
```

2. Run foreman (background queue)
```bash
bundle exec foreman start
```

3. Run the BTAA/B1G Geoportal on port 3001
```bash
cd ~/Rails/geoportal
bundle exec rails server --port=3001
```

4. Open [localhost:3000](http://localhost:3000)


### Test suite

Run test suite:

```bash
RAILS_ENV=test bundle exec rake ci
```

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

## Release Version

B1G Geoportal Version v4.2.0 / GEOMG v0.10.0 / GeoBlacklight v4.0.0-alpha.3
