# Book Reviews — Docker installation

## Requirements

- Docker
- Docker Compose

## Setup

1. Copy `.env.example` to `.env` and fill in your own values:
   ```bash
   cp .env.example .env
   ```

2. Start the app (a single command downloads and starts everything —
   database, backend, and web server):
   ```bash
   docker compose up -d
   ```

3. Create your admin user (no default account is created for security reasons):
   ```bash
   docker compose exec php php -r 'echo password_hash($argv[1], PASSWORD_DEFAULT) . PHP_EOL;' 'your-chosen-password'
   ```
   Copy the printed hash, then:
   ```bash
   docker compose exec db mysql -u bookreviews -p book_reviews -e 'INSERT INTO users (username, password_hash) VALUES ("admin", "PASTE_HASH_HERE");'
   ```
   (use the `MYSQL_PASSWORD` value from your `.env` when prompted)

4. Open the app at `http://localhost:8089` (or whatever `APP_PORT` you set).
   Admin panel: `http://localhost:8089/admin/login.php`

## What's included

- Book review management (add, edit, delete, import/export CSV & JSON)
- Bilingual reviews (English/Italian) with a language switch per book,
  plus an "Original Title" field
- Google Books API lookup when adding a review
- Optional contact form (requires SMTP settings in `.env`)

## Updating

```bash
docker compose pull
docker compose up -d
```

Your data (database) persists in a Docker volume and is not affected by image updates.
