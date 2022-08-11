Attr Redundancy/Duplication
* Config    - settings.yml (field name abstractions)
* Model     - document.rb (attr_json)
* Form      - _document_fields.html.erb
* Indexer   - document_indexer.rb (model to solr doc)
* Importer  - field_mappings_btaa.rb (csv headers to model attrs)
* Exporter  - _json_btaa_aardvark.jbuilder

Attributes
* Label (CSV Header / Form Label - label)
* Placeholder Text (Input suggestion - placeholder_text)
* Data Entry Hint (Below input details - data_entry_hint)
* Schema Field Name (Solr schema field name - solr_schema_name)
* Required? (T/F - required)
* Repeatable? (T/F - repeatable)
* Field Type (string | integer | boolean (checkboxes) | text | select | hidden/defaultValue)
* Field Value (default value)
* Field Origin (Aardvark / Custom / )

Form Markup
* controlled_values - Controlled Values (name of list)
* js_behaviors - Field JS Behaviors (datepicker | autosuggest | input mask)
* html_attributess
* only_on_persisted? (T/F)

* Import delimited? (T/F)
* Import Transformation Method (discard | build_dct_references)
* Export Transformation Method (JSON,CSV | build_dct_references_json)
* Index Transformation Method (W,S,E,N to ENVELOPE)
* Validation Method (How to test)
* Test Fixture Data (Example input)

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

Form / Aardvark
* App has one form

FormElements (form_id, element_id, order, parent_id (for grouping))
* Collection of Elements and ordering

Element (STI)
- Control
- SectionHeading (Identification - border top)
- GroupHeading (Descriptive)

Headings become nav links

----

# Appears to work
# Dynamic AttrJSONs
['foo', 'bar', 'baz'].each do |attr|
  attr_json attr.to_sym, :string
end

Roadmap
1. Write Element Model
2. Populate table
3. Extract Settings.FIELDS use (settings.yml, document.rb, document_indexer.rb, field_mappings_btaa.rb, _json_btaa_aardvark.jbuilder)
4. Extract webform (last step)
