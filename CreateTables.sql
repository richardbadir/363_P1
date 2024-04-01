DROP DATABASE IF EXISTS `Music`;
CREATE DATABASE `Music`;
USE `Music`;


CREATE TABLE Person (
    id INT PRIMARY KEY,
    URI VARCHAR(255)
);

CREATE TABLE Creator (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    role VARCHAR(255),
    FOREIGN KEY (id) REFERENCES Person(id)
);

CREATE TABLE Artist (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    FOREIGN KEY (id) REFERENCES Person(id)
);

CREATE TABLE Track (
    id INT PRIMARY KEY,
    label VARCHAR(255),
    name VARCHAR(255),
    URI VARCHAR(255),
    duration INT
);

CREATE TABLE Made_a (
    track_id INT,
    person_id INT,
    PRIMARY KEY (track_id, person_id),
    FOREIGN KEY (track_id) REFERENCES Track(id),
    FOREIGN KEY (person_id) REFERENCES Person(id)
);

CREATE TABLE Trending (
    track_id INT,
    peak_rank INT,
    Trending_weeks INT,
    PRIMARY KEY (track_id, peak_rank),
    FOREIGN KEY (track_id) REFERENCES Track(id)
);


