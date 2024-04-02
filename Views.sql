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
    tr.contentRatingName
FROM
    Tracks t
    JOIN TrackContentRating tr ON t.TrackID = tr.TrackID;
