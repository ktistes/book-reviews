CREATE DATABASE IF NOT EXISTS book_reviews;
USE book_reviews;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS reviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    original_title VARCHAR(255) NULL,
    author VARCHAR(255) NOT NULL,
    isbn VARCHAR(20),
    cover_url TEXT,
    slug TEXT,
    pages INT,
    language VARCHAR(50),
    published_date VARCHAR(50),
    genres TEXT,
    plot TEXT,
    review_content TEXT,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    views INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS review_translations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    review_id INT NOT NULL,
    language VARCHAR(10) NOT NULL,
    plot TEXT,
    review_content TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY unique_review_lang (review_id, language),
    FOREIGN KEY (review_id) REFERENCES reviews(id) ON DELETE CASCADE
);

-- The admin user is NOT created here: generate it on first run with a
-- password of your own choosing (see README, "Create the admin user").
