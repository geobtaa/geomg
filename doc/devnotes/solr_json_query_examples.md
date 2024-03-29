# Solr JSON Queries

## Examples used while building GEOMG's Report class

### Basic Solr query against text field
```bash
curl -XGET http://localhost:8983/solr/geoportal-core-development/select -d '
{
  "query": {
    "bool": {
      "must": [
        "text:water"
      ]
    }
  }
}'
```

### Basic Solr query with Facet

```bash
curl -XGET http://localhost:8983/solr/geoportal-core-development/select -d '
{
  "query": {
    "bool": {
      "must": [
        "text:*"
      ],
      "must_not": [
      ],
      "should": [
      ]
    }
  },
  "facet": {
    "doc_counts": {
      "type": "range",
      "field": date_created_dtsi,
      "start": "NOW/DAY-365DAYS",
      "end":  "NOW",
      "gap": "+1MONTH"
    }
  }
}'
```

### With Date Range field / Schema change

```bash
curl -XGET http://localhost:8983/solr/geoportal-core-development/select -d '
{
  "query": {
    "bool": {
      "must": [
        "date_created_drsim:[2021-01-05 TO 2022-01-04]"
      ],
      "must_not": [

      ],
      "should": [

      ]
    }
  },
  "facet": {
    "doc_counts": {
      "type": "range",
      "field": "date_created_dtsi",
      "start": "NOW/DAY-365DAYS",
      "end": "NOW",
      "gap": "+1MONTH"
    }
  }
}'
```
