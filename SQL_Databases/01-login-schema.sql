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

EXIT;