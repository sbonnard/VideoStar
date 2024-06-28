-- 1. Créer les requêtes pour ajouter les vidéos suivantes à la base Videostar

-- Apocalypse à Yarrao VIII
INSERT INTO video (id_video, title, year_video, id_type)
VALUES ('APOCAL', 'Apocalypse à Yarrao VIII', 2021, 2);

INSERT INTO video_place (id_video, id_place)
VALUES ('APOCAL', 16), ('APOCAL', 8);

INSERT INTO video_star (id_video, id_star, role)
VALUES ('APOCAL', 17, 'Réalisateur');

-- Quiv, un monde englouti
INSERT INTO video (id_video, title, year_video, id_type)
VALUES ('QUIVUN', 'Quiv, un monde englouti', 2020, 5);

INSERT INTO video_place (id_video, id_place)
VALUES ('QUIVUN', 10);

INSERT INTO video_star (id_video, id_star, role)
VALUES ('QUIVUN', 8, 'Réalisateur');

-- Vie en orbite autour de Ryverne IV
INSERT INTO video (id_video, title, year_video, id_type)
VALUES ('VIEENO', 'Vie en orbite autour de Ryverne IV', 2022, 7);

INSERT INTO video_place (id_video, id_place)
VALUES ('VIEENO', 18), ('VIEENO', 20);

INSERT INTO video_star (id_video, id_star, role)
VALUES ('VIEENO', 9, 'Réalisateur'), ('VIEENO', 5, 'Compositeur');

-- 2. Créer les requêtes permettant de catégoriser les vidéos suivantes en changeant leur type.

UPDATE video
SET id_type = 9
WHERE title = "Lucky Numbers";

UPDATE video
SET id_type = 6
WHERE title = "Soldier in the Rain";

UPDATE video
SET id_type = 6
WHERE title = "Dead of Night";

UPDATE video
SET id_type = 4
WHERE title LIKE "%Rose Tattoo, The%";

-- 3. Afficher le titre des vidéos pour lesquelles il n'existe pas encore d'exemplaires

SELECT title
FROM video
    LEFT JOIN copy USING (id_video)
WHERE id_copy IS NULL;

-- 4. Afficher les vidéos de type New et traitant de la planète Zorbight IX.

SELECT title
FROM type
    JOIN video USING (id_type)
    JOIN video_place USING (id_video)
    JOIN place USING (id_place)
WHERE type_doc = 'New' AND place_name = 'Zorbight IX';

-- 5. Afin de créer l’email de relance aux adhérents, affichez la liste des exemplaires loués depuis plus de 7 jours avec le nom, le prénom, l’email de l’adhérent, le titre et le format de la vidéo.

SELECT id_copy, lastname, firstname, email, title, format
FROM format
    JOIN copy USING (id_format)
    JOIN video USING (id_video)
    JOIN rental USING (id_copy)
    JOIN members USING (id_member)
WHERE date_end IS NULL AND CURDATE() - date_start > 7;

-- 6. Afficher pour chaque vidéo le nombre d’exemplaires dans chacun des formats.

SELECT id_video, title, COUNT(id_copy) AS nb_copies, format
FROM video
    JOIN copy USING (id_video)
    JOIN format USING (id_format)
GROUP BY id_video, id_format
ORDER BY id_video, id_format;

-- 7. Afficher les 10 adhérents ayant le plus payé pour de la location de vidéo en 2023.

SELECT firstname, lastname, SUM(price_day * DATEDIFF(date_end, date_start)) AS total_cost
FROM members
    JOIN rental USING (id_member)
    JOIN copy USING (id_copy)
    JOIN format USING (id_format)
WHERE date_start LIKE "%2023%" and date_end LIKE "%2023%"
GROUP BY id_member
ORDER BY total_cost DESC LIMIT 10;

-- 8. Afficher le nom et le prénom des adhérents ayant loué plusieurs fois une même vidéo. Afficher également le titre des vidéos concernées.

SELECT lastname, firstname, title, COUNT(id_video) AS total_rents
FROM members
    JOIN rental USING (id_member)
    JOIN copy USING (id_copy)
    JOIN video USING (id_video)
GROUP BY id_member, id_video
HAVING total_rents > 1;

-- 9. Afficher les titres de toutes les vidéos pour lesquelles aucun exemplaire physique n'est actuellement disponible à la location.

SELECT title
FROM rental 
    LEFT JOIN copy USING (id_copy)
    LEFT JOIN video USING (id_video)
    JOIN format USING (id_format)
WHERE date_end IS NULL AND id_format != 3 AND state = "E" OR state = "P"
GROUP BY id_video
ORDER BY id_video;

-- 10.Catherine Raleigh vient rendre toutes ses vidéos en cours de location.

SELECT * 
FROM members 
WHERE firstname = "Catherine" and lastname = "Raleigh";

-- a. Afficher la somme due par Catherine Raleigh.

SELECT firstname, lastname, SUM(price_day * DATEDIFF(CURDATE(), date_start)) AS total_cost
FROM members
    JOIN rental USING (id_member)
    JOIN copy USING (id_copy)
    JOIN format USING (id_format)
WHERE firstname = "Catherine" and lastname = "Raleigh" AND date_end IS NULL;
GROUP BY id_member;

-- b. Créer les requêtes de mise à jour de la base de données correspondant aux retours des vidéos de Catherine Raleigh. (On considère que tous les exemplaires sont rendus en bon état.)

-- Updating date_end
UPDATE rental 
SET date_end = CURDATE()
WHERE id_member = 68;

--Updating state of copies given back
UPDATE copy
SET state = 'L'
WHERE id_copy = 'MEMORI01' 
OR id_copy = 'LOOKIN03' 
OR id_copy = 'ONEHUS01'
OR id_copy = 'GREATW01';


-- c. Catherine Raleigh emprunte la vidéo “Freezer” au format Blu-Ray. Créer les requêtes de mise à jour de la base de données correspondant à cette nouvelle location.

-- Finding the Clu-Ray Copy of “Freezer”
SELECT * 
FROM copy
WHERE id_copy LIKE "FREEZE%" AND id_format = 1;

-- Updating the infos 
UPDATE rental
SET date_start = CURDATE()
WHERE id_copy = 'FREEZE01';

UPDATE copy
SET state = "E"
WHERE id_copy = "FREEZE01" AND id_format = 1 AND state = L;