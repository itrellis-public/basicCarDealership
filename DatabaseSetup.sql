-- Create the database
CREATE DATABASE iTrellisCarDealership;
GO

-- Use the database
USE iTrellisCarDealership;
GO

-- Create the Make table
CREATE TABLE Make (
    MakeID INT IDENTITY(1,1) PRIMARY KEY,
    MakeName NVARCHAR(50) NOT NULL UNIQUE
);
GO

-- Create the Color table
CREATE TABLE Color (
    ColorID INT IDENTITY(1,1) PRIMARY KEY,
    ColorName NVARCHAR(50) NOT NULL UNIQUE
);
GO

-- Create the Cars table
CREATE TABLE Cars (
    CarID UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY,
    MakeID INT NOT NULL,
    Year INT CHECK (Year >= 1886), -- The first car was made in 1886
    ColorID INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL CHECK (Price >= 0),
    HasSunroof BIT NOT NULL,
    IsFourWheelDrive BIT NOT NULL,
    HasLowMiles BIT NOT NULL,
    HasPowerWindows BIT NOT NULL,
    HasNavigation BIT NOT NULL,
    HasHeatedSeats BIT NOT NULL,
    FOREIGN KEY (MakeID) REFERENCES Make(MakeID),
    FOREIGN KEY (ColorID) REFERENCES Color(ColorID)
);
GO

-- Insert unique makes from the JSON dataset
INSERT INTO Make (MakeName)
SELECT DISTINCT MakeName FROM (VALUES
    ('Chevy'), ('Toyota'), ('Mercedes'), ('Ford')
) AS Makes(MakeName);
GO

-- Insert unique colors from the JSON dataset
INSERT INTO Color (ColorName)
SELECT DISTINCT ColorName FROM (VALUES
    ('Gray'), ('Silver'), ('Black'), ('White'), ('Red')
) AS Colors(ColorName);
GO

-- Insert cars into the Cars table
INSERT INTO Cars (MakeID, Year, ColorID, Price, HasSunroof, IsFourWheelDrive, HasLowMiles, HasPowerWindows, HasNavigation, HasHeatedSeats)
SELECT
    (SELECT MakeID FROM Make WHERE MakeName = 'Chevy'), 2016, (SELECT ColorID FROM Color WHERE ColorName = 'Gray'), 16106, 0, 1, 1, 0, 1, 0 UNION ALL
SELECT
    (SELECT MakeID FROM Make WHERE MakeName = 'Toyota'), 2012, (SELECT ColorID FROM Color WHERE ColorName = 'Silver'), 18696, 1, 1, 0, 1, 0, 1 UNION ALL
SELECT
    (SELECT MakeID FROM Make WHERE MakeName = 'Mercedes'), 2016, (SELECT ColorID FROM Color WHERE ColorName = 'Black'), 18390, 1, 0, 0, 1, 1, 0 UNION ALL
SELECT
    (SELECT MakeID FROM Make WHERE MakeName = 'Toyota'), 2015, (SELECT ColorID FROM Color WHERE ColorName = 'White'), 15895, 1, 0, 1, 1, 0, 1 UNION ALL
SELECT
    (SELECT MakeID FROM Make WHERE MakeName = 'Ford'), 2014, (SELECT ColorID FROM Color WHERE ColorName = 'Gray'), 19710, 0, 1, 0, 0, 1, 1 UNION ALL
SELECT
    (SELECT MakeID FROM Make WHERE MakeName = 'Toyota'), 2014, (SELECT ColorID FROM Color WHERE ColorName = 'Red'), 19248, 1, 0, 1, 1, 1, 1 UNION ALL
SELECT
    (SELECT MakeID FROM Make WHERE MakeName = 'Toyota'), 2015, (SELECT ColorID FROM Color WHERE ColorName = 'Black'), 13170, 1, 0, 1, 1, 0, 0 UNION ALL
SELECT
    (SELECT MakeID FROM Make WHERE MakeName = 'Mercedes'), 2013, (SELECT ColorID FROM Color WHERE ColorName = 'Gray'), 15669, 0, 0, 1, 0, 0, 0 UNION ALL
SELECT
    (SELECT MakeID FROM Make WHERE MakeName = 'Toyota'), 2015, (SELECT ColorID FROM Color WHERE ColorName = 'White'), 16629, 0, 0, 1, 0, 0, 1;
GO
