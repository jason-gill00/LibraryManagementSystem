#!/bin/sh
MainMenu()
{
        while [ "$CHOICE" != "START" ]
        do
                #clear
                echo "================================================================="
                echo "|                    Oracle All Inclusive Tool                  |"
                echo "|    Main Menu -Select Desired Operation(s):          |"
                echo "|        <CTRL-Z Anytime to Enter Interactive CMD Prompt>       |"
                echo "-----------------------------------------------------------------"
                echo " $IS_SELECTEDM M)  View Manual"
                echo " "
                echo " $IS_SELECTED1 1) Query 1"
		echo " $IS_SELECTED2 2) Query 2"
                echo " $IS_SELECTED3 3) Query 3"
		echo " $IS_SELECTED4 4) Query 4"
		echo " $IS_SELECTED5 5) Query 5"
		echo " $IS_SELECTED6 6) Query 6"
		echo " $IS_SELECTED7 7) Query 7"
		echo " $IS_SELECTED8 8) Query 8"
		echo " $IS_SELECTED9 9) Query 9"
		echo " $IS_SELECTED10 10) Query 10"
		echo " $IS_SELECTED11 11) Query 11 (Views)"
		echo " $IS_SELECTED12 12) Query 12 (Drop Views)"
		echo " $IS_SELECTED13 13) Return to Main Menu"		
		echo "_"
                echo "Choose: "
                read CHOICE
                if [ "$CHOICE" == "1" ]
                then
                    echo "Creating all tables"
                    sqlplus64 "jcabugua/11245288@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<-EOF
			
			
			SELECT c.CUSTOMERID, c.EMAIL, m.MEMBERSHIPNAME
			FROM CUSTOMER c
			JOIN MEMBERSHIP m
			ON c.MEMBERSHIPID = m.MEMBERSHIPID;

			exit;
			EOF

		elif [ "$CHOICE" == "2" ]
                then
			sqlplus64 "jcabugua/11245288@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<-EOF
			
			SELECT 
			    ORDERID,
			    ORDERDATE,
			    'ACTIVE' AS status
			FROM ORDERS 
			WHERE ORDERDATE >= '02-FEB-2020'
			UNION
			SELECT 
			    ORDERID,
			    ORDERDATE,
			    'ARCHIVED' AS status
			FROM ORDERS 
			WHERE ORDERDATE < '02-FEB-2020';


			exit;
			EOF

		elif [ "$CHOICE" == "3" ]
		then
            sqlplus64 "jcabugua/11245288@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<-EOF
			
			SELECT 
				e.EMPLOYEEID,
				p.EMAIL,
				p.PHONE,
				m.EMAIL AS MANAGER
			FROM EMPLOYEE e
			JOIN EMPLOYEE m
				ON e.EMPLOYEEID = m.MANAGERID
			JOIN PERSON p 
				ON e.EMAIL = p.EMAIL;


			exit;
			EOF

		elif [ "$CHOICE" == "4" ]
                then
			sqlplus64 "jcabugua/11245288@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<-EOF
			
			SELECT
				L.ITEMID,
				L. GENRE,
				L.AVAILABILITYSTATUS,
				L.RATING,
				V.PRODUCTIONSTUDIO,
				v.DIRECTOR
			FROM LIBRARYITEM L
			JOIN VIDEOS V
				ON V.LIBRARYITEMNUMBER = L.ITEMID;


			exit;
			EOF


		elif [ "$CHOICE" == "5" ]
		then
			sqlplus64 "jcabugua/11245288@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<-EOF	
			

			SELECT *
			FROM LIBRARYITEM
			WHERE GENRE  = 'Romance';

			exit;
			EOF

		elif [ "$CHOICE" == "6" ]
		then
			sqlplus64 "jcabugua/11245288@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<-EOF
			

			SELECT 
				e.EMPLOYEEID,
				e.EMAIL
			FROM EMPLOYEE e
			WHERE EMPLOYEEID < 3;

			exit;
			EOF

		elif [ "$CHOICE" == "7" ]
		then
			sqlplus64 "jcabugua/11245288@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<-EOF
			

			SELECT *
			FROM LIBRARYITEM
			WHERE availabilityStatus = 1;

			exit;
			EOF

		elif [ "$CHOICE" == "8" ]
		then
			sqlplus64 "jcabugua/11245288@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<-EOF
			

			SELECT * 
			FROM PAYMENTMETHOD;

			exit;
			EOF


		elif [ "$CHOICE" == "9" ]
		then
			sqlplus64 "jcabugua/11245288@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<-EOF
			
			SELECT *
			FROM CUSTOMER c
			WHERE EXISTS 
				(SELECT NUMOFBOOKSALLOWED
				FROM MEMBERSHIP m
				WHERE c.MEMBERSHIPID = m.MEMBERSHIPID 
			AND m.MEMBERSHIPNAME = 'GOLD');

			exit;
			EOF

		elif [ "$CHOICE" == "10" ]
		then
			sqlplus64 "jcabugua/11245288@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<-EOF
			
			SELECT r.RENTALDATE, c.EMAIL, r.OVERDUEAMOUNT
			FROM RENTALORDER r, CUSTOMER c 
			WHERE c.CUSTOMERID = r.CUSTOMERID
			AND r.OVERDUEAMOUNT > 5
			ORDER BY OVERDUEAMOUNT ASC;



			exit;
			EOF

		elif [ "$CHOICE" == "11" ]
		then
			sqlplus64 "jcabugua/11245288@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<-EOF
			
			CREATE VIEW manager_phone AS
			(SELECT 
				e.EMPLOYEEID, e.EMAIL
			FROM EMPLOYEE e
			WHERE EXISTS
				(SELECT e.EMAIL
				FROM EMPLOYEE m, Person p
				WHERE e.EMPLOYEEID = m.MANAGERID
				AND e.EMAIL = p.EMAIL));


			CREATE VIEW item_order_status AS
			(SELECT 
				ORDERID,
				ORDERDATE,
				'ACTIVE' AS status
			FROM ORDERS 
			WHERE ORDERDATE >= '2020-02-02'
			UNION
			SELECT 
				ORDERID,
				ORDERDATE,
				'ARCHIVED' AS status
			FROM ORDERS 
			WHERE ORDERDATE < '2020-02-02');


			CREATE VIEW potential_employee AS
			(SELECT p.LASTNAME, p.FIRSTNAME, p.phone, p.email
			FROM PERSON p
			WHERE NOT EXISTS
				(SELECT *
				FROM EMPLOYEE e
				WHERE p.EMAIL = e.EMAIL));


			exit;
			EOF

		elif [ "$CHOICE" == "12" ]
		then
			sqlplus64 "jcabugua/11245288@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<-EOF
			
			DROP VIEW item_order_status;
			DROP VIEW potential_employee;
			DROP VIEW manager_phone;


			exit;
			EOF

		elif [ "$CHOICE" == "13" ]
		then
			exit
		fi
	done
}
#--COMMENTS BLOCK--
# Main Program
#--COMMENTS BLOCK--
ProgramStart()
{
	StartMessage
	while [ 1 ]
	do
		MainMenu
	done
}
ProgramStart 