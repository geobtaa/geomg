# GEOMG
## Adding a new field

You will need to modify all the files listed below to ensure the new field is fully supported in the application.

### Document Model
* Persists the field data into the database
* app/models/document.rb
- ex. attr_json GEOMG.FIELDS.GEOM.to_sym, :string

### Document Indexer
* Indexes the field data into Solr
* app/indexers/document_indexer.rb
- ex. to_field GEOMG.FIELDS.GEOM, obj_extract('derive_locn_geometry')

### Web Form
* Presents the field when creating or editing via HTML
* app/views/documents/_document_fields.html.erb
- ex. <%= f.input GEOMG.FIELDS.GEOM, label: "Geometry", hint: "WKT - A POLYGON or MULTIPOLYGON value." %>

### Exporting

#### CSV - Add to field mappings
* config/initializers/geomg/field_mappings_btaa.rb

```ruby
      'Geometry': {
        destination: GEOMG.FIELDS.GEOM,
        delimited: false,
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
