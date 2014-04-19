/* 
**  Author: Justin Smith
**  Course: CMIS 420.7980
**  Date:  04/19/14
**  Project 2
*/

-- DROP EVERYTHING BEFORE CREATING --
DROP TABLE RESTOCK;
DROP TABLE ODETAILS_ERRORS;
DROP TABLE ORDER_ERRORS;
DROP TABLE ODETAILS;
DROP TABLE ORDERS;
DROP TABLE CUSTOMERS;
DROP TABLE PARTS;
DROP TABLE EMPLOYEE;
DROP TABLE ZIPCODES;

DROP SEQUENCE ORDER_NUMBER_SEQ;
DROP SEQUENCE CNO_SEQ;
DROP SEQUENCE PNO_SEQ;
DROP SEQUENCE ENO_SEQ;


-- CREATE TABLES --

CREATE TABLE ZIPCODES 
(
  ZIP VARCHAR2(5) NOT NULL 
, CITY VARCHAR2(25) NOT NULL 
, CONSTRAINT ZIPCODES_PK PRIMARY KEY 
  (
    ZIP 
  )
  ENABLE 
);

CREATE TABLE EMPLOYEE 
(
  ENO NUMBER(6) NOT NULL 
, ENAME VARCHAR2(50) NOT NULL 
, ZIP VARCHAR2(5) NOT NULL 
, HDATE DATE NOT NULL 
, CREATION_DATE DATE NOT NULL 
, CREATED_BY VARCHAR2(10) NOT NULL 
, LAST_UPDATE_DATE DATE NOT NULL 
, LAST_UPDATE_BY VARCHAR2(10) NOT NULL 
, CONSTRAINT EMPLOYEE_PK PRIMARY KEY 
  (
    ENO 
  )
  ENABLE 
);

ALTER TABLE EMPLOYEE
ADD CONSTRAINT EMPLOYEE_ZIPCODES_FK1 FOREIGN KEY
(
  ZIP 
)
REFERENCES ZIPCODES
(
  ZIP 
)
ENABLE;

CREATE TABLE PARTS 
(
  PNO NUMBER NOT NULL 
, PNAME VARCHAR2(50) NOT NULL 
, QOH NUMBER NOT NULL 
, PRICE NUMBER(5, 2) 
, REORDER_LEVEL NUMBER(2) 
, CREATION_DATE DATE NOT NULL 
, CREATED_BY VARCHAR2(10) NOT NULL 
, LAST_UPDATE_DATE DATE NOT NULL 
, LAST_UPDATE_BY VARCHAR2(10) NOT NULL 
, CONSTRAINT PARTS_PK PRIMARY KEY 
  (
    PNO 
  )
  ENABLE 
);

CREATE TABLE CUSTOMERS 
(
  CNO NUMBER NOT NULL 
, CNAME VARCHAR2(50) NOT NULL 
, STREET VARCHAR2(50) NOT NULL 
, ZIP VARCHAR2(5) NOT NULL 
, PHONE VARCHAR2(15) NOT NULL 
, CREATION_DATE DATE NOT NULL 
, CREATED_BY VARCHAR2(10) NOT NULL 
, LAST_UPDATE_DATE DATE NOT NULL 
, LAST_UPDATE_BY VARCHAR2(10) NOT NULL 
, CONSTRAINT CUSTOMERS_PK PRIMARY KEY 
  (
    CNO 
  )
  ENABLE 
);

ALTER TABLE CUSTOMERS
ADD CONSTRAINT CUSTOMERS_ZIPCODES_FK1 FOREIGN KEY
(
  ZIP 
)
REFERENCES ZIPCODES
(
  ZIP 
)
ENABLE;

CREATE TABLE ORDERS 
(
  ONO NUMBER NOT NULL 
, CNO NUMBER NOT NULL 
, ENO NUMBER NOT NULL 
, RECIEVED DATE 
, SHIPPED DATE 
, CREATION_DATE DATE NOT NULL 
, CREATED_BY VARCHAR2(10) NOT NULL 
, LAST_UPDATE_DATE DATE NOT NULL 
, LAST_UPDATE_BY VARCHAR2(10) NOT NULL 
, CONSTRAINT ORDERS_PK PRIMARY KEY 
  (
    ONO 
  )
  ENABLE 
);

ALTER TABLE ORDERS
ADD CONSTRAINT ORDERS_CNO_FK1 FOREIGN KEY
(
  CNO 
)
REFERENCES CUSTOMERS
(
  CNO 
)
ENABLE;

ALTER TABLE ORDERS
ADD CONSTRAINT ORDERS_ENO_FK1 FOREIGN KEY
(
  ENO 
)
REFERENCES EMPLOYEE
(
  ENO 
)
ENABLE;

CREATE TABLE ODETAILS 
(
  ONO NUMBER NOT NULL 
, PNO NUMBER NOT NULL 
, QTY NUMBER NOT NULL 
, CREATION_DATE DATE NOT NULL 
, CREATED_BY VARCHAR2(10) NOT NULL 
, LAST_UPDATE_DATE DATE NOT NULL 
, LAST_UPDATE_BY VARCHAR2(10) NOT NULL 
);

ALTER TABLE ODETAILS
ADD CONSTRAINT ODETAILS_ORDERS_FK1 FOREIGN KEY
(
  ONO 
)
REFERENCES ORDERS
(
  ONO 
)
ENABLE;

ALTER TABLE ODETAILS
ADD CONSTRAINT ODETAILS_PARTS_FK1 FOREIGN KEY
(
  PNO 
)
REFERENCES PARTS
(
  PNO 
)
ENABLE;

CREATE TABLE ORDER_ERRORS 
(
  ONO NUMBER NOT NULL 
, TRANSACTION_DATE DATE NOT NULL 
, MESSAGE VARCHAR2(100) NOT NULL 
);

ALTER TABLE ORDER_ERRORS
ADD CONSTRAINT ORDER_ERRORS_ORDERS_FK1 FOREIGN KEY
(
  ONO 
)
REFERENCES ORDERS
(
  ONO 
)
ENABLE;


CREATE TABLE ODETAILS_ERRORS 
(
  ONO NUMBER NOT NULL 
, TRANSACTION_DATE DATE NOT NULL 
, PNO NUMBER NOT NULL 
, MESSAGE VARCHAR2(100) NOT NULL 
);

ALTER TABLE ODETAILS_ERRORS
ADD CONSTRAINT ODETAILS_ERRORS_ORDERS_FK1 FOREIGN KEY
(
  ONO 
)
REFERENCES ORDERS
(
  ONO 
)
ENABLE;

ALTER TABLE ODETAILS_ERRORS
ADD CONSTRAINT ODETAILS_ERRORS_PARTS_FK1 FOREIGN KEY
(
  PNO 
)
REFERENCES PARTS
(
  PNO 
)
ENABLE;


CREATE TABLE RESTOCK 
(
  PNO NUMBER NOT NULL 
, TRANSACTION_DATE DATE NOT NULL 
);

ALTER TABLE RESTOCK
ADD CONSTRAINT RESTOCK_PARTS_FK1 FOREIGN KEY
(
  PNO 
)
REFERENCES PARTS
(
  PNO 
)
ENABLE;



-- CREATE SEQUENCES --

CREATE SEQUENCE ENO_SEQ INCREMENT BY 23 START WITH 11575 NOCACHE;
CREATE SEQUENCE PNO_SEQ INCREMENT BY 29 START WITH 120 NOCACHE;
CREATE SEQUENCE CNO_SEQ INCREMENT BY 199 START WITH 199 NOCACHE;
CREATE SEQUENCE ORDER_NUMBER_SEQ INCREMENT BY 1 START WITH 1000 NOCACHE;


-- CREATE SOME DATA --

INSERT INTO ZIPCODES (ZIP, CITY) VALUES ('22485', 'King George');
INSERT INTO ZIPCODES (ZIP, CITY) VALUES ('12172', 'Stottville');
INSERT INTO ZIPCODES (ZIP, CITY) VALUES ('13619', 'Carthage');
INSERT INTO ZIPCODES (ZIP, CITY) VALUES ('13624', 'Clayton');
INSERT INTO ZIPCODES (ZIP, CITY) VALUES ('23119', 'Moon');
INSERT INTO ZIPCODES (ZIP, CITY) VALUES ('23124', 'New Kent');
INSERT INTO ZIPCODES (ZIP, CITY) VALUES ('23117', 'Mineral');
INSERT INTO ZIPCODES (ZIP, CITY) VALUES ('23288', 'Richmond');
INSERT INTO ZIPCODES (ZIP, CITY) VALUES ('23451', 'Virginia Beach');
INSERT INTO ZIPCODES (ZIP, CITY) VALUES ('23061', 'Gloucester');
INSERT INTO ZIPCODES (ZIP, CITY) VALUES ('23601', 'Newport News');
INSERT INTO ZIPCODES (ZIP, CITY) VALUES ('00698', 'Yauco');
INSERT INTO ZIPCODES (ZIP, CITY) VALUES ('12183', 'Troy');
INSERT INTO ZIPCODES (ZIP, CITY) VALUES ('12175', 'Summit');

INSERT INTO EMPLOYEE 
(ENO, ENAME, ZIP, HDATE, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATE_BY)
VALUES
(ENO_SEQ.NEXTVAL, 'Justin Smith', '22485', SYSDATE, SYSDATE, 'jsmith', SYSDATE, 'jsmith');

INSERT INTO EMPLOYEE 
(ENO, ENAME, ZIP, HDATE, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATE_BY)
VALUES
(ENO_SEQ.NEXTVAL, 'Susan Smith', '22485', SYSDATE, SYSDATE, 'jsmith', SYSDATE, 'jsmith');

INSERT INTO EMPLOYEE 
(ENO, ENAME, ZIP, HDATE, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATE_BY)
VALUES
(ENO_SEQ.NEXTVAL, 'Ken Johnson', '22485', SYSDATE, SYSDATE, 'jsmith', SYSDATE, 'jsmith');

INSERT INTO EMPLOYEE 
(ENO, ENAME, ZIP, HDATE, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATE_BY)
VALUES
(ENO_SEQ.NEXTVAL, 'Ryan Peters', '22485', SYSDATE, SYSDATE, 'jsmith', SYSDATE, 'jsmith');

INSERT INTO EMPLOYEE 
(ENO, ENAME, ZIP, HDATE, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATE_BY)
VALUES
(ENO_SEQ.NEXTVAL, 'Mary May', '22485', SYSDATE, SYSDATE, 'jsmith', SYSDATE, 'jsmith');

INSERT INTO EMPLOYEE 
(ENO, ENAME, ZIP, HDATE, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATE_BY)
VALUES
(ENO_SEQ.NEXTVAL, 'Rick Summers', '22485', SYSDATE, SYSDATE, 'jsmith', SYSDATE, 'jsmith');

INSERT INTO PARTS
(PNO, PNAME, QOH, PRICE, REORDER_LEVEL, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATE_BY)
VALUES
(PNO_SEQ.NEXTVAL, '2mm Bolt', 2000, '0.15', 99, SYSDATE, 'jsmith', SYSDATE, 'jsmith');

INSERT INTO PARTS
(PNO, PNAME, QOH, PRICE, REORDER_LEVEL, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATE_BY)
VALUES
(PNO_SEQ.NEXTVAL, '5mm Bolt', 2000, '0.15', 99, SYSDATE, 'jsmith', SYSDATE, 'jsmith');

INSERT INTO PARTS
(PNO, PNAME, QOH, PRICE, REORDER_LEVEL, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATE_BY)
VALUES
(PNO_SEQ.NEXTVAL, '8mm Bolt', 2000, '0.15', 99, SYSDATE, 'jsmith', SYSDATE, 'jsmith');

INSERT INTO PARTS
(PNO, PNAME, QOH, PRICE, REORDER_LEVEL, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATE_BY)
VALUES
(PNO_SEQ.NEXTVAL, '#8 Nails', 8000, '.02', 99, SYSDATE, 'jsmith', SYSDATE, 'jsmith');

INSERT INTO PARTS
(PNO, PNAME, QOH, PRICE, REORDER_LEVEL, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATE_BY)
VALUES
(PNO_SEQ.NEXTVAL, '#10 Nails', 8000, '.04', 99, SYSDATE, 'jsmith', SYSDATE, 'jsmith');

INSERT INTO PARTS
(PNO, PNAME, QOH, PRICE, REORDER_LEVEL, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATE_BY)
VALUES
(PNO_SEQ.NEXTVAL, '2x4 PINE', 200, '2.35', 10, SYSDATE, 'jsmith', SYSDATE, 'jsmith');

INSERT INTO PARTS
(PNO, PNAME, QOH, PRICE, REORDER_LEVEL, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATE_BY)
VALUES
(PNO_SEQ.NEXTVAL, '2x6 PINE', 200, '4.00', 10, SYSDATE, 'jsmith', SYSDATE, 'jsmith');

INSERT INTO PARTS
(PNO, PNAME, QOH, PRICE, REORDER_LEVEL, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATE_BY)
VALUES
(PNO_SEQ.NEXTVAL, '2x8 PINE', 200, '6.00', 10, SYSDATE, 'jsmith', SYSDATE, 'jsmith');

INSERT INTO PARTS
(PNO, PNAME, QOH, PRICE, REORDER_LEVEL, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATE_BY)
VALUES
(PNO_SEQ.NEXTVAL, '2x10 PINE', 200, '10.00', 10, SYSDATE, 'jsmith', SYSDATE, 'jsmith');

INSERT INTO PARTS
(PNO, PNAME, QOH, PRICE, REORDER_LEVEL, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATE_BY)
VALUES
(PNO_SEQ.NEXTVAL, '6x6 Pine', 50, '15.00', 5, SYSDATE, 'jsmith', SYSDATE, 'jsmith');

INSERT INTO PARTS
(PNO, PNAME, QOH, PRICE, REORDER_LEVEL, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATE_BY)
VALUES
(PNO_SEQ.NEXTVAL, '1x2 Pine', 200, '1.50', 10, SYSDATE, 'jsmith', SYSDATE, 'jsmith');

INSERT INTO CUSTOMERS
(CNO, CNAME, STREET, ZIP, PHONE, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATE_BY)
VALUES
(CNO_SEQ.NEXTVAL, 'Rory Rogers', '12 Main St', '12172', '345-987-1923', SYSDATE, 'jsmith', SYSDATE, 'jsmith'); 

INSERT INTO CUSTOMERS
(CNO, CNAME, STREET, ZIP, PHONE, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATE_BY)
VALUES
(CNO_SEQ.NEXTVAL, 'Sally Sierra', '1234 Greenleaf Rd', '13619', '423-987-7423', SYSDATE, 'jsmith', SYSDATE, 'jsmith'); 

INSERT INTO CUSTOMERS
(CNO, CNAME, STREET, ZIP, PHONE, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATE_BY)
VALUES
(CNO_SEQ.NEXTVAL, 'Roger Rabbit', '15 Cartoon Ct', '13624', '567-980-1234', SYSDATE, 'jsmith', SYSDATE, 'jsmith'); 

INSERT INTO CUSTOMERS
(CNO, CNAME, STREET, ZIP, PHONE, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATE_BY)
VALUES
(CNO_SEQ.NEXTVAL, 'Gary Payne', '67 Marshall Ave', '23124', '804-876-1930', SYSDATE, 'jsmith', SYSDATE, 'jsmith'); 

INSERT INTO CUSTOMERS
(CNO, CNAME, STREET, ZIP, PHONE, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATE_BY)
VALUES
(CNO_SEQ.NEXTVAL, 'Rocky Luck', '3498 W Long St', '23061', '757-344-8976', SYSDATE, 'jsmith', SYSDATE, 'jsmith'); 

