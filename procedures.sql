DELIMITER //

-- ADD Procedures

CREATE PROCEDURE AddPharmacy(IN name VARCHAR(100), IN address VARCHAR(100), IN phone VARCHAR(15))
BEGIN
    INSERT INTO Pharmacy (PharmacyName, PharmacyAddress, PhoneNumber)
    VALUES (name, address, phone);
END //

CREATE PROCEDURE AddPharmaCompany(IN name VARCHAR(30), IN phone VARCHAR(15))
BEGIN
    INSERT INTO PharmaceuticalCompany (CoName, PhoneNumber)
    VALUES (name, phone);
END //

CREATE PROCEDURE AddDoctor(IN aadhar CHAR(12), IN name VARCHAR(50), IN specialization VARCHAR(100), IN experience INT)
BEGIN
    INSERT INTO Doctor (dAadharID, dName, Specialization, Experience)
    VALUES (aadhar, name, specialization, experience);
END //

CREATE PROCEDURE AddPatient(IN aadhar CHAR(12), IN name VARCHAR(50), IN address VARCHAR(200), IN age INT, IN physician CHAR(12))
BEGIN
    INSERT INTO Patient (pAadharID, pName, pAddress, Age, PrimaryPhysicianID)
    VALUES (aadhar, name, address, age, physician);
END //

CREATE PROCEDURE AddDrug(IN name VARCHAR(30), IN formula TEXT, IN company VARCHAR(30))
BEGIN
    INSERT INTO Drug (TradeName, Formula, CoName)
    VALUES (name, formula, company);
END //

CREATE PROCEDURE AddContract(IN company VARCHAR(30), IN name VARCHAR(100), IN address VARCHAR(100), IN startDate DATE, IN endDate DATE, IN content TEXT, IN supervisor CHAR(12))
BEGIN
    INSERT INTO Contract (CompanyName, PharmacyName, PharmacyAddress, StartDate, EndDate, Content, SupervisorID)
    VALUES (company, name, address, startDate, endDate, content, supervisor);
END //

DELIMITER //

-- UpdatePharmacy: Update phone number, name, or address based on current name and address
CREATE PROCEDURE UpdatePharmacy(
    IN currentName VARCHAR(100),
    IN currentAddress VARCHAR(100),
    IN newName VARCHAR(100),
    IN newAddress VARCHAR(100),
    IN newPhone VARCHAR(15)
)
BEGIN
    UPDATE Pharmacy
    SET PharmacyName = newName,
        PharmacyAddress = newAddress,
        PhoneNumber = newPhone
    WHERE PharmacyName = currentName AND PharmacyAddress = currentAddress;
END //

-- UpdatePharmaCompany: Update name or phone based on current name
CREATE PROCEDURE UpdatePharmaCompany(
    IN currentName VARCHAR(30),
    IN newName VARCHAR(30),
    IN newPhone VARCHAR(15)
)
BEGIN
    UPDATE PharmaceuticalCompany
    SET CoName = newName,
        PhoneNumber = newPhone
    WHERE CoName = currentName;
END //

-- UpdateDoctor: Update name, specialization, or experience
CREATE PROCEDURE UpdateDoctor(
    IN aadhar CHAR(12),
    IN newName VARCHAR(50),
    IN newSpecialization VARCHAR(100),
    IN newExperience INT
)
BEGIN
    UPDATE Doctor
    SET dName = newName,
        Specialization = newSpecialization,
        Experience = newExperience
    WHERE dAadharID = aadhar;
END //

-- UpdatePatient: Update name, address, age, or primary physician
CREATE PROCEDURE UpdatePatient(
    IN aadhar CHAR(12),
    IN newName VARCHAR(50),
    IN newAddress VARCHAR(200),
    IN newAge INT,
    IN newPhysician CHAR(12)
)
BEGIN
    UPDATE Patient
    SET pName = newName,
        pAddress = newAddress,
        Age = newAge,
        PrimaryPhysicianID = newPhysician
    WHERE pAadharID = aadhar;
END //

-- UpdateDrug: Update formula or associated company
CREATE PROCEDURE UpdateDrug(
    IN name VARCHAR(30),
    IN newFormula TEXT,
    IN newCompany VARCHAR(30)
)
BEGIN
    UPDATE Drug
    SET Formula = newFormula,
        CoName = newCompany
    WHERE TradeName = name;
END //

-- UpdateContract: Update contract details
CREATE PROCEDURE UpdateContract(
    IN company VARCHAR(30),
    IN name VARCHAR(100),
    IN address VARCHAR(100),
    IN newStartDate DATE,
    IN newEndDate DATE,
    IN newContent TEXT,
    IN newSupervisor CHAR(12)
)
BEGIN
    UPDATE Contract
    SET StartDate = newStartDate,
        EndDate = newEndDate,
        Content = newContent,
        SupervisorID = newSupervisor
    WHERE CompanyName = company AND PharmacyName = name AND PharmacyAddress = address;
END //

DELIMITER ;

-- DELETE Procedures

CREATE PROCEDURE DeleteDoctor(IN aadhar CHAR(12))
BEGIN
    DELETE FROM Doctor WHERE dAadharID = aadhar;
END //

CREATE PROCEDURE DeletePharmacy(IN name VARCHAR(100), IN address VARCHAR(100))
BEGIN
    DELETE FROM Pharmacy WHERE PharmacyName = name AND PharmacyAddress = address;
END //

-- Reporting Procedures

CREATE PROCEDURE PrescriptionsByPatientPeriod(IN patientID CHAR(12), IN fromDate DATE, IN toDate DATE)
BEGIN
    SELECT * FROM Prescribes
    WHERE pAadharID = patientID AND prescriptionDate BETWEEN fromDate AND toDate;
END //

CREATE PROCEDURE PrescriptionDetailsByDate(IN patientID CHAR(12), IN prescDate DATE)
BEGIN
    SELECT * FROM Prescribes
    WHERE pAadharID = patientID AND prescriptionDate = prescDate;
END //

CREATE PROCEDURE DrugsByCompany(IN companyName VARCHAR(30))
BEGIN
    SELECT TradeName, Formula FROM Drug
    WHERE CoName = companyName;
END //

CREATE PROCEDURE StockByPharmacy(IN name VARCHAR(50), IN location VARCHAR(100))
BEGIN
    SELECT DrugName, Price FROM Sells
    WHERE PharmacyName = name AND Phloc = location;
END //

CREATE PROCEDURE ContactDetailsPharmacyPharma(IN name VARCHAR(100), IN address VARCHAR(100), IN company VARCHAR(30))
BEGIN
    SELECT * FROM Contract
    WHERE PharmacyName = name AND PharmacyAddress = address AND CompanyName = company;
END //

CREATE PROCEDURE PatientsByDoctor(IN doctorID CHAR(12))
BEGIN
    SELECT pName, pAadharID FROM Patient
    WHERE PrimaryPhysicianID = doctorID;
END //

DELIMITER ;
