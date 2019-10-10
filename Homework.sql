CREATE DATABASE Movie



CREATE TABLE Director (
Id int IDENTITY(1,1) PRIMARY KEY,
FirstName nvarchar(MAX),
LastName nvarchar(MAX),
Nationality nvarchar(MAX),
BirhDate date
);

INSERT INTO Director
VALUES

('Quentin','Tarantino','USA','1963-03-27'),
('Guillermo','Del Torro','Mexic','1964-10-19'),
('Martin','Scorsese','USA','1942-11-17'),
('Francis','Coppola','USA','1939-04-07'),
('Charles','Spencer Chaplin','UK','1889-04-16');


DELETE FROM Director WHERE Id=3



CREATE TABLE Movie (
DirectorId int IDENTITY(1,1) PRIMARY KEY,
Title nvarchar(MAX),
ReleaseDate Date,
Rating int,
Duration time
);
INSERT INTO Movie
VALUES
('Pulp Fiction','1994-09-10','5','1:05:50'),
('El Labirionto Del Fauno','1991-02-22','6','5:07:22'),
('The Taxi Driver','1976-02-08','7','4:24:55'),
('Dracula','1992-11-10', '8','3:23:33'),
('The Dictator','1940-10-15','9','2:55:50');



UPDATE Movie SET Title='ArtificiallyUpdated' WHERE Rating<10;

Select * from Movie


CREATE TABLE Actor (
ActorId int IDENTITY(1,1) PRIMARY KEY,
FirstName nvarchar(MAX),
LastName nvarchar(MAX),
Nationality nvarchar(MAX),
BirhDate date,
PopularityRating int
);

INSERT INTO Actor
VALUES
('Anthony','Hopkins','UK','1937-01-11','1'),
('Robert','DeNiro','Spania','1945-07-17','2'),
('Tom','Hanks','Angola','1956-06-09','3')



SELECT MIN(Rating) AS SmallestRating FROM Movie;


SELECT MAX(Id) AS MostMovieDirected FROM Director;


SELECT * FROM Director ORDER BY LastName ASC;
SELECT * FROM Director ORDER BY BirthDate DESC;


UPDATE Movie SET Rating = Rating + 1 WHERE DirectorId=6;

CREATE TABLE MovieActor (
    MovieId int IDENTITY(1,1) PRIMARY KEY,
	DirectorId int CONSTRAINT fk_director REFERENCES Director(Id),
	ActorId int CONSTRAINT fk_actor REFERENCES Actor(ActorId)
);

INSERT INTO MovieActor(DirectorId,ActorId) VALUES(1,5);

--16. Implement many to many relationship between Movie and Genre
CREATE TABLE Genre(
	Id int IDENTITY(1,1) PRIMARY KEY,
	Name VARCHAR(MAX) NOT NULL
);

CREATE TABLE MovieGenre(
	MovieId int CONSTRAINT fk_movieId REFERENCES Movie(Id),
	GenreId int CONSTRAINT fk_genreId REFERENCES Genre(Id)
);

INSERT INTO Genre(GenreName) VALUES('Horror');
INSERT INTO Genre(GenreName) VALUES('Action');
SELECT * FROM Genre;

INSERT INTO MovieGenre(MovieId,GenreId) VALUES(2,1);
INSERT INTO MovieGenre(MovieId,GenreId) VALUES(5,2);
INSERT INTO MovieGenre(MovieId,GenreId) VALUES(1,2);

.--17. Which actor has worked with the most distinct movie directors?
SELECT A.ActorId, COUNT(d.Id) AS NoOfDirs
FROM Actor A INNER JOIN MovieActor ma ON A.ActorId=ma.ActorId INNER JOIN Movie m ON ma.MovieId =m.DirectorId INNER JOIN 
Director d ON m.DirectorId=d.Id GROUP BY A.ActorId
HAVING COUNT(d.Id) >= (SELECT COUNT(d.Id) AS NoOfDirs
FROM Actor A INNER JOIN MovieActor ma ON A.ActorId=ma.ActorId INNER JOIN Movie m ON ma.MovieId =m.DirectorId INNER JOIN 
Director d ON m.DirectorId=d.Id GROUP BY A.ActorId)

--18. Which is the preferred genre of each actor?
SELECT A.FirstName, A.LastName,g.GenreName
FROM Actor A INNER JOIN MovieActor ma ON A.ActorId=ma.ActorId INNER JOIN Movie m 
ON ma.MovieId =m.DirectorId INNER JOIN MovieGenre mg ON m.DirectorId=mg.MovieId INNER JOIN Genre g ON mg.GenreId=g.GenreID