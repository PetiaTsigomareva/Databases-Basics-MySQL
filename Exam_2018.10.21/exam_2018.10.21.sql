DROP database  colonial_journey_management_system_db;
/*Section1*/
CREATE database colonial_journey_management_system_db;
USE colonial_journey_management_system_db;

CREATE table planets(
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(30) NOT NULL
);

CREATE TABLE spaceports(
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL ,
  planet_id INT
);

CREATE TABLE spaceships(
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL ,
  manufacturer VARCHAR(30) NOT NULL ,
  light_speed_rate INT  DEFAULT 0

);

CREATE TABLE colonists(
  id INT PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(20) NOT NULL ,
  last_name VARCHAR(20) NOT NULL ,
  ucn CHAR(10) UNIQUE NOT NULL ,
  birth_date DATE NOT NULL
);

CREATE TABLE journeys(
  id INT PRIMARY KEY AUTO_INCREMENT,
  journey_start DATETIME NOT NULL ,
  journey_end DATETIME NOT NULL ,
  purpose  ENUM('Medical','Technical','Educational','Military') ,
  destination_spaceport_id INT,
  spaceship_id INT
);

CREATE TABLE travel_cards(
  id INT PRIMARY KEY AUTO_INCREMENT,
  card_number CHAR(10) UNIQUE NOT NULL ,
  job_during_journey ENUM('Pilot','Engineer','Trooper','Cleaner','Cook'),
  colonist_id INT,
  journey_id INT
);

ALTER TABLE spaceports
ADD CONSTRAINT fk_spaceports_planets
FOREIGN KEY spaceports(planet_id)
REFERENCES planets (id);

ALTER TABLE journeys
ADD CONSTRAINT fk_journeys_spaceports
FOREIGN KEY journeys(destination_spaceport_id)
references spaceports(id);

ALTER TABLE journeys
ADD CONSTRAINT fk_journeys_spaceship
FOREIGN KEY journeys(spaceship_id)
references spaceships(id);


ALTER TABLE travel_cards
ADD CONSTRAINT fk_travel_cards_colonists
FOREIGN KEY travel_cards(colonist_id)
REFERENCES colonists(id);


ALTER TABLE travel_cards
ADD CONSTRAINT fk_travel_cards_journeys
FOREIGN KEY travel_cards(journey_id)
REFERENCES journeys(id);

/*Section3 Querying*/
/*Task 04*/
SELECT card_number,job_during_journey
FROM travel_cards
ORDER BY card_number ASC ;

/*Task05*/
SELECT id,CONCAT(first_name,' ',last_name) AS full_name,ucn
FROM colonists
ORDER BY first_name,last_name,id ASC ;

/*Task06*/
SELECT id, journey_start,journey_end
FROM journeys
WHERE purpose like 'Military'
ORDER BY journey_start ASC ;

/*Task07*/
SELECT c.id, CONCAT(c.first_name,' ',c.last_name) AS full_name
FROM colonists c
JOIN travel_cards tc
ON c.id=tc.colonist_id
WHERE tc.job_during_journey='Pilot'
order by c.id ASC ;

/* Task07 */
select id, concat(first_name, ' ', last_name ) as full_name
  from colonists c
 where exists( select 1
                 from travel_cards tc
                where c.id = tc.colonist_id
                  and        tc.job_during_journey = 'Pilot'
              )
 order by id asc;

/*Task08*/
SELECT COUNT(tc.colonist_id) As count
FROM journeys j
join travel_cards tc
ON j.id=tc.journey_id
WHERE j.purpose='Technical';

/* Task08 */
select count(*) as count
  from colonists c
 where exists( select 1
                 from travel_cards tc
                where c.id = tc.colonist_id
                  and        tc.job_during_journey = 'Engineer'
              );


/*Task09*/
select ss.name as spaceship_name,
       (select sp.name
          from spaceports sp
          join journeys j on sp.id = j.destination_spaceport_id
         where j.spaceship_id = ss.id) as spaceport_name
  from spaceships ss
order by ss.light_speed_rate desc
limit 1;

/* Task10 */
select ss.name, ss.manufacturer
  from spaceships ss
  join journeys j on ss.id = j.spaceship_id
  join travel_cards tc on j.id = tc.journey_id
  join colonists c on tc.colonist_id = c.id
 where tc.job_during_journey = 'Pilot'
   and c.birth_date >= date_sub(STR_TO_DATE('01/01/2019', '%m/%d/%Y'), interval 30 year)
 order by ss.name asc;

/* Task11 */
select p.name as planet_name, s.name as spaceport_name
  from planets p
  join spaceports s on p.id = s.planet_id
  join journeys j on s.id = j.destination_spaceport_id
 where j.purpose = 'Educational'
 order by s.name desc;

/* Task12 */
select p.name as planet_name, count(*) as journeys_count
  from planets p
  join spaceports s on p.id = s.planet_id
  join journeys j on s.id = j.destination_spaceport_id
 group by p.name
 order by journeys_count desc, planet_name asc;

/* Task13 */
select j.id, p.name as planet_name, s.name as spaceport_name, j.purpose as journey_purpose
  from planets p
  join spaceports s on p.id = s.planet_id
  join journeys j on s.id = j.destination_spaceport_id
 order by DATEDIFF(j.journey_end, j.journey_start) asc
limit 1;

/* Task14 */
select ( select tc.job_during_journey
           from travel_cards tc
          where longest_journey.id = tc.journey_id
          group by tc.job_during_journey
          order by count(*) asc
          limit 1
          ) as job_name
  from ( select *
           from journeys j
          order by DATEDIFF(j.journey_end, j.journey_start) desc
          limit 1
        ) longest_journey;


/*Section2*/
/*Task01*/
insert into travel_cards (card_number, job_during_journey, colonist_id, journey_id)
  select CASE
           WHEN c.birth_date >= STR_TO_DATE('01/01/1980', '%m/%d/%Y')
             THEN concat(year(c.birth_date), day(c.birth_date), SUBSTRING(c.ucn FROM 1 FOR 4))
           ELSE concat(year(c.birth_date), month(c.birth_date), SUBSTRING(c.ucn FROM -4 FOR 4))
         END as card_numer,
         CASE
           WHEN c.id mod 2 = 0 THEN 'Pilot'
           WHEN c.id mod 3 = 0 THEN 'Cook'
           ELSE 'Engineer'
         END as job_during_journey,
         c.id as colonist_id,
         substr(c.ucn from 1 for 1) as journey_id
    from colonists c
   where c.id >= 96
     and c.id <= 100;

/* Task02 */
update journeys j
   set j.purpose = CASE
                     WHEN j.id mod 2 = 0 THEN 'Medical'
                     WHEN j.id mod 3 = 0 THEN 'Technical'
                     WHEN j.id mod 5 = 0 THEN 'Educational'
                     WHEN j.id mod 7 = 0 THEN 'Military'
                     ELSE j.purpose
                   END;

/* Task03 */
delete c
  from colonists c
  left join travel_cards tc on c.id = tc.colonist_id
  left join journeys j on tc.journey_id = j.id
 where j.id is null;


/*Section4*/
/* Task15 */
drop procedure udf_count_colonists_by_destination_planet;
delimiter /

create function udf_count_colonists_by_destination_planet (planet_name VARCHAR (30))
  RETURNS int
  begin
    declare result int;

   SET result:=( select count(*)
      from planets p
      join spaceports s on p.id = s.planet_id
      join journeys j on s.id = j.destination_spaceport_id
      join travel_cards tc on j.id = tc.journey_id
      join colonists c on tc.colonist_id = c.id
     where p.name = planet_name);

    return result;
  end
/
delimiter ;

SELECT p.name, udf_count_colonists_by_destination_planet('Otroyphus') AS count
  FROM planets AS p
 WHERE p.name = 'Otroyphus';

/* Task16 */
drop procedure udp_modify_spaceship_light_speed_rate;

delimiter /

create procedure udp_modify_spaceship_light_speed_rate(spaceship_name VARCHAR(50), light_speed_rate_increse INT(11))
  begin
    IF((SELECT COUNT(*) from spaceships WHERE name = spaceship_name))<>1
      THEN
        SIGNAL SQLSTATE '45000'
          SET MESSAGE_TEXT ='Spaceship you are trying to modify does not exists.';
    END IF;

    update spaceships
       set light_speed_rate = light_speed_rate + light_speed_rate_increse
     where name = spaceship_name;
  end
/

delimiter ;

CALL udp_modify_spaceship_light_speed_rate ('Na Pesho koraba', 1914);

SELECT name, light_speed_rate FROM spaceships WHERE name = 'Na Pesho koraba';

CALL udp_modify_spaceship_light_speed_rate ('USS Templar', 5);

SELECT name, light_speed_rate FROM spaceships WHERE name = 'USS Templar';








