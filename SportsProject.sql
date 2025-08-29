CREATE DATABASE SportsTeamDB;
USE SportsTeamDB;

#LEAGUES

CREATE TABLE Leagues (
    league_id INT PRIMARY KEY AUTO_INCREMENT,
    league_name VARCHAR(100) NOT NULL UNIQUE,
    country VARCHAR(50) NOT NULL,
    season VARCHAR(20) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL
);

#TEAMS

CREATE TABLE Teams (
    team_id INT PRIMARY KEY AUTO_INCREMENT,
    team_name VARCHAR(100) NOT NULL UNIQUE,
    city VARCHAR(50) NOT NULL,
    coach_name VARCHAR(100),
    founded_year INT CHECK (founded_year >= 1800),
    league_id INT,
    FOREIGN KEY (league_id) REFERENCES Leagues(league_id)
);

#PLAYERS

CREATE TABLE Players (
    player_id INT PRIMARY KEY AUTO_INCREMENT,
    player_name VARCHAR(100) NOT NULL,
    position VARCHAR(50) CHECK (position IN ('Forward','Midfielder','Defender','Goalkeeper')),
    age INT CHECK (age > 15),
    nationality VARCHAR(50),
    team_id INT,
    FOREIGN KEY (team_id) REFERENCES Teams(team_id)
);

#MATCHES

CREATE TABLE Matches (
    match_id INT PRIMARY KEY AUTO_INCREMENT,
    league_id INT,
    match_date DATE NOT NULL,
    home_team_id INT,
    away_team_id INT,
    venue VARCHAR(100) NOT NULL,
    FOREIGN KEY (league_id) REFERENCES Leagues(league_id),
    FOREIGN KEY (home_team_id) REFERENCES Teams(team_id),
    FOREIGN KEY (away_team_id) REFERENCES Teams(team_id),
    CONSTRAINT chk_teams CHECK (home_team_id <> away_team_id)
);

#SCORES

CREATE TABLE Scores (
    score_id INT PRIMARY KEY AUTO_INCREMENT,
    match_id INT,
    team_id INT,
    goals INT DEFAULT 0 CHECK (goals >= 0),
    possession DECIMAL(5,2) CHECK (possession >= 0 AND possession <= 100),
    shots_on_target INT DEFAULT 0 CHECK (shots_on_target >= 0),
    FOREIGN KEY (match_id) REFERENCES Matches(match_id),
    FOREIGN KEY (team_id) REFERENCES Teams(team_id)
);

# Insert rows into Leagues 

INSERT INTO Leagues (league_name, country, season, start_date, end_date) VALUES
('Premier League', 'England', '2024/25', '2024-08-10', '2025-05-20'),
('La Liga', 'Spain', '2024/25', '2024-08-15', '2025-05-25'),
('Serie A', 'Italy', '2024/25', '2024-08-18', '2025-05-28'),
('Bundesliga', 'Germany', '2024/25', '2024-08-20', '2025-05-30'),
('Ligue 1', 'France', '2024/25', '2024-08-22', '2025-06-01'),
('ISL', 'India', '2024/25', '2024-09-15', '2025-03-20'),
('MLS', 'USA', '2024/25', '2024-02-20', '2024-11-20'),
('Eredivisie', 'Netherlands', '2024/25', '2024-08-12', '2025-05-15');

select * from Leagues;

# Insert into Teams

INSERT INTO Teams (team_name, city, coach_name, founded_year, league_id) VALUES
('Manchester United', 'Manchester', 'Erik ten Hag', 1878, 1),
('Liverpool', 'Liverpool', 'Jurgen Klopp', 1892, 1),
('Chelsea', 'London', 'Mauricio Pochettino', 1905, 1),
('Arsenal', 'London', 'Mikel Arteta', 1886, 1),
('Tottenham Hotspur', 'London', 'Ange Postecoglou', 1882, 1),
('Real Madrid', 'Madrid', 'Carlo Ancelotti', 1902, 2),
('Barcelona', 'Barcelona', 'Xavi Hernandez', 1899, 2),
('Atletico Madrid', 'Madrid', 'Diego Simeone', 1903, 2),
('Sevilla', 'Seville', 'Quique Sanchez Flores', 1890, 2),
('AC Milan', 'Milan', 'Stefano Pioli', 1899, 3),
('Juventus', 'Turin', 'Massimiliano Allegri', 1897, 3),
('Inter Milan', 'Milan', 'Simone Inzaghi', 1908, 3),
('Napoli', 'Naples', 'Walter Mazzarri', 1926, 3),
('Bayern Munich', 'Munich', 'Thomas Tuchel', 1900, 4),
('Borussia Dortmund', 'Dortmund', 'Edin Terzić', 1909, 4),
('RB Leipzig', 'Leipzig', 'Marco Rose', 2009, 4),
('Bayer Leverkusen', 'Leverkusen', 'Xabi Alonso', 1904, 4),
('PSG', 'Paris', 'Luis Enrique', 1970, 5),
('Lyon', 'Lyon', 'Pierre Sage', 1950, 5),
('Marseille', 'Marseille', 'Gennaro Gattuso', 1899, 5),
('Monaco', 'Monaco', 'Adi Hütter', 1919, 5),
('Mumbai City', 'Mumbai', 'Des Buckingham', 2014, 6),
('Bengaluru FC', 'Bengaluru', 'Simon Grayson', 2013, 6),
('Kerala Blasters', 'Kochi', 'Ivan Vukomanović', 2014, 6),
('ATK Mohun Bagan', 'Kolkata', 'Antonio Lopez Habas', 1889, 6),
('LA Galaxy', 'Los Angeles', 'Greg Vanney', 1994, 7),
('Inter Miami', 'Miami', 'Gerardo Martino', 2018, 7),
('New York City FC', 'New York', 'Nick Cushing', 2013, 7),
('Ajax', 'Amsterdam', 'John van ’t Schip', 1900, 8),
('PSV Eindhoven', 'Eindhoven', 'Peter Bosz', 1913, 8);

select * from Teams;

# Insert into Players

INSERT INTO Players (player_name, position, age, nationality, team_id) VALUES
('Marcus Rashford', 'Forward', 26, 'England', 1),
('Mohamed Salah', 'Forward', 32, 'Egypt', 2),
('Virgil van Dijk', 'Defender', 33, 'Netherlands', 2),
('Mason Mount', 'Midfielder', 25, 'England', 3),
('Bukayo Saka', 'Forward', 23, 'England', 4),
('Harry Kane', 'Forward', 31, 'England', 5),
('Vinicius Jr', 'Forward', 24, 'Brazil', 6),
('Luka Modric', 'Midfielder', 39, 'Croatia', 6),
('Robert Lewandowski', 'Forward', 36, 'Poland', 7),
('Pedri', 'Midfielder', 22, 'Spain', 7),
('Antoine Griezmann', 'Forward', 34, 'France', 8),
('Ivan Rakitic', 'Midfielder', 37, 'Croatia', 9),
('Olivier Giroud', 'Forward', 38, 'France', 10),
('Dusan Vlahovic', 'Forward', 25, 'Serbia', 11),
('Lautaro Martinez', 'Forward', 28, 'Argentina', 12),
('Khvicha Kvaratskhelia', 'Forward', 24, 'Georgia', 13),
('Joshua Kimmich', 'Midfielder', 30, 'Germany', 14),
('Jude Bellingham', 'Midfielder', 22, 'England', 15),
('Christopher Nkunku', 'Forward', 28, 'France', 16),
('Florian Wirtz', 'Midfielder', 22, 'Germany', 17),
('Kylian Mbappe', 'Forward', 26, 'France', 18),
('Alexandre Lacazette', 'Forward', 34, 'France', 19),
('Pierre-Emerick Aubameyang', 'Forward', 36, 'Gabon', 20),
('Wissam Ben Yedder', 'Forward', 34, 'France', 21),
('Sunil Chhetri', 'Forward', 40, 'India', 23),
('Adrian Luna', 'Midfielder', 32, 'Uruguay', 24),
('Hugo Boumous', 'Midfielder', 30, 'France', 25),
('Lionel Messi', 'Forward', 38, 'Argentina', 27),
('Luis Suarez', 'Forward', 38, 'Uruguay', 27),
('Dusan Tadic', 'Midfielder', 36, 'Serbia', 29);

select * from Players;

# Insert into Matches 

INSERT INTO Matches (league_id, match_date, home_team_id, away_team_id, venue) VALUES
(1, '2024-09-15', 1, 2, 'Old Trafford'),
(1, '2024-10-10', 3, 4, 'Stamford Bridge'),
(1, '2024-11-01', 5, 1, 'Tottenham Stadium'),
(2, '2024-09-20', 6, 7, 'Santiago Bernabeu'),
(2, '2024-10-05', 8, 9, 'Wanda Metropolitano'),
(3, '2024-09-25', 10, 11, 'San Siro'),
(3, '2024-10-12', 12, 13, 'Juventus Stadium'),
(4, '2024-09-18', 14, 15, 'Allianz Arena'),
(4, '2024-10-03', 16, 17, 'Red Bull Arena'),
(5, '2024-09-21', 18, 19, 'Parc des Princes'),
(5, '2024-10-15', 20, 21, 'Velodrome'),
(6, '2024-09-30', 22, 23, 'Mumbai Arena'),
(6, '2024-10-18', 24, 22, 'Salt Lake Stadium'),
(7, '2024-03-10', 26, 27, 'LA Galaxy Stadium'),
(7, '2024-04-05', 27, 28, 'Miami Arena'),
(8, '2024-09-05', 29, 30, 'Johan Cruyff Arena'),
(8, '2024-10-08', 30, 29, 'Philips Stadion');

select * from Matches;

# Insert into Scores 

INSERT INTO Scores (match_id, team_id, goals, possession, shots_on_target) VALUES
(1, 1, 2, 55.5, 6), (1, 2, 1, 44.5, 4),
(2, 3, 1, 48.0, 3), (2, 4, 2, 52.0, 6),
(3, 5, 0, 46.0, 2), (3, 1, 2, 54.0, 5),
(4, 6, 3, 60.0, 7), (4, 7, 1, 40.0, 3),
(5, 8, 2, 49.0, 4), (5, 9, 2, 51.0, 5),
(6, 10, 2, 53.0, 6), (6, 11, 2, 47.0, 4),
(7, 12, 1, 57.0, 5), (7, 13, 2, 43.0, 3),
(8, 14, 3, 61.0, 7), (8, 15, 1, 39.0, 3),
(9, 16, 1, 50.0, 5), (9, 17, 1, 50.0, 5),
(10, 18, 2, 63.0, 8), (10, 19, 1, 37.0, 4),
(11, 20, 1, 45.0, 4), (11, 21, 2, 55.0, 5),
(12, 22, 2, 56.0, 5), (12, 23, 1, 44.0, 3),
(13, 24, 2, 59.0, 6), (13, 22, 2, 41.0, 4),
(14, 26, 1, 47.0, 4), (14, 27, 3, 53.0, 6),
(15, 27, 2, 51.0, 5), (15, 28, 1, 49.0, 3),
(16, 29, 2, 55.0, 6), (16, 30, 2, 45.0, 5),
(17, 30, 1, 48.0, 4), (17, 29, 1, 52.0, 4);

select * from Scores;

ALTER TABLE Teams ADD stadium VARCHAR(100);
 
DROP TABLE IF EXISTS TempTable;
 
UPDATE Teams SET coach_name = 'Gobika' WHERE team_id = 3;

select * from Teams;

SELECT player_name, position FROM Players WHERE age < 25;

SELECT team_name, founded_year FROM Teams ORDER BY founded_year ASC;

 SELECT DISTINCT nationality FROM Players;

 SELECT COUNT(*) AS total_players FROM Players;

 SELECT AVG(age) AS avg_age FROM Players;

SELECT team_id, COUNT(*) AS player_count FROM Players GROUP BY team_id HAVING COUNT(*) > 1;

SELECT p.player_name, t.team_name FROM Players p JOIN Teams t ON p.team_id = t.team_id;

SELECT m.match_id, ht.team_name AS home, at.team_name AS away, sh.goals AS home_goals, sa.goals AS away_goals
    FROM Matches m
    JOIN Teams ht ON m.home_team_id = ht.team_id
    JOIN Teams at ON m.away_team_id = at.team_id
    JOIN Scores sh ON m.match_id = sh.match_id AND sh.team_id = ht.team_id
    JOIN Scores sa ON m.match_id = sa.match_id AND sa.team_id = at.team_id;
    
SELECT player_name FROM Players WHERE age = (SELECT MAX(age) FROM Players);

SELECT player_name FROM Players WHERE nationality IN ('Spain', 'England');

SELECT player_name FROM Players WHERE player_name LIKE 'M%';

SELECT match_id, match_date FROM Matches WHERE match_date BETWEEN '2024-09-01' AND '2024-09-30';

CREATE VIEW LeagueStandings AS
    SELECT l.league_name, t.team_name, SUM(s.goals) AS total_goals
    FROM Scores s
    JOIN Teams t ON s.team_id = t.team_id
    JOIN Leagues l ON t.league_id = l.league_id
    GROUP BY l.league_name, t.team_name;
    
    
SELECT * 
FROM LeagueStandings;

SELECT league_name, team_name, total_goals
FROM LeagueStandings
ORDER BY total_goals DESC
LIMIT 5;

SELECT league_name, COUNT(team_name) AS total_teams
FROM LeagueStandings
GROUP BY league_name;

SELECT l.league_name, COUNT(m.match_id) AS total_matches
    FROM Matches m
    JOIN Leagues l ON m.league_id = l.league_id
    GROUP BY l.league_name;