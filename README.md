# GEOMG

An experimental UI for administering BTAA Geoblacklight JSON documents.

## Requirements

* Ruby 2.5+
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
RAILS_ENV=test bundle exec rails test
```

## TODOS

* Basic BTAA/GBL Form
** Form validation
** Input datepickers
** Controlled vocabulary lists

* Auth (Devise)
* Document Versioning (Paper Trail)
* Search
* CSV Import Workflow

## PostgreSQL Notes

* brew install postgresql
* brew services start postgresql
* bundle exec rails db:create
* bundle exec rails db:migrate
* RAILS_ENV=test bundle exec rails db:migrate
