-- 1. Create a brand‐new database
CREATE DATABASE GameDb2;
GO

-- 2. Switch to it
USE GameDb2;
GO

-- 3. Make the Games table with Id, Name, Genre, Studio, ReleaseYear
CREATE TABLE Games (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100)       NOT NULL,
    Genre NVARCHAR(100)      NOT NULL,
    Studio NVARCHAR(100)     NOT NULL,
    ReleaseYear INT          NOT NULL
);
