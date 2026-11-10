# Kolej Hostel Registration Database System

Database project for DTD3013 Database System.

## Project Description
A relational database system designed to manage university hostel registration, room assignments, and student payment records.

## Database Structure
The database `kolej_hostel_registration_system` contains 6 tables:
- `student`: Stores student records
- `admin`: Stores administrator and staff accounts
- `hostel`: Stores hostel building information
- `room`: Stores room capacity, restrictions, and availability
- `payment`: Stores student payment records and approval status
- `roomallocation`: Stores student room allocation applications and approvals

## Files Included
- `kolej_hostel_registration_system.sql`: SQL script containing DDL (table schema), DML (sample data), and sample queries
- `report.pdf`: Full project documentation and report

## How to Setup
1. Start Apache and MySQL in XAMPP.
2. Open phpMyAdmin at `http://localhost/phpmyadmin`.
3. Import `kolej_hostel_registration_system.sql`.
