-- Application database schema and data
-- No sensitive information here

CREATE TABLE final_user_sessions (
                                     user_id NUMBER,
                                     session_id VARCHAR2(36)
);

CREATE TABLE keys (
                      secret_key VARCHAR2(255)
);

INSERT INTO keys VALUES('KQKvXxQQiyLn8m0+HfUxiD57hJPkJDNXNY9sPkXgKN4=');

CREATE TABLE cocktails (
                           cocktail# NUMBER,
                           name VARCHAR2(50),
                           category VARCHAR2(20),
                           technique VARCHAR2(20),
                           glassware VARCHAR2(20),
                           garnish VARCHAR2(20),
                           CONSTRAINT cocktail#_pk PRIMARY KEY (cocktail#)
);

CREATE TABLE distributors (
                              distributor# NUMBER,
                              name VARCHAR2(20),
                              type VARCHAR2(20),
                              lead_time_days NUMBER,
                              address VARCHAR2(100),
                              CONSTRAINT distributor#_pk PRIMARY KEY (distributor#)
);

CREATE TABLE spirits (
                         spirit# NUMBER,
                         brand VARCHAR2(30),
                         category VARCHAR2(10),
                         cost_bottle NUMBER(5, 2),
                         cost_oz AS ( ROUND( (cost_bottle / 32), 2) ),
                         inventory_bottles NUMBER(3, 1),
                         inventory_oz AS (ROUND((inventory_bottles * 32),2)),
                         distributor# NUMBER,
                         CONSTRAINT spirit#_pk PRIMARY KEY (spirit#),
                         CONSTRAINT spirits_distributor#_fk FOREIGN KEY (distributor#) REFERENCES distributors (distributor#)
);

CREATE TABLE ingredients (
                             ingredient# NUMBER,
                             name VARCHAR(20),
                             type VARCHAR2(10),
                             CONSTRAINT ingredient#_pk PRIMARY KEY (ingredient#)
);

CREATE TABLE cocktail_ingredients (
                                      cocktail# NUMBER,
                                      ingredient# NUMBER,
                                      amount NUMBER(5, 2),
                                      CONSTRAINT cocktail#_fk FOREIGN KEY (cocktail#) REFERENCES cocktails (cocktail#),
                                      CONSTRAINT ingredient#_fk FOREIGN KEY (ingredient#) REFERENCES ingredients (ingredient#)
);

CREATE TABLE produce (
                         produce# NUMBER,
                         name VARCHAR(20),
                         cost_oz NUMBER(5, 2),
                         inventory_oz NUMBER(5, 2),
                         ingredient# NUMBER,
                         distributor# NUMBER,
                         CONSTRAINT produce#_pk PRIMARY KEY (produce#),
                         CONSTRAINT produce_ingredient#_fk FOREIGN KEY (ingredient#) REFERENCES ingredients (ingredient#),
                         CONSTRAINT produce_distributor#_fk FOREIGN KEY (distributor#) REFERENCES distributors (distributor#)
);

CREATE TABLE contacts (
                          contact# NUMBER,
                          full_name VARCHAR2(50),
                          phone_number VARCHAR(12),
                          email_address VARCHAR(30),
                          distributor# NUMBER,
                          CONSTRAINT contact#_pk PRIMARY KEY (contact#),
                          CONSTRAINT distributor#_fk FOREIGN KEY (distributor#) REFERENCES distributors (distributor#)
);

-- Insert data
INSERT INTO cocktails (cocktail#, name, category, technique, glassware, garnish)
VALUES (1, 'Whiskey Smash', 'Classic', 'Shaken', 'Double Old Fashioned', 'Mint Sprig');
INSERT INTO cocktails VALUES (2, 'Manhattan', 'Classic', 'Stirred', 'Martini', 'Cherry');
INSERT INTO cocktails VALUES (3, 'Trader Vic Mai Tai', 'Tiki Classic', 'Shaken', 'Double Old Fashioned', 'Mint Sprig');
INSERT INTO cocktails VALUES (4, 'Cosmo', 'Contemporary Classic', 'Shaken', 'Martini', 'Orange Twist');
INSERT INTO cocktails VALUES (5, 'Gimlet', 'Classic', 'Shaken', 'Coupe', 'No Garnish');
INSERT INTO cocktails VALUES (6, 'Bees Knees', 'Contemporary Classic', 'Shaken', 'Coupe', 'Lemon Twist');
INSERT INTO cocktails VALUES (7, 'Aperol Spritz', 'Classic', 'Build', 'Wine Glass', 'Orange Twist');
INSERT INTO cocktails VALUES (8, 'Negroni', 'Classic', 'Stirred', 'Double Old Fashioned', 'Orange Twist');
INSERT INTO cocktails VALUES (9, 'Boulevardier', 'Contemporary Classic', 'Stirred', 'Double Old Fashioned', 'Orange Twist');
INSERT INTO cocktails VALUES (10, 'Brandy Alexander', 'Contemporary Classic', 'Roll', 'Cocktail Glass', 'Nutmeg');

INSERT INTO distributors (distributor#, name, type, lead_time_days, address)
VALUES (1, 'Horizon Beverage', 'Spirits', 3, '45 Commerce Way, Norton, MA 02766');
INSERT INTO distributors VALUES (2, 'MS Walker', 'Spirits', 3, '975 University Avenue, Norwood, MA 02062');
INSERT INTO distributors VALUES (3, 'Martignetti', 'Spirits', 5, '200 Charles F. Colton Road, Taunton, MA 02780');
INSERT INTO distributors VALUES (4, 'Atlantic Beverage', 'Spirits', 5, '350 Hopping Brook Rd, Holliston, MA 01746');

INSERT INTO ingredients (ingredient#, name, type) VALUES (1, 'Lemon Juice', 'Juice');
INSERT INTO ingredients (ingredient#, name, type) VALUES (2, 'Lime Juice', 'Juice');
INSERT INTO ingredients (ingredient#, name, type) VALUES (3, 'Simple Syrup', 'Syrup');
INSERT INTO ingredients (ingredient#, name, type) VALUES (4, 'Honey Syrup', 'Syrup');
INSERT INTO ingredients (ingredient#, name, type) VALUES (5, 'Mint', 'Garnish');
INSERT INTO ingredients (ingredient#, name, type) VALUES (6, 'Lemon Wedge', 'Wedge');
INSERT INTO ingredients (ingredient#, name, type) VALUES (7, 'Bourbon', 'Spirit');
INSERT INTO ingredients (ingredient#, name, type) VALUES (8, 'Gin', 'Spirit');
INSERT INTO ingredients (ingredient#, name, type) VALUES (9, 'Sweet Vermouth', 'Vermouths');
INSERT INTO ingredients (ingredient#, name, type) VALUES (10, 'Angostura Bitters', 'Bitters');

INSERT INTO produce (produce#, name, cost_oz, inventory_oz, ingredient#, distributor#)
VALUES (1, 'Lemons', 13, 100, 1, 4);

INSERT INTO spirits (spirit#, brand, category, cost_bottle, inventory_bottles, distributor#)
VALUES (1, 'Four Roses', 'Whiskey', 34.29, 3, 1);
INSERT INTO spirits (spirit#, brand, category, cost_bottle, inventory_bottles, distributor#)
VALUES (2, 'Cold River', 'Gin', 34.29, 14, 1);

-- Whiskey Smash
INSERT INTO cocktail_ingredients (cocktail#, ingredient#, amount) VALUES (1, 7, 2);
INSERT INTO cocktail_ingredients (cocktail#, ingredient#, amount) VALUES (1, 6, 3);
INSERT INTO cocktail_ingredients (cocktail#, ingredient#, amount) VALUES (1, 3, .75);
INSERT INTO cocktail_ingredients (cocktail#, ingredient#, amount) VALUES (1, 5, 8);

-- Bees Knees
INSERT INTO cocktail_ingredients (cocktail#, ingredient#, amount) VALUES (6, 8, 1.5);
INSERT INTO cocktail_ingredients (cocktail#, ingredient#, amount) VALUES (6, 1, .75);
INSERT INTO cocktail_ingredients (cocktail#, ingredient#, amount) VALUES (6, 4, .75);

-- Manhattan
INSERT INTO cocktail_ingredients (cocktail#, ingredient#, amount) VALUES (2, 7, 2);
INSERT INTO cocktail_ingredients (cocktail#, ingredient#, amount) VALUES (2, 9, 1);
INSERT INTO cocktail_ingredients (cocktail#, ingredient#, amount) VALUES (2, 10, 2);

COMMIT;

EXIT;