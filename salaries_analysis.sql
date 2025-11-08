/*
    Name: Meheryn Hossain
    DTSC660: Data and Database Management with SQL
    Assignment 6
*/

CREATE TABLE salaries(
    timestamp                   TIMESTAMP,
    company                     VARCHAR(255),
    level                       VARCHAR(255),
    title                       VARCHAR(255),
    total_yearly_compensation   INT,
    location                    VARCHAR(255),
    years_experience            NUMERIC,
    years_at_company            NUMERIC,
    tag                         VARCHAR(255),
    base_salary                 INT,
    stock_grant_value           NUMERIC,
    bonus                       NUMERIC,
    gender                      VARCHAR(255),
    other_details               TEXT,
    city_id                     INT,
    dma_id                      VARCHAR(255),
    row_number                  INT,
    masters_degree              INT,
    bachelors_degree            INT,
    doctorate_degree            INT,
    highschool                  INT,
    some_college                INT,
    race_asian                  INT,
    race_white                  INT,
    race_two_or_more            INT,
    race_black                  INT,
    race_hispanic               INT,
    race                        VARCHAR(255),
    education                   VARCHAR(255)
    );
    
COPY salaries
FROM '/Users/Public/data_science_salaries.csv'
WITH (FORMAT CSV,HEADER);
--------------------------------------------------------------------------------
/*				                   Part 1   		  		                  */
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
/*				                 Select Statement      		  		          */
--------------------------------------------------------------------------------

SELECT * FROM salaries;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
/*				                   Backup Table     		  		          */
--------------------------------------------------------------------------------

CREATE TABLE salaries_backup AS SELECT * FROM salaries;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
/*				                 Duplicate Column      		  		          */
--------------------------------------------------------------------------------

ALTER TABLE salaries
ADD COLUMN company_duplicate varchar(255);

UPDATE salaries
SET company_duplicate = company;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
/*				                   PART 2           		  		          */
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
/*		              Question 1 - Indentification query                      */
--------------------------------------------------------------------------------

SELECT DISTINCT level FROM salaries
WHERE level IS NOT NULL
AND level = 'na' OR level = 'n/a' OR level = 'not applicable';

--------------------------------------------------------------------------------
/*				          Question 1 - Update query                           */
--------------------------------------------------------------------------------

UPDATE salaries
SET level = 'n/a'
WHERE level = 'na';


--------------------------------------------------------------------------------
/*				        Question 1 - Validation query                         */
--------------------------------------------------------------------------------
SELECT DISTINCT level FROM salaries
WHERE level = 'na';

--------------------------------------------------------------------------------
/*				        Question 1 - Rationale Comment                        */
--------------------------------------------------------------------------------

/* After using SELECT statement on the level column I noticed that there was an 
inconsistency. I saw results of both n/a and na. To keep the data consistent I
updated the table to have n/a and no more na which is displayed via the 
validation query.*/
    
--------------------------------------------------------------------------------
/*		              Question 2 - Indentification query                      */
--------------------------------------------------------------------------------

SELECT DISTINCT gender FROM salaries
WHERE gender IS NOT NULL;


--------------------------------------------------------------------------------
/*				          Question 2 - Update query                           */
--------------------------------------------------------------------------------

UPDATE salaries
SET gender = NULL
WHERE gender = 'Title: Senior Software Engineer' 

--------------------------------------------------------------------------------
/*				        Question 2 - Validation query                         */
--------------------------------------------------------------------------------

SELECT DISTINCT gender FROM salaries;

--------------------------------------------------------------------------------
/*				        Question 2 - Rationale Comment                        */
--------------------------------------------------------------------------------

/* I noticed incorrect data in the gender column. One of the entries showed
gender to be 'Title: Senior Software Engineer'. I updated the query by 
removing the incorrect data and setting it equal to null. */
    
--------------------------------------------------------------------------------
/*		              Question 3 - Indentification query                      */
--------------------------------------------------------------------------------

SELECT base_salary FROM salaries
WHERE base_salary = 0;

--------------------------------------------------------------------------------
/*				          Question 3 - Update query                           */
--------------------------------------------------------------------------------

UPDATE salaries 
SET base_salary = NULL
WHERE base_salary = 0;

--------------------------------------------------------------------------------
/*				        Question 3 - Validation query                         */
--------------------------------------------------------------------------------

SELECT base_salary FROM salaries;

--------------------------------------------------------------------------------
/*				        Question 3 - Rationale Comment                        */
--------------------------------------------------------------------------------

/* I noticed that in the base_salary column there were many 0 value entries. 
This seemed odd since a base salary should have some value above 0. 
This is why I grouped all the zeroes and made them null (missing values). */
    
--------------------------------------------------------------------------------
/*		              Question 4 - Indentification query                      */
--------------------------------------------------------------------------------

SELECT stock_grant_value FROM salaries
WHERE stock_grant_value = 0;

--------------------------------------------------------------------------------
/*				          Question 4 - Update query                           */
--------------------------------------------------------------------------------

UPDATE salaries
SET stock_grant_value = (SELECT AVG(stock_grant_value) FROM salaries)
WHERE stock_grant_value = 0;

--------------------------------------------------------------------------------
/*				        Question 4 - Validation query                         */
--------------------------------------------------------------------------------

SELECT stock_grant_value FROM salaries
WHERE stock_grant_value = 0;
--------------------------------------------------------------------------------
/*				        Question 4 - Rationale Comment                        */
--------------------------------------------------------------------------------

/* I noticed the stock_grant_value column has many 0 values which I thought 
could have been due to an error or missing information. The Update query 
replaces the zero values with the mean value so this way the data may be 
more useful especially for other calculations. */

--------------------------------------------------------------------------------
