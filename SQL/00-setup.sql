-- Connect to XEPDB1 as system
CONNECT system/OraclePassword123@XEPDB1;

-- Create users
CREATE USER java_user IDENTIFIED BY JavaUserPass123;
CREATE USER csc_cocktails IDENTIFIED BY CocktailsPass123;

-- Grant privileges to java_user
GRANT CONNECT, RESOURCE, CREATE SESSION TO java_user;
GRANT UNLIMITED TABLESPACE TO java_user;
GRANT CREATE TABLE TO java_user;

-- Grant privileges to csc_cocktails
GRANT CONNECT, RESOURCE, CREATE SESSION TO csc_cocktails;
GRANT UNLIMITED TABLESPACE TO csc_cocktails;
GRANT CREATE TABLE TO csc_cocktails;

-- Switch to java_user and create login tables
CONNECT java_user/JavaUserPass123@XEPDB1;

CREATE TABLE final_users (
                             user_id INT PRIMARY KEY,
                             username VARCHAR(255),
                             password VARCHAR(255),
                             email VARCHAR(255),
                             privilege VARCHAR2(255)
);

INSERT ALL
    INTO final_users (user_id, username, password, email, privilege) VALUES (1,'eventsadmin','02e6f70422bd78868a19f2f29b18f08f586b717082e7246a80d8fed5b2565389','operator@ops.com', 'admin')
    INTO final_users (user_id, username, password, email, privilege) VALUES (2,'NCundey','59fbdcc570893b6a6d8d25cd6d868bfa3f98ae73184d921f660b0ad07416452b','ncundey0@seesaa.net', 'user')
    INTO final_users (user_id, username, password, email, privilege) VALUES (3,'CIxer','2e4216ba6840492e2a94d532b7c9ae1e1c479f08d71a54932d10835681ece84e','cixer1@adobe.com', 'user')
    INTO final_users (user_id, username, password, email, privilege) VALUES (4,'TRandall','d724b624481432070413615b4ecd0ce7cd768646b77cbac437dc22e416e5699b','trandall2@cdbaby.com', 'user')
    INTO final_users (user_id, username, password, email, privilege) VALUES (5,'MDraysay','d906ec8d4ab72365f9eec5e976a228049f19b39f5b854fc0e4308d3247c76456','mdraysay3@uiuc.edu', 'user')
    INTO final_users (user_id, username, password, email, privilege) VALUES (6,'AShawell','4a4622ff707badd399076e0ede7a43c8398ba98740114bf487e46739bd6cd916','ashawell4@telegraph.co.uk', 'user')
    INTO final_users (user_id, username, password, email, privilege) VALUES (7,'FLantoph','7759e251996532dbbd18759f2e789a219d3ca33017e160bf8071069dfa2be90f','flantoph5@noaa.gov', 'user')
    INTO final_users (user_id, username, password, email, privilege) VALUES (8,'MMelburg','424fa8a2a1f46aa22542f904f6b3dfd4b0464269ab4867d2fbab29d5b26377da','mmelburg6@ucoz.ru', 'user')
    INTO final_users (user_id, username, password, email, privilege) VALUES (9,'BMeneghelli','c04a87625d3b048dad971fdd7f077f0cbf8e3a41ca91eee187c0e39531c4b360','bmeneghelli7@illinois.edu', 'user')
    INTO final_users (user_id, username, password, email, privilege) VALUES (10,'MWolfe','e067e3c0dce5547cbe22299de8c2e259a9968a8f7ab29fd889b706a7c2a50f7f','mwolfe8@zdnet.com', 'user')
    INTO final_users (user_id, username, password, email, privilege) VALUES (11,'MArkill','fe7c163337ecec64e3468ba70a54172a81365cffb46223ee690f0ec898c69397','markill9@answers.com', 'user')
SELECT * FROM dual;

COMMIT;

-- Switch to csc_cocktails and create app tables
CONNECT csc_cocktails/CocktailsPass123@XEPDB1;

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

-- Insert cocktail data
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