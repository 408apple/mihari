---
tags:
  - IP address
---

# GreyNoise

- [https://www.greynoise.io/](https://www.greynoise.io/)

This analyzer uses GreyNoise API (`/v2/experimental/gnql`) to search. Pagination is supported.

```yaml
analyzer: greynoise
query: ...
api_key: ...
```

## Components

### Query

`query` is a GNQL search query.

### API Key

`api_key` is an API key. Optional. Defaults to `ENV[”GREYNOISE_API_KEY"]`.
