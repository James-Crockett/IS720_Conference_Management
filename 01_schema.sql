set serveroutput on;

-- Drop SQL tables
DROP TABLE institution cascade constraints;
DROP TABLE person cascade constraints;
DROP TABLE conference cascade constraints;
DROP TABLE conference_session cascade constraints;
DROP TABLE user_roles cascade constraints;
DROP TABLE paper cascade constraints;
DROP TABLE paper_author cascade constraints;
DROP TABLE topic cascade constraints;
DROP TABLE paper_topic cascade constraints;
DROP TABLE paper_bid cascade constraints;
DROP TABLE review cascade constraints;
DROP TABLE registration cascade constraints;
DROP TABLE message cascade constraints;

-- Table 1 -  Institution
CREATE TABLE institution (
    institution_id INT PRIMARY KEY,
    institution_name VARCHAR2(255),
    country VARCHAR2(100)
);

-- Table 2 - Users 
CREATE TABLE person (
    user_id INT PRIMARY KEY,
    institution_id NUMBER,
    name VARCHAR2(255),
    address VARCHAR2(255),
    zipcode VARCHAR2(10),
    email VARCHAR2(255),
    country VARCHAR2(100),
    FOREIGN KEY (institution_id) REFERENCES institution(institution_id)
);

-- Table 3 - Conference
CREATE TABLE conference (
    conference_id INT PRIMARY KEY,
    conference_title VARCHAR2(255),
    conference_year INT,
    start_date DATE,
    end_date DATE,
    submission_due_time TIMESTAMP,
    review_due_time TIMESTAMP,
    camera_ready_due_time TIMESTAMP,
    city VARCHAR2(100),
    country VARCHAR2(100),
    early_registration_date DATE,
    early_registration_fee INT,
    regular_registration_fee INT
);

-- Table 4 - Conference Session
CREATE TABLE conference_session (
    session_id INT PRIMARY KEY,
    conference_id INT,
    user_id INT,
    session_title VARCHAR2(255),
    session_start_time TIMESTAMP,
    session_end_time TIMESTAMP,
    FOREIGN KEY (conference_id) REFERENCES conference(conference_id),
    FOREIGN KEY (user_id) REFERENCES person(user_id)
);

-- Table 5 - User Roles
CREATE TABLE user_roles (
    user_id INT,
    conference_id INT,
    role VARCHAR2(50),
    PRIMARY KEY (user_id, conference_id, role),
    FOREIGN KEY (user_id) REFERENCES person(user_id),
    FOREIGN KEY (conference_id) REFERENCES conference(conference_id)
);

-- Table 6 - Paper
CREATE TABLE paper (
    paper_id INT PRIMARY KEY,
    paper_title VARCHAR2(255),
    conference_id INT,
    submit_time TIMESTAMP,
    average_review_score NUMBER(3,2),
    status VARCHAR2(50),
    session_id INT,
    FOREIGN KEY (conference_id) REFERENCES conference(conference_id),
    FOREIGN KEY (session_id) REFERENCES conference_session(session_id)
);

-- Table 7 - Paper Author
CREATE TABLE paper_author (
    paper_id INT,
    user_id INT,
    author_order INT,
    PRIMARY KEY (paper_id, user_id),
    FOREIGN KEY (paper_id) REFERENCES paper(paper_id),
    FOREIGN KEY (user_id) REFERENCES person(user_id)
);

-- Table 8 - Topic
CREATE TABLE topic (
    topic_id INT PRIMARY KEY,
    topic_name VARCHAR2(255)
);

-- Table 9 - Paper Topic
CREATE TABLE paper_topic (
    paper_id INT,
    topic_id INT,
    PRIMARY KEY (paper_id, topic_id),
    FOREIGN KEY (paper_id) REFERENCES paper(paper_id),
    FOREIGN KEY (topic_id) REFERENCES topic(topic_id)
);

-- Table 10 - Paper Bid
CREATE TABLE paper_bid (
    bid_id INT PRIMARY KEY,
    user_id INT,
    paper_id INT,
    FOREIGN KEY (user_id) REFERENCES person(user_id),
    FOREIGN KEY (paper_id) REFERENCES paper(paper_id)
);

-- Table 11 - Review
CREATE TABLE review (
    review_id INT PRIMARY KEY,
    user_id INT,
    paper_id INT,
    review_score NUMBER(3,2),
    review_comments VARCHAR2(1000),
    review_upload_time TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES person(user_id),
    FOREIGN KEY (paper_id) REFERENCES paper(paper_id)
);

-- Table 12 - Registration
CREATE TABLE registration (
    registration_id INT PRIMARY KEY,
    conference_id INT,
    user_id INT,
    registration_fee NUMBER,
    payment_date DATE,
    payment_status VARCHAR2(50),
    FOREIGN KEY (conference_id) REFERENCES conference(conference_id),
    FOREIGN KEY (user_id) REFERENCES person(user_id)
);

-- Table 13 - Message
CREATE TABLE message (
    message_id INT PRIMARY KEY,
    user_id INT,
    message_time TIMESTAMP,
    message_body VARCHAR2(1000),
    FOREIGN KEY (user_id) REFERENCES person(user_id)
);
