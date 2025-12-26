# Conference Management System

### IS720 - Advanced Database Systems
**Group 3 Final Project**

## Project Overview
This project is a robust **Conference Management System** designed to handle the complex data requirements of academic conferences. Developed using **Oracle SQL (PL/SQL)**, the system manages users, institutions, conference sessions, paper submissions, peer reviews, and participant registration.

It features advanced database logic including **Stored Procedures**, **Triggers**, **Sequences**, and **Cursors** to automate tasks like checking for conflicts of interest (COI), calculating similarity scores for paper assignments, and generating automated reminders.

## Technologies Used
* **Language:** SQL, PL/SQL
* **Database:** Oracle Database
* **Tools:** SQL*Plus / Oracle SQL Developer / VS Code

## Features
The system implements 13 core features through PL/SQL stored procedures:

### User & Conference Management
* [cite_start]**Add User:** Registers new users while preventing duplicate emails and updating existing records [cite: 663-668].
* [cite_start]**Add Roles:** Assigns roles (Organizer, Reviewer, Author) to users for specific conferences [cite: 681-686].
* [cite_start]**Register User:** Handles conference registration, calculates fees (early vs. regular), and tracks payment status [cite: 805-825].

### Paper Submission & Review
* [cite_start]**Add Paper:** Manages paper submissions, including multi-author support and topic tagging [cite: 704-718].
* [cite_start]**Enter Bids:** Allows reviewers to bid on papers they wish to review [cite: 745-755].
* [cite_start]**Submit Review:** Processes reviews while automatically blocking submissions if a **Conflict of Interest (COI)** exists (e.g., author and reviewer are from the same institution) [cite: 760-774].
* [cite_start]**Update Status:** Updates acceptance status and calculates average review scores automatically [cite: 786-798].

### Advanced Logic (Complex Features)
* [cite_start]**Auto-Assign Reviewers:** Uses an algorithm to assign papers to reviewers based on bids, ensuring no COIs and respecting reviewer workload limits [cite: 832-845].
* [cite_start]**Session Organization:** Algorithms calculate similarity scores between papers and session topics to suggest the best papers for specific conference sessions [cite: 888-911].
* [cite_start]**Statistics Generation:** Generates comprehensive reports on acceptance rates, topic popularity, and reviewer activity [cite: 916-930].

### Automated Notifications
* [cite_start]**Review Reminders:** Identifies reviewers with overdue reviews and generates reminder messages [cite: 848-856].
* [cite_start]**Author Reminders:** Alerts authors of accepted papers who have not yet registered for the conference [cite: 868-880].

## Database Schema
The system is built on a relational schema including the following key entities:
* `INSTITUTION` & `PERSON`
* `CONFERENCE` & `CONFERENCE_SESSION`
* `PAPER`, `AUTHOR`, `TOPIC`
* `REVIEW` & `PAPER_BID`
* `REGISTRATION` & `MESSAGE`

## How to Run
To set up the database, execute the SQL files in the following order:

1.  **`00_Schema.sql`**: Drops old tables (cleanup) and creates the new table structure with seed data.
2.  **`Feature_01_...sql` through `Feature_13_...sql`**: Compiles the stored procedures for each feature.
3.  **`05_tests.sql`** (Optional): Runs the test cases to verify functionality.

```sql
-- Example: Running the setup in SQL*Plus
@00_Schema.sql
@Feature_01_Add_User.sql
-- ... load other features ...
@Feature_13_Print_Stats.sql