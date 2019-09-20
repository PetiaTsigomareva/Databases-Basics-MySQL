CREATE database instagraph_db;
USE instagraph_db;
/*Setion1*/
/*Task01*/
CREATE TABLE pictures (
  id   INT PRIMARY KEY AUTO_INCREMENT,
  path VARCHAR(255)   NOT NULL,
  size DECIMAL(10, 2) NOT NULL
);

CREATE TABLE users (
  id                 INT PRIMARY KEY AUTO_INCREMENT,
  username           VARCHAR(30) NOT NULL UNIQUE,
  password           VARCHAR(30) NOT NULL,
  profile_picture_id INT
);

CREATE TABLE posts (
  id         INT PRIMARY KEY AUTO_INCREMENT,
  caption    VARCHAR(255) NOT NULL UNIQUE,
  user_id    INT          NOT NULL,
  picture_id INT          NOT NULL
);

CREATE TABLE comments (
  id      INT PRIMARY KEY AUTO_INCREMENT,
  content VARCHAR(255) NOT NULL UNIQUE,
  user_id INT          NOT NULL,
  post_id INT          NOT NULL
);

CREATE TABLE users_followers (
  user_id     INT,
  follower_id INT
);
ALTER TABLE users
  ADD CONSTRAINT fk_users_pictures
FOREIGN KEY users(profile_picture_id)
REFERENCES pictures (id);

ALTER TABLE posts
  ADD CONSTRAINT fk_posts_users
FOREIGN KEY posts(user_id)
REFERENCES users (id);

ALTER TABLE posts
  ADD CONSTRAINT fk_posts_pictures
FOREIGN KEY posts(picture_id)
REFERENCES pictures (id);


ALTER TABLE comments
  ADD CONSTRAINT fk_comments_users
FOREIGN KEY comments(user_id)
REFERENCES users (id);

ALTER TABLE comments
  ADD CONSTRAINT fk_comments_posts
FOREIGN KEY comments(post_id)
REFERENCES posts (id);

ALTER TABLE users_followers
  ADD CONSTRAINT fk_users_users
FOREIGN KEY users_followers(user_id)
REFERENCES users (id);

ALTER TABLE users_followers
  ADD CONSTRAINT fk_users_followers
FOREIGN KEY users_followers(follower_id)
REFERENCES users (id);

/*Section3*/
/*Task05*/
SELECT id, username
FROM users
ORDER BY id ASC;

/*Task06*/
SELECT uf.user_id, u.username
FROM users_followers uf
       JOIN users u ON uf.user_id = u.id
WHERE uf.user_id = uf.follower_id
ORDER BY uf.user_id;

/*Task07*/
SELECT *
FROM pictures
WHERE size > 50000
  AND (path LIKE '%jpeg%' OR path like '%png%')
ORDER BY size DESC;

/*Task08*/

SELECT c.id, CONCAT(u.username, ' : ', c.content)AS full_comment
FROM users u
       JOIN comments c ON u.id = c.user_id
ORDER BY c.id DESC;

/**Task09*/
SELECT distinct u.id, u.username, CONCAT(p.size, 'KB') AS 'size'
FROM users AS u
       INNER JOIN pictures AS p on u.profile_picture_id = p.id
       inner join users u2 on u.profile_picture_id = u2.profile_picture_id
                                and u.id <> u2.id

ORDER BY u.id;
/*Task092*/
SELECT u.id, u.username, CONCAT(p.size, 'KB') AS 'size'
FROM users AS u
       INNER JOIN pictures AS p on u.profile_picture_id = p.id
where exists(
        select 1 from users u2 where u2.profile_picture_id = u.profile_picture_id
                                 and u2.id <> u.id
          )
ORDER BY u.id;

/*Task10 TODO*/
/*Task11*/
SELECT u.id, u.username, up.user_posts AS 'posts', uf.user_followers AS 'followers'
FROM users AS u,
     (select user_id, count(*) as user_followers from users_followers group by user_id) uf,
     (select user_id, count(*) as user_posts from posts group by user_id) up
where u.id = uf.user_id
  and u.id = up.user_id
GROUP BY u.id, u.username
order by 4 desc
limit 1;

/*Task12*/
SELECT u.id, u.username, COUNT(c.id)AS my_comments
FROM users u
       left outer join posts p ON u.id = p.user_id
       left outer join comments c ON p.id = c.post_id and c.user_id = u.id
GROUP BY u.id
ORDER BY my_comments DESC, u.id ASC;

/*Task13*/
SELECT u.id,
       u.username,
       (select p.caption
        from posts p
               left JOIN comments c ON p.id = c.post_id
        where p.user_id = u.id
        group by p.id
        order by count(*) desc, p.id asc
        limit 1) as post
FROM users u
where exists(select 1 from posts pp where pp.user_id = u.id)
ORDER BY u.id;
/*Task14*/
SELECT p.id, p.caption, COUNT(DISTINCT c.user_id)AS users
FROM posts p
       left join comments c On p.id = c.post_id
group by p.id
ORDER BY users desc, p.id asc;

/*Section4*/
/*Task15*/
DROP procedure udp_commit;

DELIMITER //

CREATE PROCEDURE udp_commit(username VARCHAR(30), password VARCHAR(30), caption VARCHAR(255), path VARCHAR(255))
  BEGIN
    DECLARE user_id INT;
    DECLARE picture_id INT;
    -- DECLARE picture_profile_id INT;

    IF (((SELECT COUNT(*) FROM users u WHERE u.username = password)) = 0)
    THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Password is incorrect!';
    END IF;


    IF ((SELECT COUNT(*) FROM pictures p WHERE p.path = path) = 0)
    THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'The picture does not exist!';
    END IF;

    SET user_id := (SELECT u.id FROM users u WHERE u.username = username);
    -- SET picture_profile_id := (SELECT u.profile_picture_id FROM users u WHERE u.username =username);
    -- SET picture_id := (SELECT p.id FROM pictures p WHERE p.id= picture_profile_id);
    SET picture_id := (SELECT p.id FROM pictures p WHERE p.path = path);

    INSERT INTO posts (caption, user_id, picture_id) VALUES (caption, user_id, picture_id);
  END

//
DELIMITER ;
CALL udp_commit('Petia', '4D52Hfgb', 'Test procedure', 'src/folders/resourses/images/story/img/fdgdgdsg.img');

CALL udp_commit('UnderSinduxrein', '4l8nYGTKMW', 'Test procedure',
                'src/folders/resourses/images/story/img/fdgdgdsg.img');

CALL udp_commit('UnderSinduxrein', '4l8nYGTKMW', '#new #procedure wer',
                'src/folders/resources/images/story/reformatted/img/hRI3TW31rC.img');

/*Task16*/
CREATE PROCEDURE udp_filter(hashtag VARCHAR(10))
  BEGIN
    SELECT p.id, p.caption, u.username
    FROM posts p
           JOIN users u ON p.user_id = u.id
    WHERE caption LIKE CONCAT('%#', hashtag, '%')
    ORDER BY id;
  END;

CALL udp_filter('cool');

/*Section2*/
/*Task02*/
INSERT INTO comments (content, user_id, post_id)
SELECT CONCAT('Omg!',
              (SELECT u.username FROM users u WHERE p.user_id = u.id),
              '!This is so cool!')AS content, CEIL(p.id * 3 / 2) AS user_id, p.id AS post_id
FROM posts p
WHERE id between 1 AND 10;

SELECT *
FROM comments;
/*Task03*/

UPDATE users u
set profile_picture_id = (SELECT case
                                   WHEN COUNT(uf.user_id) = 0
                                           THEN u.id
                                   ELSE COUNT(uf.user_id)
                                     END
                          from users_followers uf where u.id = uf.user_id)

WHERE profile_picture_id is NULL;

/*Task04*/
delete u
  from users u
  left join users_followers x1 on u.id = x1.user_id
  left join users_followers x2 on u.id = x2.follower_id
 where x1.user_id is null
   and x2.follower_id is null
;