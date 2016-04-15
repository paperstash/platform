## How many lines of code?

```bash
# Frontend
find spa -name "*.vue" -o -name "*.scss" -o -name "*.coffee" | xargs wc -l
# Backend
find apps -name "*.ex" -o -name "*.exs" | xargs wc -l
```

## How do I run database migrations?

```bash
docker-compose run svc /bin/bash -c 'cd /app/apps/paperstash && mix ecto.migrate'
```
