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

-- UPDATE Procedures

CREATE PROCEDURE UpdatePharmacyPhone(IN name VARCHAR(100), IN address VARCHAR(100), IN newPhone VARCHAR(15))
BEGIN
    UPDATE Pharmacy
    SET PhoneNumber = newPhone
    WHERE PharmacyName = name AND PharmacyAddress = address;
END //

CREATE PROCEDURE UpdateDoctorExperience(IN aadhar CHAR(12), IN newExp INT)
BEGIN
    UPDATE Doctor
    SET Experience = newExp
    WHERE dAadharID = aadhar;
END //

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
