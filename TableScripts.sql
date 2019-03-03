--drop tables
DROP TABLE dwaters_GPUS
DROP TABLE dwaters_CPUs
DROP TABLE dwaters_Disks
DROP TABLE dwaters_Manufacturers
DROP TABLE dwaters_Memories
DROP TABLE dwaters_Computers
DROP TABLE dwaters_ComputerModels
DROP TABLE dwaters_ComputerHistory
DROP TABLE dwaters_Employees
DROP TABLE dwaters_Departments
DROP TABLE dwaters_Supervisors

--create tables
CREATE TABLE [dbo].[dwaters_GPUs] (
	GPUID int NOT NULL,
	Name varchar(255) NOT NULL,
	ManufacturerID int NOT NULL,
	PRIMARY KEY (GPUID)
)

CREATE TABLE [dbo].[dwaters_Memories] (
	MemoryID int NOT NULL,
	Name varchar(255) NOT NULL,
	ManufacturerID int NOT NULL,
	SizeGB int NOT NULL,
	PRIMARY KEY (MemoryID)
)

CREATE TABLE [dbo].[dwaters_Disks] (
	DiskID int NOT NULL,
	Name varchar(255) NOT NULL,
	ManufacturerID int NOT NULL,
	SizeGB int NOT NULL,
	PRIMARY KEY (DiskID)
)


CREATE TABLE [dbo].[dwaters_CPUs] (
	CPUID int NOT NULL,
	Name varchar(255) NOT NULL,
	ManufacturerID int NOT NULL,
	PRIMARY KEY (CPUID)
)


CREATE TABLE [dbo].[dwaters_Manufacturers] (
	ManufacturerID int NOT NULL,
	Name varchar(255) NOT NULL,
	PRIMARY KEY (ManufacturerID)
)

CREATE TABLE [dbo].[dwaters_Computers] (
	ComputerID int NOT NULL,
	ModelID int NOT NULL,
	Availability bit NOT NULL,
	PurchaseDate date,
	PRIMARY KEY (ComputerID)
)

CREATE TABLE [dbo].[dwaters_ComputerModels] (
	ModelID int NOT NULL,
	Cost money,
	GPUID int NOT NULL,
	MemoryID int NOT NULL,
	DiskID int NOT NULL,
	CPUID int NOT NULL,
	Brand varchar(255) NOT NULL,
	isDesktop bit NOT NULL,
	PRIMARY KEY (ModelID)
)

CREATE TABLE [dbo].[dwaters_ComputerHistory] (
	HistoryID int NOT NULL,
	ComputerID int NOT NULL,
	EmployeeID int NOT NULL,
	givenDate date NOT NULL,
	takenBackDate date NULL,
	PRIMARY KEY (HistoryID)
)

CREATE TABLE [dbo].[dwaters_Employees] (
	EmployeeID int NOT NULL,
	firstName varchar(255) NOT NULL,
	lastName varchar(255) NOT NULL,
	emailAddress varchar(255) NOT NULL,
	hireDate date NOT NULL,
	terminationDate date NULL,
	isSupervisor bit NOT NULL,
	DepartmentID int NOT NULL,
	SupervisorID int NOT NULL,
	PRIMARY KEY (EmployeeID)
)

CREATE TABLE [dbo].[dwaters_Departments] (
	DepartmentID int NOT NULL,
	SupervisorID int NOT NULL,
	departmentName varchar(255) NOT NULL,
	PRIMARY KEY (DepartmentID)
)

CREATE TABLE [dbo].[dwaters_Supervisors] (
	SupervisorID int NOT NULL,
	EmployeeID int NOT NULL,
	PRIMARY KEY (SupervisorID)
)

--add foreign keys
ALTER TABLE dwaters_GPUs
ADD FOREIGN KEY (ManufacturerID) REFERENCES dwaters_Manufacturers(ManufacturerID)

ALTER TABLE dwaters_CPUs
ADD FOREIGN KEY (ManufacturerID) REFERENCES dwaters_Manufacturers(ManufacturerID)

ALTER TABLE dwaters_Memories
ADD FOREIGN KEY (ManufacturerID) REFERENCES dwaters_Manufacturers(ManufacturerID)

ALTER TABLE dwaters_Disks
ADD FOREIGN KEY (ManufacturerID) REFERENCES dwaters_Manufacturers(ManufacturerID)

ALTER TABLE dwaters_Computers
ADD FOREIGN KEY (ModelID) REFERENCES dwaters_ComputerModels(ModelID)

ALTER TABLE dwaters_ComputerModels
ADD FOREIGN KEY (GPUID) REFERENCES dwaters_GPUs(GPUID)
ALTER TABLE dwaters_ComputerModels
ADD FOREIGN KEY (MemoryID) REFERENCES dwaters_Memories(MemoryID)
ALTER TABLE dwaters_ComputerModels
ADD FOREIGN KEY (DiskID) REFERENCES dwaters_Disks(DiskID)
ALTER TABLE dwaters_ComputerModels
ADD FOREIGN KEY (CPUID) REFERENCES dwaters_CPUs(CPUID)

ALTER TABLE dwaters_ComputerHistory
ADD FOREIGN KEY (ComputerID) REFERENCES dwaters_Computers(ComputerID)
ALTER TABLE dwaters_ComputerHistory
ADD FOREIGN KEY (EmployeeID) REFERENCES dwaters_Employees(EmployeeID)

ALTER TABLE dwaters_Employees
ADD FOREIGN KEY (DepartmentID) REFERENCES dwaters_Departments(DepartmentID)
ALTER TABLE dwaters_Employees
ADD FOREIGN KEY (SupervisorID) REFERENCES dwaters_Supervisors(SupervisorID)

ALTER TABLE dwaters_Departments
ADD FOREIGN KEY (SupervisorID) REFERENCES dwaters_Supervisors(SupervisorID)

ALTER TABLE dwaters_Supervisors
ADD FOREIGN KEY (EmployeeID) REFERENCES dwaters_Employees(EmployeeID)