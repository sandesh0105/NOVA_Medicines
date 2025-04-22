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
    PrimaryPhysicianID CHAR(12),
    FOREIGN KEY (PrimaryPhysicianID) REFERENCES Doctor(dAadharID)
);


create table PharmaceuticalCompany (
    CoName VARCHAR(30) PRIMARY KEY,
    PhoneNumber VARCHAR(15)
);

create table Drug (
    TradeName VARCHAR(30),
    Formula TEXT,
    CoName VARCHAR(30),
    PRIMARY KEY (TradeName, CoName),
    FOREIGN KEY (CoName) REFERENCES PharmaceuticalCompany(CoName) ON DELETE CASCADE
);
CREATE TABLE Pharmacy (
    PharmacyName VARCHAR(100) PRIMARY KEY,
    PharmacyAddress TEXT,
    PhoneNumber VARCHAR(15)
);

create table Sells (
    PharmacyName VARCHAR(50),
    DrugName VARCHAR(30),
    Price DECIMAL(10, 2),
    PRIMARY KEY (PharmacyName, DrugName),
    FOREIGN KEY (PharmacyName) REFERENCES Pharmacy(PharmacyName),
    FOREIGN KEY (DrugName) REFERENCES Drug(TradeName)
);


create table Prescribes (
    prescriptionDate DATE,
    DrugName VARCHAR(30),
    pAadharID CHAR(12),
    dAadharID CHAR(12),
    Qty INT,
    PRIMARY KEY (DrugName, pAadharID, dAadharID),
    FOREIGN KEY (DrugName) REFERENCES Drug(TradeName),
    FOREIGN KEY (pAadharID) REFERENCES Patient(pAadharID),
    FOREIGN KEY (dAadharID) REFERENCES Doctor(dAadharID)
);

CREATE TABLE Contract (
    -- ContractID SERIAL PRIMARY KEY,
    PharmacyName VARCHAR(100),
    CompanyName VARCHAR(100),
    StartDate DATE,
    EndDate DATE,
    Content TEXT,
    SupervisorID CHAR(12),
    PRIMARY KEY (PharmacyName, CompanyName),
    FOREIGN KEY (PharmacyName) REFERENCES Pharmacy(PharmacyName),
    FOREIGN KEY (CompanyName) REFERENCES PharmaceuticalCompany(CoName),
    FOREIGN KEY (SupervisorID) REFERENCES Doctor(dAadharID)
);
