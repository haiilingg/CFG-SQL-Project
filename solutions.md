### JOINS & VIEW
#### View main dish order details
```MySQL
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
```

Output:
MENU_ID|CHEF_ID|CHEF_NAME|YEARS_OF_EXPERIENCE|NAME_OF_FOOD|CATEGORY|VEGAN_OPTIONS
| --- | --- | --- | --- | --- | --- | --- |  
|M01|201|TAMMY|2|Chicken Parmesan|Main|NO|
|M05|202|AMIRAH|3|Pizza|Main|YES|
|M03|203|ADAM|5|Seafood Pasta|Main|NO|

### STORED FUNCTION 
#### Determine customer status based on total payment amount
```MySQL
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
```

Output:
|CUSTOMER_ID|FIRST_NAME|LAST_NAME|MEMBERSHIP_STATUS|
| --- | --- | --- | --- |
|5|Yimin|Tan|Silver|
|6|Priscilla|Wong|Gold|
|8|Kaiwen|Puah|Silver|
|7|Meimei|Ooi|Normal|

### SUBQUERY
#### Querying order IDs of the orders entered by 'Cashier'
```MySQL
SELECT ORDER_ID, ORDER_DATE, ORDER_TIME
FROM ORDERS
WHERE USER_ID IN (SELECT USER_ID
					   FROM USER 
                       WHERE ROLE = 'CASHIER')
ORDER BY ORDER_ID; 
```

Output:
| ORDER_ID | ORDER_DATE | ORDER_TIME |
|----------|------------|------------|
| 1001     | 25/08/2023 | 19:18:29   |
| 1004     | 23/08/2023 | 13:10:48   |
| 1005     | 21/08/2023 | 20:52:36   |
| 1007     | 17/08/2023 | 17:35:13   |
| 1010     | 24/08/2023 | 13:15:13   |
| 1013     | 15/08/2023 | 19:46:53   |
| 1014     | 23/08/2023 | 15:24:52   |

### STORED PROCEDURE
```MySQL
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
```



### EVENT 
#### One delivery for every 30 mins
```MySQL
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
```

### Query with GROUP BY and HAVING 
#### Quantity of non self-pickup orders by mode of delivery
```MySQL
SELECT MODE_OF_DELIVERY, COUNT(ORDER_ID) AS NO_OF_ORDERS
FROM ORDERS
WHERE MODE_OF_DELIVERY NOT LIKE 'Self-pickup' 
GROUP BY MODE_OF_DELIVERY
HAVING COUNT(ORDER_ID) <5;
```
Output:
| MODE_OF_DELIVERY | NO_OF_ORDERS |
|------------------|--------------|
| Deliveroo        | 4            |
| Uber Eats        | 4            |
| Just Eat         | 4            |



