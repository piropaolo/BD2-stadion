SET DEFINE OFF;

DELETE FROM MIEJSCA;
DELETE FROM SEKTORY;
DELETE FROM STADIONY;
DELETE FROM IMPREZY;
DELETE FROM TYPY_SEKTOROW;
DELETE FROM TYPY_IMPREZ;
DELETE FROM typy_klientow;
DELETE FROM CENA;
DELETE FROM PROMOCJE;
DELETE FROM TYPY_KARNETOW;
DELETE FROM KLIENCI;

drop sequence dept_seq;
drop sequence dept_seq2;
drop sequence dept_seq3;
drop sequence dept_seq4;
drop sequence dept_seq5;

DROP trigger create_sek_aft_ins_stadiony;
DROP trigger INCREMENT_stadiony_ID;
DROP trigger INCREMENT_imprezy_ID;
DROP trigger create_msc_aft_ins_sektor;
drop trigger create_ceny_aft_ins_imprezy;

DROP procedure wstaw_do_typy_sektorow;
DROP procedure wstaw_do_stadiony;
DROP procedure wstaw_do_typy_imprez;
DROP procedure wstaw_do_imprezy;
DROP procedure wstaw_do_typy_klientow;
DROP procedure wstaw_do_promocje;
DROP PROCEDURE wstaw_do_typy_karnetow;
DROP PROCEDURE wstaw_do_klienci;

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

create or replace TRIGGER create_ceny_aft_ins_imprezy
AFTER INSERT ON IMPREZY
FOR EACH ROW
DECLARE
prize1 NUMBER(20,2);
prize2 NUMBER(20,2);
prize3 NUMBER(20,2);
BEGIN
    if :new.id_typu = 1 then
        prize1 := round(dbms_random.value(200,400),2);
        prize2 := round(dbms_random.value(150,200),2);
        prize3 := round(dbms_random.value(100,150),2);
		INSERT INTO CENA VALUES(prize1,1,:new.ID_IMPREZY,:new.id_typu);
        INSERT INTO CENA VALUES(prize2,2,:new.id_imprezy,:new.id_typu);
        INSERT INTO CENA VALUES(prize3,3,:new.id_imprezy,:new.id_typu);
    end if;

    if :new.id_typu = 2 then
        prize1 := round(dbms_random.value(150,250),2);
        prize2 := round(dbms_random.value(80,150),2);
        prize3 := round(dbms_random.value(50,80),2);
		INSERT INTO CENA VALUES(prize1,1,:new.id_imprezy,:new.id_typu);
        INSERT INTO CENA VALUES(prize2,2,:new.id_imprezy,:new.id_typu);
        INSERT INTO CENA VALUES(prize3,3,:new.id_imprezy,:new.id_typu);
    end if;

    if :new.id_typu = 3 then
        prize1 := round(dbms_random.value(100,200),2);
        prize2 := round(dbms_random.value(80,100),2);
        prize3 := round(dbms_random.value(40,80),2);
		INSERT INTO CENA VALUES(prize1,1,:new.id_imprezy,:new.id_typu);
        INSERT INTO CENA VALUES(prize2,2,:new.id_imprezy,:new.id_typu);
        INSERT INTO CENA VALUES(prize3,3,:new.id_imprezy,:new.id_typu);
    end if;
  DBMS_OUTPUT.put_line('Dodano wszystkie ceny dla imprezy.');
END;
/

/*PROCEDURY*/
create or replace PROCEDURE wstaw_do_typy_sektorow
IS
BEGIN
    INSERT INTO typy_sektorow VALUES (1, 'TYP 1','test_opis1');
    INSERT INTO typy_sektorow VALUES (2, 'TYP 2','test_opis2');
    INSERT INTO typy_sektorow VALUES (3, 'TYP 3','test_opis3');
	
	DBMS_OUTPUT.put_line('Dodano wszystkie typy sektorów.');
END;
/

create or replace PROCEDURE wstaw_do_typy_klientow
IS
BEGIN
    INSERT INTO typy_klientow VALUES (1, 'Normalny',0,'Nie przysluguje znizka');
    INSERT INTO typy_klientow VALUES (2, 'Dziecko',50,'Dziecko do lat 12');
    INSERT INTO typy_klientow VALUES (3, 'Emeryt',70,'Po osiegnieciu wieku emerytalnego: 65 lat');
    INSERT INTO typy_klientow VALUES (4, 'Kombatant',95,'kombatant wojennych');
	DBMS_OUTPUT.put_line('Dodano wszystkie typy klientów.');
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
		INSERT INTO stadiony VALUES (i, name(i));
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

create or replace PROCEDURE wstaw_do_typy_karnetow
IS
BEGIN
	
    INSERT INTO typy_karnetow VALUES (1, 'Karnet Ligi Diamentowej Premium', 4000, DATE'2017-12-12', 'brak opisu', 1, 2);
    INSERT INTO typy_karnetow VALUES (2, 'Karnet Ligi Diamentowej Normal', 3000, DATE'2017-12-12', 'brak opisu', 2, 2);
    INSERT INTO typy_karnetow VALUES (3, 'Karnet Ligi Diamentowej Cheap', 2000, DATE'2017-12-12', 'brak opisu', 3, 2);
    INSERT INTO typy_karnetow VALUES (4, 'Karnet Klubu Kabaretowego Premium', 200, DATE'2017-12-12', 'brak opisu', 1, 3);
    INSERT INTO typy_karnetow VALUES (5, 'Karnet Klubu Kabaretowego Normal', 150, DATE'2017-12-12', 'brak opisu', 2, 3);
    INSERT INTO typy_karnetow VALUES (6, 'Karnet Klubu Kabaretowego Cheap', 100, DATE'2017-12-12', 'brak opisu', 3, 3);
    INSERT INTO typy_karnetow VALUES (7, 'Karnet Sezonu Piłkarskiego Premium',600, DATE'2017-12-12', 'brak opisu', 1, 2);
    INSERT INTO typy_karnetow VALUES (8, 'Karnet Sezonu Piłkarskiego Normal',400, DATE'2017-12-12', 'brak opisu', 2, 2);
    INSERT INTO typy_karnetow VALUES (9, 'Karnet Sezonu Piłkarskiego Cheap',200, DATE'2017-12-12', 'brak opisu', 3, 2);
    INSERT INTO typy_karnetow VALUES (10, 'Karnet Koncertowy Premium',1000, DATE'2017-12-12', 'brak opisu', 1, 1);
    INSERT INTO typy_karnetow VALUES (11, 'Karnet Koncertowy Normal',800, DATE'2017-12-12', 'brak opisu', 2, 1);
    INSERT INTO typy_karnetow VALUES (12, 'Karnet Koncertowy Cheap',600, DATE'2017-12-12', 'brak opisu', 3, 1);
	
	DBMS_OUTPUT.put_line('Dodano wszystkie typy karnetów.');
END;
/

create or replace PROCEDURE wstaw_do_promocje
IS
BEGIN
    INSERT INTO promocje VALUES (1, 'Brak',0,'Nie przysluguje znizka',1);
    INSERT INTO promocje VALUES (2, 'Zniżka dziecięca',50,'50% zniżki od ceny oryginalnej',2);
    INSERT INTO promocje VALUES (3, 'Zniżka dla emeryta',70,'70% zniżki od ceny oryginalnej',3);
    INSERT INTO promocje VALUES (4, 'Zniżka dla kombatanta',95,'90% zniżki od ceny oryginalnej',4);
	DBMS_OUTPUT.put_line('Dodano wszystkie promocje.');
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

create or replace PROCEDURE wstaw_do_klienci
IS
	TYPE TABSTR IS TABLE OF VARCHAR2(500);
	imie TABSTR;
    TYPE TABSTR2 IS TABLE OF VARCHAR2(500);
	nazwisko TABSTR2;
  
	tel_number NUMBER(9);
    kierunkowy NUMBER(3);
    qname NUMBER(5);
    qsurname NUMBER(5);
    imie_w STRING (20);
    nazw_w STRING (20);
    rok_pesel NUMBER(2);
    miesiac_pesel NUMBER(2);
    dzien_pesel NUMBER(2);
    reszta_pesel NUMBER(5);
    got_pesel VARCHAR(11);
    got_telefon VARCHAR(16);
    typ_klienta NUMBER;
    
    
BEGIN
	imie := TABSTR ('Jan','Stanislaw','Andrzej','Jozef','Tadeusz','Jerzy','Zbigniew','Krzysztof','Henryk',
    'Ryszard','Marek','Kazimierz','Marian','Piotr','Janusz','Wladyslaw','Adam','Wieslaw','Zdzislaw','Edward',
    'Mieczyslaw','Roman','Miroslaw','Grzegorz','Czeslaw','Dariusz','Wojciech','Jacek','Eugeniusz','Maria','Tomasz',
    'Krystyna','Anna','Barbara','Teresa','Elzbieta','Janina','Zofia','Jadwiga','Danuta','Halina','Irena','Ewa',
    'Malgorzata','Helena','Grazyna','Bozena','Stanislawa','Marianna','Jolanta','Urszula','Wanda','Alicja','Dorota',
    'Agnieszka','Beata','Katarzyna','Joanna','Wieslawa','Renata');
    qname := imie.count;
  
    nazwisko := TABSTR2 ('Nowak','Kowalski','Wisniewski','Dabrowski','Lewandowski','Wojcik','Kaminski','Kowalczyk',
    'Zielinski','Szymanski','Kozlowski','Wozniak','Jankowski','Wojciechowski','Kwiatkowski','Kaczmarek','Mazur',
    'Krawczyk','Piotrowski','Grabowski','Nowakowski','Pawlowski','Michalski','Nowicki','Adamczyk','Dudek','Zajac',
    'Wieczorek','Jablonski','Majewski','Krol','Olszewski','Jaworski','Wróbel','Malinowski','Pawlak','Witkowski',
    'Walczak','Stepien','Gorski','Rutkowski','Michalak','Sikora','Ostrowski','Baran','Duda','Szewczyk','Tomaszewski',
    'Marciniak','Pietrzak','Wroblewski','Zalewski','Jakubowski','Jasinski','Zawadzki','Sadowski','Bak','Chmielewski',
    'Wlodarczyk','Borkowski','Czarnecki','Sawicki','Sokolowski','Urbanski','Kubiak','Maciejewski','Szczepanski'
    ,'Wilk','Kucharski','Kalinowski','Lis','Mazurek','Wysocki','Adamski','Kazimierczak','Wasilewski','Sobczak',
    'Czerwinski','Andrzejewski','Cieslak','Glowacki','Zakrzewski','Kolodziej','Sikorski','Krajewski','Gajewski',
    'Szulc','Szymczak','Baranowski','Laskowski','Brzezinski','Makowski','Ziolkowski','Przybylski','Domanski',
    'Nowacki','Borowski','Blaszczyk','Chojnacki','Ciesielski','Mroz','Szczepaniak','Wesolowski','Garecki','Krupa',
    'Kaczmarczyk','Leszczynski','Lipinski');
	qsurname := nazwisko.count;
  

	FOR i IN 1..5000 LOOP
		tel_number := round(dbms_random.value(600000000,899999999));
        kierunkowy := round(dbms_random.value(1,999));
        rok_pesel := round(dbms_random.value(0,99));
        miesiac_pesel := round(dbms_random.value(1,12));
        dzien_pesel := round(dbms_random.value(1,28));
        reszta_pesel := round(dbms_random.value(10000,99999));
		imie_w := imie(round(dbms_random.value(1,qname)));
        nazw_w := nazwisko(round(dbms_random.value(1,qsurname)));
        
        
            got_pesel := to_char(rok_pesel);
        if rok_pesel<10 then
            got_pesel  := concat('0',to_char(rok_pesel));
        end if;
        
        
        if miesiac_pesel<10 then
            got_pesel  := concat(got_pesel,concat('0',to_char(miesiac_pesel)));
        else
            got_pesel := concat(got_pesel,to_char(miesiac_pesel));
        end if;
        
        
        if dzien_pesel<10 then
            got_pesel  := concat(got_pesel,concat('0',to_char(dzien_pesel)));
        else
            got_pesel := concat(got_pesel,to_char(dzien_pesel));
        end if;
        
        got_pesel := concat(got_pesel, to_char(reszta_pesel));
        got_telefon := concat(concat('+',concat(to_char(kierunkowy),' ')),to_char(tel_number));
        
        if rok_pesel<18 and rok_pesel>6 then
            typ_klienta := 2;
        elsif rok_pesel<53 and rok_pesel>30 then
            typ_klienta := 3;
        else
            typ_klienta := 1;
        end if;
        
        INSERT INTO KLIENCI
        (id_klienta, 
        nazwisko, 
        imie,
        PESEL,
        zdjecie,
        telefon_kontaktowy,
        TYPY_KLIENTOW_ID_TYPU)
        
        VALUES 
        (i, 
        nazw_w, 
        imie_w,
        got_pesel,
        EMPTY_BLOB(),
        got_telefon,
        typ_klienta);
	END LOOP;
  DBMS_OUTPUT.put_line('All klienci added.');
END;
/

