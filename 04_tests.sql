set serveroutput on;

-- Test cases for features

-- Test case-

exec add_user('Ben Strokes',1,'1 Main st','21250','b.stoke@umbc.edu','USA');
exec add_user('David Warner',2,'2 Main st','21250','d.stoke@umbc.edu','USA');
exec add_user('Kagiso Rabada',3,'3 Main st','21250','k.stoke@umbc.edu','USA');
exec add_user('Virat Kohli',4,'4 Main st','21250','v.stoke@umbc.edu','USA');
exec add_user('Chris Gayle',5,'5 Main st','21250','c.stoke@umbc.edu','USA');
exec add_user('Rohit Sharma',6,'6 Main st','21250','r.stoke@umbc.edu','USA');
exec add_user('Robin Oak',5,'7 Main st','250','ro.stoke@umbc.edu','USA');
exec add_user('Alice',1,'8 Main st','2150','a.stoke@umbc.edu','USA');
exec add_user('Franz J',1,'9 Main st','297506','franzj@umbc.edu','USA');










--Feature_2
DROP TYPE roleArray;

--Create a varray to store role inputs
-- Test cases -


-- Input: Invalid conference ID
exec papers_by_conference_topic(9999, 1);
-- Output: Invalid conference ID.


-- Input: Valid conference ID but invalid topic ID
exec papers_by_conference_topic(1, 9999);
-- Output: Invalid topic ID.


-- Input: Both conference ID and topic ID are invalid
exec papers_by_conference_topic(9999, 9999);
-- Output: Invalid conference ID.


-- Input: Valid conference ID and topic ID, but no papers on that topic
exec papers_by_conference_topic(1, 2);
-- Output: (No output, as no papers are found)


-- Input: Valid conference ID and topic ID
exec papers_by_conference_topic(1, 1);
-- Output:
-- Paper ID: 8, Title: Oracle DB







-- Test cases - 


-- Input: Invalid user ID with valid paper IDs
EXEC enter_bids(999, SYS.ODCINUMBERLIST(201, 202));
-- Output: Invalid user ID.


-- Input: Valid user ID with some invalid paper IDs
EXEC enter_bids(1, SYS.ODCINUMBERLIST(5, 6, 203));
-- Output:
--id added for paper ID: 5, Bid ID: 1
--Bid added for paper ID: 6, Bid ID: 2
--Invalid paper ID: 203



-- Input: Valid user ID with valid paper IDs
EXEC enter_bids(3, SYS.ODCINUMBERLIST(1, 2));
-- Output:
--Bid added for paper ID: 1, Bid ID: 3
--Bid added for paper ID: 2, Bid ID: 4



-- Input: Valid user ID with an empty list of paper IDs
EXEC enter_bids(5, SYS.ODCINUMBERLIST());
-- Output: (No output, as there are no paper IDs to process)





--Test case 1: Validate user ID and paper ID
exec enter_review (10, 10, 5.0, 'First test case', SYSTIMESTAMP);
-- Invalid user id or paper id



--Test case 2: Check user has 'Reviewer' role for the conference
exec enter_review (4, 3, 5.0, 'Second test case', SYSTIMESTAMP);
--The user is not a reviewer.

insert into paper_author values(6,1,1);
delete from review where review_id = 4;

--Test case 3: Check for Conflict of Interest (COI)
exec enter_review (9, 6, 4.0, 'COI case', SYSTIMESTAMP);
-- A COI exists


--Test case 4: Check for existing review
exec enter_review(3, 5, 4.5, 'First comment', SYSTIMESTAMP);
exec enter_review(3, 5, 4.5, 'Updated comment', SYSTIMESTAMP);
--Update existing review


--Test case 5: New review
exec enter_review (7, 1, 5, 'New review', SYSTIMESTAMP);











--Test cases - 



-- Valid Paper ID with Reviews
BEGIN
    update_paper_status(
        ip_paper_id => 1, 
        ip_new_status => 'accepted'
    );
END;
-- Paper 1: status updated to accepted


-- Invalid Paper ID
BEGIN
    update_paper_status(
        ip_paper_id => 999, 
        ip_new_status => 'accepted'
    );
END;

-- Invalid paper ID


-- Valid Paper ID without Reviews

BEGIN
    update_paper_status(
        ip_paper_id => 2, 
        ip_new_status => 'rejected'
    );
END;
/
-- Paper 2: status updated to rejected













-- Test case 1

exec register_user_for_conference(10, 10, DATE '2024-09-10', 'unpaid');
-- Invalid user ID or conference ID.


-- Test case 2

SELECT * FROM registration WHERE user_id = 4 AND conference_id = 1;

-- Test Case: Valid user ID and conference ID, update existing registration
exec register_user_for_conference(4, 1, DATE '2024-08-21', 'unpaid');

SELECT * FROM registration WHERE user_id = 4 AND conference_id = 1;



-- Test case 3 and 4 (Funny test cases, run these separate, after all execution)
-- If it does not work just change the values around 

-- Register a user with an early registration fee
exec register_user_for_conference(5, 1, DATE '2024-07-29', 'paid');

-- Register a user with an normal registration fee
exec register_user_for_conference(6, 1, DATE '2024-08-15', 'paid');


-- Test case 5
select * from message;










-- Group Features - 



-- Featuere 9--
-- test cases - 

--TEST CASE
BEGIN
    assign_paper(1,5);
END;
/
--OUTPUT: No one has bid for this paper. user 2is assigned.


--Special case
BEGIN
    assign_paper(99,5);
END;
/
--OUTPUT: Invalid paper ID.










--Test case - 
exec review_reminder(6,TIMESTAMP '2024-12-06 12:00:00');
-- Send reminder to user:6 for missing review for paper:16
-- Send reminder to user:7 for missing review for paper:15



-- Test case -
exec review_reminder(64,TIMESTAMP '2024-12-06 12:00:00');
-- INVALID CONFERENCE ID










--Test case -  
BEGIN
    send_reminder_to_authors(3); -- Replace 1 with the desired conference ID
END;
/








--TEST CASE 1:Valid Session with Eligible Papers
DECLARE
    topics topic_array := topic_array(1, 2, 3);
BEGIN
    add_similar_paper_to_session(5, topics);
END;
/

--OUTPUT:
--Paper 9 Similarity: 0
--No suitable paper found for session 5


--TEST CASE 2: Invalid Session
DECLARE
    topics topic_array := topic_array(1, 2);
BEGIN
    add_similar_paper_to_session(999, topics);
END;
/

--OUTPUT:
--Invalid session ID



--TEST CASE 3: Similarity matches
DECLARE
    topics topic_array := topic_array(4, 5, 6);
BEGIN
    add_similar_paper_to_session(5, topics);
END;
/

--Paper 9 Similarity: .3333333333333333333333333333333333333333
--Paper 9 assigned to session 5










--Test case-

exec print_statistics;



commit;
