CREATE VIEW TrackCreditsView AS
SELECT
    t.TrackID,
    t.TrackName,
    t.TrackUri,
    t.Labels,
    t.ReleaseDate,
    t.Duration,
    t.PlayCount,
    GROUP_CONCAT(DISTINCT CONCAT('Performer: ', p.PerformerURI) SEPARATOR '; ') AS Performers,
    GROUP_CONCAT(DISTINCT CONCAT('Producer: ', pr.ProducerURI) SEPARATOR '; ') AS Producers,
    GROUP_CONCAT(DISTINCT CONCAT('Writer: ', w.WriterURI) SEPARATOR '; ') AS Writers
FROM
    Tracks t
    LEFT JOIN TrackCreditors tc ON t.TrackID = tc.TrackID
    LEFT JOIN Performers p ON tc.CreditorID = p.CreditorID
    LEFT JOIN Producers pr ON tc.CreditorID = pr.CreditorID
    LEFT JOIN Writers w ON tc.CreditorID = w.CreditorID
GROUP BY
    t.TrackID;


CREATE VIEW TrackContentRatingsView AS
SELECT
    t.TrackID,
    t.TrackName,
    t.TrackUri,
    t.Labels,
    cr.contentRatingName
FROM
    Tracks t
    JOIN TrackContentRating tr ON t.TrackID = tr.TrackID
    JOIN ContentRating cr ON tr.contentRatingID = cr.contentRatingID;



    CREATE VIEW TracksDetailedCreditsView AS
SELECT
    t.TrackID,
    t.TrackName,
    GROUP_CONCAT(DISTINCT CONCAT(c.Name, ' (', c.Role, ')') SEPARATOR '; ') AS DetailedCredits
FROM
    Tracks t
    JOIN TrackCreditors tc ON t.TrackID = tc.TrackID
    JOIN Creditors c ON tc.CreditorID = c.CreditorID
GROUP BY
    t.TrackID;
    
    
    
CREATE VIEW TrackOverviewView AS
SELECT
    t.TrackID,
    t.TrackName,
    t.TrackUri,
    t.Labels,
    t.ReleaseDate,
    t.Duration,
    t.PlayCount,
    (SELECT cr.contentRatingName 
     FROM TrackContentRating tr 
     JOIN ContentRating cr ON tr.contentRatingID = cr.contentRatingID
     WHERE tr.TrackID = t.TrackID LIMIT 1) AS ContentRating,
    GROUP_CONCAT(DISTINCT CONCAT('Performer: ', c.Name) SEPARATOR '; ') AS Performers,
    GROUP_CONCAT(DISTINCT CONCAT('Producer: ', c.Name) SEPARATOR '; ') AS Producers,
    GROUP_CONCAT(DISTINCT CONCAT('Writer: ', c.Name) SEPARATOR '; ') AS Writers
FROM
    Tracks t
    LEFT JOIN TrackCreditors tc ON t.TrackID = tc.TrackID
    LEFT JOIN Creditors c ON tc.CreditorID = c.CreditorID
    LEFT JOIN Performers p ON c.CreditorID = p.CreditorID
    LEFT JOIN Producers pr ON c.CreditorID = pr.CreditorID
    LEFT JOIN Writers w ON c.CreditorID = w.CreditorID
GROUP BY
    t.TrackID, t.TrackName, t.TrackUri, t.Labels, t.ReleaseDate, t.Duration, t.PlayCount;



