set serveroutput on;

-- Procedures / sequences / triggers for features

--Feature_1

DROP sequence seq_user_id;
create sequence seq_user_id start with 1 increment by 1;

create or replace PROCEDURE add_user 
(  ip_name in VARCHAR2,
   ip_iid in INT,
   ip_address in VARCHAR2,
   ip_zipcode in VARCHAR2,
   ip_email in VARCHAR2,
   ip_country in VARCHAR2
) IS 
   v_uid INT;
   v_count INT;

BEGIN

--Check for user with the same email input
SELECT count(*) INTO v_count
FROM person WHERE email = ip_email;

IF v_count > 0 THEN --email and user exist, proceed to update information
   --Update address, zipcode and country of the user with the existing email
   UPDATE person
   SET address = ip_address,
       zipcode = ip_zipcode,
       country = ip_country
   WHERE email = ip_email;
   dbms_output.put_line('The user already exists.'); --Print out user exists

ELSE 
   SELECT seq_user_id.NEXTVAL INTO v_uid FROM dual; --Generate new user id through sequence

   --Insert input parameter as new user in person table
   INSERT INTO person (user_id, institution_id, name, address, zipcode, email, country)
   VALUES (v_uid, ip_iid, ip_name, ip_address, ip_zipcode, ip_email, ip_country);
   dbms_output.put_line('New user ID: ' || v_uid); --print new user id
END IF;
END;
/



INSERT INTO institution VALUES (1, 'UMBC', 'USA');
INSERT INTO institution VALUES (2, 'Johns Hopkins University', 'USA');
INSERT INTO institution VALUES (3, 'Stanford University', 'USA');
INSERT INTO institution VALUES (4, 'Oxford University', 'UK');
INSERT INTO institution VALUES (5, 'University of Tokyo', 'Japan');
INSERT INTO institution VALUES (6, 'Indian Institute of Technology Delhi', 'India');





INSERT INTO conference VALUES (1, 'Database Systems Conference', 2024, DATE '2024-10-15', DATE '2024-10-17', TIMESTAMP '2024-09-01 23:59:59.00', TIMESTAMP '2024-09-15 23:59:59.00', TIMESTAMP '2024-09-30 23:59:59.00', 'Baltimore', 'USA', DATE '2024-08-01', 100, 150);
INSERT INTO conference VALUES (2, 'AI and Machine Learning Symposium', 2024, DATE '2024-11-01', DATE '2024-11-03', TIMESTAMP '2024-09-10 23:59:59', TIMESTAMP '2024-09-30 23:59:59', TIMESTAMP '2024-10-15 23:59:59', 'San Francisco', 'USA', DATE '2024-08-10', 120, 180);
INSERT INTO conference VALUES (3, 'Cybersecurity Summit', 2024, DATE '2024-12-05', DATE '2024-12-07', TIMESTAMP '2024-10-01 23:59:59', TIMESTAMP'2024-10-20 23:59:59', TIMESTAMP'2024-11-10 23:59:59', 'Boston', 'USA', DATE'2024-09-01', 130, 190);
INSERT INTO conference VALUES (4, 'Quantum Computing Conference', 2024, DATE '2024-08-25', DATE '2024-08-27', TIMESTAMP '2024-07-01 23:59:59', TIMESTAMP '2024-07-15 23:59:59', TIMESTAMP '2024-08-05 23:59:59', 'London', 'UK', DATE '2024-06-01', 140, 200);
INSERT INTO conference VALUES (5, 'Blockchain Conference', 2024, DATE '2024-09-10', DATE '2024-09-12', TIMESTAMP '2024-07-15 23:59:59', TIMESTAMP '2024-08-01 23:59:59', TIMESTAMP '2024-08-20 23:59:59', 'Tokyo', 'Japan', DATE '2024-07-01', 110, 160);




CREATE or REPLACE TYPE roleArray AS varray(20) OF varchar2(50);
/

create or replace PROCEDURE add_userRoles 
(  ip_uid  in INT,
   ip_cid in INT,
   ip_roles in roleArray 
) AS 
   v_ucount INT;
   v_ccount INT;
   v_rcount INT;

BEGIN

--Check if user_id and conference_id exist
SELECT count(*) INTO v_ucount
FROM person WHERE user_id = ip_uid;

SELECT count(*) INTO v_ccount
FROM conference WHERE conference_id = ip_cid;

IF v_ucount = 0 OR v_ccount = 0 THEN --user_id or conference_id invalid 
	dbms_output.put_line('Invalid user ID or conference ID.');
	RETURN;
END IF;

--Check each role in the role list
FOR i IN 1..ip_roles.COUNT 
LOOP
   --Check for existing record of user's role, avoid duplicates
   SELECT count(*) INTO v_rcount
   FROM user_roles 
   WHERE user_id = ip_uid AND conference_id = ip_cid
   AND role = ip_roles(i);

   IF v_rcount > 0 THEN
	dbms_output.put_line('Role already exists.');
   ELSE 
	--Insert role if no records found
	INSERT INTO user_roles (user_id, conference_id, role)
	VALUES (ip_uid, ip_cid, ip_roles(i));
	dbms_output.put_line('Role added successfully.');
   END IF;
END LOOP;

END;
/




--Normal Case
DECLARE
    roles roleArray := roleArray('Organizer');
BEGIN
    add_userroles(1,1,roles);
END;
/

DECLARE
    roles roleArray := roleArray('reviewer');
BEGIN
    add_userroles(2,1,roles);
END;
/

DECLARE
    roles roleArray := roleArray('author');
BEGIN
    add_userroles(3,1,roles);
END;
/

DECLARE
    roles roleArray := roleArray('participant');
BEGIN
    add_userroles(4,2,roles);
END;
/
DECLARE
    roles roleArray := roleArray('reviewer');
BEGIN
    add_userroles(5,3,roles);
END;
/
DECLARE
    roles roleArray := roleArray('Organizer');
BEGIN
    add_userroles(6,4,roles);
END;
/
DECLARE
    roles roleArray := roleArray('author');
BEGIN
    add_userroles(1,5,roles);
END;
/

DECLARE
    roles roleArray := roleArray('reviewer');
BEGIN
    add_userroles(7,5,roles);
END;
/
DECLARE
    roles roleArray := roleArray('author');
BEGIN
    add_userroles(2,1,roles);
END;
/
DECLARE
    roles roleArray := roleArray('reviewer');
BEGIN
    add_userroles(9,1,roles);
END;
/
DECLARE
    roles roleArray := roleArray('reviewer');
BEGIN
    add_userroles(9,5,roles);
END;
/
DECLARE
    roles roleArray := roleArray('reviewer');
BEGIN
    add_userroles(9,3,roles);
END;
/
DECLARE
    roles roleArray := roleArray('reviewer');
BEGIN
    add_userroles(8,3,roles);
END;
/
DECLARE
    roles roleArray := roleArray('reviewer');
BEGIN
    add_userroles(7,3,roles);
END;
/


-- Already exists
DECLARE
    roles roleArray := roleArray('reviewer');
BEGIN
    add_userroles(7,3,roles);
END;
/


-- Invalid
DECLARE
    roles roleArray := roleArray('reviewer');
BEGIN
    add_userroles(77,44,roles);
END;
/










-- Feature 3 - 

-- Drop procedure and sequence if they already exist
DROP PROCEDURE add_paper;
DROP SEQUENCE seq_paper_id;

-- Create sequence to auto-generate paper_id
CREATE SEQUENCE seq_paper_id START WITH 7 INCREMENT BY 1;

create or replace PROCEDURE add_paper(
    ip_conf_id IN INT,
    ip_title IN VARCHAR2,
    ip_submit_time IN TIMESTAMP,
    ip_author_ids IN SYS.ODCINUMBERLIST,
    ip_topic_ids IN SYS.ODCINUMBERLIST
) IS
    v_paper_id INT;
    v_conf_count INT;
    v_paper_count INT;
    v_topic_count INT;
    v_author_count INT;
BEGIN
    -- 1. Check if conference ID is valid
    SELECT COUNT(*) INTO v_conf_count 
    FROM conference 
    WHERE conference_id = ip_conf_id;

    IF v_conf_count = 0 THEN
        dbms_output.put_line('Invalid conference ID');
        RETURN;
    END IF;

    -- 2. Check if a paper with the same title exists in the same conference
    SELECT COUNT(*) INTO v_paper_count 
    FROM paper 
    WHERE paper_title = ip_title AND conference_id = ip_conf_id;

    IF v_paper_count > 0 THEN
        -- Paper exists, update its information
        UPDATE paper
        SET submit_time = ip_submit_time
        WHERE paper_title = ip_title AND conference_id = ip_conf_id;

        dbms_output.put_line('Paper exists, updated its information');
    ELSE
        -- Paper does not exist, insert a new paper
        SELECT seq_paper_id.NEXTVAL INTO v_paper_id FROM dual;

        INSERT INTO paper (paper_id, conference_id, paper_title, submit_time, status)
        VALUES (v_paper_id, ip_conf_id, ip_title, ip_submit_time, 'submitted');

        dbms_output.put_line('New paper ID: ' || v_paper_id);
    END IF;

    -- Get the paper ID for the subsequent steps
    SELECT paper_id INTO v_paper_id 
    FROM paper 
    WHERE paper_title = ip_title AND conference_id = ip_conf_id;

    -- 3. Insert into paper_topic table for valid topic IDs
    FOR i IN ip_topic_ids.FIRST .. ip_topic_ids.LAST LOOP
        SELECT COUNT(*) INTO v_topic_count 
        FROM topic 
        WHERE topic_id = ip_topic_ids(i);

        IF v_topic_count > 0 THEN
            MERGE INTO paper_topic pt
            USING (SELECT v_paper_id AS paper_id, ip_topic_ids(i) AS topic_id FROM dual) src
            ON (pt.paper_id = src.paper_id AND pt.topic_id = src.topic_id)
            WHEN NOT MATCHED THEN
                INSERT (paper_id, topic_id) 
                VALUES (src.paper_id, src.topic_id);
        END IF;
    END LOOP;

    -- 4. Delete old author information for the given paper
    DELETE FROM paper_author WHERE paper_id = v_paper_id;

    -- 5. Insert into paper_author table for valid user IDs
    FOR i IN ip_author_ids.FIRST .. ip_author_ids.LAST LOOP
        SELECT COUNT(*) INTO v_author_count 
        FROM person 
        WHERE user_id = ip_author_ids(i);

        IF v_author_count > 0 THEN
            INSERT INTO paper_author (paper_id, user_id, author_order)
            VALUES (v_paper_id, ip_author_ids(i), i);
        END IF;
    END LOOP;

END;
/


INSERT INTO paper VALUES (1, 'Efficient Query Processing', 1, TIMESTAMP '2024-09-01 12:30:00', NULL, 'submitted', NULL);
INSERT INTO paper VALUES (2, 'Advanced Indexing Techniques', 1, TIMESTAMP '2024-09-02 14:00:00', NULL, 'submitted', NULL);
INSERT INTO paper VALUES (3, 'AI for Healthcare', 2, TIMESTAMP '2024-09-05 16:30:00', NULL, 'submitted', NULL);
INSERT INTO paper VALUES (4, 'Quantum Computing in AI', 4, TIMESTAMP '2024-07-01 15:00:00', NULL, 'submitted', NULL);
INSERT INTO paper VALUES (5, 'Blockchain for Supply Chains', 5, TIMESTAMP '2024-07-20 17:00:00', NULL, 'submitted', NULL);
INSERT INTO paper VALUES (6, 'NFT for Payments', 5, TIMESTAMP '2024-09-01 06:00:00', NULL, 'submitted', NULL);



INSERT INTO topic VALUES (1, 'Database Optimization');
INSERT INTO topic VALUES (2, 'Indexing Techniques');
INSERT INTO topic VALUES (3, 'Query Processing');
INSERT INTO topic VALUES (4, 'AI in Healthcare');
INSERT INTO topic VALUES (5, 'Quantum Computing');
INSERT INTO topic VALUES (6, 'Blockchain');


-- Adds new paper
BEGIN
    add_paper(
        ip_conf_id => 3,
        ip_title => 'AWS S3',
        ip_submit_time => SYSTIMESTAMP,
        ip_author_ids => SYS.ODCINUMBERLIST(1),
        ip_topic_ids => SYS.ODCINUMBERLIST(1)
    );
END;
/


BEGIN
    add_paper(
        ip_conf_id => 1,
        ip_title => 'Oracle DB',
        ip_submit_time => SYSTIMESTAMP,
        ip_author_ids => SYS.ODCINUMBERLIST(1),
        ip_topic_ids => SYS.ODCINUMBERLIST(1)
    );
END;
/


BEGIN
    add_paper(
        ip_conf_id => 3,
        ip_title => 'Creating profitable cryptocurrency',
        ip_submit_time => SYSTIMESTAMP,
        ip_author_ids => SYS.ODCINUMBERLIST(1),
        ip_topic_ids => SYS.ODCINUMBERLIST(6)
    );
END;
/




-- Invalid conf. ID
BEGIN
    add_paper(
        ip_conf_id => 777,
        ip_title => 'Machine Learning Applications',
        ip_submit_time => SYSTIMESTAMP,
        ip_author_ids => SYS.ODCINUMBERLIST(4),
        ip_topic_ids => SYS.ODCINUMBERLIST(2)
    );
END;








-- Feature 4 - 


drop procedure papers_by_conference_topic;

create or replace PROCEDURE papers_by_conference_topic(
    ip_conference_id IN INT,
    ip_topic_id IN INT
) IS
    v_conf_count INT;
    v_topic_count INT;
BEGIN
    -- Check if the conference ID exists
    SELECT COUNT(*) INTO v_conf_count
    FROM conference
    WHERE conference_id = ip_conference_id;

    -- Check if the topic ID exists
    SELECT COUNT(*) INTO v_topic_count
    FROM topic
    WHERE topic_id = ip_topic_id;

    -- If either conference ID or topic ID is invalid, print error message
    IF v_conf_count = 0 THEN
        dbms_output.put_line('Invalid conference ID.');
    ELSIF v_topic_count = 0 THEN
        dbms_output.put_line('Invalid topic ID.');
    ELSE
        -- Both IDs are valid, list papers submitted to the conference on the topic
        FOR rec IN (
            SELECT p.paper_id, p.paper_title
            FROM paper p
            JOIN paper_topic pt ON p.paper_id = pt.paper_id
            WHERE p.conference_id = ip_conference_id
              AND pt.topic_id = ip_topic_id
        ) LOOP
            dbms_output.put_line('Paper ID: ' || rec.paper_id || ', Title: ' || rec.paper_title);
        END LOOP;
    END IF;
END;
/





-- Feature 5 - 
DROP PROCEDURE enter_bids;
DROP SEQUENCE seq_bid_id;

-- Create sequence for generating bid IDs
CREATE SEQUENCE seq_bid_id START WITH 1 INCREMENT BY 1;

create or replace PROCEDURE enter_bids (
    ip_user_id IN INT,
    ip_paper_ids IN SYS.ODCINUMBERLIST
) IS
    v_user_count INT;
    v_paper_count INT;
    v_bid_id INT;
    v_existing_count INT;
BEGIN
    -- Check if the user ID exists
    SELECT COUNT(*) INTO v_user_count
    FROM person
    WHERE user_id = ip_user_id;

    IF v_user_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Invalid user ID.');
        RETURN;
    END IF;

    -- Loop through each paper ID in the input list
    FOR i IN 1 .. ip_paper_ids.COUNT LOOP
        -- Check if the paper ID exists
        SELECT COUNT(*) INTO v_paper_count
        FROM paper
        WHERE paper_id = ip_paper_ids(i);

        IF v_paper_count = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Invalid paper ID: ' || ip_paper_ids(i));
        ELSE
            -- Check if the bid already exists
            SELECT COUNT(*) INTO v_existing_count
            FROM paper_bid
            WHERE user_id = ip_user_id AND paper_id = ip_paper_ids(i);

            IF v_existing_count > 0 THEN
                DBMS_OUTPUT.PUT_LINE('Bid already exists for paper ID: ' || ip_paper_ids(i));
            ELSE
                -- Generate new bid ID and insert into paper_bid table
                SELECT seq_bid_id.NEXTVAL INTO v_bid_id FROM dual;

                INSERT INTO paper_bid (bid_id, user_id, paper_id)
                VALUES (v_bid_id, ip_user_id, ip_paper_ids(i));

                DBMS_OUTPUT.PUT_LINE('Bid added for paper ID: ' || ip_paper_ids(i) || 
                                      ', Bid ID: ' || v_bid_id);
            END IF;
        END IF;
    END LOOP;
END;
/



-- Feature 6-

drop procedure enter_review;


create or replace PROCEDURE enter_review(
    ip_user_id IN NUMBER,
    ip_paper_id IN NUMBER,
    ip_review_score IN NUMBER,
    ip_review_comment IN VARCHAR2,
    ip_upload_time IN TIMESTAMP
) IS
    v_conference_id NUMBER;
    v_user_institution_id NUMBER;
    v_author_institution_id NUMBER;
    v_user_role VARCHAR2(50);
    v_review_id NUMBER;
    v_count NUMBER;

BEGIN
    -- Step 1: Validate user ID and paper ID
    SELECT COUNT(*) INTO v_count 
    FROM person u, paper p
    WHERE u.user_id = ip_user_id AND p.paper_id = ip_paper_id;

    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Invalid user id or paper id');
        RETURN;
    END IF;

    -- Step 2: Check user has 'Reviewer' role for the conference
    SELECT p.conference_id INTO v_conference_id
    FROM paper p
    WHERE p.paper_id = ip_paper_id;

    SELECT COUNT(*) INTO v_count
    FROM user_roles ur
    WHERE ur.conference_id = v_conference_id AND ur.role = 'reviewer';

    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('The user is not a reviewer.');
        RETURN;
    END IF;

    -- Step 3: Check for Conflict of Interest (COI)
    SELECT u.institution_id INTO v_user_institution_id
    FROM person u
    WHERE u.user_id = ip_user_id;

    SELECT COUNT(*) INTO v_count
    FROM paper_author pa, person u
    WHERE pa.paper_id = ip_paper_id AND pa.user_id = u.user_id AND u.institution_id = v_user_institution_id;

    IF v_count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('A COI exists');
        RETURN;
    END IF;

    -- Step 4: Check for existing review
    SELECT COUNT(*) INTO v_count
    FROM review r
    WHERE r.user_id = ip_user_id AND r.paper_id = ip_paper_id;

    IF v_count > 0 THEN
        -- Update existing review
        UPDATE review
        SET review_score = ip_review_score,
            review_comments = ip_review_comment,
            review_upload_time = ip_upload_time
        WHERE user_id = ip_user_id AND paper_id = ip_paper_id;
        DBMS_OUTPUT.PUT_LINE('Update existing review');
    ELSE
        -- Insert new review
        SELECT NVL(MAX(review.review_id), 0) + 1 INTO v_review_id FROM review;

        INSERT INTO review (review_id, user_id, paper_id, review_score, review_comments, review_upload_time)
        VALUES (v_review_id, ip_user_id, ip_paper_id, ip_review_score, ip_review_comment, ip_upload_time);

        DBMS_OUTPUT.PUT_LINE('Review added');
    END IF;

END;
/


INSERT INTO conference_session VALUES (1, 1, 1, 'Database Optimization', TIMESTAMP '2024-10-15 09:00:00', TIMESTAMP '2024-10-15 10:30:00');
INSERT INTO conference_session VALUES (2, 1, 2, 'SQL Performance Tuning', TIMESTAMP '2024-10-15 11:00:00', TIMESTAMP '2024-10-15 12:30:00');
INSERT INTO conference_session VALUES (3, 2, 3, 'AI in Healthcare', TIMESTAMP '2024-11-01 09:30:00', TIMESTAMP '2024-11-01 11:00:00');
INSERT INTO conference_session VALUES (4, 2, 4, 'Deep Learning Algorithms', TIMESTAMP '2024-11-01 11:30:00', TIMESTAMP '2024-11-01 13:00:00');
INSERT INTO conference_session VALUES (5, 3, 5, 'Security in IoT Devices', TIMESTAMP '2024-12-05 10:00:00', TIMESTAMP'2024-12-05 11:30:00');




-- Feature 7 - 
-- Drop procedure if it already exists
DROP PROCEDURE update_paper_status;
DROP SEQUENCE message_seq;

CREATE SEQUENCE message_seq START WITH 1 INCREMENT BY 1;

create or replace PROCEDURE update_paper_status(
    ip_paper_id IN INT,
    ip_new_status IN VARCHAR2
) IS
    v_avg_score NUMBER(5, 2);       -- To store the average review score
    v_paper_count INT;              -- To check if the paper ID is valid
    v_message_body VARCHAR2(200);   -- To construct the message body
    v_message_id INT;               -- For storing message ID
BEGIN
    -- 1. Check if the paper ID is valid
    SELECT COUNT(*) INTO v_paper_count 
    FROM paper 
    WHERE paper_id = ip_paper_id;

    IF v_paper_count = 0 THEN
        dbms_output.put_line('Invalid paper ID');
        RETURN;
    END IF;

    -- 2. Compute the average review score for the paper
    SELECT AVG(review_score) INTO v_avg_score 
    FROM review 
    WHERE paper_id = ip_paper_id;

    -- Update the paper's average review score and status
    UPDATE paper
    SET average_review_score = v_avg_score,
        status = ip_new_status
    WHERE paper_id = ip_paper_id;

    dbms_output.put_line('Paper ' || ip_paper_id || ': status updated to ' || ip_new_status);

    -- 3. Insert a message for each author of the paper
    FOR author IN (
        SELECT user_id 
        FROM paper_author 
        WHERE paper_id = ip_paper_id
    ) LOOP
        -- Generate new message ID using sequence
        SELECT message_seq.NEXTVAL INTO v_message_id FROM dual;

        -- Construct the message body
        v_message_body := 'Paper ' || ip_paper_id || ': status is updated to ' || ip_new_status;

        -- Insert message into the message table
        INSERT INTO message (message_id, user_id, message_time, message_body)
        VALUES (v_message_id, author.user_id, SYSTIMESTAMP, v_message_body);
    END LOOP;

END;
/



-- Feature 8 -

UPDATE registration SET payment_status = 'paid' WHERE user_id = 4 AND conference_id= 1;
DELETE FROM registration WHERE user_id = 5 AND conference_id = 1;
DELETE FROM registration WHERE user_id = 6 AND conference_id = 1;
DELETE FROM message;

-- Droping sequence to avoid errors
DROP SEQUENCE message_seq;
DROP SEQUENCE registration_seq;


create sequence message_seq;
create sequence registration_seq;

create or replace PROCEDURE register_user_for_conference(
    p_user_id          INT,
    p_conference_id    INT,
    p_current_date     DATE,
    p_payment_status   VARCHAR2
) AS
    v_registration_id      INT;
    v_message_id           INT;
    v_early_registration   DATE;
    v_early_fee            INT;
    v_regular_fee          INT;
    v_registration_fee     INT;
BEGIN
    -- Check if user ID and conference ID are valid
    BEGIN
        SELECT 1 INTO v_registration_id FROM person WHERE user_id = p_user_id;
        SELECT 1 INTO v_registration_id FROM conference WHERE conference_id = p_conference_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Invalid user ID or conference ID.');
            RETURN;
    END;

    -- Check for existing registration
    BEGIN
        SELECT registration_id INTO v_registration_id 
        FROM registration 
        WHERE user_id = p_user_id AND conference_id = p_conference_id;

        -- Update existing registration
        UPDATE registration
        SET payment_status = p_payment_status
        WHERE registration_id = v_registration_id;
        DBMS_OUTPUT.PUT_LINE('Update status of an existing registration.');
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            -- No existing registration, proceed to create a new one

            -- Determine registration fee
            SELECT early_registration_date, early_registration_fee, regular_registration_fee 
            INTO v_early_registration, v_early_fee, v_regular_fee 
            FROM conference 
            WHERE conference_id = p_conference_id;

            IF p_current_date <= v_early_registration THEN
                v_registration_fee := v_early_fee;
            ELSE
                v_registration_fee := v_regular_fee;
            END IF;

            -- Insert new registration
            SELECT registration_seq.NEXTVAL INTO v_registration_id FROM dual;
            INSERT INTO registration(
                registration_id,
                conference_id,
                user_id,
                registration_fee,
                payment_date,
                payment_status
            ) VALUES (
                v_registration_id,
                p_conference_id,
                p_user_id,
                v_registration_fee,
                p_current_date,
                p_payment_status
            );
            DBMS_OUTPUT.PUT_LINE('New registration inserted.');
    END;

    -- Insert message
    SELECT message_seq.NEXTVAL INTO v_message_id FROM dual;
    INSERT INTO message(
        message_id,
        user_id,
        message_time,
        message_body
    ) VALUES (
        v_message_id,
        p_user_id,
        SYSDATE,
        'You are registered with status ' || p_payment_status
    );

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END register_user_for_conference;

/






--FEATURE 9

DROP PROCEDURE assign_paper;
DROP SEQUENCE seq_review_id;

CREATE SEQUENCE seq_review_id;


create or replace PROCEDURE assign_paper 
( ip_pid in INT,
  max_reviews in INT
) IS 
  v_paper_count INT;
  v_review_count INT;
  v_bid_count INT;
  v_assigned INT := 0;

   CURSOR eligible IS
	SELECT p.user_id
	FROM person p
	JOIN user_roles ur ON p.user_id = ur.user_id
	WHERE ur.role = 'reviewer' 
	AND ur.conference_id = (SELECT conference_id FROM paper WHERE paper_id = ip_pid)
	AND NOT EXISTS 
	( SELECT 1 
	  FROM paper_author pa
	  JOIN person p1 ON pa.user_id = p1.user_id
	  WHERE pa.paper_id = ip_pid AND p1.institution_id = p.institution_id )
	AND NOT EXISTS 
	( SELECT 1 
	  FROM review r
	  WHERE r.paper_id = ip_pid AND r.user_id = p.user_id );

BEGIN

--Check if paper id exist
SELECT count(*) INTO v_paper_count
FROM paper
WHERE paper_id = ip_pid;

IF v_paper_count = 0 THEN
   dbms_output.put_line('Invalid paper ID.');
   return;
END IF;

FOR i IN eligible LOOP
  SELECT count(*) INTO v_review_count
  FROM review r
  JOIN paper pa ON r.paper_id = pa.paper_id
  WHERE r.user_id = i.user_id
  AND pa.conference_id = (SELECT conference_id FROM paper WHERE paper_id = ip_pid);

  IF v_review_count >= max_reviews THEN
	dbms_output.put_line('User ' || i.user_id || 'has reached capacity.');
  ELSE
	SELECT COUNT(*) INTO v_bid_count
	FROM paper_bid pb
	WHERE pb.user_id = i.user_id AND pb.paper_id = ip_pid;

	IF v_bid_count > 0 THEN
	  dbms_output.put_line('Assign to user '|| i.user_id);
	  INSERT INTO review (review_id, user_id, paper_id) VALUES (seq_review_id.NEXTVAL, i.user_id, ip_pid);
	  v_assigned := 1;
	  return;
	END IF;
  END IF;
END LOOP;

IF v_assigned = 0 THEN
  dbms_output.put_line('No one has bid for this paper.');

  FOR i IN eligible LOOP
	SELECT count(*) INTO v_review_count  
	FROM review r
	JOIN paper pa ON r.paper_id = pa.paper_id
  	WHERE r.user_id = i.user_id
  	AND pa.conference_id = (SELECT conference_id FROM paper WHERE paper_id = ip_pid);

	IF v_review_count < max_reviews THEN
	  dbms_output.put_line('User ' || i.user_id || 'is assigned.');
	  INSERT INTO review (review_id, user_id, paper_id) VALUES (seq_review_id.NEXTVAL, i.user_id, ip_pid);
      v_assigned := 1;
      RETURN;
	END IF;
  END LOOP;
END IF;

IF v_assigned = 0 THEN
  dbms_output.put_line('All reviewers have reached capacity.');
END IF;

END;
/




-- Feature 10 -

drop procedure review_reminder;

drop sequence messages_id_seq;

create sequence messages_id_seq;


create or replace PROCEDURE review_reminder(c_conf_id in INT,inp_time IN TIMESTAMP)AS
CURSOR C1 IS SELECT pr.review_id,pr.user_id,pr.paper_id,c.conference_title,rp.conference_id--cursor to find required deatils 
FROM review pr,conference c,paper rp
WHERE pr.paper_id=rp.paper_id AND c.conference_id=rp.conference_id AND rp.conference_id=c_conf_id 
AND pr.review_upload_time is NULL AND(pr.review_score IS NULL or pr.review_comments IS NULL) 
AND review_due_time<inp_time;
c_con_count INT;
r_review_id INT;
r_reviewer_id INT;
p_pid INT;
c_ctitle conference.conference_title%type;
c_conid INT;
new_msg_id number;

BEGIN
--CHECKING IF THE CONFERENCE ID IS VALID
SELECT COUNT(*) INTO c_con_count FROM conference WHERE conference_id = c_conf_id;
--IF CONFERENCE ID IS INVALID THEN
IF c_con_count=0 THEN
    DBMS_OUTPUT.PUT_LINE('INVALID CONFERENCE ID');
    RETURN;
END IF;
--IF CONFERENCE ID IS VALID
IF c_con_count>0 then
    OPEN C1;
    LOOP
    FETCH C1 INTO r_review_id,r_reviewer_id,p_pid,c_ctitle,c_conid;--inserting all the required details into the resp variables
    EXIT WHEN C1%NOTFOUND;
    --for each past due review found, inserting into message table with new message id
    --generating new meaasge id using sequence
    Select messages_id_seq.NEXTVAL INTO new_msg_id FROM dual;

    --inserting into the messages table
    INSERT INTO message(message_id,user_id,message_time,message_body)
    VALUES (new_msg_id,r_reviewer_id,inp_time,'Your review for paper:'||p_pid||' submitted to conference:'||c_ctitle||' is past due please upload your review asap');
    DBMS_OUTPUT.PUT_LINE('Send reminder to user:'||r_reviewer_id||' for missing review for paper:'||p_pid);
    END LOOP;
    CLOSE C1;
END IF;
END;
/




--Feature 10

-- DELETE FROM conference WHERE confernce_id = 6
INSERT INTO conference VALUES 
(6, 'Test Conference', 2024, DATE '2024-12-01', DATE '2024-12-03', TIMESTAMP '2024-11-01 23:59:59', TIMESTAMP '2024-11-15 23:59:59', TIMESTAMP '2024-11-30 23:59:59', 'New York', 'USA', DATE '2024-10-01', 150, 200);


--DELETE FROM paper WHERE paper_id=7;
--DELETE FROM paper WHERE paper_id=8;
INSERT INTO paper VALUES 
(15, 'Future Database Tech', 6, TIMESTAMP '2024-10-15 12:00:00', NULL, 'submitted', NULL);
INSERT INTO paper VALUES 
(16, 'AI and Ethics', 6, TIMESTAMP '2024-10-20 14:00:00', NULL, 'submitted', NULL);

--DELETE FROM reveiew WHERE review_id = 6 AND user_id = 7 AND paper_id=7;
--DELETE FROM reveiew WHERE review_id = 7 AND user_id = 6 AND paper_id=8 AND review_score = 3.0;
INSERT INTO review VALUES 
(20, 7, 15, NULL, NULL, NULL); -- Missing review score and comments
INSERT INTO review VALUES 
(21, 6, 16, 3.0, NULL, NULL); -- Missing review comments


-- Feature 11 - 
drop procedure send_reminder_to_authors;


create or replace PROCEDURE send_reminder_to_authors(p_cid INT) AS
    v_conference_title VARCHAR2(100);
    v_early_res_date DATE;
    v_paper_id INT;
    v_author_id INT;
    v_author_name VARCHAR2(30);
    v_message_id INT;
    v_count INT; 
BEGIN
    -- Check if the conference ID is valid
    SELECT COUNT(*)
    INTO v_count
    FROM conference
    WHERE conference_id = p_cid;

    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Invalid conference ID');
        RETURN;
    END IF;

    -- Get conference title and early registration date
    SELECT conference_title, early_registration_date
    INTO v_conference_title, v_early_res_date
    FROM conference
    WHERE conference_id = p_cid;


    -- Loop through each accepted paper of the conference
    FOR paper_rec IN (
        SELECT paper_id
        FROM paper
        WHERE conference_id = p_cid AND status = 'accepted' --means accepted
    ) LOOP
        v_paper_id := paper_rec.paper_id;

        -- Check if any author has registered for the conference
        SELECT COUNT(*)
        INTO v_count
        FROM  paper_author a
        JOIN registration r ON a.user_id = r.user_id
        WHERE a.paper_id = v_paper_id AND r.conference_id = p_cid;
  

        -- If no author has registered, send a reminder
        IF v_count = 0 THEN
            FOR author_rec IN (
                SELECT a.user_id, p.name
                FROM paper_author a
                JOIN person p ON a.user_id = p.user_id
                WHERE a.paper_id = v_paper_id
            ) LOOP
                v_author_id := author_rec.user_id;
                v_author_name := author_rec.name;

                -- Generate a new message ID
                SELECT NVL(MAX(message_id), 0) + 1 INTO v_message_id FROM message;

                -- Insert a message for each author
                INSERT INTO message (message_id, user_id, message_time, message_body)
                VALUES (
                    v_message_id,
                    v_author_id,
                    SYSTIMESTAMP,
                    'Dear ' || v_author_name || ', your paper ' || v_paper_id || 
                    ' has been accepted to Conference ' || v_conference_title || 
                    ', please register by ' || TO_CHAR(v_early_res_date, 'YYYY-MM-DD')
                );
            END LOOP;
        END IF;
    END LOOP;
END;
/



-- Inserts -

BEGIN
    update_paper_status(
        ip_paper_id => 9, 
        ip_new_status => 'accepted'
    );
END;
/

-- Inserts --

DECLARE
    roles roleArray := roleArray('reviewer');
BEGIN
    add_userroles(9,3,roles);
END;
/
DECLARE
    roles roleArray := roleArray('reviewer');
BEGIN
    add_userroles(8,3,roles);
END;
/
DECLARE
    roles roleArray := roleArray('reviewer');
BEGIN
    add_userroles(7,3,roles);
END;
/


insert into review values(1, 7, 9, 5.0, 'Best paper ever!! Saved my marriage', SYSTIMESTAMP);
insert into review values(2, 9,9,3.2, 'ngl, kinda mid', SYSTIMESTAMP);
insert into review values(3, 8, 9, 4.0, 'Good enough', SYSTIMESTAMP);



-- Feature 12 - 

drop procedure add_similar_paper_to_session;

CREATE OR REPLACE TYPE topic_array AS VARRAY(100) OF NUMBER;
/


create or replace PROCEDURE add_similar_paper_to_session (
    p_sess_id IN NUMBER,       -- Input: Session ID
    p_topic_list IN topic_array   -- Input: List of topics
) AS
    max_similarity NUMBER := 0;           -- Max similarity score
    best_paper_id NUMBER := 0;            -- Best paper ID

    intersection_count NUMBER := 0;       -- Size of intersection
    union_count NUMBER := 0;              -- Size of union
    similarity_score NUMBER := 0;         -- Computed similarity score
    curr_paper_id NUMBER;                 -- Current paper ID

    -- Cursor for fetching unassigned papers in the session's conference
    CURSOR unassigned_papers IS
        SELECT p.paper_id
        FROM paper p
        JOIN conference_session cs ON p.conference_id = cs.conference_id
        WHERE cs.session_id = p_sess_id
          AND p.status = 'accepted'
          AND p.session_id IS NULL;

    -- Cursor for fetching paper topics
    CURSOR paper_topic (p_id NUMBER) IS
        SELECT topic_id
        FROM paper_topic
        WHERE paper_id = p_id;

    v_sess_exists NUMBER;  -- Variable to check if session ID exists
    topic_found BOOLEAN;   -- Flag to indicate if a topic is found
BEGIN
    -- Step 1: Validate session ID
    SELECT COUNT(*) INTO v_sess_exists
    FROM conference_session
    WHERE session_id = p_sess_id;

    IF v_sess_exists = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Invalid session ID');
        RETURN;
    END IF;

    -- Step 2: Iterate through unassigned papers
    FOR paper_rec IN unassigned_papers LOOP
        curr_paper_id := paper_rec.paper_id;

        -- Initialize intersection and union counts
        intersection_count := 0;
        union_count := p_topic_list.COUNT;

        -- Step 3: Calculate intersection and union for similarity
        FOR topic_rec IN paper_topic(curr_paper_id) LOOP
            topic_found := FALSE;

            -- Check if the topic exists in the input list
            FOR i IN 1 .. p_topic_list.COUNT LOOP
                IF topic_rec.topic_id = p_topic_list(i) THEN
                    intersection_count := intersection_count + 1; -- Increment for matching topics
                    topic_found := TRUE; -- Mark topic as found
                    EXIT; -- Exit the loop if a match is found
                END IF;
            END LOOP;

            -- Increment union count for non-matching topics
            IF NOT topic_found THEN
                union_count := union_count + 1;
            END IF;
        END LOOP;

        -- Compute similarity score
        similarity_score := intersection_count / union_count;

        -- Print similarity score for each paper
        DBMS_OUTPUT.PUT_LINE('Paper ' || curr_paper_id || ' Similarity: ' || similarity_score);

        -- Step 4: Update best paper based on similarity score
        IF similarity_score > max_similarity THEN
            max_similarity := similarity_score;
            best_paper_id := curr_paper_id;
        END IF;
    END LOOP;

    -- Step 5: Assign the best paper to the session
    IF best_paper_id > 0 THEN
        UPDATE paper
        SET session_id = p_sess_id
        WHERE paper_id = best_paper_id;

        DBMS_OUTPUT.PUT_LINE('Paper ' || best_paper_id || ' assigned to session ' || p_sess_id);
    ELSE
        DBMS_OUTPUT.PUT_LINE('No suitable paper found for session ' || p_sess_id);
    END IF;
END;
/








-- Feature 13-
drop procedure print_statistics;

create or replace PROCEDURE print_statistics IS
BEGIN
    -- 1. Print acceptance rate for each conference
    DBMS_OUTPUT.PUT_LINE('==============================================');
    DBMS_OUTPUT.PUT_LINE('Conference Title                  | Acceptance Rate');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------');
    FOR rec IN (
        SELECT 
            c.conference_title,
            COUNT(p.paper_id) * 100.0 / SUM(COUNT(p.paper_id)) OVER (PARTITION BY c.conference_id) AS acceptance_rate
        FROM 
            conference c
            JOIN paper p ON c.conference_id = p.conference_id
        WHERE 
            p.status = 'accepted' -- Assume 'accepted' papers
        GROUP BY 
            c.conference_id, c.conference_title
    ) LOOP
        DBMS_OUTPUT.PUT_LINE(rpad(rec.conference_title, 30) || ' | ' || to_char(rec.acceptance_rate, '90.00') || '%');
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('==============================================');

    -- 2. Print number of papers accepted, number of sessions, number of users registered for each conference
    DBMS_OUTPUT.PUT_LINE('Conference Title                  | Papers Accepted | Sessions | Users Registered');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------');
    FOR rec IN (
        SELECT 
            c.conference_title,
            COUNT(DISTINCT p.paper_id) AS papers_accepted,
            COUNT(DISTINCT cs.session_id) AS number_of_sessions,
            COUNT(DISTINCT r.user_id) AS number_of_users_registered
        FROM 
            conference c
            LEFT JOIN paper p ON c.conference_id = p.conference_id AND p.status = 'accepted'
            LEFT JOIN conference_session cs ON c.conference_id = cs.conference_id
            LEFT JOIN registration r ON c.conference_id = r.conference_id
        GROUP BY 
            c.conference_title
    ) LOOP
        DBMS_OUTPUT.PUT_LINE(rpad(rec.conference_title, 30) || ' | ' || rpad(to_char(rec.papers_accepted), 14) || ' | ' || rpad(to_char(rec.number_of_sessions), 8) || ' | ' || to_char(rec.number_of_users_registered));
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('==============================================');

    -- 3. Print number of papers submitted, number of papers accepted, and acceptance rate for each topic
    DBMS_OUTPUT.PUT_LINE('Topic Name                        | Papers Submitted | Papers Accepted | Acceptance Rate');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------');
    FOR rec IN (
        SELECT 
            t.topic_name,
            COUNT(pt.paper_id) AS papers_submitted,
            COUNT(CASE WHEN p.status = 'accepted' THEN 1 END) AS papers_accepted,
            COUNT(CASE WHEN p.status = 'accepted' THEN 1 END) * 100.0 / COUNT(pt.paper_id) AS topic_acceptance_rate
        FROM 
            topic t
            JOIN paper_topic pt ON t.topic_id = pt.topic_id
            JOIN paper p ON pt.paper_id = p.paper_id
        GROUP BY 
            t.topic_name
    ) LOOP
        DBMS_OUTPUT.PUT_LINE(rpad(rec.topic_name, 30) || ' | ' || rpad(to_char(rec.papers_submitted), 18) || ' | ' || rpad(to_char(rec.papers_accepted), 16) || ' | ' || to_char(rec.topic_acceptance_rate, '90.00') || '%');
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('==============================================');

    -- 4. Print user statistics for reviews
    DBMS_OUTPUT.PUT_LINE('User Name                        | Reviews Completed | Reviews Not Completed');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------');
    FOR rec IN (
        SELECT 
            p.name AS user_name,
            COUNT(CASE WHEN r.review_score IS NOT NULL AND r.review_comments IS NOT NULL THEN 1 END) AS reviews_completed,
            COUNT(CASE WHEN r.review_score IS NULL OR r.review_comments IS NULL THEN 1 END) AS reviews_not_completed
        FROM 
            person p
            LEFT JOIN review r ON p.user_id = r.user_id
        GROUP BY 
            p.name
    ) LOOP
        DBMS_OUTPUT.PUT_LINE(rpad(rec.user_name, 30) || ' | ' || rpad(to_char(rec.reviews_completed), 19) || ' | ' || to_char(rec.reviews_not_completed));
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('==============================================');
END;
/
