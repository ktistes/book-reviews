# Book Reviews — SQLite edition (Docker)

Lighter alternative to the MySQL edition: two containers instead of three,
no separate database server — the whole database is a single SQLite file.

## Requirements

- Docker
- Docker Compose

## Setup

1. Copy `.env.example` to `.env` and fill in your own values:
   ```bash
   cp .env.example .env
   ```

2. Start the app (downloads and starts everything automatically):
   ```bash
   docker compose up -d
   ```
   The database schema is created automatically on first start — no
   separate SQL file to provide.

3. Create your admin user:
   ```bash
   docker compose exec php php -r 'echo password_hash($argv[1], PASSWORD_DEFAULT) . PHP_EOL;' 'your-chosen-password'
   ```
   Then insert it into the database:
   ```bash
   docker compose exec php sqlite3 /var/www/data/book_reviews.sqlite \
     'INSERT INTO users (username, password_hash) VALUES ("admin", "PASTE_HASH_HERE");'
   ```

4. Open the app at `http://localhost:8088` (or whatever `APP_PORT` you set).
   Admin panel: `http://localhost:8088/admin/login.php`

## What's included

- Book review management (add, edit, delete, import/export CSV & JSON)
- Bilingual reviews (English/Italian) with a language switch per book,
  plus an "Original Title" field
- Google Books API lookup when adding a review
- Optional contact form (requires SMTP settings in `.env`)

## Backing up

The whole database is one file — backup is just copying it:
```bash
docker compose exec php cp /var/www/data/book_reviews.sqlite /var/www/data/backup_$(date +%Y%m%d).sqlite
docker compose cp php:/var/www/data/backup_$(date +%Y%m%d).sqlite ./
```

## Updating

```bash
docker compose pull
docker compose up -d
```

Your data persists in a Docker volume and is not affected by image updates.

## A note on concurrency

SQLite locks the whole file during a write. Fine for a single-admin blog
with occasional writes; if you expect many simultaneous writers, use the
[MySQL edition](https://github.com/ktistes/book-reviews) instead.
