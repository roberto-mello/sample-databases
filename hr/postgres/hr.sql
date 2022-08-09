CREATE TABLE regions (
	region_id INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
	region_name VARCHAR(30)
);

INSERT INTO regions
  (region_id, region_name)
VALUES
  (1,'Europe'),
  (2,'Americas'),
  (3,'Asia'),
  (4,'Middle East and Africa');

CREATE TABLE countries (
	country_id CHAR(2) PRIMARY KEY,
	country_name VARCHAR(45),
	region_id INTEGER NOT NULL REFERENCES regions (region_id) 
);

INSERT INTO countries(country_id,country_name,region_id) VALUES
  ('AR','Argentina',2),
  ('AU','Australia',3),
  ('BE','Belgium',1),
  ('BR','Brazil',2),
  ('CA','Canada',2),
  ('CH','Switzerland',1),
  ('CN','China',3),
  ('DE','Germany',1),
  ('DK','Denmark',1),
  ('EG','Egypt',4),
  ('FR','France',1),
  ('HK','HongKong',3),
  ('IL','Israel',4),
  ('IN','India',3),
  ('IT','Italy',1),
  ('JP','Japan',3),
  ('KW','Kuwait',4),
  ('MX','Mexico',2),
  ('NG','Nigeria',4),
  ('NL','Netherlands',1),
  ('SG','Singapore',3),
  ('UK','United Kingdom',1),
  ('US','United States of America',2),
  ('ZM','Zambia',4),
  ('ZW','Zimbabwe',4);

CREATE TABLE locations (
	location_id INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
	street_address VARCHAR(45),
	postal_code VARCHAR(12),
	city VARCHAR (30) NOT NULL,
	state_province VARCHAR (25),
	country_id CHAR(2) NOT NULL REFERENCES countries (country_id) 
);

INSERT INTO locations
  (location_id,street_address,postal_code,city,state_province,country_id)
VALUES 
  (1,'9122 Rockfeller Rd','34232','Effingham','Indiana','US'),
  (2,'44 Isaac Newton Ave','54898','London','London','UK'),
  (3,'Deutschland 3232','79822','Munich','Bavaria','DE'),
  (4,'210 W Main St','84032','Lehi','Utah','US');

CREATE TABLE departments (
	department_id INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
	department_name VARCHAR (30) NOT NULL,
	location_id INTEGER REFERENCES locations (location_id) 
);

INSERT INTO departments
  (department_id, department_name, location_id)
VALUES
  (1,'Management', 1),
  (2,'Information Technology',2),
  (3,'Human Resources',3),
  (4,'Sales',1);

CREATE TABLE employees (
	employee_id INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
	first_name VARCHAR(20),
	last_name VARCHAR(25) NOT NULL,
	start_date DATE NOT NULL DEFAULT CURRENT_DATE,
	job_title VARCHAR(100) NOT NULL,
	salary NUMERIC (9, 2) NOT NULL,
	manager_id INTEGER,
	department_id INTEGER,
	FOREIGN KEY (department_id) REFERENCES departments (department_id),
	FOREIGN KEY (manager_id) REFERENCES employees (employee_id) 
);

INSERT INTO employees
  (employee_id, first_name, last_name, start_date, job_title, salary, manager_id, department_id)
VALUES
  (1,'John','Smith','1989-05-07','President',364000.00,NULL,1),
  (2,'Pointy','HairedBoss','1999-08-12','CTO',27000.00,1,2),
  (3,'Dilbertzoni','DeScrewed','2001-02-02','Software Engineer',77000.00,2,2),
  (4,'Vanda','Socialist','1994-03-06','VP Equity Diversity Inclusion',90000.00,1,3),
  (5,'Howard','TheDuck','2001-08-11','VP Sales', 80000.00,1,4),
  (6,'Luke','Fett','2007-07-21','Sales Guy',68000.00,5,4),
  (7,'John','SkipWork','2003-05-03','HR Henchman',68000.00,4,3),
  (8,'Lea','Palpatine','2009-07-04','UI Designer',87000.00,2,2);

CREATE TABLE dependents (
	dependent_id INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
	first_name VARCHAR (50) NOT NULL,
	last_name VARCHAR (50) NOT NULL,
	employee_id INTEGER NOT NULL REFERENCES employees (employee_id)
);

INSERT INTO dependents
  (dependent_id, first_name, last_name, employee_id)
VALUES
  (1,'Spoiled','Smith',1),
  (2,'DoNothin','Smith',1),
  (3,'Rafael','HairedBoss',2),
  (4,'Beta','HairedBoss',2),
  (5,'Wanda','DeScrewed',3);
