--�EH�R EKLEME PROSED�R�
create proc sp_CityInsert         
(
@CityName nvarchar(50)
)
AS
INSERT Cities (CityName) values (@CityName)
GO

--�EH�R DURUM G�NCELLEME 
create proc sp_CityDelete					
(
	@CityID int
)
as
UPDATE Cities set [Status]=0 where CityID=@CityID
GO

--�L�E EKLEME PROSED�R�
create proc sp_DistrictInsert         
(
@DistrictName nvarchar(50),
@City_ID int
)
as
insert Districts (DistrictName,City_ID) values (@DistrictName,@City_ID)
GO

--�L�E DURUM G�NCELLEME
create proc sp_DistrictDelete					
(
	@DistrictID int
)
as
UPDATE Districts set [Status]=0 where DistrictID=@DistrictID
GO

--HASTANE EKLEME PROSED�R 
create proc sp_HospitalInsert                  
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

--HASTANE DURUM G�NCELLEME 
create proc sp_HospitalDelete                   
(
@HospitalID int
)
as
UPDATE Hospitals set [Status]=0 where HospitalID=@HospitalID
GO

--�ALI�AN EKLEME PROSED�R 
create proc sp_EmployeeInsert
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


--�ALI�AN DURUM G�NCELLEME PROSED�R�
create proc sp_EmployeeDelete
(
@EmployeeID int
)
AS
UPDATE Employees set [Status] = 0 where EmployeeID=@EmployeeID
GO

-- *********************** 

--HASTA DURUM G�NCELLEME PROSED�R�
GO
CREATE PROC sp_PatientStatus
(
@Id int
)
AS
UPDATE Patients SET [Status] = 0 where PatientID = @Id;
GO

--EXEC sp_PatientStatus 3

--HASTA EKLEME PROSED�R�

GO
Create proc sp_PatientsInsert
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

-- EXEC sp_PatientsInsert '34567812367','Gamze','Tun�','1995-05-24',1,'+905415744378'

--HASTA KAYIT G�NCELLEME PROSED�R�
GO
CREATE PROC sp_PatientRegistrationStatus
(
@Id int
)
AS
UPDATE PatientRegistrations SET [Status] = 0 where PatientRegistrationID = @Id;
GO

--EXEC sp_PatientRegistrationStatus 3


--HASTA KAYIT EKLEME 

GO
Create proc sp_PatientRegistrationInsert
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

--EXEC sp_PatientRegistrationInsert 18,4,'2022-03-03','13:35:00','Di� �ekimi'

--HASTA ��LEM DURUM G�NCELLEME PROSED�R�
GO
CREATE PROC sp_PatientExaminationStatus
(
@Id int
)
AS
UPDATE PatientExaminations SET [Status] = 0 where  PatientExaminationID = @Id;
GO

--EXEC sp_PatientExaminationStatus 1

--HASTA ��LEM EKLEME PROSED�R�

GO
Create proc sp_PatientExaminationInsert
(
@ProcessName nvarchar(50),
@ProcessUnitPrice decimal(14, 2)
)
AS
INSERT PatientExaminations(PatientExaminationName,PatientExaminationUnitPrice) VALUES (@ProcessName,@ProcessUnitPrice)
GO

--EXEC sp_PatientExaminationInsert 'Di� �ekimi',350.00

--YATAN HASTA EKLEME PROSED�R�
GO
Create proc sp_InpatientInsert
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
--EXEC sp_InpatientInsert 6,2,1,'2021-01-25','2021-03-05',0

--YATAN HASTA DURUM G�NCELLEME PROSED�R�
Go
Create proc sp_InPatientStatusUpdate
(
@InPatientID int
)
AS

Update Inpatients SET [Status]=0 where InpatientID=@InPatientID
Go


--Exec sp_InPatientStatusUpdate 1
-- HEM��RE EKLEME PROSED�R� 
GO
Create proc sp_NursesInsert
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

--EXEC sp_NursesInsert 'B��ra','Y�ld�z','1998-02-02','Atat�rk Mahallesi 2065 sokak �sk�dar/�stanbul',1,'+905325678945'

--HEM��RE DURUM G�NCELLEME PROSED�R� 

GO
Create proc sp_NursesStatusUpdate
(
@NurseID int
)
AS
Update Nurses SET [Status]=0 where  NurseID=@NurseID
GO

--EXEC Sp_NursesStatusUpdate 8


--ODA EKLEME PROSED�R� 
GO
Create Proc sp_RoomsInsert
(
@RoomNumber int,
@Status bit
)
AS
INSERT Rooms(RoomNumber,[Status]) VALUES (@RoomNumber,@Status)
GO

--Exec sp_RoomsInsert 15,0

--ODA DURUMU S�LME PROSED�R� 
GO
Create proc sp_RoomsStatusUpdate
(
@RoomID int
)
AS
Update Rooms SET [Status]=0 where RoomID=@RoomID
GO

--EXEC Sp_RoomsStatusUpdate 1


-- YATAN HASTA B�LG� G�NCELLEME PROSED�R�

GO
Create proc sp_InpatientUpdate
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
--EXEC sp_InpatientUpdate 2,5,12,'2022-02-22','2022-02-28'



--HEM��RE B�LG� G�NCELLEME PROSED�R�

GO
Create proc sp_NursesUpdate
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

--EXEC sp_NursesUpdate  1,'B�y�k','Kozyata�� mh. �ay�r Cd. No:2/5 Kad�k�y/�stanbul','+905453415798'


--DOKTOR B�LG� G�NCELLEME PROSED�R�

GO
Create proc sp_DoctorsUpdate
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

--EXEC sp_DoctorsUpdate 1,'K�se','+905363772577','Profes�r Doktor',3

--�ALI�AN B�LG� G�NCELLEME PROSED�R�

GO
Create proc sp_EmployeesUpdate 
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

--Exec sp_EmployeesUpdate 1,'Y�lmaz �elik','�erifali Cd., K���kbakkalk�y, 34750 Ata�ehir/�stanbul','+905395393939','Temizlik Personeli'



--�LA� EKLEME PROSED�R�
GO
create proc sp_MedicineInsert				
(
	@MedicineName nvarchar(150)
)
as
insert Medicines(MedicineName) values(@MedicineName) 
GO

--�LA� DURUM G�NCELLEME PROSED�R�
create proc sp_MedicineDelete					
(
	@MedicineID int
)
as
update Medicines set [Status]=0 where MedicineID=@MedicineID
GO

--RE�ETE EKLEME PROSED�R�
GO
create proc sp_PrescriptionsInsert				
(
@P_ID	int
)
as
insert Prescriptions(Patient_ID,PrescriptionDate) values (@P_ID,GETDATE())
GO



--RE�ETEYE �LA� EKLEME PROSED�R�
GO
create proc sp_PrescriptionDetailsInsert		--RE�ETE �LA� EKLEME
(
	@PrescriptionID int,
	@PatientID int
)
as
insert PrescriptionDetails(Prescription_ID,Medicine_ID) values (@PrescriptionID,@PatientID)
GO

--DOKTOR EKLEME PROSED�R�
GO
create proc sp_DoctorsInsert
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

--EXEC sp_DoctorsInsert

--DOKTOR DURUM G�NCELLEME PROSED�R�
GO
create proc sp_DoctorsDelete
(
@Doc_ID int
)
as
UPDATE Doctors set [Status] = 0 where DoctorID = @Doc_ID
GO



--DEPARTMAN EKLEME PROSED�R�
GO
create proc sp_DepartmentsInsert
(
@spDepartmentName nvarchar(50)
)
AS
INSERT Departments (DepartmentName) Values(@spDepartmentName)
GO

--DEPARTMAN DURUM G�NCELLEME PROSED�R�
GO
create proc sp_DepartmentDelete
(
@spDepartmentID int
)
AS
UPDATE Departments SET [Status] = 0 where DepartmentID = @spDepartmentID
GO

