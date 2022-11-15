# GEOMG
## Adding a new field

You will need to modify all the files listed below to ensure the new field is fully supported in the application.

### Field Config
* Add the field to Settings
* config/settings.yml
- ex. :B1G_CREATOR_ID: 'b1g_creatorID_sm'

### Document Model
* Persists the field data into the database
* app/models/document.rb
- ex. attr_json GEOMG.FIELDS.B1G_CREATOR_ID.to_sym, :string, array: true, default: -> { [] }

### Document Indexer
* Indexes the field data into Solr
* app/indexers/document_indexer.rb
- ex. to_field GEOMG.FIELDS.B1G_CREATOR_ID, obj_extract(GEOMG.FIELDS.B1G_CREATOR_ID), transform(->(v) { v.presence ? v : nil })

### Web Form
* Presents the field when creating or editing via HTML
* app/views/documents/_document_fields.html.erb
- ex. <%= f.repeatable_attr_input GEOMG.FIELDS.B1G_CREATOR_ID, build: :at_least_one %>

### i18n/Locales
* If you need a sane Label for your new field
* config/locales/documents.en.yml
- ex. b1g_creatorID_sm:
        one: "Creator ID"
        other: "Creator ID"

### Exporting

#### CSV - Add to field mappings
* config/initializers/geomg/field_mappings_btaa.rb

```ruby
  'Creator ID': {
    destination: GEOMG.FIELDS.B1G_CREATOR_ID,
    delimited: true,
    transformation_method: nil
  },
```

**NOTE**: You'll need to stop and restart your server and sidekiq to pick up this initializer change.

#### JSON - Add to JSON view partial
* app/views/documents/_json_aardvark.jbuilder
* app/views/documents/_json_btaa_aardvark.jbuilder

```ruby
  json.locn_geometry        no_json_blanks document.derive_locn_geometry
```

### Importing
Having the field configured in the field mappings file should allow the field and its data to import into the application.

### Testing
Add the new field and some example data to our schema_support.csv file.
* test/fixtures/files/schema_support.csv
