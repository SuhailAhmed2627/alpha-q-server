CREATE DATABASE alphaQ;

CREATE USER 'Jay_Jay'@'localhost' IDENTIFIED BY 'secretpassword';
GRANT ALL PRIVILEGES ON * . * TO 'Jay_Jay'@'localhost';

CREATE USER 'webDev'@'localhost' IDENTIFIED BY 'secretpassword';
GRANT ALL PRIVILEGES ON * . * TO 'webDev'@'localhost';

USE alphaQ;

CREATE TABLE MoMs (
   member VARCHAR (30) NOT NULL,
   mom_date DATE NOT NULL,
   content TEXT
);