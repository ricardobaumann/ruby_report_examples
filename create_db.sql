CREATE TABLE players (
  id serial primary key,
  name TEXT,
  nickname TEXT,
  drink TEXT,
  salary DECIMAL(9,2)
); 

INSERT INTO players (name, nickname, drink, salary) VALUES
                    ('Matthew Gifford', 'm_giff', 'Moxie', 89000.00);
                    
INSERT INTO players (name, nickname, drink, salary) VALUES
                    ('Matthew Bouley', 'Iron Helix', 'Moxie', 75000.00);
                    
INSERT INTO players (name, nickname, drink, salary) VALUES
                    ('Luke Bouley', 'Cable Boy', 'Moxie', 75000.50);
                    
INSERT INTO players (name, nickname, drink, salary) VALUES
                    ('Andrew Thomas', 'ste-ty-xav', 'Fresca', 75000.50);
                    
INSERT INTO players (name, nickname, drink, salary) VALUES
                    ('John Dwyer', 'dwy_dwy', 'Fresca', 89000.00);
                    
INSERT INTO players (name, nickname, drink, salary) VALUES
                    ('Ryan Peacan', 'the_dominator', 'Fresca', 75000.50);
                    
INSERT INTO players (name, nickname, drink, salary) VALUES
                    ('Michael Southwick', 'Shaun Wiki', 'Fresca', 75000.50); 
                    




CREATE TABLE games (
  id serial not null primary key,
  name TEXT
); 



INSERT INTO games (name) VALUES ('Bubble Recycler');
INSERT INTO games (name) VALUES ('Computer Repair King');
INSERT INTO games (name) VALUES ('Super Dunkball II: The Return');
INSERT INTO games (name) VALUES ('Sudden Deceleration: No Time to Think'); 
INSERT INTO games (name) VALUES ('Tech Website Baron');






























CREATE TABLE plays (
  id integer NOT NULL primary key,
  player_id integer NOT NULL,
  game_id integer NOT NULL,
  won smallint NOT NULL
);

CREATE TABLE events(
  play_id integer NOT NULL,
    event VARCHAR(25) NOT NULL,
    time integer NOT NULL
);

alter table events add id serial not null primary key

INSERT INTO plays (id, player_id, game_id, won) VALUES (0, 5, 5, 1);
INSERT INTO plays (id, player_id, game_id, won) VALUES (1, 5, 5, 1);
INSERT INTO plays (id, player_id, game_id, won) VALUES (2, 5, 5, 0);
INSERT INTO plays (id, player_id, game_id, won) VALUES (3, 5, 5, 1);
. . .
INSERT INTO events (play_id, event, time) VALUES(0, 'Built DC', 2146.8);
INSERT INTO events (play_id, event, time) VALUES(0, 'Built MC', 27867);
INSERT INTO events (play_id, event, time) VALUES(0, 'Built PR', 65349);
INSERT INTO events (play_id, event, time) VALUES(0, 'Went Public', 86104);
INSERT INTO events (play_id, event, time) VALUES(1, 'Built DC', 8466.0);
INSERT INTO events (play_id, event, time) VALUES(1, 'Built MC', 29454);
INSERT INTO events (play_id, event, time) VALUES(1, 'Built PR', 57896);
INSERT INTO events (play_id, event, time) VALUES(1, 'Went Public', 79587);
INSERT INTO events (play_id, event, time) VALUES(2, 'Built DC', 31455.6);



SELECT event, avg(time) as average_time

          FROM events as e
                INNER JOIN
               plays as p
                 ON e.play_id=p.id
         WHERE p.game_id=1
                 AND
               p.player_id=1
   GROUP BY event ;



