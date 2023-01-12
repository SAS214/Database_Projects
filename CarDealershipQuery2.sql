USE dealership;

DELIMITER $$
DROP PROCEDURE IF EXISTS commissionCheck$$ 
CREATE PROCEDURE commissionCheck (IN employeeNum int, INOUT commission varchar(4000))
BEGIN
 
 DECLARE v_finished INTEGER DEFAULT 0;
 DECLARE v_lines varchar(100) DEFAULT "--------------------------------------------------------------------------------";
 DECLARE v_eFirst varchar(100) DEFAULT "";
 DECLARE v_eLast varchar(100) DEFAULT "";
 DECLARE v_eAddress varchar(100) DEFAULT "";
 DECLARE v_eCity varchar(100) DEFAULT "";
 DECLARE v_eState varchar(100) DEFAULT "";
 DECLARE v_eZip varchar(100) DEFAULT "";
 DECLARE v_retail decimal(8,2) DEFAULT 0.0;
 DECLARE v_pay decimal(8,2) DEFAULT 0.0;
 DECLARE v_count INTEGER DEFAULT 0;
 DECLARE v_eight decimal(3,2) DEFAULT .08;
 DECLARE v_ten decimal(3,2) DEFAULT .10;
 DECLARE v_fifteen decimal(3,2) DEFAULT .15;
 DECLARE v_twenty decimal(3,2) DEFAULT .20;
 
 
 DEClARE employee_cursor CURSOR FOR
 SELECT firstName from employee
 SELECT lastName from employee
 SELECT address from employee
 SELECT city from cityState
 SELECT state from cityState
 SELECT zipCode from cityState
 SELECT salePrice from sale
 WHERE employeeID = employeeNum;
 
 DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET v_finished = 1;

-- open the cursor
OPEN employee_cursor;

 get_employee: LOOP
 FETCH employee_cursor INTO v_eFirst, v_eLast, v_eAddress, v_eCity, v_eState, v_eZip, v_retail;
 
 IF v_finished = 1 THEN 
    LEAVE get_employee;
 END IF;
 

SELECT @i:=0;
UPDATE v_count = @i:=@i+1;



IF v_count = 1 THEN
    
    IF v_retail >= 40000 THEN
    SET v_pay = v_retail * (20/100 * v_retail);
    ELSEIF v_retail >=30000 THEN
    SET v_pay = v_retail * (15/100 * v_retail);
    ELSEIF v_retail >= 20000 THEN
    SET v_pay = v_retail * (10/100 * v_retail);
    ELSEIF v_retail <20000 THEN
    SET v_pay = v_retail * (8/100 * v_retail);




SELECT v_pay;


    SET commission = CONCAT(commission, '\n', v_lines, '\n');
    SET commission = CONCAT(commission, '\From', '\n');
    SET commission = CONCAT(commission, '\nCGS 2545 Car Dealership\n');
    SET commission = CONCAT(commission, 'UCF\n');
    SET commission = CONCAT(commission, 'MSB 260\n\n');
    SET commission = CONCAT(commission, 'Pay to the order of:\n\n');
    SET commission = CONCAT(commission, v_eFirst, '', v_eLast, '\n');
    SET commission = CONCAT(commission, v_eAddress, '\n');
    SET commission = CONCAT(commission, v_eCity, ',', v_eState, ',', v_eZip, '\n');
    SET commission = CONCAT(commission, 'In the amount of:\n\n');
    SET commission = CONCAT(commission, '$', v_pay, '\n');
    SET commission = CONCAT(commission, '\n', v_lines, '\n');


END IF;


END LOOP get_employee;
CLOSE employee_cursor;

END$$
 
DELIMITER ;

SET @commission = ''; 
call commissionCheck(@sale.employeeID, @commission);
SELECT @commission;
