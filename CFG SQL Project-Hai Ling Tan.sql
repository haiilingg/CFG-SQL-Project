-- CREATE DATABASE AND TABLES --

CREATE DATABASE RESTAURANT;
USE RESTAURANT;

CREATE TABLE ORDERS (
    ORDER_ID INT UNIQUE PRIMARY KEY,
    ORDER_DATE DATE,
    ORDER_TIME TIME,
    MODE_OF_DELIVERY VARCHAR(45),
    USER_ID INT,
	FOREIGN KEY (USER_ID) REFERENCES USER(USER_ID),
    CUSTOMER_ID INT,
    FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID),
    MENU_ID VARCHAR(45),
    FOREIGN KEY (MENU_ID) REFERENCES MENU(MENU_ID),
    PAYMENT_ID VARCHAR(45), 
    FOREIGN KEY (PAYMENT_ID) REFERENCES PAYMENT(PAYMENT_ID));

INSERT INTO ORDERS
(ORDER_ID, ORDER_DATE, ORDER_TIME, MODE_OF_DELIVERY, USER_ID, CUSTOMER_ID, MENU_ID, PAYMENT_ID)
VALUES
(1001, '2023-08-25', '19:18:29', 'Self-pickup', 9006, 5, 'M01', 1166),
(1002, '2023-08-22', '20:50:04', 'Deliveroo', 9009, 5, 'M02', 1121),
(1003, '2023-08-16', '17:25:46', 'Uber Eats', 9007, 5, 'M03', 1213),
(1004, '2023-08-23', '13:10:48', 'Uber Eats', 9010, 6, 'M04', 1122),
(1005, '2023-08-21', '20:52:36', 'Just Eat', 9006, 6, 'M05', 1211),
(1006, '2023-08-19', '14:07:20', 'Just Eat', 9008, 6, 'M04', 1188),
(1007, '2023-08-17', '17:35:13', 'Self-pickup', 9010, 6, 'M02', 1155),
(1008, '2023-08-23', '17:44:06', 'Deliveroo', 9009, 7, 'M06', 1144),
(1009, '2023-08-21', '14:36:55', 'Deliveroo', 9007, 7, 'M05', 1210),
(1010, '2023-08-24', '13:15:13', 'Uber Eats', 9010, 7, 'M03', 1215),
(1011, '2023-08-22', '20:19:57', 'Deliveroo', 9008, 7, 'M02', 1212),
(1012, '2023-08-16', '20:34:53', 'Just Eat', 9009, 7, 'M06', 1177),
(1013, '2023-08-15', '19:46:53', 'Just Eat', 9006, 8, 'M05', 1214),
(1014, '2023-08-23', '15:24:52', 'Self-pickup', 9010, 8, 'M03', 1133),
(1015, '2023-08-22', '16:35:34', 'Uber Eats', 9007, 8, 'M01', 1199);



CREATE TABLE MENU(
MENU_ID VARCHAR(45) PRIMARY KEY,
CATEGORY VARCHAR(45),
NAME_OF_FOOD VARCHAR(45),
SESSION_AVAILABLE VARCHAR(45),
VEGAN_OPTIONS VARCHAR(45),
CHEF_ID INT,
FOREIGN KEY (CHEF_ID) REFERENCES CHEF(CHEF_ID));

INSERT INTO MENU
(MENU_ID, CATEGORY, NAME_OF_FOOD,SESSION_AVAILABLE,VEGAN_OPTIONS,CHEF_ID)
VALUES
('M01', 'Main', 'Chicken Parmesan', 'BOTH', 'NO', 201),
('M02', 'Dessert', 'Pana Cotta', 'DINNER', 'YES', 204),
('M03', 'Main', 'Seafood Pasta', 'BOTH', 'NO', 203),
('M04', 'Snacks', 'Arancini', 'LUNCH', 'YES', 204),
('M05', 'Main', 'Pizza', 'BOTH', 'YES', 202),
('M06', 'Dessert', 'Tiramisu', 'DINNER', 'YES', 205);

CREATE TABLE CHEF(
CHEF_ID INT PRIMARY KEY,
CHEF_NAME VARCHAR(45),
SALARY INT,
YEARS_OF_EXPERIENCE INT);

SELECT * FROM USER;

INSERT INTO CHEF
(CHEF_ID, CHEF_NAME, SALARY,YEARS_OF_EXPERIENCE)
VALUES
(201, 'TAMMY', 2500, 2),
(202, 'AMIRAH', 3300, 3),
(203, 'ADAM', 6000, 5),
(204, 'RACHEL', 4500, 4),
(205, 'RIZAL', 2000, 1);


CREATE TABLE USER(
USER_ID INT PRIMARY KEY,
FIRST_NAME VARCHAR(45),
LAST_NAME VARCHAR(45),
USERNAME VARCHAR(45),
PASSWORD VARCHAR(45),
ROLE VARCHAR(45));

INSERT INTO USER
(USER_ID,FIRST_NAME,LAST_NAME,USERNAME,PASSWORD,ROLE)
VALUES
(9006, 'Horyew', 'Yim', 'yewyew', 'HYY990099!', 'CASHIER'),
(9007, 'Lynn', 'Theng', 'sltheng', 'SLTH981221#', 'ADMIN'),
(9008, 'Xinyi', 'Teoh', 'xy.teoh', 'XYT970924?', 'WAITRESS'),
(9009, 'Zahim', 'Ismail', 'zahim.ismail', 'ZIZ989796%', 'WAITER'),
(9010, 'Izzati', 'Mustaffa', 'izz.mustaffa', 'NIM8796^', 'CASHIER');

CREATE TABLE CUSTOMER(
CUSTOMER_ID INT PRIMARY KEY,
FIRST_NAME VARCHAR(45),
LAST_NAME VARCHAR(45),
PHONE_NUMBER VARCHAR(45),
EMAIL VARCHAR(45));

INSERT INTO CUSTOMER
(CUSTOMER_ID ,FIRST_NAME,LAST_NAME, PHONE_NUMBER,EMAIL)
VALUES
(5, 'Yixin', 'Tan', '07532219754', 'yixinnn@gmail.com'),
(6, 'Phylicia', 'Ng', '07327045458', 'psyn97@gmail.com'),
(7, 'Meisin', 'Ong', '07721683720', 'msong98@gmail.com'),
(8, 'Yiwen', 'Phang', '07613683261', 'yiwen00@gmail.com');

CREATE TABLE PAYMENT 
(PAYMENT_ID VARCHAR(45) PRIMARY KEY,
CUSTOMER_ID INT,
FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID),
PAYMENT_TYPE VARCHAR(45),
PAYMENT_AMOUNT DECIMAL(10, 2));

INSERT INTO PAYMENT
(PAYMENT_ID,CUSTOMER_ID,PAYMENT_TYPE,PAYMENT_AMOUNT)
VALUES
(1121, 5, 'Credit Card', 30.13),
(1122, 6, 'Online Banking', 45.45),
(1133, 8, 'E-Wallet', 23.2),
(1144, 7, 'Debit Card', 15.16),
(1155, 6, 'Debit Card', 48.38),
(1166, 5, 'Debit Card', 27.01),
(1177, 7, 'Debit Card', 35.14),
(1188, 6, 'E-Wallet', 87.39),
(1199, 8, 'Credit Card', 15.75),
(1210, 7, 'Online Banking', 27.78),
(1211, 6, 'E-Wallet', 92.7),
(1212, 7, 'Online Banking', 24.25),
(1213, 5, 'E-Wallet', 140.7),
(1214, 8, 'Debit Card', 113.92),
(1215, 7, 'Credit Card', 23.24);

-- JOINS & VIEW
-- View main dish order details
CREATE VIEW Main_dish_order_details AS
SELECT 
DISTINCT(O.MENU_ID), C.CHEF_ID, C.CHEF_NAME, C.YEARS_OF_EXPERIENCE,
M.NAME_OF_FOOD, M.CATEGORY, M.VEGAN_OPTIONS
FROM ORDERS O
JOIN MENU M ON O.MENU_ID = M.MENU_ID
JOIN CHEF C ON M.CHEF_ID = C.CHEF_ID
WHERE CATEGORY LIKE 'Main'
ORDER BY C.CHEF_ID;
 
SELECT * FROM Main_dish_order_details;

-- STORED FUNCTION 
-- Determine customer status based on total payment amount
USE RESTAURANT;

DELIMITER // 

CREATE FUNCTION membership_status
(total_payment_amount DECIMAL(10, 2)) -- equals to((SUM(P.PAYMENT_AMOUNT) --
RETURNS VARCHAR(20)
DETERMINISTIC 
BEGIN 
    DECLARE customer_status VARCHAR(20);
    IF total_payment_amount > 200.00 THEN
        SET customer_status = 'Gold';
    ELSEIF total_payment_amount BETWEEN 150.00 AND 200.00 THEN
        SET customer_status = 'Silver';
    ELSE
        SET customer_status = 'Normal';
    END IF;

    RETURN customer_status;
END // 
DELIMITER ;

SELECT C.CUSTOMER_ID, C.FIRST_NAME, C.LAST_NAME, 
membership_status(SUM(P.PAYMENT_AMOUNT)) AS MEMBERSHIP_STATUS
FROM CUSTOMER C
INNER JOIN PAYMENT P ON P.CUSTOMER_ID = C.CUSTOMER_ID
GROUP BY C.CUSTOMER_ID;

-- SUBQUERY
-- Querying order IDs of the orders entered by 'Cashier'

SELECT ORDER_ID, ORDER_DATE, ORDER_TIME
FROM ORDERS
WHERE USER_ID IN (SELECT USER_ID
					   FROM USER 
                       WHERE ROLE = 'CASHIER')
ORDER BY ORDER_ID; 


-- ADDITIONAL REQUIREMENTS --
-- STORED PROCEDURE

DELIMITER //
CREATE PROCEDURE Rating (CHEF_NAME VARCHAR(50), CHEF_RATING INT,
COMMENTS VARCHAR(50))
BEGIN
   DECLARE FullRating VARCHAR(201);
   SET FullRating = CONCAT(CHEF_NAME, ',', CHEF_RATING,',', COMMENTS);
   SELECT FullRating;
END //
DELIMITER ;

CALL Rating('RIZAL',3,'Improvement neeeded.');
CALL Rating('RACHEL',4,'Keep it up!');
CALL Rating('TAMMY',5,'Excellent!');
CALL Rating('AMIRAH',3,'You can do better.');
CALL Rating('ADAM',4,'Awesome job!');

-- EVENT -- to update
-- One delivery for every 30 mins

SET GLOBAL event_scheduler = ON;

CREATE TABLE DELIVERY_EVENT (
    ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    DEPARTURE_TIME TIMESTAMP
);

DELIMITER //

CREATE EVENT RECURRING_EVENT
ON SCHEDULE EVERY 30 minute
STARTS NOW()
DO BEGIN
  INSERT INTO DELIVERY_EVENT (DEPARTURE_TIME)
  VALUES (NOW());
END //

DELIMITER ;

SELECT * FROM DELIVERY_EVENT;

-- Query with GROUP BY and HAVING --
-- Quantity of non self-pickup orders by mode of delivery
SELECT MODE_OF_DELIVERY, COUNT(ORDER_ID) AS NO_OF_ORDERS
FROM ORDERS
WHERE MODE_OF_DELIVERY NOT LIKE 'Self-pickup' 
GROUP BY MODE_OF_DELIVERY
HAVING COUNT(ORDER_ID) <5;




