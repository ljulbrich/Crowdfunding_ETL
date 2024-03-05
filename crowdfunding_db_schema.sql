-- Creating tables first
CREATE TABLE IF NOT EXISTS category (
	category_id VARCHAR(255) PRIMARY KEY NOT NULL,
	category VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS subcategory (
	subcategory_id VARCHAR(255) PRIMARY KEY NOT NULL,
	subcategory VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS contacts (
	contact_id SERIAL PRIMARY KEY NOT NULL,
	first_name VARCHAR(255) NOT NULL,
	last_name VARCHAR(255) NOT NULL,
	email VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS campaign (
    cf_id SERIAL PRIMARY KEY NOT NULL,
    contact_id SERIAL NOT NULL,
    company_name VARCHAR(255) NOT NULL,
    blurb VARCHAR(255) NOT NULL,
    goal NUMERIC(7,1) NOT NULL,
    pledged NUMERIC(7,1) NOT NULL,
    outcome VARCHAR(255) NOT NULL,
	backers_count INT NOT NULL,
	country VARCHAR(255) NOT NULL,
	currency VARCHAR(255) NOT NULL,
	launched_at DATE NOT NULL,
	deadline DATE NOT NULL,
	category_id VARCHAR(255) NOT NULL,
	subcategory_id VARCHAR(255) NOT NULL
);

-- Adding relationships
ALTER TABLE IF EXISTS public.campaign
    ADD CONSTRAINT category_id FOREIGN KEY (category_id)
    REFERENCES public.category (category_id) MATCH FULL
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
	
ALTER TABLE IF EXISTS public.campaign
	ADD CONSTRAINT subcategory_id FOREIGN KEY (subcategory_id)
	REFERENCES public.subcategory (subcategory_id) MATCH FULL
	ON UPDATE NO ACTION
	ON DELETE NO ACTION
	NOT VALID;

ALTER TABLE IF EXISTS public.campaign
	ADD CONSTRAINT contact_id FOREIGN KEY (contact_id)
	REFERENCES public.contacts (contact_id) MATCH FULL
	ON UPDATE NO ACTION
	ON DELETE NO ACTION
	NOT VALID;
	
-- Adding CSV data
COPY category(category_id, category)
    FROM '\Resources\category.csv'
    DELIMITER ','
    CSV HEADER;

COPY subcategory(subcategory_id, subcategory)
    FROM '\Resources\subcategory.csv'
    DELIMITER ','
    CSV HEADER;

COPY contacts(contact_id, first_name, last_name, email)
    FROM '\Resources\contacts.csv'
    DELIMITER ','
    CSV HEADER;
	
COPY campaign(cf_id,contact_id,company_name,blurb,goal,pledged,outcome,backers_count,country,currency,launched_at,deadline,category_id,subcategory_id)
    FROM '\Resources\campaign.csv'
    DELIMITER ','
    CSV HEADER;

-- Selecting each database for viewing
SELECT * FROM campaign;

SELECT * FROM category;

SELECT * FROM subcategory;

SELECT * FROM contacts;
