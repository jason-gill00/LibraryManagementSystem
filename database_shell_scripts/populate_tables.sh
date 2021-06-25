sqlplus64 "jcabugua/11245288@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<-EOF

INSERT ALL
INTO person 
VALUES('01-FEB-1987','sean12@gmail.com',647123456,'sean','beasley','M1W1J5','Ontario','Toronto','Canada',123,'Jane St.')
INTO person 
VALUES('01-FEB-1987','nat10@gmail.com',647654321,'nat','James','M1W2K7','Ontario','Toronto','Canada',100,'Kennedy E.')
INTO person 
VALUES('01-FEB-1987','BobP@gmail.com',647654321,'Bob','Pierce','M1W3S4','Ontario','Toronto','Canada',1850,'Lawrence Ave. E.')
INTO person 
VALUES('01-FEB-1987','RobH@gmail.com',647654321,'Rob','Harden','M1W8H1','Ontario','Toronto','Canada',2500,'Eglinton Ave. W.')
INTO person 
VALUES('01-FEB-1987','TomA@gmail.com',647654321,'Tom','Antetokoumpo','M1W5B2','Ontario','Toronto','Canada',1500,'Finch Ave. E.')
SELECT 1 FROM DUAL;

INSERT ALL
INTO Membership VALUES (1,10,'01-FEB-1987','SILVER')
INTO Membership VALUES (2,8,'01-FEB-1987','GOLD')
SELECT 1 FROM DUAL;

INSERT ALL
INTO PaymentMethod VALUES  (1,'Visa')
INTO PaymentMethod VALUES  (2,'Debit')
SELECT 1 FROM DUAL;

INSERT ALL
INTO Customer VALUES (1,'RobH@gmail.com',1,1)
INTO Customer VALUES (2,'TomA@gmail.com',2,2)
SELECT 1 FROM DUAL;


INSERT ALL 
INTO LIBRARYITEM VALUES(1,'Romance',1,'01-FEB-1987',8)
INTO LIBRARYITEM VALUES(2,'Romance',1,'01-FEB-1987',10)
SELECT 1 FROM DUAL;

INSERT ALL
INTO BOOKS VALUES(121032992,'John Cabuguason',1)
SELECT 1 FROM DUAL;

INSERT ALL
INTO Videos VALUES (1,1,'UniversalStudios','John','Jason')
INTO Videos VALUES (2,2,'UniversalStudios','Shant','Jason')
SELECT 1 FROM DUAL;

INSERT ALL
INTO RentalOrder VALUES (1,1,1,50,15,'01-FEB-1987','01-FEB-1987')
INTO RentalOrder VALUES (2,2,2,30,5,'01-FEB-1987','01-FEB-1987')
SELECT 1 FROM DUAL;
 

INSERT ALL
INTO SUPPLIERS    VALUES(0,'AMD Books')
INTO SUPPLIERS    VALUES(1,'NVIDIA Education')
SELECT 1 FROM DUAL;


INSERT ALL 
INTO SUPPLIERITEMS VALUES(1,0,'How to read for dummies','Book')
INTO SUPPLIERITEMS VALUES(2,1,'MYSQL 101','Book')
SELECT 1 FROM DUAL;



INSERT ALL
INTO ORDERS VALUES(1,1,1,7,2,'15-OCT-2020')
INTO ORDERS VALUES(2,0,1,15,3,'02-NOV-2020')
INTO ORDERS VALUES(3,1,2,25,3,'25-MAY-2019')
INTO ORDERS VALUES (4,0,1,5,23,'05-FEB-2019')
SELECT 1 FROM DUAL;


INSERT ALL
INTO EMPLOYEE VALUES(1,1,'sean12@gmail.com')
INTO EMPLOYEE VALUES(2,1,'nat10@gmail.com')
INTO EMPLOYEE VALUES(3,1,'BobP@gmail.com')
SELECT 1 FROM DUAL;
exit;
EOF