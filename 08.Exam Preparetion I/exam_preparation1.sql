/*Section1 -Task01*/
USE buhtig;
CREATE TABLE users(
  id INT PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(30) NOT NULL UNIQUE ,
  password VARCHAR(30) NOT NULL ,
  email VARCHAR(50) NOT NULL
);

CREATE TABLE repositories(
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL

);

CREATE TABLE repositories_contributors(
  repository_id INT,
  contributor_id INT
);

CREATE TABLE issues(
  id INT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(255) NOT NULL ,
  issue_status VARCHAR(6)NOT NULL ,
  repository_id INT NOT NULL ,
  assignee_id INT NOT NULL
);

CREATE TABLE commits(
  id INT PRIMARY KEY AUTO_INCREMENT,
  message VARCHAR(255) NOT NULL ,
  issue_id INT,
  repository_id INT NOT NULL ,
  contributor_id INT NOT NULL
);
CREATE TABLE files(
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL ,
  size DECIMAL(10,2) NOT NULL ,
  parent_id INT ,
  commit_id INT NOT NULL
);
ALTER TABLE repositories_contributors
ADD CONSTRAINT fk_repositories_contributors_repositories
FOREIGN KEY repositories_contributors(repository_id)
REFERENCES repositories(id);

ALTER TABLE repositories_contributors
ADD CONSTRAINT fk_repositories_contributors_users
FOREIGN KEY repositories_contributors(contributor_id)
REFERENCES users(id);

ALTER TABLE issues
ADD CONSTRAINT fk_issues_repositories
FOREIGN KEY issues(repository_id)
REFERENCES repositories(id);

ALTER TABLE issues
ADD CONSTRAINT fk_issues_users
FOREIGN KEY issues(assignee_id)
REFERENCES users(id);

ALTER TABLE commits
ADD CONSTRAINT fk_commits_issues
FOREIGN KEY commits(issue_id)
REFERENCES issues(id);

ALTER TABLE commits
ADD CONSTRAINT fk_commits_repositories
FOREIGN KEY commits(repository_id)
REFERENCES repositories(id);

ALTER TABLE commits
ADD CONSTRAINT fk_commits_users
FOREIGN KEY commits(contributor_id)
REFERENCES users(id);

ALTER TABLE files
ADD CONSTRAINT fk_files_commits
FOREIGN KEY files(commit_id)
REFERENCES commits(id);


ALTER TABLE files
ADD CONSTRAINT fk_files_files
FOREIGN KEY files(parent_id)
REFERENCES files(id);

/*Section3*/
/*Task05*/
SELECT id, username
FROM users
ORDER BY id asc ;
/*Task06*/
SELECT *
FROM repositories_contributors
WHERE contributor_id=repository_id
ORDER BY repository_id ASC ;

/*Task07*/
SELECT id, name,size
from files
WHERE size>1000 AND name LIKE '%html%'
ORDER BY size DESC ;

/*Task08*/
SELECT i.id, CONCAT(u.username,' : ',i.title)
FROM users u
INNER JOIN issues i
ON u.id=i.assignee_id
ORDER BY i.id DESC ;

/*Task09*/

SELECT d.id,d.name,CONCAT(d.size,'KB') as size
FROM files f
RIGHT JOIN files d
ON f.parent_id=d.id
WHERE f.id IS NULL
ORDER BY d.id;

/*Task10*/
SELECT i.repository_id,r.name,COUNT(i.id) as issues
FROM repositories r
INNER JOIN issues i
ON r.id = i.repository_id
GROUP BY i.repository_id
ORDER BY issues DESC,r.id ASC
LIMIT 5;

/*Task11*/
SELECT r.id,
       r.name,(SELECT COUNT(*)
                FROM commits
                WHERE commits.repository_id=r.id) as commits,
      COUNT(u.id) as contributors
FROM users u
JOIN repositories_contributors rc
ON u.id=rc.contributor_id
JOIN repositories r
ON r.id =rc.repository_id
GROUP BY r.id
ORDER BY contributors DESC,r.id ASC
LIMIT 1;

/*Task12*????????/
SELECT u.id,u.username,COUNT(c.id)as commits
FROM users u
INNER JOIN issues i
ON u.id=i.assignee_id
INNER JOIN commits c
ON i.id=c.issue_id
WHERE i.assignee_id =u.id AND c.contributor_id=u.id
GROUP BY u.id
ORDER BY commits DESC, u.id ASC ;


/*Task13*/
SELECT * from files;

SELECT LEFT(a.name,LOCATE('.', a.name)-1)as file ,
       (SELECT COUNT(*)
        FROM commits c
        WHERE c.message like CONCAT('%',a.name,'%') ) as recursive_count
FROM files a
JOIN files b
ON a.parent_id=b.id AND b.parent_id=a.id AND a.id!=b.id
GROUP BY a.id
ORDER BY a.name;

/*13*/

SELECT LEFT(a.name,LOCATE('.', a.name)-1)as file ,COUNT(c.id)  as recursive_count
FROM files a
JOIN files b
ON a.parent_id=b.id AND b.parent_id=a.id AND a.id!=b.id
LEFT JOIN commits c
ON c.message like CONCAT('%',a.name,'%')
GROUP BY a.id
ORDER BY a.name;

/*Task14*/
SELECT r.id,r.name,COUNT(DISTINCT c.contributor_id) as users
from commits c
RIGHT JOIN  repositories r
on c.repository_id=r.id
GROUP BY r.id
ORDER BY users DESC,r.id ASC ;
/*Section4*/
/*Task15*/
DROP procedure udp_commit;

DELIMITER //
CREATE PROCEDURE udp_commit(user VARCHAR(30),password VARCHAR(30),message VARCHAR(255),issue_id INT)
 BEGIN

    DECLARE user_id INT;
    DECLARE repository_id INT;
   IF((SELECT COUNT(*) from users WHERE users.username =user))<>1
     THEN
      SIGNAL SQLSTATE '45000'
       SET MESSAGE_TEXT ='No such user!';
   END IF;

  IF((SELECT  COUNT(*) FROM users WHERE users.username =user AND users.password=password ))<>1
    THEN
       SIGNAL SQLSTATE '45000'
       SET MESSAGE_TEXT ='Password is incorrect!';
  END IF ;

   IF ((SELECT  COUNT(*) from issues WHERE issues.id=issue_id))<>1
     THEN
       SIGNAL SQLSTATE '45000'
       SET MESSAGE_TEXT ='The issue does not exist!';
     END IF ;
   SET user_id := (SELECT u.id from users u WHERE u.username=user);
   SET repository_id:=(SELECT i.repository_id FROM issues i WHERE i.id=issue_id);


    INSERT into commits(repository_id, contributor_id,issue_id,message)
    VALUE (repository_id,user_id,issue_id,message);

   UPDATE issues
       SET issue_status='closed'
       WHERE issues.id=issue_id;

 END
  //
DELIMITER ;
CALL udp_commit('WhoDenoteBel','ajmISQi*','Fixed issue: Invalid welcomming message in Read.html5',4);
CALL udp_commit('Petia','ajmISQi*','Fixed issue: Invalid welcomming message in Read.html5',3);
CALL udp_commit('WhoDenoteBel','123','Fixed issue: Invalid welcomming message in Read.html5',100);
CALL udp_commit('WhoDenoteBel','ajmISQi*','Fixed issue: Invalid welcomming message in Read.html5',100);

/*Task16*/
DROP procedure udp_findbyextension;
DELIMITER //
CREATE PROCEDURE udp_findbyextension(extension varchar(100))
  BEGIN
    SELECT f.id,f.name AS caption,CONCAT(size,'KB')AS user
    FROM files f
    WHERE f.name like CONCAT('%.',extension)
    ORDER BY f.id ASC ;
  END
  //
CALL udp_findbyextension('html');
/*Section2*/
/*Task02*/


INSERT INTO issues(title, issue_status, repository_id, assignee_id)
        SELECT CONCAT('Critical Problem With ',f.name,'!')AS title,
       'open' AS issue_status,
       CEILING(f.id*2/3) AS repository_id,
       c.contributor_id AS assignee_id
       FROM files f
       JOIN commits c
     ON f.commit_id=c.id
WHERE f.id between 46 AND 50;
SELECT * from issues;

/*Task03*/
INSERT INTO repositories_contributors(contributor_id,repository_id)
SELECT *
From(SELECT contributor_id
       FROM repositories_contributors
        WHERE contributor_id=repository_id
     )as t1
CROSS JOIN (
      SELECT MIN(r.id) as repository_id
      FROM repositories r
      LEFT JOIN repositories_contributors rc
      ON r.id=rc.repository_id
      WHERE rc.repository_id IS NULL
           ) as t2
      WHERE t2.repository_id IS NOT NULL ;

/*Task04*/
DELETE FROM repositories
WHERE id NOT IN (SELECT repository_id from issues);
