Attr Redundancy/Duplication
* Config    - ~~settings.yml (field name abstractions)~~
* Model     - ~~document.rb (attr_json)~~
* Importer  - ~~field_mappings_btaa.rb (csv headers to model attrs)~~
* Indexer   - ~~document_indexer.rb (model to solr doc)~~
* Exporter  - ~~_json_btaa_aardvark.jbuilder~~
* Form      - _document_fields.html.erb


Elements
* Label (CSV Header / Form Label - label)
* Placeholder Text (Input suggestion - placeholder_text)
* Data Entry Hint (Below input details - data_entry_hint)
* Solr Field Name (Solr schema field name - solr_schema_name)
* Required? (T/F - required)
* Repeatable? (T/F - repeatable)
* Field Type (string | integer | boolean (checkboxes) | text | select | hidden/defaultValue)
* Field Value (default value)

Form Markup
* controlled_vocabularies - Controlled Values (name of list)
* js_behaviors - Field JS Behaviors (datepicker | autosuggest | input mask)
* html_attributes
* display_only_on_persisted? (T/F)

* Import delimited? (T/F)
* Import Transformation Method (discard | build_dct_references)
* Export Transformation Method (JSON,CSV | build_dct_references_json)
* Index Transformation Method (W,S,E,N to ENVELOPE)
* Validation Method (How to test)
* Test Fixture Data (Example input for CSV round-trip testing)

---
* Field Type: string
* Field Origin: Aardvark
* Label: Title
* Placeholder Text: (none)
* Data Entry Hint: Theme: city, state, temporal coverage
* Schema Field Name: title
* Required: True
* Repeatable: False
* Field Value: (none)
* Test Fixture Example Data: Title

* Controlled Values: (none)
* Field JS Behaviors: (none)

* Import delimited: False
* Import transformation method: (none)
* Export transformation method: (none)
* Index transformation method: (none)
* Validation method (required)

----

FormElements (STI)
- FormHeading (ex. Identification)
- FormGroup (ex. Descriptive)
- FormControl (ex. Title, etc.)
- FormFeature (ex. Multiple Downloads, Institutional Access Links)

Headings, Groups, and Features automatically become form nav links and page anchors.

----

Roadmap
1. ~Write Element Model~
2. ~Populate table (db/seeds_element.csv)~
3. Extract field configurations (settings.yml, document.rb, document_indexer.rb, field_mappings_btaa.rb, _json_btaa_aardvark.jbuilder)
4. Extract webform (last step)

TODO

Migration
The codebase has a BAD chicken vs. egg issue, where the Elements table needs to exist and be populated with data for the migrations to run. When we push this code out to dev or prod we'll need to handle this issue... likely need to run the elements migration manually.
