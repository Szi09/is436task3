-- init.sql
CREATE TABLE players (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    score INT DEFAULT 0
);

CREATE TABLE matches (
    id INT AUTO_INCREMENT PRIMARY KEY,
    player1_id INT,
    player2_id INT,
    winner_id INT,
    match_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
