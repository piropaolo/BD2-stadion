

/*niszczenie tabel*/
drop table przychody cascade constraints;
drop table umowy cascade constraints;
drop table bilans cascade constraints;
drop table firmy_zew cascade constraints;
drop table kina cascade constraints;
drop table film cascade constraints;
drop table companies cascade constraints;
drop table person cascade constraints;

drop SEQUENCE dept_seq;
drop SEQUENCE dept_seq2;
drop SEQUENCE dept_seq3;
drop SEQUENCE dept_seq4;
drop SEQUENCE dept_seq5;

drop trigger add_bilans_after_insert_comp;
drop trigger add_filmy_after_inert_person;
drop trigger add_firmy_zew_insert_person;
drop trigger add_umowy_after_inert_person;
drop trigger increment_film_id;
drop trigger increment_firmy_zew_id;
drop trigger increment_przychody_id;
drop trigger increment_umowy_id;
drop trigger oblicz_bilnas;
drop trigger oblicz_bilnas2;
drop trigger przychody_dla_firmy;
drop trigger wstaw_przychody;
drop trigger zrealizowanie_umowy;

drop procedure wstaw_do_companies;
drop procedure wstaw_do_kin;
drop procedure wstaw_do_person;



delete from bilans;
delete from firmy_zew;
delete from film;
delete from umowy;
delete from przychody;
delete from person;
delete from companies;
delete from kina;



/*tworzenie tabel*/
create table bilans(
id_firmy number primary key,
nazwa_firmy varchar2(200),
kwota_przychodow INTEGER,
kwota_wydatkow INTEGER,
bilans INTEGER

);

create table companies(
id number primary key,
name VARCHAR2(200 BYTE),
start_date date
);


create table firmy_zew(
id_zew_firmy number primary key,
lokalizacja VARCHAR2(200 BYTE),
id_prezesa number,
prezes VARCHAR2(200 BYTE)
);

create table kina(
id number primary key,
nazwa VARCHAR2(200 BYTE),
lokalizacja VARCHAR2(200 BYTE)
);

create table person(
id number primary key,
imie VARCHAR2(200 BYTE),
nazwisko VARCHAR2(200 BYTE),
telefon number(9,0),
stanowisko VARCHAR2(200 BYTE)
);

create table przychody(
id_przychodu number primary key,
id_firmy number,
tytul VARCHAR2(200 BYTE),
id_filmu number,
id_kina number,
kiedy date,
kwota INTEGER
);

create table umowy(
id_umowy number primary key,
id_osoby number,
id_firmy number,
kiedy date,
kwota number,
czy_zrealizowano VARCHAR2(20 BYTE)
);

create table film(
id number primary key,
tytul VARCHAR2(2000 BYTE),
rezyser VARCHAR2(20 BYTE),
id_rezysera number,
gatunek VARCHAR2(200 BYTE),
rok number
);

/*relacje*/
ALTER TABLE firmy_zew add constraint firmy_zewFK foreign key(id_prezesa) references person(id);
ALTER TABLE UMOWY add constraint umowyFK foreign key(id_osoby) references person(id);
ALTER TABLE UMOWY add constraint umowyFK2 foreign key(id_firmy) references companies(id);
ALTER TABLE BILANS add constraint bilansFK foreign key(id_firmy) references companies(id);
ALTER TABLE FILM add constraint filmFK foreign key(id_rezysera) references person(id);
ALTER TABLE PRZYCHODY add constraint przychodyFK foreign key(id_kina) references kina(id);
ALTER TABLE PRZYCHODY add constraint przychodyFK2 foreign key(id_filmu) references film(id);
ALTER TABLE PRZYCHODY add constraint przychodyFK3 foreign key(id_firmy) references companies(id);

/* SEKWENCJE */
CREATE SEQUENCE dept_seq START WITH 1;
CREATE SEQUENCE dept_seq2 START WITH 1;
CREATE SEQUENCE dept_seq3 START WITH 1;
CREATE SEQUENCE dept_seq4 START WITH 1;
CREATE SEQUENCE dept_seq5 START WITH 1;

/* TRIGGERY GENERUJACE*/


CREATE OR REPLACE TRIGGER INCREMENT_umowy_ID
BEFORE INSERT ON umowy
FOR EACH ROW

BEGIN
  SELECT dept_seq.NEXTVAL
  INTO   :new.id_umowy
  FROM   dual;
END;
/

CREATE OR REPLACE TRIGGER INCREMENT_przychody_ID
BEFORE INSERT ON przychody
FOR EACH ROW

BEGIN
  SELECT dept_seq4.NEXTVAL
  INTO   :new.id_przychodu
  FROM   dual;
END;
/

CREATE OR REPLACE TRIGGER INCREMENT_film_ID
BEFORE INSERT ON film
FOR EACH ROW

BEGIN
  SELECT dept_seq2.NEXTVAL
  INTO   :new.id
  FROM   dual;
END;
/

CREATE OR REPLACE TRIGGER INCREMENT_firmy_zew_ID
BEFORE INSERT ON firmy_zew
FOR EACH ROW

BEGIN
  SELECT dept_seq3.NEXTVAL
  INTO   :new.id_zew_firmy
  FROM   dual;
END;
/

create or replace TRIGGER INCREMENT_kina_ID
BEFORE INSERT ON kina
FOR EACH ROW

BEGIN
  SELECT dept_seq5.NEXTVAL
  INTO   :new.id
  FROM   dual;
END;
/

create or replace TRIGGER add_umowy_after_inert_person
AFTER INSERT
   ON person
   FOR EACH ROW
   
DECLARE
  year NUMBER(4);
	dates VARCHAR2(10);
	day NUMBER(5);
  kiedy_v date;
  v_id_firmy pls_integer;

BEGIN
    year := dbms_random.value(2013,2017);
    v_id_firmy := dbms_random.value(1,150);
		day := dbms_random.value(1,355);
		dates := to_char(year) || to_char(day,'999');
    kiedy_v := (to_date(dates,'yyyyddd'));
    
    if :new.stanowisko='Technik' then
    INSERT INTO UMOWY(id_osoby,kwota,czy_zrealizowano,kiedy,ID_FIRMY)
    VALUES(:new.id,100,'nie',kiedy_v,v_id_firmy);
    end if;
    
    if :new.stanowisko='Rezyser' then
    INSERT INTO UMOWY(id_osoby,kwota,czy_zrealizowano,kiedy,ID_FIRMY)
    VALUES(:new.id,4000,'nie',kiedy_v,v_id_firmy);
    end if;
    
    if :new.stanowisko='Aktor' then
    INSERT INTO UMOWY(id_osoby,kwota,czy_zrealizowano,kiedy,ID_FIRMY)
    VALUES(:new.id,800,'nie',kiedy_v,v_id_firmy);
    end if;
    
    
    if :new.stanowisko='Dzwiekowiec' then
    INSERT INTO UMOWY(id_osoby,kwota,czy_zrealizowano,kiedy,ID_FIRMY)
    VALUES(:new.id,300,'nie',kiedy_v,v_id_firmy);
    end if;
    
    if :new.stanowisko='Oswietleniowiec' then
    INSERT INTO UMOWY(id_osoby,kwota,czy_zrealizowano,kiedy,ID_FIRMY)
    VALUES(:new.id,250,'nie',kiedy_v,v_id_firmy);
    end if;
    
    if :new.stanowisko='Montazysta' then
    INSERT INTO UMOWY(id_osoby,kwota,czy_zrealizowano,kiedy,ID_FIRMY)
    VALUES(:new.id,300,'nie',kiedy_v,v_id_firmy);
    end if;
    
    if :new.stanowisko='Operator' then
    INSERT INTO UMOWY(id_osoby,kwota,czy_zrealizowano,kiedy,ID_FIRMY)
    VALUES(:new.id,400,'nie',kiedy_v,v_id_firmy);
    end if;
    
    if :new.stanowisko='Prezes' then
    INSERT INTO UMOWY(id_osoby,kwota,czy_zrealizowano,kiedy,ID_FIRMY)
    VALUES(:new.id,3000,'nie',kiedy_v,v_id_firmy);
    end if;

END;
/


create or replace TRIGGER add_filmy_after_inert_person
AFTER INSERT
   ON person
   FOR EACH ROW
   
DECLARE
  year NUMBER(4);
  
  TYPE TABSTR IS TABLE OF VARCHAR2(250);
	tytul TABSTR;
  v_tytul varchar2(20);
  qtytul number;
  
  TYPE TABSTR2 IS TABLE OF VARCHAR2(250);
	gatunek TABSTR2;
  v_gatunek varchar2(20);
  qgatunek number;
	

BEGIN
    tytul :=TABSTR('Szybcy i Wsciekli','Szybcy i Wsciekli 2','Szybcy i Wsciekli 3','Szybcy i Wsciekli 4','Szybcy i Wsciekli 5','Szybcy i Wsciekli 6',
    'Szybcy i Wsciekli 7','Szybcy i Wsciekli 8','Harry Potter','The Big Lebowski','12 Angry Men','Memento','Risk','Kubo','Bogowie','Donnie Darko','Leon',
    'Filth','127 Godzin','Forrest Gump','Inception','Clockwork Orange','Fight Club','2001 Space Odyssey','The Green Mile');
    qtytul := tytul.count;
    v_tytul := tytul(round(dbms_random.value(1,qtytul)));
    
    gatunek :=TABSTR2('Komedia','Dramat','Akcja','Psychologiczny','Triller','Animacja','Obyczajowy','Romans');
    qgatunek := gatunek.count;
    v_gatunek := gatunek(round(dbms_random.value(1,qgatunek)));
    
    year := dbms_random.value(1955,2015);
    
    if :new.stanowisko='Rezyser' then
    INSERT INTO film(rezyser,id_rezysera,tytul,gatunek,rok)
    VALUES(:new.imie || ' '|| :new.nazwisko, :new.id,v_tytul,v_gatunek,year);
    end if;
    

END;
/

create or replace TRIGGER add_firmy_zew_insert_person
AFTER INSERT
   ON person
   FOR EACH ROW
  
DECLARE
  
  TYPE TABSTR IS TABLE OF VARCHAR2(250);
	lokalizacja TABSTR;
  lokalizacja_w varchar2(20);
  qlokalizacja number;
  
  

BEGIN
    lokalizacja := TABSTR('Warszawa','Wroclaw','Bialystok','Nowy York','Chicago','Boston','Nowy Orlean','Las Vegas','Los Angeles','San Diego','San Francisco',
    'Lomza','Miami','San Antonio','New Jersey','Smallville','BigCity','San Andreas','Vice City'); 
    qlokalizacja := lokalizacja.count;
  
    lokalizacja_w := lokalizacja(round(dbms_random.value(1,qlokalizacja)));
    
    if :new.stanowisko='Prezes' then
    INSERT INTO firmy_zew(lokalizacja,id_prezesa,prezes)
    VALUES(lokalizacja_w,:new.id,:new.imie ||' '|| :new.nazwisko);
    end if;
    

END;
/

create or replace TRIGGER add_bilans_after_insert_comp
AFTER INSERT or update
   ON companies
   FOR EACH ROW

BEGIN

INSERT INTO BILANS(id_firmy,nazwa_firmy,kwota_przychodow,kwota_wydatkow,bilans)
      VALUES (:new.id,:new.name,0,0,0);

END;
/

create or replace TRIGGER zrealizowanie_umowy
AFTER UPDATE OF czy_zrealizowano
   ON UMOWY
   FOR EACH ROW

BEGIN
    if:new.czy_zrealizowano='tak' then
    update bilans
    set kwota_wydatkow = kwota_wydatkow + :new.kwota
    where id_firmy = :new.id_firmy;
    end if;
    
END;
/

create or replace TRIGGER przychody_dla_firmy
AFTER INSERT 
   ON przychody
   FOR EACH ROW

BEGIN
    
    update bilans
    set KWOTA_PRZYCHODOW = KWOTA_PRZYCHODOW + :new.kwota
    where id_firmy = :new.id_firmy;
   
    
END;
/



create or replace TRIGGER oblicz_bilnas
AFTER UPDATE OF kwota_wydatkow
   ON bilans

BEGIN
    update bilans
    set bilans = KWOTA_PRZYCHODOW - KWOTA_WYDATKOW;
   
   
END;
/

create or replace TRIGGER oblicz_bilnas2
AFTER UPDATE OF kwota_przychodow
   ON bilans

BEGIN
    update bilans
    set bilans = KWOTA_PRZYCHODOW - KWOTA_WYDATKOW;
    
   
END;
/


create or replace TRIGGER wstaw_przychody
AFTER INSERT ON film
FOR EACH ROW

DECLARE
  year NUMBER(4);
	dates VARCHAR2(10);
  startday NUMBER(5);
  
  kiedy_v date;
  iden_kina pls_integer;
  ile pls_integer;
  iden_firmy pls_integer;

BEGIN
    iden_kina := dbms_random.value(1,10);
    ile := dbms_random.value(3000,4000);
    iden_firmy := dbms_random.value(1,150);
    
    year := :new.rok;
    startday := dbms_random.value(1,355);
    dates := to_char(year) || to_char(startday,'999');
    kiedy_v := (to_date(dates,'yyyyddd'));
    
    
    INSERT INTO przychody(id_firmy,tytul,id_filmu,id_kina,kiedy,kwota)
    VALUES(iden_firmy,:new.tytul,:new.id,iden_kina,kiedy_v,ile);
   
END;
/
/* PROCEDURY */
create or replace PROCEDURE  wstaw_do_companies
IS
	TYPE TABSTR IS TABLE OF VARCHAR2(250);
	name TABSTR;
	qname NUMBER(5);
	year NUMBER(4);
	dates VARCHAR2(10);
	startday NUMBER(5);
BEGIN
	name := TABSTR ('UGI', 'AES', 'Telephone & Data Systems', 'Paccar', 'Philip Morris International', 'Avon Products', 'Parker Hannifin', 'Freeport-McMoRan Copper & Gold', 'Great Atlantic & Pacific Tea', 'General Motors', 'Staples', 'UnitedHealth Group', 'MetLife', 'National Oilwell Varco', 'NCR', 'Safeway', 'KBR', 'TravelCenters of America', 'Tesoro', 'Goodyear Tire & Rubber', 'Bemis', 'Time Warner Cable', 'HCA Holdings', 'J.M. Smucker', 'Owens & Minor', 'Owens-Illinois', 'Qwest Communications', 
	'Automatic Data Processing', 'Calpine', 'PNC Financial Services Group', 'J.P. Morgan Chase & Co.', 'NextEra Energy', 'Delta Air Lines', 'Avnet', 'First Data', 'Western Union', 'Chesapeake Energy', 'Best Buy', 'PG&E Corp.', 'Sonic Automotive', 'Qualcomm', 'International Business Machines', 'Universal Health Services', 'Ameren', 'General Electric', 'Texas Instruments', 'NII Holdings', 'Merck', 'Travelers Cos.', 'Community Health Systems', 'Entergy', 'WellPoint', 'Phillips-Van Heusen', 'Whole Foods Market', 'Autoliv', 'Thermo Fisher Scientific', 'Avery Dennison', 'Dr Pepper Snapple Group', 'Plains All American Pipeline', 'Aramark', 'Universal American', 'Virgin Media', 'Loews', 'Union Pacific', 'McGraw-Hill', 'Dover', 'Amazon.com', 'Reinsurance Group of America', 'Mattel', 'ITT', 'Comcast', 'Nike', 'General Cable', 'Enterprise Products Partners', 'Office Depot', 'Dollar General', 'Apple', 
	'Expeditors International of Washington', 'Micron Technology', 'Bank of New York Mellon Corp.', 'Alcoa', 'Applied Materials', 'BB&T Corp.', 'Williams', 'Aflac', 'Procter & Gamble', 'Harris', 'Citigroup', 'CB Richard Ellis Group', 'New York Life Insurance', 'EMC', 'Gannett', 'PPL', 'Tech Data', 'Verizon Communications', 'Costco Wholesale', 'Jabil Circuit', 'Broadcom', 'Home Depot', 'Starwood Hotels & Resorts', 'Cisco Systems', 'Progress Energy', 'Northrop Grumman', 'Corning', 'Unum Group', 'AutoZone', 'Icahn Enterprises', 'Dell', 'Prudential Financial', 'Kimberly-Clark', 'Public Service Enterprise Group', 'Henry Schein', 'Arrow Electronics', 'Host Hotels & Resorts', 'General Mills', 'Ryder System', 'Kellogg', 'Ashland', 'PetSmart', 'CenterPoint Energy', 'SAIC', 'OfficeMax', 'Mohawk Industries', 'Masco', 'Wal-Mart Stores', 'Express Scripts', 'Stryker', 'Xcel Energy', 'BJ''s Wholesale Club', 
	'FirstEnergy', 'Supervalu', 'Ball', 'Newmont Mining', 'Pitney Bowes', 'Eaton', 'Apollo Group', 'St. Jude Medical', 'Oneok', 'Nucor', 'Cameron International', 'Amgen', 'SPX', 'United Services Automobile Assn.', 'INTL FCStone', 'Regions Financial', 'Avaya', 'Southwest Airlines', 'State Farm Insurance Cos.', 'Omnicare', 'KeyCorp');
	qname := name.count;

	FOR i IN 1..qname LOOP
		year := dbms_random.value(1985,2012);
		startday := dbms_random.value(1,355);
		dates := to_char(year) || to_char(startday,'999');
		INSERT INTO companies VALUES (i, name(i), to_date(dates,'yyyyddd'));
	END LOOP;
	DBMS_OUTPUT.put_line('All companies added.');
END;
/

create or replace PROCEDURE WSTAW_DO_KIN 
IS

  TYPE TABSTR IS TABLE OF VARCHAR2(250);
    nazwa TABSTR;
    qnazwa NUMBER(5);
  
   TYPE TABSTR2 IS TABLE OF VARCHAR2(250);
    lokalizacja TABSTR2;
    qlokalizacja NUMBER(5);
  
    nazwa_w STRING (20);
    lokalizacja_w STRING (20);
BEGIN  
  nazwa := TABSTR('Praha','Centurion','Forum','ZaEkranem','5 po piatej','Syrena','Pokoj','Helios','CinemaCity','Multikino','Ton',
  'Riot','Iluzjon','Taras','Cheaper','Greater','GoldenScreen','BlueCity','GoldenGobles','All for All','Brok','Brzmien','Pod Baranami','Pod Gwiazdami',
  'Ponad Podzialami','Brak','Brzmienie','Trust','Chrust','BezNas','Z Nami','Zaczarowany Olowek','Tanie Kino');
  qnazwa := nazwa.count;
  
  lokalizacja := TABSTR2('Warszawa','Wroclaw','Bialystok','Nowy York','Chicago','Boston','Nowy Orlean','Las Vegas','Los Angeles','San Diego','San Francisco',
  'Lomza','Miami','San Antonio','New Jersey','Smallville','BigCity','San Andreas','Vice City');
  qlokalizacja := lokalizacja.count;
  
  FOR i IN 1..10 LOOP
    nazwa_w := nazwa(round(dbms_random.value(1,qnazwa)));
    lokalizacja_w := lokalizacja(round(dbms_random.value(1,qlokalizacja)));
   INSERT INTO kina 
        (id, 
        nazwa, 
        lokalizacja)
        
        VALUES 
        (i, 
        nazwa_w,
        lokalizacja_w);
  END LOOP;
  
  DBMS_OUTPUT.put_line('All cinemas added.');
END;
/

create or replace PROCEDURE wstaw_do_person
IS
	TYPE TABSTR IS TABLE OF VARCHAR2(500);
	imie TABSTR;
    TYPE TABSTR2 IS TABLE OF VARCHAR2(500);
	nazwisko TABSTR2;
    TYPE TABSTR3 IS TABLE OF VARCHAR2(500);
	stanowisko TABSTR3;
  
	tel_number NUMBER(9);
    qname NUMBER(5);
    qsurname NUMBER(5);
    qstanowisko NUMBER(5);
    imie_w STRING (20);
    nazw_w STRING (20);
    stanowisko_w STRING(20);
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
  
    stanowisko := TABSTR3 ('Aktor','Rezyser','Prezes','Dzwiekowiec','Oswietleniowiec','Montazysta','Operator','Technik');
    qstanowisko := stanowisko.count;

	FOR i IN 1..30 LOOP
		tel_number := dbms_random.value(600000000,899999999);
		imie_w := imie(round(dbms_random.value(1,qname)));
        nazw_w := nazwisko(round(dbms_random.value(1,qsurname)));
        stanowisko_w := stanowisko(round(dbms_random.value(1,qstanowisko)));
        INSERT INTO PERSON 
        (id, 
        telefon, 
        imie,
        nazwisko,
        stanowisko)
        
        VALUES 
        (i, 
        tel_number, 
        imie_w,
        nazw_w,
        stanowisko_w);
	END LOOP;
  DBMS_OUTPUT.put_line('All persons added.');
END;
/





/*1. WSTAW DO KIN*/
/*2. WSTAW DO COMPANIES*/
/*3. WSTAW DO OSOBY*/



/* Ukazanie zmiany bilansu */
update umowy
set czy_zrealizowano='tak'
where id_umowy=615;

/*dodanie rezysera -> dodaje film -> dodaje przychod -> zmiania bilans firmy*/
INSERT INTO PERSON (id, telefon, imie, nazwisko, stanowisko) VALUES (31, 584930587, 'Maciej','Suchocki','Rezyser');

/* dodanie przychodu - dostosowac w zaleznosci od wygenerowanych filmow i kin*/
INSERT INTO przychody(id_przychodu,id_firmy,tytul,id_filmu,id_kina,kiedy,kwota)
      values (14,48,'Bogowie',141,3,to_date('1973/07/20'),3040);
      
SELECT nazwa from kina where lokalizacja='Las Vegas';
SELECT name,start_date from companies where START_DATE>'08/12/06';
SELECT nazwa_firmy,bilans from bilans where bilans>0;

SELECT bilans,COUNT(*) FROM bilans group by bilans;
SELECT lokalizacja,COUNT(*) from kina group by lokalizacja;

/*Nie prezesi i prezesi */
SELECT imie, nazwisko,stanowisko from person where id not in( select id_prezesa from firmy_zew);


SELECT lokalizacja,COUNT(*) from kina group by lokalizacja having count(*)>=2;
SELECT stanowisko, COUNT(*) from person group by stanowisko having stanowisko like 'O%';

SELECT SUM(kwota) as suma_przychodow,nazwa  from przychody join kina on kina.id=przychody.id_kina group by nazwa order by suma_przychodow DESC;
SELECT id_firmy,companies.NAME,AVG(kwota) as srednia_zarobkow from przychody,companies where id_firmy=companies.ID group by id_firmy,companies.NAME;














