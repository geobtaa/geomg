# Blazer

## GEOMG Example Queries

### Basic Count of Documents

```sql
select count(id)
from kithe_models
where publication_state = 'published';
```

### Basic Count Scoped by Date

```sql
select count(id)
from kithe_models
where publication_state = 'published'
and created_at < '2021-12-31';
```

### Basic Count and Group By - Charted

Blazer will automatically "chart" these results, because the resulting table includes an integer and a date/time column.

```sql
select date_trunc('month', created_at)::date as month,
count(*) as documents
from kithe_models
group by month
order by month desc
```

### Select an Aardvark JSON attribute

```sql
SELECT count(id) as total, json_attributes->>'schema_provider_s' as provider
FROM kithe_models
group by provider
order by total desc
```

### Extract lat/lng from JSON centroid - Mapped

Blazer will automatically "map" these results, because the resulting table includes a latitude and a longitude column.

```sql
select
    title,
    split_part(json_attributes ->> 'dcat_centroid_ss'::text, ',', 1) as latitude,
    split_part(json_attributes ->> 'dcat_centroid_ss'::text, ',', 2) as longitude
from kithe_models
where
    publication_state = 'published'
    and created_at > '2021-10-01'
    and created_at < '2021-11-01'
```
