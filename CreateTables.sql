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