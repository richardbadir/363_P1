#1. Basic Select with Simple Where Clause
SELECT * FROM Tracks WHERE Duration > 240;


#2. Basic Select with Simple Group By Clause

#With Group By:
SELECT ReleaseDate, COUNT(*) AS NumberOfTracks FROM Tracks GROUP BY ReleaseDate;

#With Group By and Having Clause:
SELECT ReleaseDate, COUNT(*) AS NumberOfTracks FROM Tracks GROUP BY ReleaseDate HAVING COUNT(*) > 1;



#3. Simple Join Select Query

#Using Product and Where Clause:
SELECT Tracks.*, ContentRating.contentRatingName
FROM Tracks
JOIN TrackContentRating ON Tracks.TrackID = TrackContentRating.TrackID
JOIN ContentRating ON TrackContentRating.contentRatingID = ContentRating.contentRatingID
WHERE ContentRating.contentRatingName = 'EXPLICIT';


SELECT Tracks.*, ContentRating.contentRatingName
FROM Tracks
JOIN TrackContentRating ON Tracks.TrackID = TrackContentRating.TrackID
JOIN ContentRating ON TrackContentRating.contentRatingID = ContentRating.contentRatingID
WHERE ContentRating.contentRatingName = 'NONE';





#4. Various Join Types

#Inner Join:
SELECT * FROM Tracks INNER JOIN TrackContentRating ON Tracks.TrackID = TrackContentRating.TrackID;

#Left Outer Join:
SELECT * FROM Tracks LEFT JOIN TrackContentRating ON Tracks.TrackID = TrackContentRating.TrackID;

#Right Outer Join:
SELECT * FROM Tracks RIGHT JOIN TrackContentRating ON Tracks.TrackID = TrackContentRating.TrackID;

#Full Join (MySQL doesn't support FULL JOIN directly, but it can be simulated using UNION):
SELECT * FROM Tracks LEFT JOIN TrackContentRating ON Tracks.TrackID = TrackContentRating.TrackID
UNION
SELECT * FROM Tracks RIGHT JOIN TrackContentRating ON Tracks.TrackID = TrackContentRating.TrackID;


#5. Correlated Subqueries
SELECT TrackName 
FROM Tracks t 
WHERE EXISTS (
    SELECT * 
    FROM TrackContentRating tc
    JOIN ContentRating cr ON tc.contentRatingID = cr.contentRatingID
    WHERE t.TrackID = tc.TrackID AND cr.contentRatingName = 'EXPLICIT'
);


#6. Set Operations

#Union:
SELECT TrackName FROM Tracks WHERE ReleaseDate = '2024-01-18'
UNION
SELECT TrackName FROM Tracks WHERE ReleaseDate = '2024-02-09';

#Difference (MySQL uses NOT IN or LEFT JOIN ... WHERE IS NULL):
SELECT TrackName FROM Tracks WHERE ReleaseDate = '2024-01-18' AND TrackID NOT IN (SELECT TrackID FROM Tracks WHERE ReleaseDate = '2024-02-09');



#7. View with Hard-Coded Criteria
CREATE VIEW PGTracks AS 
SELECT Tracks.* 
FROM Tracks 
JOIN TrackContentRating ON Tracks.TrackID = TrackContentRating.TrackID
JOIN ContentRating ON TrackContentRating.contentRatingID = ContentRating.contentRatingID
WHERE ContentRating.contentRatingName = 'EXPLICIT';



#8. Division Operator

#Using NOT IN:
SELECT CreditorID FROM Creditors WHERE CreditorID NOT IN (SELECT CreditorID FROM Performers);

#Using NOT EXISTS:
SELECT CreditorID FROM Creditors c WHERE NOT EXISTS (SELECT * FROM Performers p WHERE p.CreditorID = c.CreditorID);




#9.Covering Constraints and Overlap Constraints

#Covering Constraint:
SELECT t.TrackID, t.TrackName
FROM Tracks t
WHERE NOT EXISTS (
    SELECT * 
    FROM TrackCreditors tc
    WHERE t.TrackID = tc.TrackID
);

#Overlap Constraints
SELECT 
    t1.TrackID, 
    t1.TrendingDate AS StartDate1, 
    DATE_ADD(t1.TrendingDate, INTERVAL t1.ConsecutiveAppearancesOnChart DAY) AS EndDate1,
    t2.TrendingDate AS StartDate2,
    DATE_ADD(t2.TrendingDate, INTERVAL t2.ConsecutiveAppearancesOnChart DAY) AS EndDate2
FROM 
    TrendingDates t1
JOIN 
    TrendingDates t2 
ON 
    t1.TrackID = t2.TrackID 
    AND t1.TrendingDate < t2.TrendingDate
WHERE 
    DATE_ADD(t1.TrendingDate, INTERVAL t1.ConsecutiveAppearancesOnChart DAY) > t2.TrendingDate
    AND t1.TrackID = t2.TrackID
ORDER BY 
    t1.TrackID, t1.TrendingDate;

#10. TRIGGER QUERY
SELECT * FROM TrackInsertionLog ORDER BY InsertionTimestamp DESC; -- Query for the trigger