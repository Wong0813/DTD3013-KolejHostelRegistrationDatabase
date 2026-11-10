-- ==============================================================================
-- DTD3013 Database System
-- Kolej Hostel Registration System
-- ==============================================================================

-- ------------------------------------------------------------------------------
-- 1. DATA DEFINITION LANGUAGE (DDL)
-- ------------------------------------------------------------------------------

-- Create database
CREATE DATABASE IF NOT EXISTS kolej_hostel_registration_system;
USE kolej_hostel_registration_system;

-- Drop existing tables if re-importing (reverse dependency order)
DROP TABLE IF EXISTS roomallocation;
DROP TABLE IF EXISTS payment;
DROP TABLE IF EXISTS room;
DROP TABLE IF EXISTS hostel;
DROP TABLE IF EXISTS admin;
DROP TABLE IF EXISTS student;

-- Create tables

-- Student Table
CREATE TABLE student (
    StudentId VARCHAR(12) NOT NULL,
    Name VARCHAR(100),
    Gender VARCHAR(6),
    Race VARCHAR(10),
    PhoneNumber VARCHAR(15),
    YearOfStudy INT,
    Faculty VARCHAR(10),
    PRIMARY KEY (StudentId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Admin Table
CREATE TABLE admin (
    AdminId VARCHAR(5) NOT NULL,
    Name VARCHAR(100),
    PhoneNumber VARCHAR(15),
    Email VARCHAR(100),
    PRIMARY KEY (AdminId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Hostel Table
CREATE TABLE hostel (
    HostelId VARCHAR(5) NOT NULL,
    HostelName VARCHAR(50),
    Location VARCHAR(100),
    GenderAllow VARCHAR(6),
    PRIMARY KEY (HostelId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Room Table
CREATE TABLE room (
    RoomId VARCHAR(5) NOT NULL,
    HostelId VARCHAR(5),
    RoomNumber VARCHAR(5),
    Capacity INT,
    RaceRestriction VARCHAR(10),
    Status VARCHAR(10),
    PRIMARY KEY (RoomId),
    CONSTRAINT fk_room_hostel FOREIGN KEY (HostelId) REFERENCES hostel(HostelId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Payment Table
CREATE TABLE payment (
    PaymentId VARCHAR(5) NOT NULL,
    StudentId VARCHAR(12),
    AdminId VARCHAR(5),
    PaymentDate DATE,
    Status VARCHAR(10),
    ProofOfPayment VARCHAR(255),
    Amount DECIMAL(10,2),
    PRIMARY KEY (PaymentId),
    CONSTRAINT fk_payment_student FOREIGN KEY (StudentId) REFERENCES student(StudentId),
    CONSTRAINT fk_payment_admin FOREIGN KEY (AdminId) REFERENCES admin(AdminId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Room Allocation Table
CREATE TABLE roomallocation (
    AllocationId VARCHAR(6) NOT NULL,
    StudentId VARCHAR(12),
    PaymentId VARCHAR(5),
    AdminId VARCHAR(5),
    RoomId VARCHAR(5),
    Status VARCHAR(10),
    SubmitDate DATE,
    PRIMARY KEY (AllocationId),
    CONSTRAINT fk_ra_student FOREIGN KEY (StudentId) REFERENCES student(StudentId),
    CONSTRAINT fk_ra_payment FOREIGN KEY (PaymentId) REFERENCES payment(PaymentId),
    CONSTRAINT fk_ra_admin FOREIGN KEY (AdminId) REFERENCES admin(AdminId),
    CONSTRAINT fk_ra_room FOREIGN KEY (RoomId) REFERENCES room(RoomId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------------------------------------
-- 2. DATA MANIPULATION LANGUAGE (DML) - SAMPLE DATA
-- ------------------------------------------------------------------------------

-- Insert Student Data
INSERT INTO student (StudentId, Name, Gender, Race, PhoneNumber, YearOfStudy, Faculty) VALUES
('D20231106001', 'AHMAD FAIZ BIN ROSLAN', 'Male', 'Malay', '011-1111111', 2, 'FKMT'),
('D20231106002', 'TAN WEI LING', 'Female', 'Chinese', '011-1111112', 1, 'FPE'),
('D20231106003', 'ARUN KUMAR A/L RAJ', 'Male', 'Indian', '011-1111113', 2, 'FKMT'),
('D20231106004', 'NURUL AIN BINTI ZAINAL', 'Female', 'Malay', '011-1111114', 4, 'FSK'),
('D20231106005', 'LIM KAI WEN', 'Male', 'Chinese', '011-1111115', 1, 'FBK');

-- Insert Admin Data
INSERT INTO admin (AdminId, Name, PhoneNumber, Email) VALUES
('A001', 'LEE WEI MING', '012-2222221', 'weiming.lee@hostel.com'),
('A002', 'MUHAMMAD HAZIQ BIN AZMI', '012-2222222', 'haziq.azmi@hostel.com'),
('A003', 'NORAINA BINTI ZAKARIA', '012-2222223', 'noraina@hostel.com'),
('A004', 'KAVITHA A/P SELVAN', '012-2222224', 'kavitha.s@hostel.com'),
('A005', 'SITI NUR BALQIS BINTI MOHD', '012-2222225', 'balqis.mohd@hostel.com');

-- Insert Payment Data
INSERT INTO payment (PaymentId, StudentId, AdminId, PaymentDate, Status, ProofOfPayment, Amount) VALUES
('P001', 'D20231106001', 'A001', '2025-06-01', 'Approved', 'proof_p001.jpg', 506.00),
('P002', 'D20231106002', 'A001', '2025-06-01', 'Approved', 'proof_p002.jpg', 506.00),
('P003', 'D20231106003', 'A001', '2025-06-01', 'Rejected', 'proof_p003.jpg', 506.00),
('P004', 'D20231106004', 'A003', '2025-06-01', 'Pending', 'proof_p004.jpg', 506.00),
('P005', 'D20231106005', 'A004', '2025-06-01', 'Pending', 'proof_p005.jpg', 506.00);

-- Insert Hostel Data
INSERT INTO hostel (HostelId, HostelName, Location, GenderAllow) VALUES
('H001', 'Kolej Khar', 'Jalan Khar 1', 'Male'),
('H002', 'Kolej Ksas', 'Jalan Ksas 1', 'Male'),
('H003', 'Kolej Kuo', 'Jalan Kuo 1', 'Male'),
('H004', 'Kolej Kab', 'Jalan Kab 1', 'Female'),
('H005', 'Kolej Ksjas', 'Jalan Ksjas 1', 'Female');

-- Insert Room Data
INSERT INTO room (RoomId, HostelId, RoomNumber, Capacity, RaceRestriction, Status) VALUES
('R001', 'H001', '001', 2, 'Chinese', 'Available'),
('R002', 'H001', '002', 2, 'Chinese', 'Available'),
('R003', 'H001', '101', 2, 'Malay', 'Available'),
('R004', 'H001', '102', 2, 'Indian', 'Available'),
('R005', 'H001', '201', 2, 'Malay', 'Available');

-- Insert Room Allocation Data
INSERT INTO roomallocation (AllocationId, StudentId, PaymentId, AdminId, RoomId, Status, SubmitDate) VALUES
('RA001', 'D20231106001', 'P001', 'A001', 'R001', 'PENDING', '2025-06-01'),
('RA002', 'D20231106002', 'P002', 'A001', 'R002', 'APPROVED', '2025-06-01'),
('RA003', 'D20231106003', 'P003', 'A002', 'R003', 'APPROVED', '2025-06-01'),
('RA004', 'D20231106004', 'P004', 'A003', 'R004', 'APPROVED', '2025-06-01'),
('RA005', 'D20231106005', 'P005', 'A004', 'R005', 'PENDING', '2025-06-01');

-- ------------------------------------------------------------------------------
-- 3. EXAMPLE QUERIES
-- ------------------------------------------------------------------------------

-- Basic Read
-- SELECT StudentId, Name, Faculty FROM student;

-- JOIN Payment with Student
-- SELECT payment.PaymentId, student.Name, payment.PaymentDate
-- FROM payment
-- INNER JOIN student ON payment.StudentId = student.StudentId;

-- Multi-Table JOIN (Payment, Student, Admin)
-- SELECT payment.PaymentId, student.Name, admin.Name
-- FROM payment
-- INNER JOIN student ON payment.StudentId = student.StudentId
-- INNER JOIN admin ON payment.AdminId = admin.AdminId;

-- Update record
-- UPDATE student SET Name = 'Test User', Gender = 'Male' WHERE StudentId = 'D20231106002';

-- Delete record
-- DELETE FROM student WHERE Name = 'Test User';

-- Sort
-- SELECT * FROM student ORDER BY Name ASC;
-- SELECT * FROM student ORDER BY Name DESC;

-- Group by
-- SELECT Gender, COUNT(StudentId) AS NumberOfStudents FROM student GROUP BY Gender;

-- Aggregate functions
-- SELECT MAX(YearOfStudy) AS LongestYearOfStudy FROM student;
-- SELECT MIN(YearOfStudy) AS ShortestYearOfStudy FROM student;
-- SELECT AVG(YearOfStudy) FROM student;

-- Filter with conditions
-- SELECT * FROM roomallocation WHERE AdminId = 'A001';
-- SELECT * FROM student WHERE YearOfStudy > 2;
-- SELECT * FROM student WHERE YearOfStudy BETWEEN 1 AND 3;
-- SELECT * FROM roomallocation WHERE AdminId = 'A001' AND Status = 'APPROVED';
-- SELECT * FROM roomallocation WHERE RoomId IN ('R001', 'R005');
-- SELECT * FROM student WHERE Name LIKE 'A%';
