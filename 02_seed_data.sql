set serveroutput on;

INSERT INTO institution VALUES (1, 'UMBC', 'USA');
INSERT INTO institution VALUES (2, 'Johns Hopkins University', 'USA');
INSERT INTO institution VALUES (3, 'Stanford University', 'USA');
INSERT INTO institution VALUES (4, 'Oxford University', 'UK');
INSERT INTO institution VALUES (5, 'University of Tokyo', 'Japan');
INSERT INTO institution VALUES (6, 'Indian Institute of Technology Delhi', 'India');




INSERT INTO person VALUES (1, 1, 'Ben Stokes', '123 Main St', '21250', 'alice.j@umbc.edu', 'USA');
INSERT INTO person VALUES (2, 2, 'David Warner', '456 Elm St', '21218', 'bob.s@jhu.edu', 'USA');
INSERT INTO person VALUES (3, 3, 'Kagiso Rabada', '789 Oak St', '94305', 'carol.k@stanford.edu', 'USA');
INSERT INTO person VALUES (4, 4, 'Virat Kohli', '101 High St', 'OX1 3PA', 'david.l@oxford.uk', 'UK');
INSERT INTO person VALUES (5, 5, 'Chris Gayle', '202 Tokyo Blvd', '113-0033', 'eve.n@tokyo.ac.jp', 'Japan');
INSERT INTO person VALUES (6, 6, 'Rohit Sharma', 'Noida Sector 8', '11104', 'naveen.k@iitd.edu', 'India');






INSERT INTO conference VALUES (1, 'Database Systems Conference', 2024, DATE '2024-10-15', DATE '2024-10-17', TIMESTAMP '2024-09-01 23:59:59.00', TIMESTAMP '2024-09-15 23:59:59.00', TIMESTAMP '2024-09-30 23:59:59.00', 'Baltimore', 'USA', DATE '2024-08-01', 100, 150);
INSERT INTO conference VALUES (2, 'AI and Machine Learning Symposium', 2024, DATE '2024-11-01', DATE '2024-11-03', TIMESTAMP '2024-09-10 23:59:59', TIMESTAMP '2024-09-30 23:59:59', TIMESTAMP '2024-10-15 23:59:59', 'San Francisco', 'USA', DATE '2024-08-10', 120, 180);
INSERT INTO conference VALUES (3, 'Cybersecurity Summit', 2024, DATE '2024-12-05', DATE '2024-12-07', TIMESTAMP '2024-10-01 23:59:59', TIMESTAMP'2024-10-20 23:59:59', TIMESTAMP'2024-11-10 23:59:59', 'Boston', 'USA', DATE'2024-09-01', 130, 190);
INSERT INTO conference VALUES (4, 'Quantum Computing Conference', 2024, DATE '2024-08-25', DATE '2024-08-27', TIMESTAMP '2024-07-01 23:59:59', TIMESTAMP '2024-07-15 23:59:59', TIMESTAMP '2024-08-05 23:59:59', 'London', 'UK', DATE '2024-06-01', 140, 200);
INSERT INTO conference VALUES (5, 'Blockchain Conference', 2024, DATE '2024-09-10', DATE '2024-09-12', TIMESTAMP '2024-07-15 23:59:59', TIMESTAMP '2024-08-01 23:59:59', TIMESTAMP '2024-08-20 23:59:59', 'Tokyo', 'Japan', DATE '2024-07-01', 110, 160);




INSERT INTO conference_session VALUES (1, 1, 1, 'Database Optimization', TIMESTAMP '2024-10-15 09:00:00', TIMESTAMP '2024-10-15 10:30:00');
INSERT INTO conference_session VALUES (2, 1, 2, 'SQL Performance Tuning', TIMESTAMP '2024-10-15 11:00:00', TIMESTAMP '2024-10-15 12:30:00');
INSERT INTO conference_session VALUES (3, 2, 3, 'AI in Healthcare', TIMESTAMP '2024-11-01 09:30:00', TIMESTAMP '2024-11-01 11:00:00');
INSERT INTO conference_session VALUES (4, 2, 4, 'Deep Learning Algorithms', TIMESTAMP '2024-11-01 11:30:00', TIMESTAMP '2024-11-01 13:00:00');
INSERT INTO conference_session VALUES (5, 3, 5, 'Security in IoT Devices', TIMESTAMP '2024-12-05 10:00:00', TIMESTAMP'2024-12-05 11:30:00');




INSERT INTO user_roles VALUES (1, 1, 'organizer');
INSERT INTO user_roles VALUES (2, 1, 'reviewer');
INSERT INTO user_roles VALUES (3, 1, 'author');
INSERT INTO user_roles VALUES (4, 2, 'participant');
INSERT INTO user_roles VALUES (5, 3, 'reviewer');
INSERT INTO user_roles VALUES (6, 4, 'organizer');




INSERT INTO paper VALUES (1, 'Efficient Query Processing', 1, TIMESTAMP '2024-09-01 12:30:00', NULL, 'submitted', NULL);
INSERT INTO paper VALUES (2, 'Advanced Indexing Techniques', 1, TIMESTAMP '2024-09-02 14:00:00', NULL, 'submitted', NULL);
INSERT INTO paper VALUES (3, 'AI for Healthcare', 2, TIMESTAMP '2024-09-05 16:30:00', NULL, 'submitted', NULL);
INSERT INTO paper VALUES (4, 'Quantum Computing in AI', 4, TIMESTAMP '2024-07-01 15:00:00', NULL, 'submitted', NULL);
INSERT INTO paper VALUES (5, 'Blockchain for Supply Chains', 5, TIMESTAMP '2024-07-20 17:00:00', NULL, 'submitted', NULL);




INSERT INTO paper_author VALUES (1, 3, 1);
INSERT INTO paper_author VALUES (1, 4, 2);
INSERT INTO paper_author VALUES (2, 3, 1);
INSERT INTO paper_author VALUES (3, 5, 1);
INSERT INTO paper_author VALUES (4, 6, 1);
INSERT INTO paper_author VALUES (5, 1, 1);


INSERT INTO topic VALUES (1, 'Database Optimization');
INSERT INTO topic VALUES (2, 'Indexing Techniques');
INSERT INTO topic VALUES (3, 'Query Processing');
INSERT INTO topic VALUES (4, 'AI in Healthcare');
INSERT INTO topic VALUES (5, 'Quantum Computing');
INSERT INTO topic VALUES (6, 'Blockchain');




INSERT INTO paper_topic VALUES (1, 1);
INSERT INTO paper_topic VALUES (1, 3);
INSERT INTO paper_topic VALUES (2, 2);
INSERT INTO paper_topic VALUES (3, 4);
INSERT INTO paper_topic VALUES (4, 5);
INSERT INTO paper_topic VALUES (5, 6);





INSERT INTO paper_bid VALUES (1, 2, 1);
INSERT INTO paper_bid VALUES (2, 2, 2);
INSERT INTO paper_bid VALUES (3, 5, 3);
INSERT INTO paper_bid VALUES (4, 5, 4);
INSERT INTO paper_bid VALUES (5, 3, 5);





INSERT INTO review VALUES (1, 2, 1, 4.5, 'Well-written paper.', TIMESTAMP '2024-09-15 14:00:00');
INSERT INTO review VALUES (2, 2, 2, 3.8, 'Good but needs improvement.', TIMESTAMP '2024-09-16 12:00:00');
INSERT INTO review VALUES (3, 5, 3, 4.2, 'Interesting insights.', TIMESTAMP '2024-09-17 16:30:00');
INSERT INTO review VALUES (4, 5, 4, 4.7, 'Great potential.', TIMESTAMP '2024-09-18 14:15:00');
INSERT INTO review VALUES (5, 3, 5, 4.0, 'Solid work.', TIMESTAMP '2024-09-19 11:45:00');





INSERT INTO registration VALUES (1, 1, 4, 150, DATE '2024-08-20', 'paid');
INSERT INTO registration VALUES (2, 2, 3, 180, DATE '2024-09-05', 'paid');
INSERT INTO registration VALUES (3, 3, 5, 190, DATE '2024-09-10', 'unpaid');
INSERT INTO registration VALUES (4, 4, 6, 200, DATE '2024-09-15', 'paid');
INSERT INTO registration VALUES (5, 5, 1, 160, DATE '2024-09-20', 'unpaid');





INSERT INTO message VALUES (1, 3, TIMESTAMP '2024-09-05 10:00:00', 'Paper submitted successfully.');
INSERT INTO message VALUES (2, 4, TIMESTAMP '2024-09-06 12:30:00', 'You have been registered for the conference.');
INSERT INTO message VALUES (3, 5, TIMESTAMP '2024-09-10 14:00:00', 'Review submitted.');
INSERT INTO message VALUES (4, 6, TIMESTAMP '2024-09-15 16:30:00', 'Session added to the conference.');
INSERT INTO message VALUES (5, 1, TIMESTAMP '2024-09-20 10:00:00', 'Registration is pending.');
