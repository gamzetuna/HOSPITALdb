USE [HOSPITALS]
GO
/****** Object:  Table [dbo].[Prescriptions]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Prescriptions](
	[PrescriptionID] [int] IDENTITY(1,1) NOT NULL,
	[Patient_ID] [int] NULL,
	[PrescriptionsCode] [nvarchar](10) NULL,
	[PrescriptionDate] [date] NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[PrescriptionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Medicines]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Medicines](
	[MedicineID] [int] IDENTITY(1,1) NOT NULL,
	[MedicineName] [nvarchar](200) NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[MedicineID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PrescriptionDetails]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PrescriptionDetails](
	[Prescription_ID] [int] NOT NULL,
	[Medicine_ID] [int] NOT NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Prescription_ID] ASC,
	[Medicine_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fnc_PrescriptionDetail]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fnc_PrescriptionDetail]
(
	@PrescriptionsCode varchar(11)
)
returns table
as
return
(select m.MedicineName from PrescriptionDetails pd
JOIN Prescriptions p
on pd.Prescription_ID=p.PrescriptionID
JOIN Medicines m
on pd.Medicine_ID=m.MedicineID
where p.PrescriptionsCode=@PrescriptionsCode
group by p.PrescriptionID,p.Patient_ID,p.PrescriptionsCode,m.MedicineName)
GO
/****** Object:  Table [dbo].[Departments]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departments](
	[DepartmentID] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentName] [nvarchar](50) NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[DepartmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Doctors]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doctors](
	[DoctorID] [int] IDENTITY(1,1) NOT NULL,
	[HospitalID] [int] NULL,
	[DoctorTC] [nchar](11) NULL,
	[DoctorName] [nvarchar](50) NULL,
	[DoctorLastname] [nvarchar](50) NULL,
	[DoctorBirthDate] [date] NULL,
	[DoctorGender] [bit] NULL,
	[DoctorPhoneNumber] [nchar](13) NULL,
	[DoctorTitle] [nvarchar](50) NULL,
	[DoctorDepartment_ID] [int] NULL,
	[ReportsTo] [int] NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[DoctorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Patients]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Patients](
	[PatientID] [int] IDENTITY(1,1) NOT NULL,
	[PatientTC] [nchar](11) NULL,
	[PatientName] [nvarchar](50) NULL,
	[PatientLastname] [nvarchar](50) NULL,
	[PatientBirthDate] [date] NULL,
	[PatientGender] [bit] NULL,
	[PatientPhoneNumber] [nchar](13) NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[PatientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PatientRegistrations]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientRegistrations](
	[PatientRegistrationID] [int] IDENTITY(1,1) NOT NULL,
	[Patient_ID] [int] NULL,
	[Doctor_ID] [int] NULL,
	[AppointmentDate] [date] NULL,
	[AppointmentTime] [time](0) NULL,
	[PatientSymptoms] [nvarchar](150) NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[PatientRegistrationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inpatients]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inpatients](
	[InpatientID] [int] IDENTITY(1,1) NOT NULL,
	[Patient_ID] [int] NULL,
	[Nurse_ID] [int] NULL,
	[Room_ID] [int] NULL,
	[HospitalizationDate] [date] NULL,
	[DischargedDate] [date] NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[InpatientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fnc_TotalPatientsOfEachDepartmentInHospitals]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fnc_TotalPatientsOfEachDepartmentInHospitals]
(
	@HospitalID int
)
returns table
as
return(Select d.DepartmentName, COUNT(InpatientID) as TotalInpatients from Inpatients i
JOIN Patients p ON i.Patient_ID=p.PatientID
JOIN PatientRegistrations pr ON p.PatientID=pr.Patient_ID
JOIN Doctors dr ON pr.Doctor_ID=dr.DoctorID
JOIN Departments d ON dr.DoctorDepartment_ID=d.DepartmentID
where dr.HospitalID=@HospitalID
GROUP BY d.DepartmentName)
GO
/****** Object:  Table [dbo].[Rooms]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rooms](
	[RoomID] [int] IDENTITY(1,1) NOT NULL,
	[RoomNumber] [int] NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[RoomID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fnc_InpatientInformation]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fnc_InpatientInformation]
(
	@PatientTC varchar(11)
)
returns table
as
return
(select p.PatientTC,p.PatientName+' '+p.PatientLastname as [Patient Name],dp.DepartmentName as [Department Name],r.RoomNumber from Inpatients i
JOIN Patients p
on i.Patient_ID=p.PatientID
JOIN PatientRegistrations pr
on p.PatientID=pr.Patient_ID
JOIN Doctors d
on pr.Doctor_ID=d.DoctorID
JOIN Departments dp
on d.DoctorDepartment_ID=dp.DepartmentID
JOIN Rooms r
on r.RoomID=i.Room_ID
where i.Status=1 and p.PatientTC=@PatientTC
group by p.PatientTC,p.PatientName,p.PatientLastname,dp.DepartmentName,r.RoomNumber)
GO
/****** Object:  Table [dbo].[Hospitals]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Hospitals](
	[HospitalID] [int] IDENTITY(1,1) NOT NULL,
	[HospitalName] [nvarchar](50) NULL,
	[HospitalAdress] [nvarchar](200) NULL,
	[HospitalPhoneNumber] [nchar](13) NULL,
	[District_ID] [int] NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[HospitalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fnc_PatientRegistrationHistory]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fnc_PatientRegistrationHistory]
(
	@PatientTC varchar(13)
)
returns table
as
return
(select p.PatientTC,p.PatientName+' '+p.PatientLastname as [Patient Name],d.DoctorName+' '+d.DoctorLastname as [Doctor Name],
h.HospitalName,pr.PatientSymptoms,pr.AppointmentDate,pr.AppointmentTime from Patients p
JOIN PatientRegistrations pr
on p.PatientID=pr.Patient_ID
JOIN Doctors d
on pr.Doctor_ID=d.DoctorID
JOIN Hospitals h
on d.HospitalID=h.HospitalID
where p.PatientTC=@PatientTC
group by p.PatientName,p.PatientLastname,p.PatientTC,d.DoctorName,d.DoctorLastname,h.HospitalName,
pr.PatientSymptoms,pr.AppointmentDate,pr.AppointmentTime)
GO
/****** Object:  Table [dbo].[PatientExaminations]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientExaminations](
	[PatientExaminationID] [int] IDENTITY(1,1) NOT NULL,
	[PatientExaminationName] [nvarchar](50) NULL,
	[PatientExaminationUnitPrice] [decimal](14, 2) NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[PatientExaminationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ExaminationDetails]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExaminationDetails](
	[PatientRegistration_ID] [int] NOT NULL,
	[PatientExamination_ID] [int] NOT NULL,
	[PatientExaminationQuantity] [int] NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[PatientRegistration_ID] ASC,
	[PatientExamination_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_EarningsOfEachDoctorsInIzmirKonak]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_EarningsOfEachDoctorsInIzmirKonak]
as
(select d.DoctorName +' '+d.DoctorLastname as [Doctor Name],dpt.DepartmentName,h.HospitalName, SUM(pe.PatientExaminationUnitPrice*ed.PatientExaminationQuantity) as [Total Price] from Doctors d
LEFT JOIN PatientRegistrations pr
on d.DoctorID=pr.Doctor_ID
LEFT JOIN Hospitals h
on d.HospitalID=h.HospitalID
LEFT JOIN ExaminationDetails ed
on ed.PatientRegistration_ID=pr.PatientRegistrationID
LEFT JOIN PatientExaminations pe
on pe.PatientExaminationID=ed.PatientExamination_ID
LEFT JOIN Departments dpt
on d.DoctorDepartment_ID=dpt.DepartmentID
where h.HospitalID=3
group by d.DoctorName,d.DoctorLastname,h.HospitalName,dpt.DepartmentName)
GO
/****** Object:  View [dbo].[vw_EarningsOfEachDoctorsInAnkaraCankaya]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_EarningsOfEachDoctorsInAnkaraCankaya]
as
(select d.DoctorName +' '+d.DoctorLastname as [Doctor Name],dpt.DepartmentName,h.HospitalName, SUM(pe.PatientExaminationUnitPrice*ed.PatientExaminationQuantity) as [Total Price] from Doctors d
LEFT JOIN PatientRegistrations pr
on d.DoctorID=pr.Doctor_ID
LEFT JOIN Hospitals h
on d.HospitalID=h.HospitalID
LEFT JOIN ExaminationDetails ed
on ed.PatientRegistration_ID=pr.PatientRegistrationID
LEFT JOIN PatientExaminations pe
on pe.PatientExaminationID=ed.PatientExamination_ID
LEFT JOIN Departments dpt
on d.DoctorDepartment_ID=dpt.DepartmentID
where h.HospitalID=2
group by d.DoctorName,d.DoctorLastname,h.HospitalName,dpt.DepartmentName)	
GO
/****** Object:  View [dbo].[vw_EarningsOfEachDoctorsInIstanbulAtasehir]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_EarningsOfEachDoctorsInIstanbulAtasehir]
as
(select d.DoctorName +' '+d.DoctorLastname as [Doctor Name],dpt.DepartmentName,h.HospitalName, SUM(pe.PatientExaminationUnitPrice*ed.PatientExaminationQuantity) as [Total Price] from Doctors d
LEFT JOIN PatientRegistrations pr
on d.DoctorID=pr.Doctor_ID
LEFT JOIN Hospitals h
on d.HospitalID=h.HospitalID
LEFT JOIN ExaminationDetails ed
on ed.PatientRegistration_ID=pr.PatientRegistrationID
LEFT JOIN PatientExaminations pe
on pe.PatientExaminationID=ed.PatientExamination_ID
LEFT JOIN Departments dpt
on d.DoctorDepartment_ID=dpt.DepartmentID
where h.HospitalID=1
group by d.DoctorName,d.DoctorLastname,h.HospitalName,dpt.DepartmentName)	
GO
/****** Object:  View [dbo].[vw_PrescriptionDetails]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_PrescriptionDetails]
as 
select p.PrescriptionsCode,m.MedicineName from Prescriptions p
JOIN  PrescriptionDetails pd
on p.PrescriptionID=pd.Prescription_ID
JOIN  Medicines m
on m.MedicineID=pd.Medicine_ID
group by p.PrescriptionsCode,m.MedicineName
GO
/****** Object:  View [dbo].[vw_Prescriptions]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_Prescriptions]
as
select p.PatientName+' '+p.PatientLastname as [Patient Name],d.DoctorName+' '+d.DoctorLastname as [Doctor Name],ps.PrescriptionsCode,pr.AppointmentDate from PatientRegistrations pr
JOIN Doctors d
on pr.Doctor_ID=d.DoctorID
JOIN Patients p
on pr.Patient_ID=p.PatientID
JOIN Prescriptions ps
on p.PatientID=ps.Patient_ID
group by ps.PrescriptionsCode,p.PatientName,p.PatientLastname,d.DoctorName,d.DoctorLastname,pr.AppointmentDate
GO
/****** Object:  View [dbo].[vw_TotalPatientsOfDoctorsInHospitals]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_TotalPatientsOfDoctorsInHospitals]
as
(select d.DoctorID,d.DoctorName +' '+d.DoctorLastname as [Doctor Name],h.HospitalName, COUNT(PR.Patient_ID) as [Total Patients] from Doctors d
left join PatientRegistrations pr
on d.DoctorID=pr.Doctor_ID
join Hospitals h
on d.HospitalID=h.HospitalID
group by d.DoctorID,d.DoctorName,d.DoctorLastname,h.HospitalName)
GO
/****** Object:  View [dbo].[vw_WhichHospitalPatient]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[vw_WhichHospitalPatient]
AS
(
Select h.HospitalName,count(distinct p.PatientID) as [Total Number of Patients] from Patients p
JOIN PatientRegistrations pr ON p.PatientID=pr.Patient_ID
JOIN Doctors dr ON pr.Doctor_ID=dr.DoctorID
JOIN Hospitals h ON dr.HospitalID=h.HospitalID
Group by h.HospitalName
)
GO
/****** Object:  View [dbo].[vw_WhichHospitalWhichDepartman]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_WhichHospitalWhichDepartman]
AS
(
Select d.DepartmentName,count(distinct p.PatientID) as [Total Number of Patients] from Patients p
JOIN PatientRegistrations pr ON p.PatientID=pr.Patient_ID
JOIN Doctors dr ON pr.Doctor_ID=dr.DoctorID
JOIN Hospitals h ON dr.HospitalID=h.HospitalID
JOIN Departments d on dr.DoctorDepartment_ID=d.DepartmentID
where h.HospitalID=1
group by d.DepartmentName
)
GO
/****** Object:  View [dbo].[vw_RoomInfo]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_RoomInfo] 
AS
(
SELECT r.RoomID,p.PatientName+' '+p.PatientLastname as PatientName FROM Rooms r
left join Inpatients i
on r.RoomID=i.Room_ID
left join Patients p
on i.Patient_ID=p.PatientID
--where i.Status=1
group by r.RoomID,p.PatientName,p.PatientLastname
)
GO
/****** Object:  View [dbo].[vw_RoomEmpty]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_RoomEmpty]
AS
(
SELECT r.RoomID,p.PatientName+' '+p.PatientLastname as PatientName FROM Rooms r
left join Inpatients i
on r.RoomID=i.Room_ID
left join Patients p
on i.Patient_ID=p.PatientID
where PatientName is null
group by r.RoomID,p.PatientName,p.PatientLastname
)
GO
/****** Object:  View [dbo].[vw_HastaneGiro]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_HastaneGiro]
As(
Select  h.HospitalName, SUM(pe.PatientExaminationUnitPrice*ed.PatientExaminationQuantity) AS [Toplam Ciro]from ExaminationDetails ed
JOIN PatientRegistrations p    ON ed.PatientRegistration_ID = p.PatientRegistrationID
JOIN Doctors d			ON p.Doctor_ID = d.DoctorID
JOIN Hospitals  h ON d.HospitalID= h.HospitalID
JOIN PatientExaminations pe    ON pe.PatientExaminationID =ed.PatientExamination_ID
--where h.HospitalID= 2
GROUP BY h.HospitalName
)
GO
/****** Object:  View [dbo].[vw_WhichDoktorDepartment]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_WhichDoktorDepartment]
AS
(
Select D.DepartmentID,D.DepartmentName , Count (DC.DoctorDepartment_ID) AS [Number of Doctors Working] from Doctors DC 
JOIN Departments D
ON DC.DoctorDepartment_ID=D.DepartmentID
Group BY D.DepartmentID,D.DepartmentName
)
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[EmployeeID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeName] [nvarchar](50) NULL,
	[EmployeeLastname] [nvarchar](50) NULL,
	[Hospital_ID] [int] NULL,
	[EmployeeBirthdate] [date] NULL,
	[EmployeeAdress] [nvarchar](200) NULL,
	[EmployeeGender] [bit] NULL,
	[EmployeePhoneNumber] [nchar](13) NULL,
	[EmployeeDuty] [nvarchar](50) NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_EmployeesAge]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[vw_EmployeesAge] 
AS
(
select e.EmployeeName,e.EmployeeLastname,h.HospitalName,DATEDIFF(YEAR,e.EmployeeBirthdate,GETDATE()) as [Employee Age] from Employees e 
JOIN Hospitals h
ON e.Hospital_ID = h.HospitalID
)
GO
/****** Object:  View [dbo].[vw_DoctorAge]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[vw_DoctorAge] 
AS
(
select d.DoctorName,d.DoctorLastname,h.HospitalName,DATEDIFF(YEAR,d.DoctorBirthDate,GETDATE()) as [Doctor Age] from Doctors d
JOIN Hospitals h
ON d.HospitalID= h.HospitalID
)
GO
/****** Object:  View [dbo].[vw_PatientsAge]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[vw_PatientsAge]
AS
(
select PatientID, PatientName +' '+ PatientLastname AS [Patient Full Name],DATEDIFF(YEAR,PatientBirthDate,GETDATE()) as [Patient Age] from Patients
)
GO
/****** Object:  View [dbo].[vw_HospitalInPatient]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[vw_HospitalInPatient]
AS
(
Select h.HospitalName,i.Patient_ID,p.PatientName+' '+p.PatientLastname AS [Patient Full Name ] from  Inpatients i
JOIN Patients p ON i.Patient_ID=p.PatientID
JOIN PatientRegistrations pr ON  pr.Patient_ID=p.PatientID
JOIN Doctors dr ON pr.Doctor_ID=dr.DoctorID
JOIN Hospitals h ON dr.HospitalID=h.HospitalID
where h.HospitalID=1
Group by i.Patient_ID,p.PatientName,p.PatientLastname,h.HospitalName
)
GO
/****** Object:  Table [dbo].[Nurses]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Nurses](
	[NurseID] [int] IDENTITY(1,1) NOT NULL,
	[Hospital_ID] [int] NULL,
	[NurseName] [nvarchar](50) NULL,
	[NurseLastname] [nvarchar](50) NULL,
	[NurseBirthdate] [date] NULL,
	[NurseAdress] [nvarchar](200) NULL,
	[NurseGender] [bit] NULL,
	[NursePhoneNumber] [nchar](13) NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[NurseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_HospitalNurses]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[vw_HospitalNurses]
AS
(
Select n.NurseID,h.HospitalName,n.NurseName+' '+n.NurseLastname AS [Nurse Full Name] from Hospitals h 
JOIN Doctors dr ON h.HospitalID=dr.HospitalID
JOIN PatientRegistrations pr ON dr.DoctorID=pr.Doctor_ID
JOIN Patients p ON pr.Patient_ID=p.PatientID
JOIN Inpatients i ON p.PatientID=i.Patient_ID
RIGHT JOIN  Nurses n ON i.Nurse_ID=n.NurseID
Where H.HospitalID=2
Group by h.HospitalName,n.NurseName,n.NurseLastname,n.NurseID
)
GO
/****** Object:  Table [dbo].[Cities]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cities](
	[CityID] [int] IDENTITY(1,1) NOT NULL,
	[CityName] [nvarchar](50) NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[CityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DepartmentDetails]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DepartmentDetails](
	[Hospital_ID] [int] NOT NULL,
	[Department_ID] [int] NOT NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Hospital_ID] ASC,
	[Department_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Districts]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Districts](
	[DistrictID] [int] IDENTITY(1,1) NOT NULL,
	[DistrictName] [nvarchar](50) NULL,
	[City_ID] [int] NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[DistrictID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Cities] ON 

INSERT [dbo].[Cities] ([CityID], [CityName], [Status]) VALUES (1, N'İstanbul', 1)
INSERT [dbo].[Cities] ([CityID], [CityName], [Status]) VALUES (2, N'Ankara', 1)
INSERT [dbo].[Cities] ([CityID], [CityName], [Status]) VALUES (3, N'İzmir', 1)
SET IDENTITY_INSERT [dbo].[Cities] OFF
GO
INSERT [dbo].[DepartmentDetails] ([Hospital_ID], [Department_ID], [Status]) VALUES (1, 1, 1)
INSERT [dbo].[DepartmentDetails] ([Hospital_ID], [Department_ID], [Status]) VALUES (1, 2, 1)
INSERT [dbo].[DepartmentDetails] ([Hospital_ID], [Department_ID], [Status]) VALUES (1, 3, 1)
INSERT [dbo].[DepartmentDetails] ([Hospital_ID], [Department_ID], [Status]) VALUES (1, 4, 1)
INSERT [dbo].[DepartmentDetails] ([Hospital_ID], [Department_ID], [Status]) VALUES (1, 5, 1)
INSERT [dbo].[DepartmentDetails] ([Hospital_ID], [Department_ID], [Status]) VALUES (1, 6, 1)
INSERT [dbo].[DepartmentDetails] ([Hospital_ID], [Department_ID], [Status]) VALUES (1, 7, 1)
INSERT [dbo].[DepartmentDetails] ([Hospital_ID], [Department_ID], [Status]) VALUES (1, 8, 1)
INSERT [dbo].[DepartmentDetails] ([Hospital_ID], [Department_ID], [Status]) VALUES (1, 9, 1)
INSERT [dbo].[DepartmentDetails] ([Hospital_ID], [Department_ID], [Status]) VALUES (1, 10, 1)
INSERT [dbo].[DepartmentDetails] ([Hospital_ID], [Department_ID], [Status]) VALUES (1, 11, 1)
INSERT [dbo].[DepartmentDetails] ([Hospital_ID], [Department_ID], [Status]) VALUES (1, 12, 1)
INSERT [dbo].[DepartmentDetails] ([Hospital_ID], [Department_ID], [Status]) VALUES (2, 1, 1)
INSERT [dbo].[DepartmentDetails] ([Hospital_ID], [Department_ID], [Status]) VALUES (2, 2, 1)
INSERT [dbo].[DepartmentDetails] ([Hospital_ID], [Department_ID], [Status]) VALUES (2, 3, 1)
INSERT [dbo].[DepartmentDetails] ([Hospital_ID], [Department_ID], [Status]) VALUES (2, 4, 1)
INSERT [dbo].[DepartmentDetails] ([Hospital_ID], [Department_ID], [Status]) VALUES (2, 5, 1)
INSERT [dbo].[DepartmentDetails] ([Hospital_ID], [Department_ID], [Status]) VALUES (2, 6, 1)
INSERT [dbo].[DepartmentDetails] ([Hospital_ID], [Department_ID], [Status]) VALUES (2, 7, 1)
INSERT [dbo].[DepartmentDetails] ([Hospital_ID], [Department_ID], [Status]) VALUES (2, 8, 1)
INSERT [dbo].[DepartmentDetails] ([Hospital_ID], [Department_ID], [Status]) VALUES (2, 9, 1)
INSERT [dbo].[DepartmentDetails] ([Hospital_ID], [Department_ID], [Status]) VALUES (2, 10, 1)
INSERT [dbo].[DepartmentDetails] ([Hospital_ID], [Department_ID], [Status]) VALUES (2, 11, 1)
INSERT [dbo].[DepartmentDetails] ([Hospital_ID], [Department_ID], [Status]) VALUES (2, 12, 1)
INSERT [dbo].[DepartmentDetails] ([Hospital_ID], [Department_ID], [Status]) VALUES (2, 13, 1)
INSERT [dbo].[DepartmentDetails] ([Hospital_ID], [Department_ID], [Status]) VALUES (3, 1, 1)
INSERT [dbo].[DepartmentDetails] ([Hospital_ID], [Department_ID], [Status]) VALUES (3, 2, 1)
INSERT [dbo].[DepartmentDetails] ([Hospital_ID], [Department_ID], [Status]) VALUES (3, 3, 1)
INSERT [dbo].[DepartmentDetails] ([Hospital_ID], [Department_ID], [Status]) VALUES (3, 4, 1)
INSERT [dbo].[DepartmentDetails] ([Hospital_ID], [Department_ID], [Status]) VALUES (3, 5, 1)
INSERT [dbo].[DepartmentDetails] ([Hospital_ID], [Department_ID], [Status]) VALUES (3, 6, 1)
INSERT [dbo].[DepartmentDetails] ([Hospital_ID], [Department_ID], [Status]) VALUES (3, 7, 1)
INSERT [dbo].[DepartmentDetails] ([Hospital_ID], [Department_ID], [Status]) VALUES (3, 8, 1)
INSERT [dbo].[DepartmentDetails] ([Hospital_ID], [Department_ID], [Status]) VALUES (3, 9, 1)
INSERT [dbo].[DepartmentDetails] ([Hospital_ID], [Department_ID], [Status]) VALUES (3, 10, 1)
INSERT [dbo].[DepartmentDetails] ([Hospital_ID], [Department_ID], [Status]) VALUES (3, 11, 1)
INSERT [dbo].[DepartmentDetails] ([Hospital_ID], [Department_ID], [Status]) VALUES (3, 12, 1)
INSERT [dbo].[DepartmentDetails] ([Hospital_ID], [Department_ID], [Status]) VALUES (3, 13, 1)
INSERT [dbo].[DepartmentDetails] ([Hospital_ID], [Department_ID], [Status]) VALUES (3, 14, 1)
INSERT [dbo].[DepartmentDetails] ([Hospital_ID], [Department_ID], [Status]) VALUES (3, 15, 1)
GO
SET IDENTITY_INSERT [dbo].[Departments] ON 

INSERT [dbo].[Departments] ([DepartmentID], [DepartmentName], [Status]) VALUES (1, N'Ağız,Diş ve Çene Cerrahisi', 1)
INSERT [dbo].[Departments] ([DepartmentID], [DepartmentName], [Status]) VALUES (2, N'Beyin ve Sinir Cerrahisi', 1)
INSERT [dbo].[Departments] ([DepartmentID], [DepartmentName], [Status]) VALUES (3, N'Deri ve Zührevi Hastalıkları (Cildiye)', 1)
INSERT [dbo].[Departments] ([DepartmentID], [DepartmentName], [Status]) VALUES (4, N'Diş Hekimliği (Genel Diş)', 1)
INSERT [dbo].[Departments] ([DepartmentID], [DepartmentName], [Status]) VALUES (5, N'Gastroenteroloji', 1)
INSERT [dbo].[Departments] ([DepartmentID], [DepartmentName], [Status]) VALUES (6, N'Göğüs Hastalıkları', 1)
INSERT [dbo].[Departments] ([DepartmentID], [DepartmentName], [Status]) VALUES (7, N'Göz Hastalıkları', 1)
INSERT [dbo].[Departments] ([DepartmentID], [DepartmentName], [Status]) VALUES (8, N'İç Hastalıkları (Dahiliye)', 1)
INSERT [dbo].[Departments] ([DepartmentID], [DepartmentName], [Status]) VALUES (9, N'Kardiyoloji', 1)
INSERT [dbo].[Departments] ([DepartmentID], [DepartmentName], [Status]) VALUES (10, N'Kulak Burun Boğaz Hastalıkları', 1)
INSERT [dbo].[Departments] ([DepartmentID], [DepartmentName], [Status]) VALUES (11, N'Nöroloji', 1)
INSERT [dbo].[Departments] ([DepartmentID], [DepartmentName], [Status]) VALUES (12, N'Ortopedi ve Travmatoloji', 1)
INSERT [dbo].[Departments] ([DepartmentID], [DepartmentName], [Status]) VALUES (13, N'Plastik, Rekonstrüktif ve Estetik Cerrahi', 1)
INSERT [dbo].[Departments] ([DepartmentID], [DepartmentName], [Status]) VALUES (14, N'Ruh Sağlığı ve Hastalıkları (Psikiyatri)', 1)
INSERT [dbo].[Departments] ([DepartmentID], [DepartmentName], [Status]) VALUES (15, N'Üroloji', 1)
SET IDENTITY_INSERT [dbo].[Departments] OFF
GO
SET IDENTITY_INSERT [dbo].[Districts] ON 

INSERT [dbo].[Districts] ([DistrictID], [DistrictName], [City_ID], [Status]) VALUES (1, N'Ataşehir', 1, 1)
INSERT [dbo].[Districts] ([DistrictID], [DistrictName], [City_ID], [Status]) VALUES (2, N'Kadıköy', 1, 1)
INSERT [dbo].[Districts] ([DistrictID], [DistrictName], [City_ID], [Status]) VALUES (3, N'Kartal', 1, 1)
INSERT [dbo].[Districts] ([DistrictID], [DistrictName], [City_ID], [Status]) VALUES (4, N'Maltepe', 1, 1)
INSERT [dbo].[Districts] ([DistrictID], [DistrictName], [City_ID], [Status]) VALUES (5, N'Pendik', 1, 1)
INSERT [dbo].[Districts] ([DistrictID], [DistrictName], [City_ID], [Status]) VALUES (6, N'Beypazarı', 2, 1)
INSERT [dbo].[Districts] ([DistrictID], [DistrictName], [City_ID], [Status]) VALUES (7, N'Çankaya', 2, 1)
INSERT [dbo].[Districts] ([DistrictID], [DistrictName], [City_ID], [Status]) VALUES (8, N'Kızılcahamam', 2, 1)
INSERT [dbo].[Districts] ([DistrictID], [DistrictName], [City_ID], [Status]) VALUES (9, N'Mamak', 2, 1)
INSERT [dbo].[Districts] ([DistrictID], [DistrictName], [City_ID], [Status]) VALUES (10, N'Polatlı', 2, 1)
INSERT [dbo].[Districts] ([DistrictID], [DistrictName], [City_ID], [Status]) VALUES (11, N'Çeşme', 3, 1)
INSERT [dbo].[Districts] ([DistrictID], [DistrictName], [City_ID], [Status]) VALUES (12, N'Foça', 3, 1)
INSERT [dbo].[Districts] ([DistrictID], [DistrictName], [City_ID], [Status]) VALUES (13, N'Konak', 3, 1)
INSERT [dbo].[Districts] ([DistrictID], [DistrictName], [City_ID], [Status]) VALUES (14, N'Seferihisar', 3, 1)
INSERT [dbo].[Districts] ([DistrictID], [DistrictName], [City_ID], [Status]) VALUES (15, N'Urla', 3, 1)
SET IDENTITY_INSERT [dbo].[Districts] OFF
GO
SET IDENTITY_INSERT [dbo].[Doctors] ON 

INSERT [dbo].[Doctors] ([DoctorID], [HospitalID], [DoctorTC], [DoctorName], [DoctorLastname], [DoctorBirthDate], [DoctorGender], [DoctorPhoneNumber], [DoctorTitle], [DoctorDepartment_ID], [ReportsTo], [Status]) VALUES (1, 1, N'34678068159', N'Ali', N'Köse', CAST(N'1984-09-02' AS Date), 0, N'+905363772577', N'Operatör Doktor', 1, NULL, 1)
INSERT [dbo].[Doctors] ([DoctorID], [HospitalID], [DoctorTC], [DoctorName], [DoctorLastname], [DoctorBirthDate], [DoctorGender], [DoctorPhoneNumber], [DoctorTitle], [DoctorDepartment_ID], [ReportsTo], [Status]) VALUES (2, 1, N'99653068159', N'Mehmet', N'Karahanlı', CAST(N'1995-09-02' AS Date), 0, N'+905369871577', N'Pratisyen Doktor', 1, 1, 1)
INSERT [dbo].[Doctors] ([DoctorID], [HospitalID], [DoctorTC], [DoctorName], [DoctorLastname], [DoctorBirthDate], [DoctorGender], [DoctorPhoneNumber], [DoctorTitle], [DoctorDepartment_ID], [ReportsTo], [Status]) VALUES (3, 1, N'34635018159', N'Ali', N'Candan', CAST(N'1972-09-02' AS Date), 0, N'+905369882577', N'Doçent Doktor', 2, NULL, 1)
INSERT [dbo].[Doctors] ([DoctorID], [HospitalID], [DoctorTC], [DoctorName], [DoctorLastname], [DoctorBirthDate], [DoctorGender], [DoctorPhoneNumber], [DoctorTitle], [DoctorDepartment_ID], [ReportsTo], [Status]) VALUES (4, 1, N'51578068159', N'Evrim', N'Kocakurt', CAST(N'1982-09-02' AS Date), 0, N'+905361672577', N'Operatör Doktor', 2, 3, 1)
INSERT [dbo].[Doctors] ([DoctorID], [HospitalID], [DoctorTC], [DoctorName], [DoctorLastname], [DoctorBirthDate], [DoctorGender], [DoctorPhoneNumber], [DoctorTitle], [DoctorDepartment_ID], [ReportsTo], [Status]) VALUES (5, 1, N'93478068159', N'Ali', N'Karakuş', CAST(N'1990-09-02' AS Date), 0, N'+905364282577', N'Pratisyen Doktor', 2, 4, 1)
INSERT [dbo].[Doctors] ([DoctorID], [HospitalID], [DoctorTC], [DoctorName], [DoctorLastname], [DoctorBirthDate], [DoctorGender], [DoctorPhoneNumber], [DoctorTitle], [DoctorDepartment_ID], [ReportsTo], [Status]) VALUES (6, 1, N'34567890123', N'Bayram', N'Kızıl', CAST(N'1973-10-01' AS Date), 1, N'+905567890123', N'Operatör Doktor', 3, NULL, 1)
INSERT [dbo].[Doctors] ([DoctorID], [HospitalID], [DoctorTC], [DoctorName], [DoctorLastname], [DoctorBirthDate], [DoctorGender], [DoctorPhoneNumber], [DoctorTitle], [DoctorDepartment_ID], [ReportsTo], [Status]) VALUES (7, 1, N'11578068159', N'Feriha', N'Mutlu', CAST(N'1984-09-02' AS Date), 0, N'+905367182577', N'Uzman Doktor', 3, 6, 1)
INSERT [dbo].[Doctors] ([DoctorID], [HospitalID], [DoctorTC], [DoctorName], [DoctorLastname], [DoctorBirthDate], [DoctorGender], [DoctorPhoneNumber], [DoctorTitle], [DoctorDepartment_ID], [ReportsTo], [Status]) VALUES (8, 1, N'61278068159', N'Mehmet', N'Bayram', CAST(N'1984-09-02' AS Date), 0, N'+905368742577', N'Yardımcı Doçent', 4, NULL, 1)
INSERT [dbo].[Doctors] ([DoctorID], [HospitalID], [DoctorTC], [DoctorName], [DoctorLastname], [DoctorBirthDate], [DoctorGender], [DoctorPhoneNumber], [DoctorTitle], [DoctorDepartment_ID], [ReportsTo], [Status]) VALUES (9, 1, N'49131245673', N'Güneş', N'Ay', CAST(N'1981-09-14' AS Date), 1, N'+905131245673', N'Operatör Doktor', 5, NULL, 1)
INSERT [dbo].[Doctors] ([DoctorID], [HospitalID], [DoctorTC], [DoctorName], [DoctorLastname], [DoctorBirthDate], [DoctorGender], [DoctorPhoneNumber], [DoctorTitle], [DoctorDepartment_ID], [ReportsTo], [Status]) VALUES (10, 1, N'84378068159', N'Furkan', N'Köse', CAST(N'1984-05-22' AS Date), 0, N'+905361532577', N'Operatör Doktor', 6, NULL, 1)
INSERT [dbo].[Doctors] ([DoctorID], [HospitalID], [DoctorTC], [DoctorName], [DoctorLastname], [DoctorBirthDate], [DoctorGender], [DoctorPhoneNumber], [DoctorTitle], [DoctorDepartment_ID], [ReportsTo], [Status]) VALUES (11, 1, N'19278068159', N'Burhan', N'Altıntop', CAST(N'1981-09-02' AS Date), 0, N'+905361162577', N'Yardımcı Doçent', 7, NULL, 1)
INSERT [dbo].[Doctors] ([DoctorID], [HospitalID], [DoctorTC], [DoctorName], [DoctorLastname], [DoctorBirthDate], [DoctorGender], [DoctorPhoneNumber], [DoctorTitle], [DoctorDepartment_ID], [ReportsTo], [Status]) VALUES (12, 1, N'98778068159', N'Seda', N'Sayan', CAST(N'1964-09-02' AS Date), 0, N'+905361132977', N'Operatör Doktor', 8, NULL, 1)
INSERT [dbo].[Doctors] ([DoctorID], [HospitalID], [DoctorTC], [DoctorName], [DoctorLastname], [DoctorBirthDate], [DoctorGender], [DoctorPhoneNumber], [DoctorTitle], [DoctorDepartment_ID], [ReportsTo], [Status]) VALUES (13, 1, N'84371268159', N'Cengiz', N'Kurtoğlu', CAST(N'1956-08-02' AS Date), 0, N'+905361232577', N'Doçent Doktor', 9, NULL, 1)
INSERT [dbo].[Doctors] ([DoctorID], [HospitalID], [DoctorTC], [DoctorName], [DoctorLastname], [DoctorBirthDate], [DoctorGender], [DoctorPhoneNumber], [DoctorTitle], [DoctorDepartment_ID], [ReportsTo], [Status]) VALUES (14, 1, N'84321768159', N'İbrahim', N'Tatlıses', CAST(N'1960-03-01' AS Date), 0, N'+905361132587', N'Operatör Doktor', 10, NULL, 1)
INSERT [dbo].[Doctors] ([DoctorID], [HospitalID], [DoctorTC], [DoctorName], [DoctorLastname], [DoctorBirthDate], [DoctorGender], [DoctorPhoneNumber], [DoctorTitle], [DoctorDepartment_ID], [ReportsTo], [Status]) VALUES (15, 1, N'12378768159', N'Taha', N'Duymaz', CAST(N'1984-07-10' AS Date), 0, N'+905361132599', N'Operatör Doktor', 11, NULL, 1)
INSERT [dbo].[Doctors] ([DoctorID], [HospitalID], [DoctorTC], [DoctorName], [DoctorLastname], [DoctorBirthDate], [DoctorGender], [DoctorPhoneNumber], [DoctorTitle], [DoctorDepartment_ID], [ReportsTo], [Status]) VALUES (16, 1, N'84928061359', N'Recep', N'Köseoğlu', CAST(N'1972-09-02' AS Date), 0, N'+905361232537', N'Operatör Doktor', 12, NULL, 1)
INSERT [dbo].[Doctors] ([DoctorID], [HospitalID], [DoctorTC], [DoctorName], [DoctorLastname], [DoctorBirthDate], [DoctorGender], [DoctorPhoneNumber], [DoctorTitle], [DoctorDepartment_ID], [ReportsTo], [Status]) VALUES (17, 1, N'81378068159', N'Suzan', N'Gündeş', CAST(N'1984-11-07' AS Date), 0, N'+905361132577', N'Operatör Doktor', 13, NULL, 1)
INSERT [dbo].[Doctors] ([DoctorID], [HospitalID], [DoctorTC], [DoctorName], [DoctorLastname], [DoctorBirthDate], [DoctorGender], [DoctorPhoneNumber], [DoctorTitle], [DoctorDepartment_ID], [ReportsTo], [Status]) VALUES (18, 2, N'44378068159', N'Bayram', N'Duran', CAST(N'1984-09-02' AS Date), 0, N'+905361132577', N'Operatör Doktor', 14, NULL, 1)
INSERT [dbo].[Doctors] ([DoctorID], [HospitalID], [DoctorTC], [DoctorName], [DoctorLastname], [DoctorBirthDate], [DoctorGender], [DoctorPhoneNumber], [DoctorTitle], [DoctorDepartment_ID], [ReportsTo], [Status]) VALUES (19, 2, N'57479068159', N'Abuzer', N'Kömürcü', CAST(N'1984-09-02' AS Date), 0, N'+905361132577', N'Operatör Doktor', 15, NULL, 1)
INSERT [dbo].[Doctors] ([DoctorID], [HospitalID], [DoctorTC], [DoctorName], [DoctorLastname], [DoctorBirthDate], [DoctorGender], [DoctorPhoneNumber], [DoctorTitle], [DoctorDepartment_ID], [ReportsTo], [Status]) VALUES (20, 2, N'87546129873', N'Özge', N'Özenli', CAST(N'1995-01-02' AS Date), 1, N'+905365784577', N'Pratisyen Doktor', 8, NULL, 1)
INSERT [dbo].[Doctors] ([DoctorID], [HospitalID], [DoctorTC], [DoctorName], [DoctorLastname], [DoctorBirthDate], [DoctorGender], [DoctorPhoneNumber], [DoctorTitle], [DoctorDepartment_ID], [ReportsTo], [Status]) VALUES (21, 2, N'21548159874', N'Büşra', N'Mutlu', CAST(N'1987-07-08' AS Date), 1, N'+905378967187', N'Uzman Doktor', 5, NULL, 1)
INSERT [dbo].[Doctors] ([DoctorID], [HospitalID], [DoctorTC], [DoctorName], [DoctorLastname], [DoctorBirthDate], [DoctorGender], [DoctorPhoneNumber], [DoctorTitle], [DoctorDepartment_ID], [ReportsTo], [Status]) VALUES (22, 2, N'27584691526', N'Yasin', N'Karanlı', CAST(N'1992-09-09' AS Date), 0, N'+905373248745', N'Operatör Doktor', 8, NULL, 1)
INSERT [dbo].[Doctors] ([DoctorID], [HospitalID], [DoctorTC], [DoctorName], [DoctorLastname], [DoctorBirthDate], [DoctorGender], [DoctorPhoneNumber], [DoctorTitle], [DoctorDepartment_ID], [ReportsTo], [Status]) VALUES (23, 3, N'21548159879', N'Hande', N'Neşeli', CAST(N'1989-01-02' AS Date), 1, N'+905378942577', N'Doçent Doktor', 8, NULL, 1)
INSERT [dbo].[Doctors] ([DoctorID], [HospitalID], [DoctorTC], [DoctorName], [DoctorLastname], [DoctorBirthDate], [DoctorGender], [DoctorPhoneNumber], [DoctorTitle], [DoctorDepartment_ID], [ReportsTo], [Status]) VALUES (24, 3, N'68754659879', N'Elif', N'Atalar', CAST(N'1982-05-02' AS Date), 1, N'+905387242577', N'Pratisyen Doktor', 4, NULL, 1)
INSERT [dbo].[Doctors] ([DoctorID], [HospitalID], [DoctorTC], [DoctorName], [DoctorLastname], [DoctorBirthDate], [DoctorGender], [DoctorPhoneNumber], [DoctorTitle], [DoctorDepartment_ID], [ReportsTo], [Status]) VALUES (25, 3, N'74125159879', N'Seval', N'Sevinçli', CAST(N'1992-01-12' AS Date), 1, N'+905358949517', N'Operatör Doktor', 7, NULL, 1)
INSERT [dbo].[Doctors] ([DoctorID], [HospitalID], [DoctorTC], [DoctorName], [DoctorLastname], [DoctorBirthDate], [DoctorGender], [DoctorPhoneNumber], [DoctorTitle], [DoctorDepartment_ID], [ReportsTo], [Status]) VALUES (26, 3, N'24569898797', N'İsmail', N'Güven', CAST(N'1979-08-02' AS Date), 0, N'+905342842567', N'Doçent Doktor', 3, NULL, 1)
INSERT [dbo].[Doctors] ([DoctorID], [HospitalID], [DoctorTC], [DoctorName], [DoctorLastname], [DoctorBirthDate], [DoctorGender], [DoctorPhoneNumber], [DoctorTitle], [DoctorDepartment_ID], [ReportsTo], [Status]) VALUES (27, 3, N'21548159856', N'Ümit', N'Ateş', CAST(N'1985-12-12' AS Date), 0, N'+905365742154', N'Operatör Doktor', 12, NULL, 1)
SET IDENTITY_INSERT [dbo].[Doctors] OFF
GO
SET IDENTITY_INSERT [dbo].[Employees] ON 

INSERT [dbo].[Employees] ([EmployeeID], [EmployeeName], [EmployeeLastname], [Hospital_ID], [EmployeeBirthdate], [EmployeeAdress], [EmployeeGender], [EmployeePhoneNumber], [EmployeeDuty], [Status]) VALUES (1, N'Zeynep', N'Yılmaz', 1, CAST(N'1984-02-01' AS Date), N'Şerifali Cd., Küçükbakkalköy, 34750 Ataşehir/İstanbul', 1, N'+905395393939', N'Temizlik Personeli', 1)
INSERT [dbo].[Employees] ([EmployeeID], [EmployeeName], [EmployeeLastname], [Hospital_ID], [EmployeeBirthdate], [EmployeeAdress], [EmployeeGender], [EmployeePhoneNumber], [EmployeeDuty], [Status]) VALUES (2, N'Yusuf', N'Kaya', 1, CAST(N'1989-01-02' AS Date), N'Kırmızı Kuşak Sk. 12-28, Rasimpaşa, 34716 Kadıköy/İstanbul', 0, N'+905305303030', N'Sekreter', 1)
INSERT [dbo].[Employees] ([EmployeeID], [EmployeeName], [EmployeeLastname], [Hospital_ID], [EmployeeBirthdate], [EmployeeAdress], [EmployeeGender], [EmployeePhoneNumber], [EmployeeDuty], [Status]) VALUES (3, N'Elif', N'Demir', 1, CAST(N'1996-02-03' AS Date), N'Atölyeler Sk. No:3, Yunus, 34873 Kartal/İstanbul', 1, N'+905325323232', N'Güvenlik Personeli', 1)
INSERT [dbo].[Employees] ([EmployeeID], [EmployeeName], [EmployeeLastname], [Hospital_ID], [EmployeeBirthdate], [EmployeeAdress], [EmployeeGender], [EmployeePhoneNumber], [EmployeeDuty], [Status]) VALUES (4, N'Ömer', N'Çelik', 1, CAST(N'1993-01-04' AS Date), N'Sevinç Sok. 11 B, Feyzullah, 34843 Maltepe/İstanbul', 0, N'+905304464646', N'Temizlik Personeli', 1)
INSERT [dbo].[Employees] ([EmployeeID], [EmployeeName], [EmployeeLastname], [Hospital_ID], [EmployeeBirthdate], [EmployeeAdress], [EmployeeGender], [EmployeePhoneNumber], [EmployeeDuty], [Status]) VALUES (5, N'Mustafa', N'Şahin', 1, CAST(N'1980-02-05' AS Date), N'Karadeniz Cd. 34-46, Kaynarca, 34890 Pendik/İstanbul', 0, N'+905307161616', N'Aşçı', 1)
INSERT [dbo].[Employees] ([EmployeeID], [EmployeeName], [EmployeeLastname], [Hospital_ID], [EmployeeBirthdate], [EmployeeAdress], [EmployeeGender], [EmployeePhoneNumber], [EmployeeDuty], [Status]) VALUES (6, N'Hamza', N'Arslan', 2, CAST(N'1986-02-11' AS Date), N'Beypazarı, Hacıkara, 06730 Beypazarı/Ankara', 0, N'+905313516160', N'Güvenlik Personeli', 1)
INSERT [dbo].[Employees] ([EmployeeID], [EmployeeName], [EmployeeLastname], [Hospital_ID], [EmployeeBirthdate], [EmployeeAdress], [EmployeeGender], [EmployeePhoneNumber], [EmployeeDuty], [Status]) VALUES (7, N'Mehmet', N'Güneş', 2, CAST(N'1997-01-12' AS Date), N'Ziya Gökalp Caddesi No: 11 Kızılay/Ankara', 0, N'+905345343434', N'Temizlik Görevlisi', 1)
INSERT [dbo].[Employees] ([EmployeeID], [EmployeeName], [EmployeeLastname], [Hospital_ID], [EmployeeBirthdate], [EmployeeAdress], [EmployeeGender], [EmployeePhoneNumber], [EmployeeDuty], [Status]) VALUES (8, N'Ayşe', N'Avcı', 2, CAST(N'1998-02-13' AS Date), N'Küçük Hamam Cd. No:6, Yenice, 06890 Kızılcahamam/Ankara', 1, N'+905353837016', N'Aşçı', 1)
INSERT [dbo].[Employees] ([EmployeeID], [EmployeeName], [EmployeeLastname], [Hospital_ID], [EmployeeBirthdate], [EmployeeAdress], [EmployeeGender], [EmployeePhoneNumber], [EmployeeDuty], [Status]) VALUES (9, N'Defne', N'Bozkurt', 2, CAST(N'1990-01-14' AS Date), N'Kutludüğün, 06635 Mamak/Ankara', 1, N'+905304484848', N'Sekreter', 1)
INSERT [dbo].[Employees] ([EmployeeID], [EmployeeName], [EmployeeLastname], [Hospital_ID], [EmployeeBirthdate], [EmployeeAdress], [EmployeeGender], [EmployeePhoneNumber], [EmployeeDuty], [Status]) VALUES (10, N'İsmet', N'Özer', 2, CAST(N'1982-02-15' AS Date), N'Halit Ürek Cd., Gülveren, 06900 Polatlı/Ankara', 0, N'+905373515151', N'Temizlik Görevlisi', 1)
INSERT [dbo].[Employees] ([EmployeeID], [EmployeeName], [EmployeeLastname], [Hospital_ID], [EmployeeBirthdate], [EmployeeAdress], [EmployeeGender], [EmployeePhoneNumber], [EmployeeDuty], [Status]) VALUES (11, N'Emine', N'Yıldız', 3, CAST(N'1977-01-06' AS Date), N'2002. Sk., Musalla, 35930 Çeşme/İzmir', 1, N'+905365363636', N'Sekreter', 1)
INSERT [dbo].[Employees] ([EmployeeID], [EmployeeName], [EmployeeLastname], [Hospital_ID], [EmployeeBirthdate], [EmployeeAdress], [EmployeeGender], [EmployeePhoneNumber], [EmployeeDuty], [Status]) VALUES (12, N'Öykü', N'Yıldırım', 3, CAST(N'1995-02-07' AS Date), N'181. Sk. 14-26, Fevzipaşa, 35680 Foça/İzmir', 1, N'+905385383838', N'Temizlik Personeli', 1)
INSERT [dbo].[Employees] ([EmployeeID], [EmployeeName], [EmployeeLastname], [Hospital_ID], [EmployeeBirthdate], [EmployeeAdress], [EmployeeGender], [EmployeePhoneNumber], [EmployeeDuty], [Status]) VALUES (13, N'Fatma', N'Öztürk', 3, CAST(N'1979-01-08' AS Date), N'998/2. Sk. 11 B, Kadifekale, 35270 Konak/İzmir', 1, N'+905375373737', N'Güvenlik Personeli', 1)
INSERT [dbo].[Employees] ([EmployeeID], [EmployeeName], [EmployeeLastname], [Hospital_ID], [EmployeeBirthdate], [EmployeeAdress], [EmployeeGender], [EmployeePhoneNumber], [EmployeeDuty], [Status]) VALUES (14, N'Kerem', N'Aydın', 3, CAST(N'1991-02-09' AS Date), N'1054. Sk. No:8, Tepecik, 35460 Seferihisar/İzmir', 0, N'+905353838383', N'Aşçı', 1)
INSERT [dbo].[Employees] ([EmployeeID], [EmployeeName], [EmployeeLastname], [Hospital_ID], [EmployeeBirthdate], [EmployeeAdress], [EmployeeGender], [EmployeePhoneNumber], [EmployeeDuty], [Status]) VALUES (15, N'Ahmet', N'Özdemir', 3, CAST(N'1987-01-10' AS Date), N'12073. Sk. 32/17, Gülbahçe Mh, 35433 Urla/İzmir', 0, N'+905332848484', N'Temizlik Görevlisi', 1)
SET IDENTITY_INSERT [dbo].[Employees] OFF
GO
INSERT [dbo].[ExaminationDetails] ([PatientRegistration_ID], [PatientExamination_ID], [PatientExaminationQuantity], [Status]) VALUES (1, 1, 1, 1)
INSERT [dbo].[ExaminationDetails] ([PatientRegistration_ID], [PatientExamination_ID], [PatientExaminationQuantity], [Status]) VALUES (2, 7, 1, 1)
INSERT [dbo].[ExaminationDetails] ([PatientRegistration_ID], [PatientExamination_ID], [PatientExaminationQuantity], [Status]) VALUES (3, 2, 1, 1)
INSERT [dbo].[ExaminationDetails] ([PatientRegistration_ID], [PatientExamination_ID], [PatientExaminationQuantity], [Status]) VALUES (3, 3, 1, 1)
INSERT [dbo].[ExaminationDetails] ([PatientRegistration_ID], [PatientExamination_ID], [PatientExaminationQuantity], [Status]) VALUES (3, 6, 1, 1)
INSERT [dbo].[ExaminationDetails] ([PatientRegistration_ID], [PatientExamination_ID], [PatientExaminationQuantity], [Status]) VALUES (3, 8, 1, 1)
INSERT [dbo].[ExaminationDetails] ([PatientRegistration_ID], [PatientExamination_ID], [PatientExaminationQuantity], [Status]) VALUES (4, 2, 1, 1)
INSERT [dbo].[ExaminationDetails] ([PatientRegistration_ID], [PatientExamination_ID], [PatientExaminationQuantity], [Status]) VALUES (4, 3, 1, 1)
INSERT [dbo].[ExaminationDetails] ([PatientRegistration_ID], [PatientExamination_ID], [PatientExaminationQuantity], [Status]) VALUES (4, 9, 1, 1)
INSERT [dbo].[ExaminationDetails] ([PatientRegistration_ID], [PatientExamination_ID], [PatientExaminationQuantity], [Status]) VALUES (5, 6, 1, 1)
INSERT [dbo].[ExaminationDetails] ([PatientRegistration_ID], [PatientExamination_ID], [PatientExaminationQuantity], [Status]) VALUES (6, 1, 1, 1)
INSERT [dbo].[ExaminationDetails] ([PatientRegistration_ID], [PatientExamination_ID], [PatientExaminationQuantity], [Status]) VALUES (7, 7, 1, 1)
INSERT [dbo].[ExaminationDetails] ([PatientRegistration_ID], [PatientExamination_ID], [PatientExaminationQuantity], [Status]) VALUES (8, 1, 1, 1)
INSERT [dbo].[ExaminationDetails] ([PatientRegistration_ID], [PatientExamination_ID], [PatientExaminationQuantity], [Status]) VALUES (8, 6, 1, 1)
INSERT [dbo].[ExaminationDetails] ([PatientRegistration_ID], [PatientExamination_ID], [PatientExaminationQuantity], [Status]) VALUES (9, 1, 1, 1)
INSERT [dbo].[ExaminationDetails] ([PatientRegistration_ID], [PatientExamination_ID], [PatientExaminationQuantity], [Status]) VALUES (9, 3, 1, 1)
INSERT [dbo].[ExaminationDetails] ([PatientRegistration_ID], [PatientExamination_ID], [PatientExaminationQuantity], [Status]) VALUES (10, 4, 1, 1)
INSERT [dbo].[ExaminationDetails] ([PatientRegistration_ID], [PatientExamination_ID], [PatientExaminationQuantity], [Status]) VALUES (10, 8, 1, 1)
INSERT [dbo].[ExaminationDetails] ([PatientRegistration_ID], [PatientExamination_ID], [PatientExaminationQuantity], [Status]) VALUES (11, 1, 1, 1)
INSERT [dbo].[ExaminationDetails] ([PatientRegistration_ID], [PatientExamination_ID], [PatientExaminationQuantity], [Status]) VALUES (11, 5, 1, 1)
INSERT [dbo].[ExaminationDetails] ([PatientRegistration_ID], [PatientExamination_ID], [PatientExaminationQuantity], [Status]) VALUES (12, 5, 1, 1)
INSERT [dbo].[ExaminationDetails] ([PatientRegistration_ID], [PatientExamination_ID], [PatientExaminationQuantity], [Status]) VALUES (13, 6, 1, 1)
INSERT [dbo].[ExaminationDetails] ([PatientRegistration_ID], [PatientExamination_ID], [PatientExaminationQuantity], [Status]) VALUES (14, 9, 1, 1)
INSERT [dbo].[ExaminationDetails] ([PatientRegistration_ID], [PatientExamination_ID], [PatientExaminationQuantity], [Status]) VALUES (15, 1, 1, 1)
INSERT [dbo].[ExaminationDetails] ([PatientRegistration_ID], [PatientExamination_ID], [PatientExaminationQuantity], [Status]) VALUES (16, 8, 1, 1)
INSERT [dbo].[ExaminationDetails] ([PatientRegistration_ID], [PatientExamination_ID], [PatientExaminationQuantity], [Status]) VALUES (17, 1, 1, 1)
GO
SET IDENTITY_INSERT [dbo].[Hospitals] ON 

INSERT [dbo].[Hospitals] ([HospitalID], [HospitalName], [HospitalAdress], [HospitalPhoneNumber], [District_ID], [Status]) VALUES (1, N'Özel Fenerbahçe Ataşehir Hastanesi', N'Atatürk Mah. Ataşehir Bulv,34758 Ataşehir', N'+902163561907', 1, 1)
INSERT [dbo].[Hospitals] ([HospitalID], [HospitalName], [HospitalAdress], [HospitalPhoneNumber], [District_ID], [Status]) VALUES (2, N'Özel Fenerbahçe Çankaya Hastanesi', N'Balgat Mah. Mevlana Bulv, 1422. Sk. No: 4, 06520 Çankaya', N'+903122531907', 7, 1)
INSERT [dbo].[Hospitals] ([HospitalID], [HospitalName], [HospitalAdress], [HospitalPhoneNumber], [District_ID], [Status]) VALUES (3, N'Özel Fenerbahçe Konak Hastanesi', N'Çınarlı Mah. Fatih Caddesi No:10, 35110 Konak', N'+902324771907', 13, 1)
SET IDENTITY_INSERT [dbo].[Hospitals] OFF
GO
SET IDENTITY_INSERT [dbo].[Inpatients] ON 

INSERT [dbo].[Inpatients] ([InpatientID], [Patient_ID], [Nurse_ID], [Room_ID], [HospitalizationDate], [DischargedDate], [Status]) VALUES (1, 1, 12, 5, CAST(N'2022-02-22' AS Date), CAST(N'2022-02-28' AS Date), 1)
INSERT [dbo].[Inpatients] ([InpatientID], [Patient_ID], [Nurse_ID], [Room_ID], [HospitalizationDate], [DischargedDate], [Status]) VALUES (2, 2, 5, 9, CAST(N'2022-02-22' AS Date), CAST(N'2022-02-28' AS Date), 1)
INSERT [dbo].[Inpatients] ([InpatientID], [Patient_ID], [Nurse_ID], [Room_ID], [HospitalizationDate], [DischargedDate], [Status]) VALUES (3, 5, 6, 7, CAST(N'2022-02-25' AS Date), CAST(N'2022-03-11' AS Date), 1)
INSERT [dbo].[Inpatients] ([InpatientID], [Patient_ID], [Nurse_ID], [Room_ID], [HospitalizationDate], [DischargedDate], [Status]) VALUES (4, 8, 3, 3, CAST(N'2022-01-03' AS Date), CAST(N'2022-01-17' AS Date), 0)
INSERT [dbo].[Inpatients] ([InpatientID], [Patient_ID], [Nurse_ID], [Room_ID], [HospitalizationDate], [DischargedDate], [Status]) VALUES (5, 9, 2, 4, CAST(N'2021-12-06' AS Date), CAST(N'2021-12-10' AS Date), 0)
INSERT [dbo].[Inpatients] ([InpatientID], [Patient_ID], [Nurse_ID], [Room_ID], [HospitalizationDate], [DischargedDate], [Status]) VALUES (6, 10, 7, 2, CAST(N'2021-12-24' AS Date), CAST(N'2022-03-31' AS Date), 1)
INSERT [dbo].[Inpatients] ([InpatientID], [Patient_ID], [Nurse_ID], [Room_ID], [HospitalizationDate], [DischargedDate], [Status]) VALUES (7, 12, 8, 1, CAST(N'2022-02-02' AS Date), CAST(N'2022-03-14' AS Date), 1)
INSERT [dbo].[Inpatients] ([InpatientID], [Patient_ID], [Nurse_ID], [Room_ID], [HospitalizationDate], [DischargedDate], [Status]) VALUES (8, 11, 12, 8, CAST(N'2022-02-02' AS Date), CAST(N'2022-04-02' AS Date), 1)
INSERT [dbo].[Inpatients] ([InpatientID], [Patient_ID], [Nurse_ID], [Room_ID], [HospitalizationDate], [DischargedDate], [Status]) VALUES (9, 18, 11, 13, CAST(N'2022-02-25' AS Date), CAST(N'2022-02-28' AS Date), 1)
INSERT [dbo].[Inpatients] ([InpatientID], [Patient_ID], [Nurse_ID], [Room_ID], [HospitalizationDate], [DischargedDate], [Status]) VALUES (10, 20, 14, 19, CAST(N'2022-02-03' AS Date), CAST(N'2022-04-02' AS Date), 1)
INSERT [dbo].[Inpatients] ([InpatientID], [Patient_ID], [Nurse_ID], [Room_ID], [HospitalizationDate], [DischargedDate], [Status]) VALUES (11, 24, 18, 27, CAST(N'2022-02-25' AS Date), CAST(N'2022-02-28' AS Date), 1)
INSERT [dbo].[Inpatients] ([InpatientID], [Patient_ID], [Nurse_ID], [Room_ID], [HospitalizationDate], [DischargedDate], [Status]) VALUES (12, 26, 15, 21, CAST(N'2022-02-02' AS Date), CAST(N'2022-03-14' AS Date), 1)
SET IDENTITY_INSERT [dbo].[Inpatients] OFF
GO
SET IDENTITY_INSERT [dbo].[Medicines] ON 

INSERT [dbo].[Medicines] ([MedicineID], [MedicineName], [Status]) VALUES (1, N'APRANAX FORTE 550 mg 20 tablet', 1)
INSERT [dbo].[Medicines] ([MedicineID], [MedicineName], [Status]) VALUES (2, N'APRANAX PLUS 20 film tablet', 1)
INSERT [dbo].[Medicines] ([MedicineID], [MedicineName], [Status]) VALUES (3, N'ASPIRIN 100 mg 20 tablet', 1)
INSERT [dbo].[Medicines] ([MedicineID], [MedicineName], [Status]) VALUES (4, N'A-FERIN PLUS pediatrik 100 ml şurup', 1)
INSERT [dbo].[Medicines] ([MedicineID], [MedicineName], [Status]) VALUES (5, N'BUSCOPAN 10 mg 20 draje {Zentiva}', 1)
INSERT [dbo].[Medicines] ([MedicineID], [MedicineName], [Status]) VALUES (6, N'BUSCOPAN PLUS 20 film tablet {Zentiva}', 1)
INSERT [dbo].[Medicines] ([MedicineID], [MedicineName], [Status]) VALUES (7, N'CALPOL 120 mg 150 ml süspansiyon', 1)
INSERT [dbo].[Medicines] ([MedicineID], [MedicineName], [Status]) VALUES (8, N'CIPRO 500 mg 14 tablet ilaç', 1)
INSERT [dbo].[Medicines] ([MedicineID], [MedicineName], [Status]) VALUES (9, N'CORASPIN 100 mg 30 tablet', 1)
INSERT [dbo].[Medicines] ([MedicineID], [MedicineName], [Status]) VALUES (10, N'ETOL FORT 400 mg 14 film tablet', 1)
INSERT [dbo].[Medicines] ([MedicineID], [MedicineName], [Status]) VALUES (11, N'FUCIDIN % 2 20 gr krem', 1)
INSERT [dbo].[Medicines] ([MedicineID], [MedicineName], [Status]) VALUES (12, N'GAVISCON ADVANCE 200 ml oral süspansiyon ', 1)
INSERT [dbo].[Medicines] ([MedicineID], [MedicineName], [Status]) VALUES (13, N'HIRUDOID FORT 445 mg 40 gr krem', 1)
INSERT [dbo].[Medicines] ([MedicineID], [MedicineName], [Status]) VALUES (14, N'HIRUDOID FORT 445 mg 40 gr jel', 1)
INSERT [dbo].[Medicines] ([MedicineID], [MedicineName], [Status]) VALUES (15, N'HAMETAN 30 gr pomad', 1)
INSERT [dbo].[Medicines] ([MedicineID], [MedicineName], [Status]) VALUES (16, N'KLACID 500 mg 14 film tablet', 1)
INSERT [dbo].[Medicines] ([MedicineID], [MedicineName], [Status]) VALUES (17, N'KLACID 250 mg/5 ml oral süspansiyon için granül 100 ml', 1)
INSERT [dbo].[Medicines] ([MedicineID], [MedicineName], [Status]) VALUES (18, N'MAJEZIK 100 mg 15 film tablet', 1)
INSERT [dbo].[Medicines] ([MedicineID], [MedicineName], [Status]) VALUES (19, N'MAJEZIK %0.25 oral sprey 30 ml ', 1)
INSERT [dbo].[Medicines] ([MedicineID], [MedicineName], [Status]) VALUES (20, N'MUSCOFLEX 4 mg 20 kapsül', 1)
INSERT [dbo].[Medicines] ([MedicineID], [MedicineName], [Status]) VALUES (21, N'MOMECON %0.1 krem', 1)
INSERT [dbo].[Medicines] ([MedicineID], [MedicineName], [Status]) VALUES (22, N'METPAMID 10 mg 5 ampül', 1)
SET IDENTITY_INSERT [dbo].[Medicines] OFF
GO
SET IDENTITY_INSERT [dbo].[Nurses] ON 

INSERT [dbo].[Nurses] ([NurseID], [Hospital_ID], [NurseName], [NurseLastname], [NurseBirthdate], [NurseAdress], [NurseGender], [NursePhoneNumber], [Status]) VALUES (1, 1, N'Gamze', N'Küçük', CAST(N'1997-12-07' AS Date), N'Kozyatağı mh. Çayır Cd. No:2/5 Kadıköy/İstanbul', 1, N'+905453415798', 1)
INSERT [dbo].[Nurses] ([NurseID], [Hospital_ID], [NurseName], [NurseLastname], [NurseBirthdate], [NurseAdress], [NurseGender], [NursePhoneNumber], [Status]) VALUES (2, 1, N'Özge', N'Camgöz', CAST(N'1995-10-12' AS Date), N'Ataşehir mh. Panayır Sk. No:6/3 Ataşehir/İstanbul', 1, N'+905654321781', 1)
INSERT [dbo].[Nurses] ([NurseID], [Hospital_ID], [NurseName], [NurseLastname], [NurseBirthdate], [NurseAdress], [NurseGender], [NursePhoneNumber], [Status]) VALUES (3, 1, N'Murat', N'Sakin', CAST(N'1998-06-24' AS Date), N'Altayçeşme mh. Panayır Sk. No:3/6 Maltepe/İstanbul', 0, N'+905689702345', 1)
INSERT [dbo].[Nurses] ([NurseID], [Hospital_ID], [NurseName], [NurseLastname], [NurseBirthdate], [NurseAdress], [NurseGender], [NursePhoneNumber], [Status]) VALUES (4, 1, N'Kerim', N'Duman', CAST(N'1992-05-08' AS Date), N'Kordonboyu mh. Cevahir Sk. No:114/6 Kartal/İstanbul', 0, N'+905076543612', 1)
INSERT [dbo].[Nurses] ([NurseID], [Hospital_ID], [NurseName], [NurseLastname], [NurseBirthdate], [NurseAdress], [NurseGender], [NursePhoneNumber], [Status]) VALUES (5, 1, N'Ceren', N'Sağ', CAST(N'1986-11-14' AS Date), N'Alibeyköy mh. Tutmaç Sk. No:1/10  Alibeyköy/İstanbul', 1, N'+905567890123', 1)
INSERT [dbo].[Nurses] ([NurseID], [Hospital_ID], [NurseName], [NurseLastname], [NurseBirthdate], [NurseAdress], [NurseGender], [NursePhoneNumber], [Status]) VALUES (6, 1, N'Simge', N'Sagın', CAST(N'1994-03-21' AS Date), N'Küçükyalı mh .Tutmaç Sk. No:2/10  Maltepe/İstanbul', 1, N'+905212456785', 1)
INSERT [dbo].[Nurses] ([NurseID], [Hospital_ID], [NurseName], [NurseLastname], [NurseBirthdate], [NurseAdress], [NurseGender], [NursePhoneNumber], [Status]) VALUES (7, 1, N'Raşit', N'Basri', CAST(N'1990-02-14' AS Date), N'Şahapgürler mh. Cevahir Sk. No:114/6 Sultanbeyli/İstanbul', 0, N'+905215456787', 1)
INSERT [dbo].[Nurses] ([NurseID], [Hospital_ID], [NurseName], [NurseLastname], [NurseBirthdate], [NurseAdress], [NurseGender], [NursePhoneNumber], [Status]) VALUES (8, 1, N'Harun', N'Camgöz', CAST(N'1988-07-22' AS Date), N'YukarıGümüş mh. Zeytin Sk. No:11/8 Tuzla/İstanbul', 0, N'+905709874321', 1)
INSERT [dbo].[Nurses] ([NurseID], [Hospital_ID], [NurseName], [NurseLastname], [NurseBirthdate], [NurseAdress], [NurseGender], [NursePhoneNumber], [Status]) VALUES (9, 1, N'Feridun', N'Düz', CAST(N'1996-04-29' AS Date), N'Aşkolsun mh. Peynir Sk. No:12/20 Kadıköy/İstanbul', 0, N'+905503052906', 1)
INSERT [dbo].[Nurses] ([NurseID], [Hospital_ID], [NurseName], [NurseLastname], [NurseBirthdate], [NurseAdress], [NurseGender], [NursePhoneNumber], [Status]) VALUES (10, 1, N'Eren', N'Yaldız', CAST(N'1999-01-17' AS Date), N'Atatürk mh. Gazoz Sk. No:25/8  Ataşehir/İstanbul', 0, N'+905212456785', 1)
INSERT [dbo].[Nurses] ([NurseID], [Hospital_ID], [NurseName], [NurseLastname], [NurseBirthdate], [NurseAdress], [NurseGender], [NursePhoneNumber], [Status]) VALUES (11, 1, N'Özge', N'Çelik', CAST(N'1997-01-19' AS Date), N'Şişli mh. Gazoz Sk. No:25/8  Şişli/İstanbul', 1, N'+905212413570', 1)
INSERT [dbo].[Nurses] ([NurseID], [Hospital_ID], [NurseName], [NurseLastname], [NurseBirthdate], [NurseAdress], [NurseGender], [NursePhoneNumber], [Status]) VALUES (12, 2, N'Gamze', N'Tuna', CAST(N'1986-06-30' AS Date), N'Altındağ mh. Piryani Sk. No:13/2 Altındağ/Ankara', 1, N'+905415744389', 1)
INSERT [dbo].[Nurses] ([NurseID], [Hospital_ID], [NurseName], [NurseLastname], [NurseBirthdate], [NurseAdress], [NurseGender], [NursePhoneNumber], [Status]) VALUES (13, 2, N'Beyza', N'Şimşek', CAST(N'1998-04-02' AS Date), N'Sevgi mah. Gül sokağı no:3/3 Mamak/Ankara', 1, N'+905439638521', 1)
INSERT [dbo].[Nurses] ([NurseID], [Hospital_ID], [NurseName], [NurseLastname], [NurseBirthdate], [NurseAdress], [NurseGender], [NursePhoneNumber], [Status]) VALUES (14, 2, N'Yılmaz', N'Biçer', CAST(N'1997-05-05' AS Date), N'Günışığı mh. Işık sk. No10/5 Keçiören/Ankara', 0, N'+905331892036', 1)
INSERT [dbo].[Nurses] ([NurseID], [Hospital_ID], [NurseName], [NurseLastname], [NurseBirthdate], [NurseAdress], [NurseGender], [NursePhoneNumber], [Status]) VALUES (15, 2, N'Mert', N'Ersin', CAST(N'1987-06-07' AS Date), N'Leylak mh. Gül Cd. No:5/6 Pursaklar/Ankara', 0, N'+905437896543', 1)
INSERT [dbo].[Nurses] ([NurseID], [Hospital_ID], [NurseName], [NurseLastname], [NurseBirthdate], [NurseAdress], [NurseGender], [NursePhoneNumber], [Status]) VALUES (16, 2, N'Defne', N'Kılıç', CAST(N'1993-03-05' AS Date), N'Kalem mh. silgi sokak No:1/10 Çankaya/Ankara', 1, N'+905467843256', 1)
INSERT [dbo].[Nurses] ([NurseID], [Hospital_ID], [NurseName], [NurseLastname], [NurseBirthdate], [NurseAdress], [NurseGender], [NursePhoneNumber], [Status]) VALUES (17, 3, N'Zümra', N'Ozan', CAST(N'1995-07-12' AS Date), N'İnönü mh.Badem sk. No: 5 Dikili/İzmir', 1, N'+905366667777', 1)
INSERT [dbo].[Nurses] ([NurseID], [Hospital_ID], [NurseName], [NurseLastname], [NurseBirthdate], [NurseAdress], [NurseGender], [NursePhoneNumber], [Status]) VALUES (18, 3, N'YiğitCan', N'Kütük', CAST(N'1997-04-08' AS Date), N'Çınar mh. Baba sk. No: 3 Foça/İzmir', 0, N'+90537779988 ', 1)
INSERT [dbo].[Nurses] ([NurseID], [Hospital_ID], [NurseName], [NurseLastname], [NurseBirthdate], [NurseAdress], [NurseGender], [NursePhoneNumber], [Status]) VALUES (19, 3, N'Serra', N'Akkaya', CAST(N'1990-06-03' AS Date), N'Aşıkveysel mh. Ceviz sk. No: 10/5 Karşıyaka/İzmir', 1, N'+905413546789', 1)
INSERT [dbo].[Nurses] ([NurseID], [Hospital_ID], [NurseName], [NurseLastname], [NurseBirthdate], [NurseAdress], [NurseGender], [NursePhoneNumber], [Status]) VALUES (20, 3, N'Yakup', N'Aslan', CAST(N'1983-07-10' AS Date), N'Atatürk mh. Peyami sk. No: 8 Bornova/İzmir', 0, N'+905435678945', 1)
INSERT [dbo].[Nurses] ([NurseID], [Hospital_ID], [NurseName], [NurseLastname], [NurseBirthdate], [NurseAdress], [NurseGender], [NursePhoneNumber], [Status]) VALUES (21, 3, N'Akif Emre', N'Arslan', CAST(N'1970-10-11' AS Date), N'Özdemir mh. Asaf sk. No:1/3  Buca/İzmir', 0, N'+905214567890', 1)
SET IDENTITY_INSERT [dbo].[Nurses] OFF
GO
SET IDENTITY_INSERT [dbo].[PatientExaminations] ON 

INSERT [dbo].[PatientExaminations] ([PatientExaminationID], [PatientExaminationName], [PatientExaminationUnitPrice], [Status]) VALUES (1, N'Ayakta Muayene', CAST(200.00 AS Decimal(14, 2)), 1)
INSERT [dbo].[PatientExaminations] ([PatientExaminationID], [PatientExaminationName], [PatientExaminationUnitPrice], [Status]) VALUES (2, N'İşitme Testi', CAST(250.00 AS Decimal(14, 2)), 1)
INSERT [dbo].[PatientExaminations] ([PatientExaminationID], [PatientExaminationName], [PatientExaminationUnitPrice], [Status]) VALUES (3, N'Röntgen', CAST(150.00 AS Decimal(14, 2)), 1)
INSERT [dbo].[PatientExaminations] ([PatientExaminationID], [PatientExaminationName], [PatientExaminationUnitPrice], [Status]) VALUES (4, N'MR', CAST(1000.00 AS Decimal(14, 2)), 1)
INSERT [dbo].[PatientExaminations] ([PatientExaminationID], [PatientExaminationName], [PatientExaminationUnitPrice], [Status]) VALUES (5, N'Görme testi', CAST(150.00 AS Decimal(14, 2)), 1)
INSERT [dbo].[PatientExaminations] ([PatientExaminationID], [PatientExaminationName], [PatientExaminationUnitPrice], [Status]) VALUES (6, N'Kan Alma', CAST(100.00 AS Decimal(14, 2)), 1)
INSERT [dbo].[PatientExaminations] ([PatientExaminationID], [PatientExaminationName], [PatientExaminationUnitPrice], [Status]) VALUES (7, N'EKG', CAST(150.00 AS Decimal(14, 2)), 1)
INSERT [dbo].[PatientExaminations] ([PatientExaminationID], [PatientExaminationName], [PatientExaminationUnitPrice], [Status]) VALUES (8, N'Akciğer Grafisi', CAST(200.00 AS Decimal(14, 2)), 1)
INSERT [dbo].[PatientExaminations] ([PatientExaminationID], [PatientExaminationName], [PatientExaminationUnitPrice], [Status]) VALUES (9, N'Solunum Fonksiyon Testi', CAST(250.00 AS Decimal(14, 2)), 1)
SET IDENTITY_INSERT [dbo].[PatientExaminations] OFF
GO
SET IDENTITY_INSERT [dbo].[PatientRegistrations] ON 

INSERT [dbo].[PatientRegistrations] ([PatientRegistrationID], [Patient_ID], [Doctor_ID], [AppointmentDate], [AppointmentTime], [PatientSymptoms], [Status]) VALUES (1, 1, 14, CAST(N'2022-05-22' AS Date), CAST(N'02:23:25' AS Time), N'Ateş', 1)
INSERT [dbo].[PatientRegistrations] ([PatientRegistrationID], [Patient_ID], [Doctor_ID], [AppointmentDate], [AppointmentTime], [PatientSymptoms], [Status]) VALUES (2, 2, 13, CAST(N'2022-01-22' AS Date), CAST(N'09:23:25' AS Time), N'Hızlı Kalp Ritmi', 1)
INSERT [dbo].[PatientRegistrations] ([PatientRegistrationID], [Patient_ID], [Doctor_ID], [AppointmentDate], [AppointmentTime], [PatientSymptoms], [Status]) VALUES (3, 3, 18, CAST(N'2022-02-24' AS Date), CAST(N'09:23:25' AS Time), N'Depresyon', 1)
INSERT [dbo].[PatientRegistrations] ([PatientRegistrationID], [Patient_ID], [Doctor_ID], [AppointmentDate], [AppointmentTime], [PatientSymptoms], [Status]) VALUES (4, 4, 10, CAST(N'2022-05-25' AS Date), CAST(N'13:23:25' AS Time), N'Göğüs ağrısı', 1)
INSERT [dbo].[PatientRegistrations] ([PatientRegistrationID], [Patient_ID], [Doctor_ID], [AppointmentDate], [AppointmentTime], [PatientSymptoms], [Status]) VALUES (5, 5, 15, CAST(N'2022-03-25' AS Date), CAST(N'14:23:25' AS Time), N'Epilepsi', 1)
INSERT [dbo].[PatientRegistrations] ([PatientRegistrationID], [Patient_ID], [Doctor_ID], [AppointmentDate], [AppointmentTime], [PatientSymptoms], [Status]) VALUES (6, 6, 14, CAST(N'2022-01-26' AS Date), CAST(N'15:23:25' AS Time), N'Kulak ağrısı', 1)
INSERT [dbo].[PatientRegistrations] ([PatientRegistrationID], [Patient_ID], [Doctor_ID], [AppointmentDate], [AppointmentTime], [PatientSymptoms], [Status]) VALUES (7, 7, 9, CAST(N'2022-03-27' AS Date), CAST(N'16:23:25' AS Time), N'Mide yanması', 1)
INSERT [dbo].[PatientRegistrations] ([PatientRegistrationID], [Patient_ID], [Doctor_ID], [AppointmentDate], [AppointmentTime], [PatientSymptoms], [Status]) VALUES (8, 8, 18, CAST(N'2022-02-28' AS Date), CAST(N'16:23:25' AS Time), N'Koyu idrar', 1)
INSERT [dbo].[PatientRegistrations] ([PatientRegistrationID], [Patient_ID], [Doctor_ID], [AppointmentDate], [AppointmentTime], [PatientSymptoms], [Status]) VALUES (9, 9, 10, CAST(N'2022-04-26' AS Date), CAST(N'13:23:25' AS Time), N'Öksürük', 1)
INSERT [dbo].[PatientRegistrations] ([PatientRegistrationID], [Patient_ID], [Doctor_ID], [AppointmentDate], [AppointmentTime], [PatientSymptoms], [Status]) VALUES (10, 10, 2, CAST(N'2022-05-22' AS Date), CAST(N'10:23:25' AS Time), N'Çene Kırığı', 1)
INSERT [dbo].[PatientRegistrations] ([PatientRegistrationID], [Patient_ID], [Doctor_ID], [AppointmentDate], [AppointmentTime], [PatientSymptoms], [Status]) VALUES (11, 11, 6, CAST(N'2022-06-22' AS Date), CAST(N'12:23:25' AS Time), N'Egzema', 1)
INSERT [dbo].[PatientRegistrations] ([PatientRegistrationID], [Patient_ID], [Doctor_ID], [AppointmentDate], [AppointmentTime], [PatientSymptoms], [Status]) VALUES (12, 12, 11, CAST(N'2022-07-22' AS Date), CAST(N'10:23:25' AS Time), N'Görme bozukluğu', 1)
INSERT [dbo].[PatientRegistrations] ([PatientRegistrationID], [Patient_ID], [Doctor_ID], [AppointmentDate], [AppointmentTime], [PatientSymptoms], [Status]) VALUES (13, 13, 16, CAST(N'2022-09-22' AS Date), CAST(N'11:23:25' AS Time), N'Kol kırığı', 1)
INSERT [dbo].[PatientRegistrations] ([PatientRegistrationID], [Patient_ID], [Doctor_ID], [AppointmentDate], [AppointmentTime], [PatientSymptoms], [Status]) VALUES (14, 14, 12, CAST(N'2022-07-22' AS Date), CAST(N'13:23:25' AS Time), N'Ateş', 1)
INSERT [dbo].[PatientRegistrations] ([PatientRegistrationID], [Patient_ID], [Doctor_ID], [AppointmentDate], [AppointmentTime], [PatientSymptoms], [Status]) VALUES (15, 15, 1, CAST(N'2022-05-22' AS Date), CAST(N'14:23:25' AS Time), N'Çene Ağrısı', 1)
INSERT [dbo].[PatientRegistrations] ([PatientRegistrationID], [Patient_ID], [Doctor_ID], [AppointmentDate], [AppointmentTime], [PatientSymptoms], [Status]) VALUES (16, 16, 19, CAST(N'2022-02-28' AS Date), CAST(N'16:23:25' AS Time), N'Koyu idrar', 1)
INSERT [dbo].[PatientRegistrations] ([PatientRegistrationID], [Patient_ID], [Doctor_ID], [AppointmentDate], [AppointmentTime], [PatientSymptoms], [Status]) VALUES (17, 17, 4, CAST(N'2022-05-26' AS Date), CAST(N'13:23:25' AS Time), N'MS Hastalığı', 1)
INSERT [dbo].[PatientRegistrations] ([PatientRegistrationID], [Patient_ID], [Doctor_ID], [AppointmentDate], [AppointmentTime], [PatientSymptoms], [Status]) VALUES (18, 15, 9, CAST(N'2022-05-22' AS Date), CAST(N'10:23:25' AS Time), N'Halsizlik', 1)
INSERT [dbo].[PatientRegistrations] ([PatientRegistrationID], [Patient_ID], [Doctor_ID], [AppointmentDate], [AppointmentTime], [PatientSymptoms], [Status]) VALUES (19, 3, 8, CAST(N'2022-03-22' AS Date), CAST(N'12:23:25' AS Time), N'Diş Ağrısı', 1)
INSERT [dbo].[PatientRegistrations] ([PatientRegistrationID], [Patient_ID], [Doctor_ID], [AppointmentDate], [AppointmentTime], [PatientSymptoms], [Status]) VALUES (20, 11, 6, CAST(N'2022-01-22' AS Date), CAST(N'10:23:25' AS Time), N'Egzema', 1)
INSERT [dbo].[PatientRegistrations] ([PatientRegistrationID], [Patient_ID], [Doctor_ID], [AppointmentDate], [AppointmentTime], [PatientSymptoms], [Status]) VALUES (21, 3, 7, CAST(N'2022-05-22' AS Date), CAST(N'11:23:25' AS Time), N'Sedef Hastalığı', 1)
INSERT [dbo].[PatientRegistrations] ([PatientRegistrationID], [Patient_ID], [Doctor_ID], [AppointmentDate], [AppointmentTime], [PatientSymptoms], [Status]) VALUES (22, 4, 17, CAST(N'2022-01-22' AS Date), CAST(N'02:23:25' AS Time), N'Burun estetik', 1)
INSERT [dbo].[PatientRegistrations] ([PatientRegistrationID], [Patient_ID], [Doctor_ID], [AppointmentDate], [AppointmentTime], [PatientSymptoms], [Status]) VALUES (23, 8, 13, CAST(N'2022-06-22' AS Date), CAST(N'09:23:25' AS Time), N'Hızlı Kalp Ritmi', 1)
INSERT [dbo].[PatientRegistrations] ([PatientRegistrationID], [Patient_ID], [Doctor_ID], [AppointmentDate], [AppointmentTime], [PatientSymptoms], [Status]) VALUES (24, 9, 18, CAST(N'2022-05-24' AS Date), CAST(N'09:23:25' AS Time), N'Depresyon', 1)
INSERT [dbo].[PatientRegistrations] ([PatientRegistrationID], [Patient_ID], [Doctor_ID], [AppointmentDate], [AppointmentTime], [PatientSymptoms], [Status]) VALUES (25, 10, 12, CAST(N'2022-03-25' AS Date), CAST(N'14:23:25' AS Time), N'karaciğerde sıkıntı', 1)
INSERT [dbo].[PatientRegistrations] ([PatientRegistrationID], [Patient_ID], [Doctor_ID], [AppointmentDate], [AppointmentTime], [PatientSymptoms], [Status]) VALUES (26, 3, 14, CAST(N'2022-01-26' AS Date), CAST(N'15:23:25' AS Time), N'Sinüs tıkanma ve ağrı', 1)
INSERT [dbo].[PatientRegistrations] ([PatientRegistrationID], [Patient_ID], [Doctor_ID], [AppointmentDate], [AppointmentTime], [PatientSymptoms], [Status]) VALUES (27, 1, 18, CAST(N'2022-06-22' AS Date), CAST(N'03:23:25' AS Time), N'Öksürük', 1)
INSERT [dbo].[PatientRegistrations] ([PatientRegistrationID], [Patient_ID], [Doctor_ID], [AppointmentDate], [AppointmentTime], [PatientSymptoms], [Status]) VALUES (28, 21, 20, CAST(N'2022-04-20' AS Date), CAST(N'10:23:25' AS Time), N'Ateş', 1)
INSERT [dbo].[PatientRegistrations] ([PatientRegistrationID], [Patient_ID], [Doctor_ID], [AppointmentDate], [AppointmentTime], [PatientSymptoms], [Status]) VALUES (29, 22, 22, CAST(N'2022-04-02' AS Date), CAST(N'11:30:25' AS Time), N'Öksürük', 1)
INSERT [dbo].[PatientRegistrations] ([PatientRegistrationID], [Patient_ID], [Doctor_ID], [AppointmentDate], [AppointmentTime], [PatientSymptoms], [Status]) VALUES (30, 17, 27, CAST(N'2022-03-03' AS Date), CAST(N'10:00:25' AS Time), N'Mide Bulantısı', 1)
INSERT [dbo].[PatientRegistrations] ([PatientRegistrationID], [Patient_ID], [Doctor_ID], [AppointmentDate], [AppointmentTime], [PatientSymptoms], [Status]) VALUES (31, 6, 19, CAST(N'2022-03-05' AS Date), CAST(N'09:30:00' AS Time), N'Öksürük', 1)
INSERT [dbo].[PatientRegistrations] ([PatientRegistrationID], [Patient_ID], [Doctor_ID], [AppointmentDate], [AppointmentTime], [PatientSymptoms], [Status]) VALUES (32, 2, 18, CAST(N'2022-03-07' AS Date), CAST(N'08:50:00' AS Time), N'Ateş', 1)
INSERT [dbo].[PatientRegistrations] ([PatientRegistrationID], [Patient_ID], [Doctor_ID], [AppointmentDate], [AppointmentTime], [PatientSymptoms], [Status]) VALUES (33, 27, 21, CAST(N'2022-05-01' AS Date), CAST(N'12:00:25' AS Time), N'Baş Ağrısı', 1)
SET IDENTITY_INSERT [dbo].[PatientRegistrations] OFF
GO
SET IDENTITY_INSERT [dbo].[Patients] ON 

INSERT [dbo].[Patients] ([PatientID], [PatientTC], [PatientName], [PatientLastname], [PatientBirthDate], [PatientGender], [PatientPhoneNumber], [Status]) VALUES (1, N'49131245678', N'Hüseyin', N'Cemil', CAST(N'1993-01-01' AS Date), 0, N'+905453415798', 1)
INSERT [dbo].[Patients] ([PatientID], [PatientTC], [PatientName], [PatientLastname], [PatientBirthDate], [PatientGender], [PatientPhoneNumber], [Status]) VALUES (2, N'98654321781', N'Kamile', N'Gürsu', CAST(N'1966-03-12' AS Date), 1, N'+905654321781', 1)
INSERT [dbo].[Patients] ([PatientID], [PatientTC], [PatientName], [PatientLastname], [PatientBirthDate], [PatientGender], [PatientPhoneNumber], [Status]) VALUES (3, N'23689702345', N'Şeyma', N'Demir', CAST(N'2004-08-08' AS Date), 1, N'+905689702345', 1)
INSERT [dbo].[Patients] ([PatientID], [PatientTC], [PatientName], [PatientLastname], [PatientBirthDate], [PatientGender], [PatientPhoneNumber], [Status]) VALUES (4, N'56789421369', N'Ferhat', N'Korkmaz', CAST(N'1995-01-22' AS Date), 0, N'+905789421369', 1)
INSERT [dbo].[Patients] ([PatientID], [PatientTC], [PatientName], [PatientLastname], [PatientBirthDate], [PatientGender], [PatientPhoneNumber], [Status]) VALUES (5, N'57321789045', N'Fırat', N'Keser', CAST(N'1987-06-18' AS Date), 0, N'+905321789045', 1)
INSERT [dbo].[Patients] ([PatientID], [PatientTC], [PatientName], [PatientLastname], [PatientBirthDate], [PatientGender], [PatientPhoneNumber], [Status]) VALUES (6, N'49131245673', N'Güneş', N'Ay', CAST(N'1981-09-14' AS Date), 1, N'+905131245673', 1)
INSERT [dbo].[Patients] ([PatientID], [PatientTC], [PatientName], [PatientLastname], [PatientBirthDate], [PatientGender], [PatientPhoneNumber], [Status]) VALUES (7, N'43267845345', N'Zeynep', N'Kızılkaya', CAST(N'1996-08-15' AS Date), 1, N'+905267845345', 1)
INSERT [dbo].[Patients] ([PatientID], [PatientTC], [PatientName], [PatientLastname], [PatientBirthDate], [PatientGender], [PatientPhoneNumber], [Status]) VALUES (8, N'98076543612', N'Nisa', N'Nur', CAST(N'1956-04-19' AS Date), 1, N'+905076543612', 1)
INSERT [dbo].[Patients] ([PatientID], [PatientTC], [PatientName], [PatientLastname], [PatientBirthDate], [PatientGender], [PatientPhoneNumber], [Status]) VALUES (9, N'34567890123', N'Bayram', N'Kızıl', CAST(N'1973-10-01' AS Date), 1, N'+905567890123', 1)
INSERT [dbo].[Patients] ([PatientID], [PatientTC], [PatientName], [PatientLastname], [PatientBirthDate], [PatientGender], [PatientPhoneNumber], [Status]) VALUES (10, N'11212456788', N'Cemalettin', N'Üçbacak', CAST(N'1938-05-29' AS Date), 0, N'+905212456785', 1)
INSERT [dbo].[Patients] ([PatientID], [PatientTC], [PatientName], [PatientLastname], [PatientBirthDate], [PatientGender], [PatientPhoneNumber], [Status]) VALUES (11, N'11215456787', N'Ali', N'Can', CAST(N'1999-11-24' AS Date), 0, N'+905215456787', 1)
INSERT [dbo].[Patients] ([PatientID], [PatientTC], [PatientName], [PatientLastname], [PatientBirthDate], [PatientGender], [PatientPhoneNumber], [Status]) VALUES (12, N'11212413570', N'Seda', N'Sayın', CAST(N'1949-07-03' AS Date), 1, N'+905212413570', 1)
INSERT [dbo].[Patients] ([PatientID], [PatientTC], [PatientName], [PatientLastname], [PatientBirthDate], [PatientGender], [PatientPhoneNumber], [Status]) VALUES (13, N'45709874321', N'Kübra', N'Yıldırım', CAST(N'1996-08-05' AS Date), 1, N'+905709874321', 1)
INSERT [dbo].[Patients] ([PatientID], [PatientTC], [PatientName], [PatientLastname], [PatientBirthDate], [PatientGender], [PatientPhoneNumber], [Status]) VALUES (14, N'55503052906', N'Emre', N'Ayvaz', CAST(N'2000-02-29' AS Date), 0, N'+905503052906', 1)
INSERT [dbo].[Patients] ([PatientID], [PatientTC], [PatientName], [PatientLastname], [PatientBirthDate], [PatientGender], [PatientPhoneNumber], [Status]) VALUES (15, N'34567812345', N'Berat Ozan', N'Kiraz', CAST(N'1998-01-01' AS Date), 0, N'+905456781234', 1)
INSERT [dbo].[Patients] ([PatientID], [PatientTC], [PatientName], [PatientLastname], [PatientBirthDate], [PatientGender], [PatientPhoneNumber], [Status]) VALUES (16, N'36789034521', N'Gamze', N'Tuna', CAST(N'1994-05-24' AS Date), 1, N'+905415744389', 1)
INSERT [dbo].[Patients] ([PatientID], [PatientTC], [PatientName], [PatientLastname], [PatientBirthDate], [PatientGender], [PatientPhoneNumber], [Status]) VALUES (17, N'98765434562', N'Volkan', N'Ercan', CAST(N'1995-05-24' AS Date), 0, N'+905567812345', 1)
INSERT [dbo].[Patients] ([PatientID], [PatientTC], [PatientName], [PatientLastname], [PatientBirthDate], [PatientGender], [PatientPhoneNumber], [Status]) VALUES (18, N'41831225678', N'Erdal', N'Kömürcü', CAST(N'1979-06-20' AS Date), 0, N'+905333419098', 1)
INSERT [dbo].[Patients] ([PatientID], [PatientTC], [PatientName], [PatientLastname], [PatientBirthDate], [PatientGender], [PatientPhoneNumber], [Status]) VALUES (19, N'19131245888', N'Elif Eylül', N'Cemil', CAST(N'1984-09-09' AS Date), 1, N'+905363447798', 1)
INSERT [dbo].[Patients] ([PatientID], [PatientTC], [PatientName], [PatientLastname], [PatientBirthDate], [PatientGender], [PatientPhoneNumber], [Status]) VALUES (20, N'39199845678', N'Ali', N'Kılıç', CAST(N'1963-03-14' AS Date), 0, N'+905366669988', 1)
INSERT [dbo].[Patients] ([PatientID], [PatientTC], [PatientName], [PatientLastname], [PatientBirthDate], [PatientGender], [PatientPhoneNumber], [Status]) VALUES (21, N'12194245678', N'Nizamettin', N'Güvenç', CAST(N'1973-01-01' AS Date), 0, N'+905553445798', 1)
INSERT [dbo].[Patients] ([PatientID], [PatientTC], [PatientName], [PatientLastname], [PatientBirthDate], [PatientGender], [PatientPhoneNumber], [Status]) VALUES (22, N'22294245678', N'Halil İbrahim', N'Kapar', CAST(N'1955-02-11' AS Date), 0, N'+905551115798', 1)
INSERT [dbo].[Patients] ([PatientID], [PatientTC], [PatientName], [PatientLastname], [PatientBirthDate], [PatientGender], [PatientPhoneNumber], [Status]) VALUES (23, N'12111145577', N'Kaya', N'Çilingiroğlu', CAST(N'1973-01-01' AS Date), 0, N'+905511447788', 1)
INSERT [dbo].[Patients] ([PatientID], [PatientTC], [PatientName], [PatientLastname], [PatientBirthDate], [PatientGender], [PatientPhoneNumber], [Status]) VALUES (24, N'22222225678', N'Kuzey', N'Tekinoğlu', CAST(N'1983-09-15' AS Date), 0, N'+905553411111', 1)
INSERT [dbo].[Patients] ([PatientID], [PatientTC], [PatientName], [PatientLastname], [PatientBirthDate], [PatientGender], [PatientPhoneNumber], [Status]) VALUES (25, N'22266665678', N'Güney', N'Tekinoğlu', CAST(N'1985-09-15' AS Date), 0, N'+905553422222', 1)
INSERT [dbo].[Patients] ([PatientID], [PatientTC], [PatientName], [PatientLastname], [PatientBirthDate], [PatientGender], [PatientPhoneNumber], [Status]) VALUES (26, N'33336665678', N'Cemre', N'Çaylak', CAST(N'1985-09-15' AS Date), 1, N'+905553433333', 1)
INSERT [dbo].[Patients] ([PatientID], [PatientTC], [PatientName], [PatientLastname], [PatientBirthDate], [PatientGender], [PatientPhoneNumber], [Status]) VALUES (27, N'55555665678', N'Rıza', N'Soylu', CAST(N'1965-09-25' AS Date), 0, N'+905553555555', 1)
SET IDENTITY_INSERT [dbo].[Patients] OFF
GO
INSERT [dbo].[PrescriptionDetails] ([Prescription_ID], [Medicine_ID], [Status]) VALUES (1, 2, 1)
INSERT [dbo].[PrescriptionDetails] ([Prescription_ID], [Medicine_ID], [Status]) VALUES (2, 1, 1)
INSERT [dbo].[PrescriptionDetails] ([Prescription_ID], [Medicine_ID], [Status]) VALUES (3, 4, 1)
INSERT [dbo].[PrescriptionDetails] ([Prescription_ID], [Medicine_ID], [Status]) VALUES (4, 5, 1)
INSERT [dbo].[PrescriptionDetails] ([Prescription_ID], [Medicine_ID], [Status]) VALUES (5, 1, 1)
INSERT [dbo].[PrescriptionDetails] ([Prescription_ID], [Medicine_ID], [Status]) VALUES (6, 5, 1)
INSERT [dbo].[PrescriptionDetails] ([Prescription_ID], [Medicine_ID], [Status]) VALUES (10, 1, 1)
GO
SET IDENTITY_INSERT [dbo].[Prescriptions] ON 

INSERT [dbo].[Prescriptions] ([PrescriptionID], [Patient_ID], [PrescriptionsCode], [PrescriptionDate], [Status]) VALUES (1, 1, N'6B7A9A43', CAST(N'2022-05-22' AS Date), 1)
INSERT [dbo].[Prescriptions] ([PrescriptionID], [Patient_ID], [PrescriptionsCode], [PrescriptionDate], [Status]) VALUES (2, 2, N'F49CDC82', CAST(N'2022-01-22' AS Date), 1)
INSERT [dbo].[Prescriptions] ([PrescriptionID], [Patient_ID], [PrescriptionsCode], [PrescriptionDate], [Status]) VALUES (3, 3, N'65527C6E', CAST(N'2022-02-24' AS Date), 1)
INSERT [dbo].[Prescriptions] ([PrescriptionID], [Patient_ID], [PrescriptionsCode], [PrescriptionDate], [Status]) VALUES (4, 4, N'EE47008B', CAST(N'2022-05-25' AS Date), 1)
INSERT [dbo].[Prescriptions] ([PrescriptionID], [Patient_ID], [PrescriptionsCode], [PrescriptionDate], [Status]) VALUES (5, 5, N'98F0CBFE', CAST(N'2022-03-25' AS Date), 1)
INSERT [dbo].[Prescriptions] ([PrescriptionID], [Patient_ID], [PrescriptionsCode], [PrescriptionDate], [Status]) VALUES (6, 6, N'D4A1510B', CAST(N'2022-01-26' AS Date), 1)
INSERT [dbo].[Prescriptions] ([PrescriptionID], [Patient_ID], [PrescriptionsCode], [PrescriptionDate], [Status]) VALUES (7, 7, N'A844D706', CAST(N'2022-03-27' AS Date), 1)
INSERT [dbo].[Prescriptions] ([PrescriptionID], [Patient_ID], [PrescriptionsCode], [PrescriptionDate], [Status]) VALUES (8, 8, N'3629CC5D', CAST(N'2022-02-28' AS Date), 1)
INSERT [dbo].[Prescriptions] ([PrescriptionID], [Patient_ID], [PrescriptionsCode], [PrescriptionDate], [Status]) VALUES (9, 9, N'C652D5B8', CAST(N'2022-04-26' AS Date), 1)
INSERT [dbo].[Prescriptions] ([PrescriptionID], [Patient_ID], [PrescriptionsCode], [PrescriptionDate], [Status]) VALUES (10, 10, N'02DF2D6A', CAST(N'2022-05-22' AS Date), 1)
INSERT [dbo].[Prescriptions] ([PrescriptionID], [Patient_ID], [PrescriptionsCode], [PrescriptionDate], [Status]) VALUES (11, 11, N'D6FFF0D6', CAST(N'2022-06-22' AS Date), 1)
INSERT [dbo].[Prescriptions] ([PrescriptionID], [Patient_ID], [PrescriptionsCode], [PrescriptionDate], [Status]) VALUES (12, 12, N'820BB9EB', CAST(N'2022-07-22' AS Date), 1)
INSERT [dbo].[Prescriptions] ([PrescriptionID], [Patient_ID], [PrescriptionsCode], [PrescriptionDate], [Status]) VALUES (13, 13, N'E8D8684A', CAST(N'2022-09-22' AS Date), 1)
INSERT [dbo].[Prescriptions] ([PrescriptionID], [Patient_ID], [PrescriptionsCode], [PrescriptionDate], [Status]) VALUES (14, 14, N'50FC11DE', CAST(N'2022-07-22' AS Date), 1)
INSERT [dbo].[Prescriptions] ([PrescriptionID], [Patient_ID], [PrescriptionsCode], [PrescriptionDate], [Status]) VALUES (15, 15, N'3DBFA887', CAST(N'2022-02-28' AS Date), 1)
INSERT [dbo].[Prescriptions] ([PrescriptionID], [Patient_ID], [PrescriptionsCode], [PrescriptionDate], [Status]) VALUES (16, 16, N'475B28E4', CAST(N'2022-02-28' AS Date), 1)
INSERT [dbo].[Prescriptions] ([PrescriptionID], [Patient_ID], [PrescriptionsCode], [PrescriptionDate], [Status]) VALUES (17, 17, N'34D8ACE8', CAST(N'2022-05-26' AS Date), 1)
SET IDENTITY_INSERT [dbo].[Prescriptions] OFF
GO
SET IDENTITY_INSERT [dbo].[Rooms] ON 

INSERT [dbo].[Rooms] ([RoomID], [RoomNumber], [Status]) VALUES (1, 1, 1)
INSERT [dbo].[Rooms] ([RoomID], [RoomNumber], [Status]) VALUES (2, 2, 1)
INSERT [dbo].[Rooms] ([RoomID], [RoomNumber], [Status]) VALUES (3, 3, 0)
INSERT [dbo].[Rooms] ([RoomID], [RoomNumber], [Status]) VALUES (4, 4, 0)
INSERT [dbo].[Rooms] ([RoomID], [RoomNumber], [Status]) VALUES (5, 5, 1)
INSERT [dbo].[Rooms] ([RoomID], [RoomNumber], [Status]) VALUES (6, 6, 0)
INSERT [dbo].[Rooms] ([RoomID], [RoomNumber], [Status]) VALUES (7, 7, 1)
INSERT [dbo].[Rooms] ([RoomID], [RoomNumber], [Status]) VALUES (8, 8, 0)
INSERT [dbo].[Rooms] ([RoomID], [RoomNumber], [Status]) VALUES (9, 9, 0)
INSERT [dbo].[Rooms] ([RoomID], [RoomNumber], [Status]) VALUES (10, 10, 0)
INSERT [dbo].[Rooms] ([RoomID], [RoomNumber], [Status]) VALUES (11, 11, 0)
INSERT [dbo].[Rooms] ([RoomID], [RoomNumber], [Status]) VALUES (12, 12, 0)
INSERT [dbo].[Rooms] ([RoomID], [RoomNumber], [Status]) VALUES (13, 13, 1)
INSERT [dbo].[Rooms] ([RoomID], [RoomNumber], [Status]) VALUES (14, 14, 0)
INSERT [dbo].[Rooms] ([RoomID], [RoomNumber], [Status]) VALUES (15, 15, 0)
INSERT [dbo].[Rooms] ([RoomID], [RoomNumber], [Status]) VALUES (16, 16, 0)
INSERT [dbo].[Rooms] ([RoomID], [RoomNumber], [Status]) VALUES (17, 17, 0)
INSERT [dbo].[Rooms] ([RoomID], [RoomNumber], [Status]) VALUES (18, 18, 0)
INSERT [dbo].[Rooms] ([RoomID], [RoomNumber], [Status]) VALUES (19, 19, 1)
INSERT [dbo].[Rooms] ([RoomID], [RoomNumber], [Status]) VALUES (20, 20, 0)
INSERT [dbo].[Rooms] ([RoomID], [RoomNumber], [Status]) VALUES (21, 21, 1)
INSERT [dbo].[Rooms] ([RoomID], [RoomNumber], [Status]) VALUES (22, 22, 0)
INSERT [dbo].[Rooms] ([RoomID], [RoomNumber], [Status]) VALUES (23, 23, 0)
INSERT [dbo].[Rooms] ([RoomID], [RoomNumber], [Status]) VALUES (24, 24, 0)
INSERT [dbo].[Rooms] ([RoomID], [RoomNumber], [Status]) VALUES (25, 25, 0)
INSERT [dbo].[Rooms] ([RoomID], [RoomNumber], [Status]) VALUES (26, 26, 0)
INSERT [dbo].[Rooms] ([RoomID], [RoomNumber], [Status]) VALUES (27, 27, 1)
INSERT [dbo].[Rooms] ([RoomID], [RoomNumber], [Status]) VALUES (28, 28, 0)
INSERT [dbo].[Rooms] ([RoomID], [RoomNumber], [Status]) VALUES (29, 29, 0)
INSERT [dbo].[Rooms] ([RoomID], [RoomNumber], [Status]) VALUES (30, 30, 0)
SET IDENTITY_INSERT [dbo].[Rooms] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Doctors__2DC0C5B6CF18699E]    Script Date: 25.02.2022 15:49:14 ******/
ALTER TABLE [dbo].[Doctors] ADD UNIQUE NONCLUSTERED 
(
	[DoctorTC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Patients__970E0B9887B52CEA]    Script Date: 25.02.2022 15:49:14 ******/
ALTER TABLE [dbo].[Patients] ADD UNIQUE NONCLUSTERED 
(
	[PatientTC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ck_Prescriptions_PCode]    Script Date: 25.02.2022 15:49:14 ******/
ALTER TABLE [dbo].[Prescriptions] ADD  CONSTRAINT [ck_Prescriptions_PCode] UNIQUE NONCLUSTERED 
(
	[PrescriptionsCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Cities] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[DepartmentDetails] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Departments] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Districts] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Doctors] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Employees] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[ExaminationDetails] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Hospitals] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Inpatients] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Medicines] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Nurses] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[PatientExaminations] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[PatientRegistrations] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Patients] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[PrescriptionDetails] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Prescriptions] ADD  DEFAULT (left(newid(),(8))) FOR [PrescriptionsCode]
GO
ALTER TABLE [dbo].[Prescriptions] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Rooms] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[DepartmentDetails]  WITH CHECK ADD FOREIGN KEY([Department_ID])
REFERENCES [dbo].[Departments] ([DepartmentID])
GO
ALTER TABLE [dbo].[DepartmentDetails]  WITH CHECK ADD FOREIGN KEY([Hospital_ID])
REFERENCES [dbo].[Hospitals] ([HospitalID])
GO
ALTER TABLE [dbo].[Districts]  WITH CHECK ADD FOREIGN KEY([City_ID])
REFERENCES [dbo].[Cities] ([CityID])
GO
ALTER TABLE [dbo].[Doctors]  WITH CHECK ADD FOREIGN KEY([DoctorDepartment_ID])
REFERENCES [dbo].[Departments] ([DepartmentID])
GO
ALTER TABLE [dbo].[Doctors]  WITH CHECK ADD FOREIGN KEY([HospitalID])
REFERENCES [dbo].[Hospitals] ([HospitalID])
GO
ALTER TABLE [dbo].[Doctors]  WITH CHECK ADD FOREIGN KEY([ReportsTo])
REFERENCES [dbo].[Doctors] ([DoctorID])
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD FOREIGN KEY([Hospital_ID])
REFERENCES [dbo].[Hospitals] ([HospitalID])
GO
ALTER TABLE [dbo].[ExaminationDetails]  WITH CHECK ADD FOREIGN KEY([PatientRegistration_ID])
REFERENCES [dbo].[PatientRegistrations] ([PatientRegistrationID])
GO
ALTER TABLE [dbo].[ExaminationDetails]  WITH CHECK ADD FOREIGN KEY([PatientExamination_ID])
REFERENCES [dbo].[PatientExaminations] ([PatientExaminationID])
GO
ALTER TABLE [dbo].[Hospitals]  WITH CHECK ADD FOREIGN KEY([District_ID])
REFERENCES [dbo].[Districts] ([DistrictID])
GO
ALTER TABLE [dbo].[Inpatients]  WITH CHECK ADD FOREIGN KEY([Nurse_ID])
REFERENCES [dbo].[Nurses] ([NurseID])
GO
ALTER TABLE [dbo].[Inpatients]  WITH CHECK ADD FOREIGN KEY([Patient_ID])
REFERENCES [dbo].[Patients] ([PatientID])
GO
ALTER TABLE [dbo].[Inpatients]  WITH CHECK ADD FOREIGN KEY([Room_ID])
REFERENCES [dbo].[Rooms] ([RoomID])
GO
ALTER TABLE [dbo].[Nurses]  WITH CHECK ADD FOREIGN KEY([Hospital_ID])
REFERENCES [dbo].[Hospitals] ([HospitalID])
GO
ALTER TABLE [dbo].[PatientRegistrations]  WITH CHECK ADD FOREIGN KEY([Doctor_ID])
REFERENCES [dbo].[Doctors] ([DoctorID])
GO
ALTER TABLE [dbo].[PatientRegistrations]  WITH CHECK ADD FOREIGN KEY([Patient_ID])
REFERENCES [dbo].[Patients] ([PatientID])
GO
ALTER TABLE [dbo].[PrescriptionDetails]  WITH CHECK ADD FOREIGN KEY([Medicine_ID])
REFERENCES [dbo].[Medicines] ([MedicineID])
GO
ALTER TABLE [dbo].[PrescriptionDetails]  WITH CHECK ADD FOREIGN KEY([Prescription_ID])
REFERENCES [dbo].[Prescriptions] ([PrescriptionID])
GO
ALTER TABLE [dbo].[Prescriptions]  WITH CHECK ADD FOREIGN KEY([Patient_ID])
REFERENCES [dbo].[Patients] ([PatientID])
GO
/****** Object:  StoredProcedure [dbo].[sp_CityDelete]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_CityDelete]					
(
	@CityID int
)
as
UPDATE Cities set [Status]=0 where CityID=@CityID
GO
/****** Object:  StoredProcedure [dbo].[sp_CityInsert]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_CityInsert]         
(
@CityName nvarchar(50)
)
AS
INSERT Cities (CityName) values (@CityName)
GO
/****** Object:  StoredProcedure [dbo].[sp_DepartmentDelete]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_DepartmentDelete]
(
@spDepartmentID int
)
AS
UPDATE Departments SET [Status] = 0 where DepartmentID = @spDepartmentID
GO
/****** Object:  StoredProcedure [dbo].[sp_DepartmentsInsert]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_DepartmentsInsert]
(
@spDepartmentName nvarchar(50)
)
AS
INSERT Departments (DepartmentName) Values(@spDepartmentName)
GO
/****** Object:  StoredProcedure [dbo].[sp_DistrictDelete]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_DistrictDelete]					
(
	@DistrictID int
)
as
UPDATE Districts set [Status]=0 where DistrictID=@DistrictID
GO
/****** Object:  StoredProcedure [dbo].[sp_DistrictInsert]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_DistrictInsert]         
(
@DistrictName nvarchar(50),
@City_ID int
)
as
insert Districts (DistrictName,City_ID) values (@DistrictName,@City_ID)
GO
/****** Object:  StoredProcedure [dbo].[sp_DoctorsDelete]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_DoctorsDelete]
(
@Doc_ID int
)
as
UPDATE Doctors set [Status] = 0 where DoctorID = @Doc_ID
GO
/****** Object:  StoredProcedure [dbo].[sp_DoctorsInsert]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_DoctorsInsert]
(
@DoctorTC nchar(11),
@DoctorName nvarchar(50),
@DoctorLastname nvarchar(50),
@DoctorBirthDate date,
@DoctorGender bit,
@DoctorPhoneNumber nchar(13),
@DoctorTitle nvarchar(50),
@DoctorDepartment_ID int,    
@ReportsTo int
)
as 
INSERT Doctors(DoctorTC,DoctorName,DoctorLastname,DoctorBirthDate,DoctorGender,DoctorPhoneNumber,DoctorTitle,DoctorDepartment_ID,ReportsTo) VALUES(@DoctorTC,@DoctorName,@DoctorLastname,@DoctorBirthDate,@DoctorGender,@DoctorPhoneNumber,@DoctorTitle,@DoctorDepartment_ID,@ReportsTo)
GO
/****** Object:  StoredProcedure [dbo].[sp_DoctorsUpdate]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[sp_DoctorsUpdate]
(
@DoctorID int,
@DoctorLastName nvarchar(50),
@DoctorPhoneNumber nchar(13),
@DoctorTitle nvarchar(50),
@ReportsTo int
)
AS

Update Doctors SET DoctorLastname=@DoctorLastName,DoctorPhoneNumber=@DoctorPhoneNumber,DoctorTitle=@DoctorTitle,ReportsTo=@ReportsTo
where DoctorID=@DoctorID
GO
/****** Object:  StoredProcedure [dbo].[sp_EmployeeDelete]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_EmployeeDelete]
(
@EmployeeID int
)
AS
UPDATE Employees set [Status]=0 where EmployeeID=@EmployeeID
GO
/****** Object:  StoredProcedure [dbo].[sp_EmployeeInsert]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_EmployeeInsert]
(
@EmployeeName nvarchar(50),
@EmployeeLastname nvarchar(50),			
@Hospital_ID int,
@EmployeeBirthdate date,
@EmployeeAdress nvarchar(200),
@EmployeeGender bit,
@EmployeePhoneNumber nchar(13),
@EmployeeDuty nvarchar(50)
)
AS
INSERT Employees(EmployeeName,EmployeeLastname,Hospital_ID,EmployeeBirthdate,EmployeeAdress,EmployeeGender,EmployeePhoneNumber,EmployeeDuty) 
VALUES (@EmployeeName,@EmployeeLastname,@Hospital_ID,@EmployeeBirthdate,@EmployeeAdress,@EmployeeGender,@EmployeePhoneNumber,@EmployeeDuty)
GO
/****** Object:  StoredProcedure [dbo].[sp_EmployeesUpdate]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[sp_EmployeesUpdate] 
(
@EmployeeID int,
@EmployeeLastName nvarchar(50),
@EmployeeAdress nvarchar(50),
@EmployeePhoneNumber nchar(13),
@EmployeeDuty nvarchar(50)
)
AS
Update Employees SET EmployeeLastname=@EmployeeLastName,EmployeeAdress=@EmployeeAdress,EmployeePhoneNumber=@EmployeePhoneNumber,EmployeeDuty=@EmployeeDuty
where EmployeeID=@EmployeeID
GO
/****** Object:  StoredProcedure [dbo].[sp_HospitalDelete]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_HospitalDelete]                   
(
@HospitalID int
)
as
UPDATE Hospitals set [Status]=0 where HospitalID=@HospitalID
GO
/****** Object:  StoredProcedure [dbo].[sp_HospitalInsert]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_HospitalInsert]                  
(
@HospitalName nvarchar(50),
@HospitalAdress nvarchar(200),
@HospitalPhoneNumber nchar(13),
@District_ID int
)
as
insert Hospitals (HospitalName,HospitalAdress,HospitalPhoneNumber,District_ID) 
values (@HospitalName,@HospitalAdress,@HospitalPhoneNumber,@District_ID)
GO
/****** Object:  StoredProcedure [dbo].[sp_InpatientInsert]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[sp_InpatientInsert]
(
@Patient_ID  int,
@Nurse_ID int,
@Room_ID int,
@Hospitalization date,
@DischargedDate date,
@Status bit
)
AS

INSERT InPatients(Patient_ID,Nurse_ID,Room_ID,HospitalizationDate,DischargedDate,[Status]) Values(@Patient_ID,@Nurse_ID,@Room_ID,@Hospitalization,@DischargedDate,@Status)
GO
/****** Object:  StoredProcedure [dbo].[sp_InPatientStatusUpdate]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[sp_InPatientStatusUpdate]
(
@InPatientID int
)
AS

Update Inpatients SET [Status]=0 where InpatientID=@InPatientID
GO
/****** Object:  StoredProcedure [dbo].[sp_InpatientUpdate]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[sp_InpatientUpdate]
(
@InpatientID int,
@Nurse_ID int,
@Room_ID int,
@HospitalizationDate date,
@DischargedDate date
)
AS
Update InPatients SET Nurse_ID=@Nurse_ID,Room_ID=@Room_ID,HospitalizationDate=@HospitalizationDate,DischargedDate=@DischargedDate
where InpatientID=@InpatientID
GO
/****** Object:  StoredProcedure [dbo].[sp_MedicineDelete]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_MedicineDelete]					
(
	@MedicineID int
)
as
update Medicines set [Status]=0 where MedicineID=@MedicineID
GO
/****** Object:  StoredProcedure [dbo].[sp_MedicineInsert]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_MedicineInsert]				
(
	@MedicineName nvarchar(150)
)
as
insert Medicines(MedicineName) values(@MedicineName) 
GO
/****** Object:  StoredProcedure [dbo].[sp_NursesInsert]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[sp_NursesInsert]
(
@NurseName nvarchar(50),
@NurseLastname nvarchar(50),
@NurseBirthdate date,
@NurseAdress nvarchar(200),
@NurseGender bit,
@NursePhoneNumber nchar(13)
)
AS
INSERT Nurses(NurseName,NurseLastname,NurseBirthdate,NurseAdress,NurseGender,NursePhoneNumber) VALUES(@NurseName,@NurseLastname,@NurseBirthdate,@NurseAdress,@NurseGender,@NursePhoneNumber)
GO
/****** Object:  StoredProcedure [dbo].[sp_NursesStatusUpdate]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[sp_NursesStatusUpdate]
(
@NurseID int
)
AS
Update Nurses SET [Status]=0 where  NurseID=@NurseID
GO
/****** Object:  StoredProcedure [dbo].[sp_NursesUpdate]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[sp_NursesUpdate]
(
@NurseID int,
@NurseLastname nvarchar(50),
@NurseAdress nvarchar(200),
@NursePhoneNumber nchar(13)
)
AS

Update Nurses SET NurseLastname=@NurseLastname,NurseAdress=@NurseAdress,NursePhoneNumber=@NursePhoneNumber
where NurseID=@NurseID
GO
/****** Object:  StoredProcedure [dbo].[sp_PatientExaminationInsert]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[sp_PatientExaminationInsert]
(
@ProcessName nvarchar(50),
@ProcessUnitPrice decimal(14, 2)
)
AS
INSERT PatientExaminations(PatientExaminationName,PatientExaminationUnitPrice) VALUES (@ProcessName,@ProcessUnitPrice)
GO
/****** Object:  StoredProcedure [dbo].[sp_PatientExaminationStatus]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_PatientExaminationStatus]
(
@Id int
)
AS
UPDATE PatientExaminations SET [Status] = 0 where  PatientExaminationID = @Id;
GO
/****** Object:  StoredProcedure [dbo].[sp_PatientRegistrationInsert]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[sp_PatientRegistrationInsert]
(
@Patient_Id int,
@Doctor_Id int,
@AppointmentDate date,
@AppointmentTime time(0),
@PatientSymptoms nvarchar(150)
)
AS
INSERT PatientRegistrations (Patient_ID,Doctor_ID,AppointmentDate,AppointmentTime,PatientSymptoms)
Values (@Patient_Id,@Doctor_Id,@AppointmentDate,@AppointmentTime,@PatientSymptoms)
GO
/****** Object:  StoredProcedure [dbo].[sp_PatientRegistrationStatus]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_PatientRegistrationStatus]
(
@Id int
)
AS
UPDATE PatientRegistrations SET [Status] = 0 where PatientRegistrationID = @Id;
GO
/****** Object:  StoredProcedure [dbo].[sp_PatientsInsert]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[sp_PatientsInsert]
(
@PatientTC nchar(11),
@PatientName nvarchar(50),
@PatientLastName nvarchar(50),
@PatientBirthDay date,
@PatientGender bit,
@PatientPhoneNumber nchar(13)
)
AS
INSERT Patients(PatientTC,PatientName,PatientLastname,PatientBirthDate,PatientGender,PatientPhoneNumber)
Values (@PatientTC,@PatientName,@PatientLastName,@PatientBirthDay,@PatientGender,@PatientPhoneNumber)
GO
/****** Object:  StoredProcedure [dbo].[sp_PatientStatus]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_PatientStatus]
(
@Id int
)
AS
UPDATE Patients SET [Status] = 0 where PatientID = @Id;
GO
/****** Object:  StoredProcedure [dbo].[sp_PrescriptionDetailsInsert]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_PrescriptionDetailsInsert]		--REÇETE İLAÇ EKLEME
(
	@PrescriptionID int,
	@PatientID int
)
as
insert PrescriptionDetails(Prescription_ID,Medicine_ID) values (@PrescriptionID,@PatientID)
GO
/****** Object:  StoredProcedure [dbo].[sp_PrescriptionsInsert]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_PrescriptionsInsert]				
(
@P_ID	int
)
as
insert Prescriptions(Patient_ID,PrescriptionDate) values (@P_ID,GETDATE())
GO
/****** Object:  StoredProcedure [dbo].[sp_RoomsInsert]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[sp_RoomsInsert]
(
@RoomNumber int,
@Status bit
)
AS
INSERT Rooms(RoomNumber,[Status]) VALUES (@RoomNumber,@Status)
GO
/****** Object:  StoredProcedure [dbo].[sp_RoomsStatusUpdate]    Script Date: 25.02.2022 15:49:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[sp_RoomsStatusUpdate]
(
@RoomID int
)
AS
Update Rooms SET [Status]=0 where RoomID=@RoomID
GO
