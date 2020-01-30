# README

### Kithe / Steps from Zero to Running

#### PG

- brew install postgresql
- add to Gemfile

#### Bootstrap

- add to Gemfile
- add to application.scss
- add basic container markup to layout

#### SimpleForm

- rails generate simple_form:install —bootstrap

#### Cocoon

- add assets/javascripts
- add assets/javascripts/application.js
- require cocoon

#### QuestionAuthority

- add to Gemfile

#### Solr_wrapper

- add to Gemfile
- add .solr_wrapper from Geoportal

#### jQuery

- add to Gemfile

#### Sprockets 4

- add to manifest.js
- //= link application.js

#### Rake

- add geomg:server task (similar to GBL)

#### DotEnv

- add to Gemfile
- add .env.development
- set SOLR_URL val

#### Kithe initializer

- add solr env path

#### Kithe Solr Schema vs. GBL expectations

- id field
- *_ssi field (model_name_ssi)
- *_dtsi / pdate field type (date_created_dtsi)
