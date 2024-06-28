CREATE DATABASE video_star;

CREATE TABLE person (
    id_person SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    lastname VARCHAR(50) NOT NULL,
    firstname VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_person)
);

CREATE TABLE state (
    id_state SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    status VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_state)
);

CREATE TABLE format_ (
    id_format SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    format_type VARCHAR(50) NOT NULL,
    price DECIMAL(5.2) UNSIGNED NOT NULL,
    PRIMARY KEY (id_format)
);

CREATE TABLE genre (
    id_genre SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    genre_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_genre)
);

CREATE TABLE condition_ (
    id_condition SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    overall_condition VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_condition)
);

CREATE TABLE planet (
    id_planet SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_planet)
);

CREATE TABLE rental (
    id_rental SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    date_start DATE NOT NULL,
    date_end DATE NOT NULL,
    quantity TINYINT UNSIGNED NOT NULL,
    PRIMARY KEY (id_rental)
);

CREATE TABLE location (
    id_location SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    adress VARCHAR(50) NOT NULL,
    id_planet SMALLINT UNSIGNED NOT NULL,
    PRIMARY KEY (id_location),
    FOREIGN KEY (id_planet) REFERENCES planet(id_planet)
)

CREATE TABLE members (
    id_members SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    birthdate DATE NOT NULL,
    id_location SMALLINT UNSIGNED NOT NULL,
    id_person SMALLINT UNSIGNED NOT NULL,
    PRIMARY KEY (id_members),
    FOREIGN KEY (id_location) REFERENCES location(id_location), 
    FOREIGN KEY (id_person) REFERENCES person(id_person)
)

CREATE TABLE report (
    id_report SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    agent_comment VARCHAR(100),
    id_rental SMALLINT UNSIGNED NOT NULL,
    PRIMARY KEY (id_report),
    FOREIGN KEY (id_rental) REFERENCES rental(id_rental)
)

CREATE TABLE track_record (
    id_condition SMALLINT UNSIGNED NOT NULL,
    id_report SMALLINT UNSIGNED NOT NULL,
    FOREIGN KEY (id_condition) REFERENCES condition_(id_condition),
    FOREIGN KEY (id_report) REFERENCES report(id_report)
)

CREATE table videos (
    id_videos SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    quantity TINYINT UNSIGNED NOT NULL,
    date_create DATE NOT NULL,
    acquisition_date DATE NOT NULL,
    codification VARCHAR(8) NOT NULL UNIQUE,
    id_genre SMALLINT UNSIGNED NOT NULL,
    id_state SMALLINT UNSIGNED NOT NULL,
    id_format SMALLINT UNSIGNED NOT NULL,
    id_location SMALLINT UNSIGNED NOT NULL,
    id_person SMALLINT UNSIGNED NOT NULL,
    PRIMARY KEY (id_videos),
    FOREIGN KEY (id_genre) REFERENCES genre(id_genre),
    FOREIGN KEY (id_state) REFERENCES state(id_state),
    FOREIGN KEY (id_format) REFERENCES format_(id_format),
    FOREIGN KEY (id_location) REFERENCES location(id_location),
    FOREIGN KEY (id_person) REFERENCES person(id_person)
)

CREATE TABLE orders (
    id_rental SMALLINT UNSIGNED NOT NULL,
    id_videos SMALLINT UNSIGNED NOT NULL,
    price_order DECIMAL(8.2) UNSIGNED NOT NULL,
    FOREIGN KEY (id_rental) REFERENCES rental(id_rental),
    FOREIGN KEY (id_videos) REFERENCES videos(id_videos)
)

INSERT INTO format_ (format_type, price)
VALUES ('DVD', 3), ('Blu-Ray', 4), ('VOD', 5);

INSERT INTO genre (genre_name)
VALUES ('New'), ('planète'), ('galaxie'), ('société'), 
('colonies'), ('armement'), ('stations-spatiales'), ('flotte'), 
('jedi'), ('histoire'), ('politique'), ('enfants'), ('ecosystèmes'), 
('langues'), ('économie'), ('sabre-laser'), ('mode'), ('bâtiments'), 
('people'), ('sport');

INSERT INTO state (status)
VALUES ('L'), ('E'), ('D'), ('P');