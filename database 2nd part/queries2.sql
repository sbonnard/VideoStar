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

SELECT * 
FROM rental
WHERE date_end IS NULL;

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