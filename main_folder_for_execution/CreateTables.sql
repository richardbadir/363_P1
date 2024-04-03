DROP DATABASE IF EXISTS `Music`;
CREATE DATABASE `Music`;
USE `Music`;


CREATE TABLE Creditors ( -- A performer, producer and writer ISA creditor
    CreditorID INT AUTO_INCREMENT,
    Name VARCHAR(255),
    Role VARCHAR(50),
    PRIMARY KEY (CreditorID)
);

CREATE TABLE Performers (
    CreditorID INT,
    PerformerURI VARCHAR(200),
    PRIMARY KEY (CreditorID),
    FOREIGN KEY (CreditorID) REFERENCES Creditors(CreditorID)
);

CREATE TABLE Producers (
    CreditorID INT,
    ProducerURI VARCHAR(200),
    PRIMARY KEY (CreditorID),
    FOREIGN KEY (CreditorID) REFERENCES Creditors(CreditorID)
);

CREATE TABLE Writers (
    CreditorID INT,
    WriterURI VARCHAR(200),
    PRIMARY KEY (CreditorID),
    FOREIGN KEY (CreditorID) REFERENCES Creditors(CreditorID)
);

CREATE TABLE Tracks (
    TrackID INT AUTO_INCREMENT,
    TrackName VARCHAR(255),
    TrackUri VARCHAR(255) UNIQUE,+
    Labels TEXT,
    ReleaseDate DATE,
    Duration INT,
    PlayCount BIGINT,
    PRIMARY KEY (TrackID),
    CHECK (Duration >= 0 AND PlayCount >= 0)
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
    FOREIGN KEY (TrackID) REFERENCES Tracks(TrackID) ON DELETE CASCADE,
    CHECK (PeakRank > 0 AND AppearancesOnChart > 0 AND ConsecutiveAppearancesOnChart>0)
);

CREATE TABLE ContentRating (
	contentRatingID INT auto_increment, 
    contentRatingName VARCHAR(255),
    PRIMARY KEY (contentRatingID)
);

CREATE TABLE TrackContentRating ( -- connect the track to the contentRating (one to many)
    TrackID INT,
    contentRatingID INT,
    PRIMARY KEY (TrackID, contentRatingID),
    FOREIGN KEY (TrackID) REFERENCES Tracks(TrackID) ON DELETE CASCADE,
    FOREIGN KEY (contentRatingID) REFERENCES ContentRating(contentRatingID)
);

CREATE TABLE TrackInsertionLog ( --keeps track of when a new song is added to the database
    LogID INT AUTO_INCREMENT PRIMARY KEY,
    TrackID INT,
    TrackName VARCHAR(255),
    InsertionTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$

CREATE TRIGGER LogTrackInsertion --trigger to keep track when a new song is added.
AFTER INSERT ON Tracks
FOR EACH ROW
BEGIN
    INSERT INTO TrackInsertionLog (TrackID, TrackName)
    VALUES (NEW.TrackID, NEW.TrackName);
END$$

DELIMITER ;

