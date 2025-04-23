DELIMITER //

-- ADD Procedures
DROP PROCEDURE IF EXISTS AddPharmacy //
CREATE PROCEDURE AddPharmacy(IN name VARCHAR(100), IN address VARCHAR(100), IN phone VARCHAR(15))
BEGIN
    INSERT INTO Pharmacy (PharmacyName, PharmacyAddress, PhoneNumber)
    VALUES (name, address, phone);
END //

DROP PROCEDURE IF EXISTS AddPharmaCompany //
CREATE PROCEDURE AddPharmaCompany(IN name VARCHAR(30), IN phone VARCHAR(15))
BEGIN
    INSERT INTO PharmaceuticalCompany (CoName, PhoneNumber)
    VALUES (name, phone);
END //

DROP PROCEDURE IF EXISTS AddDoctor //
CREATE PROCEDURE AddDoctor(IN aadhar CHAR(12), IN name VARCHAR(50), IN specialization VARCHAR(100), IN experience INT)
BEGIN
    INSERT INTO Doctor (dAadharID, dName, Specialization, Experience)
    VALUES (aadhar, name, specialization, experience);
END //

DROP PROCEDURE IF EXISTS AddPatient //
CREATE PROCEDURE AddPatient(IN aadhar CHAR(12), IN name VARCHAR(50), IN address VARCHAR(200), IN age INT, IN physician CHAR(12))
BEGIN
    INSERT INTO Patient (pAadharID, pName, pAddress, Age, PrimaryPhysicianID)
    VALUES (aadhar, name, address, age, physician);
END //

DROP PROCEDURE IF EXISTS AddDrug //    
CREATE PROCEDURE AddDrug(IN name VARCHAR(30), IN formula TEXT, IN company VARCHAR(30))
BEGIN
    INSERT INTO Drug (TradeName, Formula, CoName)
    VALUES (name, formula, company);
END //

DROP PROCEDURE IF EXISTS AddContract //
CREATE PROCEDURE AddContract(IN company VARCHAR(30), IN name VARCHAR(100), IN address VARCHAR(100), IN startDate DATE, IN endDate DATE, IN content TEXT, IN supervisor CHAR(12))
BEGIN
    INSERT INTO Contract (CompanyName, PharmacyName, PharmacyAddress, StartDate, EndDate, Content, SupervisorID)
    VALUES (company, name, address, startDate, endDate, content, supervisor);
END //


DROP PROCEDURE IF EXISTS AddPrescription //
CREATE PROCEDURE AddPrescription(IN pAID CHAR(12), IN dAID CHAR(12), IN Drug VARCHAR(30), IN prDate DATE, IN Qantity INT)
BEGIN
    INSERT INTO Contract (pAadharID, dAadharID, DrugName, prescriptionDate, Qty)
    VALUES (pAID, dAID, Drug, prDate, Qantity);
END //

DROP PROCEDURE IF EXISTS AddSellsData //
CREATE PROCEDURE AddSellsData(IN PhName VARCHAR(50), IN PhAddr VARCHAR(100), IN drug VARCHAR(30), IN price DECIMAL(10, 2))
BEGIN
    INSERT INTO Contract (PharmacyName, Phloc, DrugName, Price)
    VALUES (PhName, PhAddr, drug, price);
END //

-- UPDATE Procedures

DROP PROCEDURE IF EXISTS UpdatePharmacyPhone //
CREATE PROCEDURE UpdatePharmacyPhone(IN name VARCHAR(100), IN address VARCHAR(100), IN newPhone VARCHAR(15))
BEGIN
    UPDATE Pharmacy
    SET PhoneNumber = newPhone
    WHERE PharmacyName = name AND PharmacyAddress = address;
END //

DROP PROCEDURE IF EXISTS UpdateDoctorExperience //
CREATE PROCEDURE UpdateDoctorExperience(IN aadhar CHAR(12), IN newExp INT)
BEGIN
    UPDATE Doctor
    SET Experience = newExp
    WHERE dAadharID = aadhar;
END //

-- DELETE Procedures

DROP PROCEDURE IF EXISTS DeleteDoctor //
CREATE PROCEDURE DeleteDoctor(IN aadhar CHAR(12))
BEGIN
    DELETE FROM Doctor WHERE dAadharID = aadhar;
END //

DROP PROCEDURE IF EXISTS DeletePharmacy //
CREATE PROCEDURE DeletePharmacy(IN name VARCHAR(100), IN address VARCHAR(100))
BEGIN
    DELETE FROM Pharmacy WHERE PharmacyName = name AND PharmacyAddress = address;
END //

DROP PROCEDURE IF EXISTS DeletePatient //
CREATE PROCEDURE DeletePatient(IN aadhar CHAR(12))
BEGIN
    DELETE FROM Patient WHERE pAadharID = aadhar;
END //

DROP PROCEDURE IF EXISTS DeletePharmaCo //
CREATE PROCEDURE DeletePharmaCo(IN companyName VARCHAR(30))
BEGIN
    DELETE FROM PharmaceuticalCompany WHERE CoName = companyName;
END //

DROP PROCEDURE IF EXISTS DeleteDrug //
CREATE PROCEDURE DeleteDrug(IN tradeName VARCHAR(30), IN companyName VARCHAR(30))
BEGIN
    DELETE FROM Drug WHERE TradeName = tradeName AND CoName = companyName;
END //

DROP PROCEDURE IF EXISTS DeleteSells //
CREATE PROCEDURE DeleteSells(
    IN pharmacyName VARCHAR(50),
    IN pharmacyLoc VARCHAR(100),
    IN drugName VARCHAR(30)
)
BEGIN
    DELETE FROM Sells 
    WHERE PharmacyName = pharmacyName AND Phloc = pharmacyLoc AND DrugName = drugName;
END //

DROP PROCEDURE IF EXISTS DeletePrescription //
CREATE PROCEDURE DeletePrescription(
    IN patientID CHAR(12),
    IN doctorID CHAR(12),
    IN drugName VARCHAR(30)
)
BEGIN
    DELETE FROM Prescribes 
    WHERE pAadharID = patientID AND dAadharID = doctorID AND DrugName = drugName;
END //

DROP PROCEDURE IF EXISTS DeleteContract //
CREATE PROCEDURE DeleteContract(
    IN pharmacyName VARCHAR(100),
    IN pharmacyAddress VARCHAR(100),
    IN companyName VARCHAR(30)
)
BEGIN
    DELETE FROM Contract 
    WHERE PharmacyName = pharmacyName AND PharmacyAddress = pharmacyAddress AND CompanyName = companyName;
END //

-- Reporting Procedures

DROP PROCEDURE IF EXISTS PrescriptionsByPatientPeriod //
CREATE PROCEDURE PrescriptionsByPatientPeriod(IN patientID CHAR(12), IN fromDate DATE, IN toDate DATE)
BEGIN
    SELECT * FROM Prescribes
    WHERE pAadharID = patientID AND prescriptionDate BETWEEN fromDate AND toDate;
END //

DROP PROCEDURE IF EXISTS PrescriptionDetailsByDate //
CREATE PROCEDURE PrescriptionDetailsByDate(IN patientID CHAR(12), IN prescDate DATE)
BEGIN
    SELECT * FROM Prescribes
    WHERE pAadharID = patientID AND prescriptionDate = prescDate;
END //

DROP PROCEDURE IF EXISTS DrugsByCompany //
CREATE PROCEDURE DrugsByCompany(IN companyName VARCHAR(30))
BEGIN
    SELECT TradeName, Formula FROM Drug
    WHERE CoName = companyName;
END //

DROP PROCEDURE IF EXISTS StockByPharmacy //
CREATE PROCEDURE StockByPharmacy(IN name VARCHAR(50), IN location VARCHAR(100))
BEGIN
    SELECT DrugName, Price FROM Sells
    WHERE PharmacyName = name AND Phloc = location;
END //

DROP PROCEDURE IF EXISTS ContactDetailsPharmacyPharma //
CREATE PROCEDURE ContactDetailsPharmacyPharma(IN name VARCHAR(100), IN address VARCHAR(100), IN company VARCHAR(30))
BEGIN
    SELECT * FROM Contract
    WHERE PharmacyName = name AND PharmacyAddress = address AND CompanyName = company;
END //

DROP PROCEDURE IF EXISTS PatientsByDoctor //
CREATE PROCEDURE PatientsByDoctor(IN doctorID CHAR(12))
BEGIN
    SELECT pName, pAadharID FROM Patient
    WHERE PrimaryPhysicianID = doctorID;
END //

DELIMITER ;
