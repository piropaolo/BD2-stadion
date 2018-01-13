SET DEFINE OFF;

DELETE FROM STADIONY;
DELETE FROM SEKTORY;
DELETE FROM TYPY_SEKTOROW;
DELETE FROM IMPREZY;
DELETE FROM TYPY_IMPREZ;
DELETE FROM MIEJSCA;

drop sequence dept_seq;
drop sequence dept_seq2;
drop sequence dept_seq3;
drop sequence dept_seq4;
drop sequence dept_seq5;

DROP trigger create_sek_aft_ins_stadiony;
DROP trigger INCREMENT_stadiony_ID;
DROP trigger INCREMENT_imprezy_ID;
DROP trigger INCREMENT_typy_sektorow_ID;
DROP trigger create_msc_aft_ins_sektor;

DROP procedure wstaw_do_typy_sektorow;
DROP procedure wstaw_do_stadiony;
DROP procedure wstaw_do_typy_imprez;
DROP procedure wstaw_do_imprezy;

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

create or replace TRIGGER INCREMENT_imprezy_ID
BEFORE INSERT ON imprezy
FOR EACH ROW
BEGIN
  SELECT dept_seq2.NEXTVAL
  INTO   :new.ID_IMPREZY
  FROM   dual;
END;
/

create or replace TRIGGER create_sek_aft_ins_stadiony
AFTER INSERT ON STADIONY
FOR EACH ROW
BEGIN
  FOR i IN 1..12 LOOP
  
        if i<=4 then
		INSERT INTO SEKTORY(id_sektora ,id_typu, id_stadionu)
        VALUES (i, 1, :NEW.id_stadionu);
        end if;
        
        if (i>4 and i<=8) then
        INSERT INTO SEKTORY(id_sektora ,id_typu, id_stadionu)
        VALUES (i, 2, :NEW.id_stadionu);
        end if;
        
        if (i>8 and i<=12) then
        INSERT INTO SEKTORY(id_sektora ,id_typu, id_stadionu)
        VALUES (i, 3, :NEW.id_stadionu);
        end if;
        
  END LOOP;
  DBMS_OUTPUT.put_line('Dodano wszystkie sektory.');
END;
/

create or replace TRIGGER create_msc_aft_ins_sektor
AFTER INSERT ON SEKTORY
FOR EACH ROW
BEGIN
  if :new.id_typu = 1 then 
    for i in 1..50 LOOP
        FOR j IN 1..100 LOOP
            INSERT INTO MIEJSCA VALUES(i, j, :NEW.id_sektora, :NEW.id_stadionu);
        END LOOP;
    END LOOP;
  end if;
  
  if :new.id_typu = 2 then 
    for i in 1..100 LOOP
        FOR j IN 1..100 LOOP
            INSERT INTO MIEJSCA VALUES(i, j, :NEW.id_sektora, :NEW.id_stadionu);
        END LOOP;
    END LOOP;
  end if;
  
  if :new.id_typu = 3 then 
    for i in 1..50 LOOP
        FOR j IN 1..100 LOOP
            INSERT INTO MIEJSCA VALUES(i, j, :NEW.id_sektora, :NEW.id_stadionu);
        END LOOP;
    END LOOP;
  end if;      
  DBMS_OUTPUT.put_line('Dodano wszystkie miejsca dla sektora.');
END;
/

/*PROCEDURY*/
create or replace PROCEDURE wstaw_do_typy_sektorow
IS
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
	name := TABSTR ('UGI', 'AES', 'Telephone Data Systems', 'Paccar', 'Philip Morris International', 'Avon Products', 'Parker Hannifin', 'Freeport-McMoRan Copper & Gold', 'Great Atlantic & Pacific Tea', 'General Motors', 'Staples', 'UnitedHealth Group', 'MetLife', 'National Oilwell Varco', 'NCR', 'Safeway', 'KBR', 'TravelCenters of America', 'Tesoro', 'Goodyear Tire & Rubber', 'Bemis', 'Time Warner Cable', 'HCA Holdings', 'J.M. Smucker', 'Owens & Minor', 'Owens-Illinois', 'Qwest Communications', 
	'Automatic Data Processing', 'Calpine', 'PNC Financial Services Group', 'J.P. Morgan Chase & Co.', 'NextEra Energy', 'Delta Air Lines', 'Avnet', 'First Data', 'Western Union', 'Chesapeake Energy', 'Best Buy', 'PG&E Corp.', 'Sonic Automotive', 'Qualcomm', 'International Business Machines', 'Universal Health Services', 'Ameren', 'General Electric', 'Texas Instruments', 'NII Holdings', 'Merck', 'Travelers Cos.', 'Community Health Systems', 'Entergy', 'WellPoint', 'Phillips-Van Heusen', 'Whole Foods Market', 'Autoliv', 'Thermo Fisher Scientific', 'Avery Dennison', 'Dr Pepper Snapple Group', 'Plains All American Pipeline', 'Aramark', 'Universal American', 'Virgin Media', 'Loews', 'Union Pacific', 'McGraw-Hill', 'Dover', 'Amazon.com', 'Reinsurance Group of America', 'Mattel', 'ITT', 'Comcast', 'Nike', 'General Cable', 'Enterprise Products Partners', 'Office Depot', 'Dollar General', 'Apple', 
	'Expeditors International of Washington', 'Micron Technology', 'Bank of New York Mellon Corp.', 'Alcoa', 'Applied Materials', 'BB&T Corp.', 'Williams', 'Aflac', 'Procter & Gamble', 'Harris', 'Citigroup', 'CB Richard Ellis Group', 'New York Life Insurance', 'EMC', 'Gannett', 'PPL', 'Tech Data', 'Verizon Communications', 'Costco Wholesale', 'Jabil Circuit', 'Broadcom', 'Home Depot', 'Starwood Hotels & Resorts', 'Cisco Systems', 'Progress Energy', 'Northrop Grumman', 'Corning', 'Unum Group', 'AutoZone', 'Icahn Enterprises', 'Dell', 'Prudential Financial', 'Kimberly-Clark', 'Public Service Enterprise Group', 'Henry Schein', 'Arrow Electronics', 'Host Hotels & Resorts', 'General Mills', 'Ryder System', 'Kellogg', 'Ashland', 'PetSmart', 'CenterPoint Energy', 'SAIC', 'OfficeMax', 'Mohawk Industries', 'Masco', 'Wal-Mart Stores', 'Express Scripts', 'Stryker', 'Xcel Energy', 'BJ''s Wholesale Club', 
	'FirstEnergy', 'Supervalu', 'Ball', 'Newmont Mining', 'Pitney Bowes', 'Eaton', 'Apollo Group', 'St. Jude Medical', 'Oneok', 'Nucor', 'Cameron International', 'Amgen', 'SPX', 'United Services Automobile Assn.', 'INTL FCStone', 'Regions Financial', 'Avaya', 'Southwest Airlines', 'State Farm Insurance Cos.', 'Omnicare', 'KeyCorp');
	qname := name.count;
	FOR i IN 1..2 LOOP
		INSERT INTO stadiony VALUES (1, name(1));
	END LOOP;
	DBMS_OUTPUT.put_line('Dodano wszystkie stadiony.');
END;
/

create or replace PROCEDURE wstaw_do_typy_imprez
IS
BEGIN
	
    INSERT INTO typy_imprez VALUES (1, 'Koncert','test_opis1');
    INSERT INTO typy_imprez VALUES (2, 'Wydarzenie sportowe','test_opis2');
    INSERT INTO typy_imprez VALUES (3, 'Występ','test_opis3');
	
	DBMS_OUTPUT.put_line('Dodano wszystkie typy imprez.');
END;
/

create or replace PROCEDURE wstaw_do_imprezy
is
  TYPE TABSTR IS TABLE OF VARCHAR2(250);
    nazwa TABSTR;
    qnazwa NUMBER(5);

  TYPE TABSTR2 IS TABLE OF DATE;
    dates TABSTR2;
    qdates NUMBER(5);

BEGIN  
  nazwa := TABSTR('Praha','Centurion','Forum','ZaEkranem','5 po piatej','Syrena','Pokoj','Helios','CinemaCity','Multikino','Ton',
  'Riot','Iluzjon','Taras','Cheaper','Greater','GoldenScreen','BlueCity','GoldenGobles','All for All','Brok','Brzmien','Pod Baranami','Pod Gwiazdami',
  'Ponad Podzialami','Brak','Brzmienie','Trust','Chrust','BezNas','Z Nami','Zaczarowany Olowek','Tanie Kino');
  qnazwa := nazwa.count;

  dates := TABSTR2(DATE'2013-02-14',DATE'2013-03-23',DATE'2013-04-02',DATE'2013-07-16',
                    DATE'2013-09-18',DATE'2013-10-15',DATE'2013-11-11',DATE'2013-12-30',
                    DATE'2013-02-02',DATE'2013-03-10',DATE'2013-04-04',DATE'2013-06-12',
                    DATE'2013-05-30',DATE'2013-03-03',DATE'2013-04-23',DATE'2013-09-23',
                    DATE'2013-10-07',DATE'2013-11-14',DATE'2013-11-22',DATE'2013-12-14');
  qdates := dates.count;
  FOR i IN 0..4 LOOP
    FOR j IN 1..qdates LOOP
        INSERT into imprezy values(j,nazwa(round(dbms_random.value(1,qnazwa))),add_months(dates(j),12*i),round(dbms_random.value(1,2)),round(dbms_random.value(1,3)),'test_opis');
    END LOOP;
  END LOOP;
  DBMS_OUTPUT.put_line('Dodano wszystkie imprezy.');
END;
/



/* WYWOŁANIA */
/*KOLEJNOSC WYWOŁYWANIA PROCEDUR
    1.WSTAW DO TYPY SEKTORÓW
    2.WSTAW DO TYPY IMPREZ
    3.WSTAW DO STADIONY
    4.WSTAW DO IMPREZY
*/

SELECT * FROM typy_sektorow;
SELECT * FROM STADIONY ORDER BY ID_STADIONU;
SELECT * FROM SEKTORY ORDER BY ID_STADIONU;
SELECT COUNT(*) FROM STADIONY;
    SELECT COUNT(*) FROM MIEJSCA WHERE id_sektora=6;
SELECT * FROM IMPREZY ORDER BY ID_STADIONU;

