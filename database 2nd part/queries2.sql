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