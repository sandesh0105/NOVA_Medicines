-- DBMS Project
-- source <file path>/<filename>.sql;
DROP DATABASE IF EXISTS NOVA;
create database NOVA;

FLUSH PRIVILEGES;
use NOVA;
create table Doctor (
    dAadharID CHAR(12) PRIMARY KEY,
    dName VARCHAR(50),
    Specialization VARCHAR(100),
    Experience INT
);
create table Patient (
    pAadharID CHAR(12) PRIMARY KEY,
    pName VARCHAR(50),
    pAddress VARCHAR(200),
    Age INT,
    PrimaryPhysicianID CHAR(12) NOT NULL,
    FOREIGN KEY (PrimaryPhysicianID) REFERENCES Doctor(dAadharID)
);


create table PharmaceuticalCompany (
    CoName VARCHAR(30) PRIMARY KEY,
    PhoneNumber VARCHAR(15)
);

create table Drug (
    TradeName VARCHAR(30),
    CoName VARCHAR(30),
    Formula TEXT,
    PRIMARY KEY (TradeName, CoName),
    FOREIGN KEY (CoName) REFERENCES PharmaceuticalCompany(CoName) ON DELETE CASCADE
);
CREATE TABLE Pharmacy (
    PharmacyName VARCHAR(100),
    PharmacyAddress VARCHAR(100),
    PhoneNumber VARCHAR(15),
    PRIMARY KEY(PharmacyName,PharmacyAddress)
);

create table Sells (
    PharmacyName VARCHAR(50),
    Phloc VARCHAR(100),
    DrugName VARCHAR(30),
    Price DECIMAL(10, 2),
    PRIMARY KEY (PharmacyName, DrugName, Phloc),
    FOREIGN KEY (PharmacyName, Phloc) REFERENCES Pharmacy(PharmacyName,PharmacyAddress),
    FOREIGN KEY (DrugName) REFERENCES Drug(TradeName)
);


create table Prescribes (
    pAadharID CHAR(12),
    dAadharID CHAR(12),
    DrugName VARCHAR(30),
    prescriptionDate DATE,
    Qty INT,
    PRIMARY KEY (DrugName, pAadharID, dAadharID),
    FOREIGN KEY (DrugName) REFERENCES Drug(TradeName),
    FOREIGN KEY (pAadharID) REFERENCES Patient(pAadharID),
    FOREIGN KEY (dAadharID) REFERENCES Doctor(dAadharID)
);

CREATE TABLE Contract (
    CompanyName VARCHAR(30),
    PharmacyName VARCHAR(100),
    PharmacyAddress VARCHAR(100),
    StartDate DATE,
    EndDate DATE,
    Content TEXT,
    SupervisorID CHAR(12),
    PRIMARY KEY (PharmacyName, CompanyName, PharmacyAddress),
    FOREIGN KEY (PharmacyName,PharmacyAddress) REFERENCES Pharmacy(PharmacyName,PharmacyAddress),
    FOREIGN KEY (CompanyName) REFERENCES PharmaceuticalCompany(CoName),
    FOREIGN KEY (SupervisorID) REFERENCES Doctor(dAadharID)
);

