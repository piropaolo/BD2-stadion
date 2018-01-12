DELETE FROM STADIONY;
DELETE FROM SEKTORY;
DELETE FROM TYPY_SEKTOROW;

drop sequence dept_seq;
drop sequence dept_seq2;
drop sequence dept_seq3;
drop sequence dept_seq4;
drop sequence dept_seq5;

/*DROP trigger INCREMENT_sektory_ID;*/
DROP trigger create_sek_aft_ins_stadiony;
DROP trigger INCREMENT_stadiony_ID;
DROP trigger INCREMENT_typy_sektorow_ID;


DROP procedure wstaw_do_typy_sektorow;
DROP procedure wstaw_do_stadiony;


/*SEKWENCJE*/
CREATE SEQUENCE dept_seq START WITH 1;
CREATE SEQUENCE dept_seq2 START WITH 1;
CREATE SEQUENCE dept_seq3 START WITH 1;
CREATE SEQUENCE dept_seq4 START WITH 1;
CREATE SEQUENCE dept_seq5 START WITH 1;

/*TRIGGERY*/
create or replace TRIGGER INCREMENT_stadiony_ID
BEFORE INSERT ON STADIONY
FOR EACH ROW
BEGIN
  SELECT dept_seq.NEXTVAL
  INTO   :new.ID_STADIONU
  FROM   dual;
END;
/

create or replace TRIGGER create_sek_aft_ins_stadiony
AFTER INSERT ON STADIONY
FOR EACH ROW
BEGIN
  FOR i IN 1..12 LOOP
		INSERT INTO SEKTORY(id_sektora ,id_typu, id_stadionu)
        VALUES (i, 2, :NEW.id_stadionu);
  END LOOP;
  DBMS_OUTPUT.put_line('Dodano wszystkie sektory.');
END;
/

/*PROCEDURY*/
create or replace PROCEDURE wstaw_do_typy_sektorow
IS
  TYPE TABSTR IS TABLE OF VARCHAR2(250);
BEGIN
	
    INSERT INTO typy_sektorow VALUES (1, 'test_typ1','test_opis1');
    INSERT INTO typy_sektorow VALUES (2, 'test_typ2','test_opis2');
    INSERT INTO typy_sektorow VALUES (3, 'test_typ3','test_opis3');
	
	DBMS_OUTPUT.put_line('Dodano wszystkie typy sektorów.');
END;
/

create or replace PROCEDURE wstaw_do_stadiony
IS
  	TYPE TABSTR IS TABLE OF VARCHAR2(250);
	name TABSTR;
	qname NUMBER(5);
BEGIN
	name := TABSTR ('UGI', 'AES', 'Telephone & Data Systems', 'Paccar', 'Philip Morris International', 'Avon Products', 'Parker Hannifin', 'Freeport-McMoRan Copper & Gold', 'Great Atlantic & Pacific Tea', 'General Motors', 'Staples', 'UnitedHealth Group', 'MetLife', 'National Oilwell Varco', 'NCR', 'Safeway', 'KBR', 'TravelCenters of America', 'Tesoro', 'Goodyear Tire & Rubber', 'Bemis', 'Time Warner Cable', 'HCA Holdings', 'J.M. Smucker', 'Owens & Minor', 'Owens-Illinois', 'Qwest Communications', 
	'Automatic Data Processing', 'Calpine', 'PNC Financial Services Group', 'J.P. Morgan Chase & Co.', 'NextEra Energy', 'Delta Air Lines', 'Avnet', 'First Data', 'Western Union', 'Chesapeake Energy', 'Best Buy', 'PG&E Corp.', 'Sonic Automotive', 'Qualcomm', 'International Business Machines', 'Universal Health Services', 'Ameren', 'General Electric', 'Texas Instruments', 'NII Holdings', 'Merck', 'Travelers Cos.', 'Community Health Systems', 'Entergy', 'WellPoint', 'Phillips-Van Heusen', 'Whole Foods Market', 'Autoliv', 'Thermo Fisher Scientific', 'Avery Dennison', 'Dr Pepper Snapple Group', 'Plains All American Pipeline', 'Aramark', 'Universal American', 'Virgin Media', 'Loews', 'Union Pacific', 'McGraw-Hill', 'Dover', 'Amazon.com', 'Reinsurance Group of America', 'Mattel', 'ITT', 'Comcast', 'Nike', 'General Cable', 'Enterprise Products Partners', 'Office Depot', 'Dollar General', 'Apple', 
	'Expeditors International of Washington', 'Micron Technology', 'Bank of New York Mellon Corp.', 'Alcoa', 'Applied Materials', 'BB&T Corp.', 'Williams', 'Aflac', 'Procter & Gamble', 'Harris', 'Citigroup', 'CB Richard Ellis Group', 'New York Life Insurance', 'EMC', 'Gannett', 'PPL', 'Tech Data', 'Verizon Communications', 'Costco Wholesale', 'Jabil Circuit', 'Broadcom', 'Home Depot', 'Starwood Hotels & Resorts', 'Cisco Systems', 'Progress Energy', 'Northrop Grumman', 'Corning', 'Unum Group', 'AutoZone', 'Icahn Enterprises', 'Dell', 'Prudential Financial', 'Kimberly-Clark', 'Public Service Enterprise Group', 'Henry Schein', 'Arrow Electronics', 'Host Hotels & Resorts', 'General Mills', 'Ryder System', 'Kellogg', 'Ashland', 'PetSmart', 'CenterPoint Energy', 'SAIC', 'OfficeMax', 'Mohawk Industries', 'Masco', 'Wal-Mart Stores', 'Express Scripts', 'Stryker', 'Xcel Energy', 'BJ''s Wholesale Club', 
	'FirstEnergy', 'Supervalu', 'Ball', 'Newmont Mining', 'Pitney Bowes', 'Eaton', 'Apollo Group', 'St. Jude Medical', 'Oneok', 'Nucor', 'Cameron International', 'Amgen', 'SPX', 'United Services Automobile Assn.', 'INTL FCStone', 'Regions Financial', 'Avaya', 'Southwest Airlines', 'State Farm Insurance Cos.', 'Omnicare', 'KeyCorp');
	qname := name.count;
	FOR i IN 1..qname LOOP
		INSERT INTO stadiony VALUES (i, name(i));
	END LOOP;
	DBMS_OUTPUT.put_line('Dodano wszystkie stadiony.');
END;
/

SELECT * FROM typy_sektorow;
SELECT * FROM STADIONY ORDER BY ID_STADIONU;
SELECT * FROM SEKTORY ORDER BY ID_STADIONU;
