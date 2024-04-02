DROP DATABASE IF EXISTS `Music`;
CREATE DATABASE `Music`;
USE `Music`;


CREATE TABLE Creditors ( -- A performer, producer and producer ISA creditor
    CreditorID INT AUTO_INCREMENT,
    Name VARCHAR(255),
    Role VARCHAR(50),
    PRIMARY KEY (CreditorID)
);

CREATE TABLE Performers (
    CreditorID INT,
    PerformerURI VARCHAR(20),
    PRIMARY KEY (CreditorID),
    FOREIGN KEY (CreditorID) REFERENCES Creditors(CreditorID)
);

CREATE TABLE Producers (
    CreditorID INT,
    ProducerURI VARCHAR(20),
    PRIMARY KEY (CreditorID),
    FOREIGN KEY (CreditorID) REFERENCES Creditors(CreditorID)
);

CREATE TABLE Writers (
    CreditorID INT,
    WriterURI VARCHAR(20),
    PRIMARY KEY (CreditorID),
    FOREIGN KEY (CreditorID) REFERENCES Creditors(CreditorID)
);

CREATE TABLE Tracks (
    TrackID INT AUTO_INCREMENT,
    TrackName VARCHAR(255),
    TrackUri VARCHAR(255) UNIQUE,
    Labels TEXT,
    ReleaseDate DATE,
    Duration INT,
    PlayCount BIGINT,
    PRIMARY KEY (TrackID)
);

CREATE TABLE TrackCreditors ( -- connect the creditors with the track (many to many)
    TrackID INT,
    CreditorID INT,
    PRIMARY KEY (TrackID, CreditorID),
    FOREIGN KEY (TrackID) REFERENCES Tracks(TrackID) ,
    FOREIGN KEY (CreditorID) REFERENCES Creditors(CreditorID)
);

CREATE TABLE TrendingDates ( -- Weak entity connected to Tracks
    TrackID INT,
    TrendingDate DATE,
	PeakRank INT,
	AppearancesOnChart INT,
    ConsecutiveAppearancesOnChart INT,
    PRIMARY KEY (TrackID, TrendingDate),
    FOREIGN KEY (TrackID) REFERENCES Tracks(TrackID) ON DELETE CASCADE 
);

CREATE TABLE ContentRating (
    contentRatingName VARCHAR(255),
    PRIMARY KEY (contentRatingName)
);

CREATE TABLE TrackContentRating ( -- connect the track to the contentRating (one to many)
    TrackID INT,
    contentRatingName VARCHAR(255),
    PRIMARY KEY (TrackID, contentRatingName),
    FOREIGN KEY (TrackID) REFERENCES Tracks(TrackID) ON DELETE CASCADE,
    FOREIGN KEY (contentRatingName) REFERENCES ContentRating(contentRatingName)
);

