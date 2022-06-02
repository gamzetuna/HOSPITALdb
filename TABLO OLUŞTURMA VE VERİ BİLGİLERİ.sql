--Create database HOSPITALS
/*
USE HOSPITALS
GO
*/
-------------------- Þehirler
create table Cities(
CityID int not null primary key identity(1,1),
CityName nvarchar(50),
[Status] bit DEFAULT 1
)


----------------- Bölgeler
create table Districts(
DistrictID int not null primary key identity(1,1),
DistrictName nvarchar(50),
City_ID int,
[Status] bit DEFAULT 1
FOREIGN KEY (City_ID) REFERENCES Cities(CityID)
)


-------------------Hastaneler

create table Hospitals(
HospitalID int not null primary key identity(1,1),
HospitalName nvarchar(50),
HospitalAdress nvarchar(200),
HospitalPhoneNumber nchar(13),
District_ID int,
[Status] bit DEFAULT 1,
FOREIGN KEY (District_ID) REFERENCES Districts(DistrictID)
)


--------------------- Çalýþanlar

create table Employees(
EmployeeID int not null primary key identity(1,1),
EmployeeName nvarchar(50),
EmployeeLastname nvarchar(50),
Hospital_ID int,
EmployeeBirthdate date,
EmployeeAdress nvarchar(200),
EmployeeGender bit,
EmployeePhoneNumber nchar(13),
EmployeeDuty nvarchar(50),
[Status] bit DEFAULT 1,
FOREIGN KEY (Hospital_ID) REFERENCES Hospitals(HospitalID)
)




------------------ DEPARTMANLAR--------------
create table Departments (
DepartmentID int not null primary key identity(1,1),
DepartmentName nvarchar(50),
[Status] bit DEFAULT 1
)

-------------------DEPARTMAN DETAY---------------

create table DepartmentDetails(
Hospital_ID int,
Department_ID int,
[Status] bit DEFAULT 1,
PRIMARY KEY (Hospital_ID, Department_ID),
FOREIGN KEY (Hospital_ID) REFERENCES Hospitals(HospitalID),
FOREIGN KEY (Department_ID) REFERENCES Departments(DepartmentID)
)


 ------------------DOKTORLAR---------------
create table Doctors (
DoctorID int not null primary key identity(1,1),
HospitalID int,
DoctorTC nchar(11) UNIQUE,
DoctorName nvarchar(50),
DoctorLastname nvarchar(50),
DoctorBirthDate date,
DoctorGender bit,
DoctorPhoneNumber nchar(13),
DoctorTitle nvarchar(50),
DoctorDepartment_ID int,     --- FOREIGN KEY
ReportsTo int,
[Status] bit DEFAULT 1,
FOREIGN KEY (DoctorDepartment_ID) REFERENCES Departments(DepartmentID),
FOREIGN KEY(HospitalID) References Hospitals(HospitalID ),
FOREIGN KEY (ReportsTo) REFERENCES Doctors(DoctorID)
)

------------------- HASTALAR---------------
create table Patients (
PatientID int not null primary key identity(1,1),
PatientTC nchar(11) UNIQUE,
PatientName nvarchar(50),
PatientLastname nvarchar(50),
PatientBirthDate date,
PatientGender bit,
PatientPhoneNumber nchar(13),
[Status] bit DEFAULT 1
)

------------------ HASTA KAYIT----------------------
create table PatientRegistrations (
PatientRegistrationID int not null primary key identity(1,1),
Patient_ID int, 
Doctor_ID int,
AppointmentDate date,
AppointmentTime time(0),   
PatientSymptoms nvarchar(150),
[Status] bit DEFAULT 1,
FOREIGN KEY (Patient_ID) REFERENCES Patients(PatientID),
FOREIGN KEY (Doctor_ID) REFERENCES Doctors(DoctorID)
)


-----------HASTA MUAYENE--------


create table PatientExaminations (
PatientExaminationID int not null primary key identity(1,1),
PatientExaminationName nvarchar(50),
PatientExaminationUnitPrice decimal(14,2),
[Status] bit DEFAULT 1
)

----------- MUAYENE DETAY --------------

create table ExaminationDetails (
PatientRegistration_ID int,
PatientExamination_ID int,
PatientExaminationQuantity int,
[Status] bit DEFAULT 1,
PRIMARY KEY (PatientRegistration_ID, PatientExamination_ID),
FOREIGN KEY (PatientRegistration_ID) REFERENCES  PatientRegistrations(PatientRegistrationID),
FOREIGN KEY (PatientExamination_ID) REFERENCES PatientExaminations(PatientExaminationID)
)

------------- REÇETELER ----------------
create table Prescriptions (
PrescriptionID int not null primary key identity(1,1),
Patient_ID int,
PrescriptionsCode nvarchar(10) DEFAULT LEFT(NEWID(),8),
PrescriptionDate Date,
[Status] bit DEFAULT 1,
FOREIGN KEY (Patient_ID) REFERENCES Patients(PatientID),
constraint ck_Prescriptions_PCode UNIQUE (PrescriptionsCode)
)

---------------Ýlaçlar--------------------

create table Medicines (
MedicineID int not null primary key identity(1,1),
MedicineName nvarchar(200),
[Status] bit DEFAULT 1,
)


----------------REÇETE DETAY--------------

create table PrescriptionDetails(
Prescription_ID int,
Medicine_ID int,
[Status] bit DEFAULT 1,
PRIMARY KEY (Prescription_ID,Medicine_ID),
FOREIGN KEY (Prescription_ID) REFERENCES Prescriptions(PrescriptionID),
FOREIGN KEY (Medicine_ID) REFERENCES Medicines(MedicineID)
)


---------------- HEMÞÝRELER-----------------------------------

create table Nurses(
NurseID int not null primary key identity(1,1),
Hospital_ID int,
NurseName nvarchar(50),
NurseLastname nvarchar(50),
NurseBirthdate date,
NurseAdress nvarchar(200),
NurseGender bit,
NursePhoneNumber nchar(13),
[Status] bit DEFAULT 1,
FOREIGN KEY(Hospital_ID) References Hospitals(HospitalID)
)

----------------ROOMS--------------------------

create table Rooms(
RoomID int not null primary key identity(1,1),
RoomNumber int,
[Status] bit DEFAULT 1,
)


--------------- YATAN HASTALAR ----------------------

create table Inpatients(
InpatientID int not null primary key identity(1,1),
Patient_ID int,
Nurse_ID int,
Room_ID int,
HospitalizationDate date,
DischargedDate date,
[Status] bit DEFAULT 1,
FOREIGN KEY (Nurse_ID) REFERENCES Nurses(NurseID),
FOREIGN KEY (Room_ID) REFERENCES Rooms(RoomID),
FOREIGN KEY (Patient_ID) REFERENCES Patients(PatientID)
)

--*************************************  VERÝLER *********************************************************

Insert Cities(CityName) values('Ýstanbul')
Insert Cities(CityName) values('Ankara')
Insert Cities(CityName) values('Ýzmir')

Insert Districts(DistrictName,City_ID) Values('Ataþehir',1)
Insert Districts(DistrictName,City_ID) Values('Kadýköy',1)
Insert Districts(DistrictName,City_ID) Values('Kartal',1)
Insert Districts(DistrictName,City_ID) Values('Maltepe',1)
Insert Districts(DistrictName,City_ID) Values('Pendik',1)
Insert Districts(DistrictName,City_ID) Values('Beypazarý',2)
Insert Districts(DistrictName,City_ID) Values('Çankaya',2)
Insert Districts(DistrictName,City_ID) Values('Kýzýlcahamam',2)
Insert Districts(DistrictName,City_ID) Values('Mamak',2)
Insert Districts(DistrictName,City_ID) Values('Polatlý',2)
Insert Districts(DistrictName,City_ID) Values('Çeþme',3)
Insert Districts(DistrictName,City_ID) Values('Foça',3)
Insert Districts(DistrictName,City_ID) Values('Konak',3)
Insert Districts(DistrictName,City_ID) Values('Seferihisar',3)
Insert Districts(DistrictName,City_ID) Values('Urla',3)

--- HASTANELER VERÝ

insert Hospitals(HospitalName,HospitalAdress,HospitalPhoneNumber,District_ID) values('Özel Fenerbahçe Ataþehir Hastanesi','Atatürk Mah. Ataþehir Bulv,34758 Ataþehir','+902163561907',1)					
insert Hospitals(HospitalName,HospitalAdress,HospitalPhoneNumber,District_ID) values('Özel Fenerbahçe Çankaya Hastanesi','Balgat Mah. Mevlana Bulv, 1422. Sk. No: 4, 06520 Çankaya','+903122531907',7)	
insert Hospitals(HospitalName,HospitalAdress,HospitalPhoneNumber,District_ID) values('Özel Fenerbahçe Konak Hastanesi','Çýnarlý Mah. Fatih Caddesi No:10, 35110 Konak','+902324771907',13)	
----------------------

---------- ÇALIÞANLAR -------------

Insert Employees(EmployeeName,EmployeeLastname,Hospital_ID,EmployeeBirthdate,EmployeeAdress,EmployeeGender,EmployeePhoneNumber,EmployeeDuty) 
Values('Zeynep','Yýlmaz',1,'1984-02-01','Þerifali Cd., Küçükbakkalköy, 34750 Ataþehir/Ýstanbul',1,'+905395393939','Temizlik Personeli')
Insert Employees(EmployeeName,EmployeeLastname,Hospital_ID,EmployeeBirthdate,EmployeeAdress,EmployeeGender,EmployeePhoneNumber,EmployeeDuty) 
Values('Yusuf','Kaya',1,'1989-01-02','Kýrmýzý Kuþak Sk. 12-28, Rasimpaþa, 34716 Kadýköy/Ýstanbul',0,'+905305303030','Sekreter')
Insert Employees(EmployeeName,EmployeeLastname,Hospital_ID,EmployeeBirthdate,EmployeeAdress,EmployeeGender,EmployeePhoneNumber,EmployeeDuty) 
Values('Elif','Demir',1,'1996-02-03','Atölyeler Sk. No:3, Yunus, 34873 Kartal/Ýstanbul',1,'+905325323232','Güvenlik Personeli')
Insert Employees(EmployeeName,EmployeeLastname,Hospital_ID,EmployeeBirthdate,EmployeeAdress,EmployeeGender,EmployeePhoneNumber,EmployeeDuty) 
Values('Ömer','Çelik',1,'1993-01-04','Sevinç Sok. 11 B, Feyzullah, 34843 Maltepe/Ýstanbul',0,'+905304464646','Temizlik Personeli')
Insert Employees(EmployeeName,EmployeeLastname,Hospital_ID,EmployeeBirthdate,EmployeeAdress,EmployeeGender,EmployeePhoneNumber,EmployeeDuty) 
Values('Mustafa','Þahin',1,'1980-02-05','Karadeniz Cd. 34-46, Kaynarca, 34890 Pendik/Ýstanbul',0,'+905307161616','Aþçý')
Insert Employees(EmployeeName,EmployeeLastname,Hospital_ID,EmployeeBirthdate,EmployeeAdress,EmployeeGender,EmployeePhoneNumber,EmployeeDuty) 
Values('Hamza','Arslan',2,'1986-02-11','Beypazarý, Hacýkara, 06730 Beypazarý/Ankara',0,'+905313516160','Güvenlik Personeli')
Insert Employees(EmployeeName,EmployeeLastname,Hospital_ID,EmployeeBirthdate,EmployeeAdress,EmployeeGender,EmployeePhoneNumber,EmployeeDuty) 
Values('Mehmet','Güneþ',2,'1997-01-12','Ziya Gökalp Caddesi No: 11 Kýzýlay/Ankara',0,'+905345343434','Temizlik Görevlisi')
Insert Employees(EmployeeName,EmployeeLastname,Hospital_ID,EmployeeBirthdate,EmployeeAdress,EmployeeGender,EmployeePhoneNumber,EmployeeDuty) 
Values('Ayþe','Avcý',2,'1998-02-13','Küçük Hamam Cd. No:6, Yenice, 06890 Kýzýlcahamam/Ankara',1,'+905353837016','Aþçý')
Insert Employees(EmployeeName,EmployeeLastname,Hospital_ID,EmployeeBirthdate,EmployeeAdress,EmployeeGender,EmployeePhoneNumber,EmployeeDuty) 
Values('Defne','Bozkurt',2,'1990-01-14','Kutludüðün, 06635 Mamak/Ankara',1,'+905304484848','Sekreter')
Insert Employees(EmployeeName,EmployeeLastname,Hospital_ID,EmployeeBirthdate,EmployeeAdress,EmployeeGender,EmployeePhoneNumber,EmployeeDuty) 
Values('Ýsmet','Özer',2,'1982-02-15','Halit Ürek Cd., Gülveren, 06900 Polatlý/Ankara',0,'+905373515151','Temizlik Görevlisi') 
Insert Employees(EmployeeName,EmployeeLastname,Hospital_ID,EmployeeBirthdate,EmployeeAdress,EmployeeGender,EmployeePhoneNumber,EmployeeDuty) 
Values('Emine','Yýldýz',3,'1977-01-06','2002. Sk., Musalla, 35930 Çeþme/Ýzmir',1,'+905365363636','Sekreter')
Insert Employees(EmployeeName,EmployeeLastname,Hospital_ID,EmployeeBirthdate,EmployeeAdress,EmployeeGender,EmployeePhoneNumber,EmployeeDuty) 
Values('Öykü','Yýldýrým',3,'1995-02-07','181. Sk. 14-26, Fevzipaþa, 35680 Foça/Ýzmir',1,'+905385383838','Temizlik Personeli')
Insert Employees(EmployeeName,EmployeeLastname,Hospital_ID,EmployeeBirthdate,EmployeeAdress,EmployeeGender,EmployeePhoneNumber,EmployeeDuty) 
Values('Fatma','Öztürk',3,'1979-01-08','998/2. Sk. 11 B, Kadifekale, 35270 Konak/Ýzmir',1,'+905375373737','Güvenlik Personeli')
Insert Employees(EmployeeName,EmployeeLastname,Hospital_ID,EmployeeBirthdate,EmployeeAdress,EmployeeGender,EmployeePhoneNumber,EmployeeDuty) 
Values('Kerem','Aydýn',3,'1991-02-09','1054. Sk. No:8, Tepecik, 35460 Seferihisar/Ýzmir',0,'+905353838383','Aþçý')
Insert Employees(EmployeeName,EmployeeLastname,Hospital_ID,EmployeeBirthdate,EmployeeAdress,EmployeeGender,EmployeePhoneNumber,EmployeeDuty) 
Values('Ahmet','Özdemir',3,'1987-01-10','12073. Sk. 32/17, Gülbahçe Mh, 35433 Urla/Ýzmir',0,'+905332848484','Temizlik Görevlisi')

--DEPARTMANLAR VERÝ 

insert Departments(DepartmentName) values('Aðýz,Diþ ve Çene Cerrahisi')				     
insert Departments(DepartmentName) values('Beyin ve Sinir Cerrahisi')					
insert Departments(DepartmentName) values('Deri ve Zührevi Hastalýklarý (Cildiye)')	    
insert Departments(DepartmentName) values('Diþ Hekimliði (Genel Diþ)')				   
insert Departments(DepartmentName) values('Gastroenteroloji')							
insert Departments(DepartmentName) values('Göðüs Hastalýklarý')						
insert Departments(DepartmentName) values('Göz Hastalýklarý')							
insert Departments(DepartmentName) values('Ýç Hastalýklarý (Dahiliye)')				
insert Departments(DepartmentName) values('Kardiyoloji')								
insert Departments(DepartmentName) values('Kulak Burun Boðaz Hastalýklarý')			
insert Departments(DepartmentName) values('Nöroloji')									
insert Departments(DepartmentName) values('Ortopedi ve Travmatoloji')					
insert Departments(DepartmentName) values('Plastik, Rekonstrüktif ve Estetik Cerrahi')
insert Departments(DepartmentName) values('Ruh Saðlýðý ve Hastalýklarý (Psikiyatri)')	
insert Departments(DepartmentName) values('Üroloji')									

-- DEPARTMAN DETAY VERÝ
insert DepartmentDetails(Hospital_ID,Department_ID) values(1,1)
insert DepartmentDetails(Hospital_ID,Department_ID) values(1,2)
insert DepartmentDetails(Hospital_ID,Department_ID) values(1,3)
insert DepartmentDetails(Hospital_ID,Department_ID) values(1,4)
insert DepartmentDetails(Hospital_ID,Department_ID) values(1,5)
insert DepartmentDetails(Hospital_ID,Department_ID) values(1,6)
insert DepartmentDetails(Hospital_ID,Department_ID) values(1,7)
insert DepartmentDetails(Hospital_ID,Department_ID) values(1,8)
insert DepartmentDetails(Hospital_ID,Department_ID) values(1,9)
insert DepartmentDetails(Hospital_ID,Department_ID) values(1,10)
insert DepartmentDetails(Hospital_ID,Department_ID) values(1,11)
insert DepartmentDetails(Hospital_ID,Department_ID) values(1,12)

insert DepartmentDetails(Hospital_ID,Department_ID) values(2,1)
insert DepartmentDetails(Hospital_ID,Department_ID) values(2,2)
insert DepartmentDetails(Hospital_ID,Department_ID) values(2,3)
insert DepartmentDetails(Hospital_ID,Department_ID) values(2,4)
insert DepartmentDetails(Hospital_ID,Department_ID) values(2,5)
insert DepartmentDetails(Hospital_ID,Department_ID) values(2,6)
insert DepartmentDetails(Hospital_ID,Department_ID) values(2,7)
insert DepartmentDetails(Hospital_ID,Department_ID) values(2,8)
insert DepartmentDetails(Hospital_ID,Department_ID) values(2,9)
insert DepartmentDetails(Hospital_ID,Department_ID) values(2,10)
insert DepartmentDetails(Hospital_ID,Department_ID) values(2,11)
insert DepartmentDetails(Hospital_ID,Department_ID) values(2,12)
insert DepartmentDetails(Hospital_ID,Department_ID) values(2,13)

insert DepartmentDetails(Hospital_ID,Department_ID) values(3,1)
insert DepartmentDetails(Hospital_ID,Department_ID) values(3,2)
insert DepartmentDetails(Hospital_ID,Department_ID) values(3,3)
insert DepartmentDetails(Hospital_ID,Department_ID) values(3,4)
insert DepartmentDetails(Hospital_ID,Department_ID) values(3,5)
insert DepartmentDetails(Hospital_ID,Department_ID) values(3,6)
insert DepartmentDetails(Hospital_ID,Department_ID) values(3,7)
insert DepartmentDetails(Hospital_ID,Department_ID) values(3,8)
insert DepartmentDetails(Hospital_ID,Department_ID) values(3,9)
insert DepartmentDetails(Hospital_ID,Department_ID) values(3,10)
insert DepartmentDetails(Hospital_ID,Department_ID) values(3,11)
insert DepartmentDetails(Hospital_ID,Department_ID) values(3,12)
insert DepartmentDetails(Hospital_ID,Department_ID) values(3,13)
insert DepartmentDetails(Hospital_ID,Department_ID) values(3,14)
insert DepartmentDetails(Hospital_ID,Department_ID) values(3,15)





--insert Doctors (DoctorTC,DoctorName,DoctorSurname,DoctorAge,DoctorBirthDate,DoctorGender,DoctorPhoneNumber,DoctorTitle,DoctorDepartment_ID,ReportsTo) Values ()

-- Aðýz ve diþ ID = 1
insert Doctors (DoctorTC,HospitalID,DoctorName,DoctorLastname,DoctorBirthDate,DoctorGender,DoctorPhoneNumber,DoctorTitle,DoctorDepartment_ID,ReportsTo)
Values ('34678068159',1,'Ali','Köse','1984-09-02',0,'+905363772577','Operatör Doktor',1,NULL)			--doktor ýd 1

insert Doctors (DoctorTC,HospitalID,DoctorName,DoctorLastname,DoctorBirthDate,DoctorGender,DoctorPhoneNumber,DoctorTitle,DoctorDepartment_ID,ReportsTo)
Values ('99653068159',1,'Mehmet','Karahanlý','1995-09-02',0,'+905369871577','Pratisyen Doktor',1,1)		--doktor ýd 2				 

--Beyin ve Sinir Cerrahisi ID = 2
insert Doctors (DoctorTC,HospitalID,DoctorName,DoctorLastname,DoctorBirthDate,DoctorGender,DoctorPhoneNumber,DoctorTitle,DoctorDepartment_ID,ReportsTo)
Values ('34635018159',1,'Ali','Candan','1972-09-02',0,'+905369882577','Doçent Doktor',2,NUll)			--doktor ýd 3
insert Doctors (DoctorTC,HospitalID,DoctorName,DoctorLastname,DoctorBirthDate,DoctorGender,DoctorPhoneNumber,DoctorTitle,DoctorDepartment_ID,ReportsTo)
Values ('51578068159',1,'Evrim','Kocakurt','1982-09-02',0,'+905361672577','Operatör Doktor',2,3)		--doktor ýd 4
insert Doctors (DoctorTC,HospitalID,DoctorName,DoctorLastname,DoctorBirthDate,DoctorGender,DoctorPhoneNumber,DoctorTitle,DoctorDepartment_ID,ReportsTo)
Values ('93478068159',1,'Ali','Karakuþ','1990-09-02',0,'+905364282577','Pratisyen Doktor',2,4)			--doktor ýd 5	

--Deri ve Zührevi Hastalýklarý (Cildiye) ID = 3
insert Doctors (DoctorTC,HospitalID,DoctorName,DoctorLastname,DoctorBirthDate,DoctorGender,DoctorPhoneNumber,DoctorTitle,DoctorDepartment_ID,ReportsTo)
Values ('34567890123',1,'Bayram','Kýzýl','1973-10-01',1,'+905567890123','Operatör Doktor',3,NUll)		--doktor ýd 6
insert Doctors (DoctorTC,HospitalID,DoctorName,DoctorLastname,DoctorBirthDate,DoctorGender,DoctorPhoneNumber,DoctorTitle,DoctorDepartment_ID,ReportsTo)
Values ('11578068159',1,'Feriha','Mutlu','1984-09-02',0,'+905367182577','Uzman Doktor',3,6)				--doktor ýd 7

--Diþ Hekimliði (Genel Diþ) ID = 4
insert Doctors (DoctorTC,HospitalID,DoctorName,DoctorLastname,DoctorBirthDate,DoctorGender,DoctorPhoneNumber,DoctorTitle,DoctorDepartment_ID,ReportsTo)
Values ('61278068159',1,'Mehmet','Bayram','1984-09-02',0,'+905368742577','Yardýmcý Doçent',4,NUll)		--doktor ýd 8

--Gastroenteroloji	ID = 5
insert Doctors (DoctorTC,HospitalID,DoctorName,DoctorLastname,DoctorBirthDate,DoctorGender,DoctorPhoneNumber,DoctorTitle,DoctorDepartment_ID,ReportsTo)
Values ('49131245673',1,'Güneþ','Ay','1981-09-14',1,'+905131245673','Operatör Doktor',5,NUll)			--doktor ýd 9

--Göðüs Hastalýklarý ID = 6
insert Doctors (DoctorTC,HospitalID,DoctorName,DoctorLastname,DoctorBirthDate,DoctorGender,DoctorPhoneNumber,DoctorTitle,DoctorDepartment_ID,ReportsTo)
Values ('84378068159',1,'Furkan','Köse','1984-05-22',0,'+905361532577','Operatör Doktor',6,NUll)		-- doktor ýd 10

--Göz Hastalýklarý ID = 7
insert Doctors (DoctorTC,HospitalID,DoctorName,DoctorLastname,DoctorBirthDate,DoctorGender,DoctorPhoneNumber,DoctorTitle,DoctorDepartment_ID,ReportsTo)
Values ('19278068159',1,'Burhan','Altýntop','1981-09-02',0,'+905361162577','Yardýmcý Doçent',7,NUll)	-- doktor ýd 11

--Ýç Hastalýklarý (Dahiliye) ID = 8
insert Doctors (DoctorTC,HospitalID,DoctorName,DoctorLastname,DoctorBirthDate,DoctorGender,DoctorPhoneNumber,DoctorTitle,DoctorDepartment_ID,ReportsTo)
Values ('98778068159',1,'Seda','Sayan','1964-09-02',0,'+905361132977','Operatör Doktor',8,NUll)			-- doktor ýd 12

--Kardiyoloji	ID = 9
insert Doctors (DoctorTC,HospitalID,DoctorName,DoctorLastname,DoctorBirthDate,DoctorGender,DoctorPhoneNumber,DoctorTitle,DoctorDepartment_ID,ReportsTo)
Values ('84371268159',1,'Cengiz','Kurtoðlu','1956-08-02',0,'+905361232577','Doçent Doktor',9,NUll)		-- doktor ýd 13

--Kulak Burun Boðaz Hastalýklarý ID = 10
insert Doctors (DoctorTC,HospitalID,DoctorName,DoctorLastname,DoctorBirthDate,DoctorGender,DoctorPhoneNumber,DoctorTitle,DoctorDepartment_ID,ReportsTo)
Values ('84321768159',1,'Ýbrahim','Tatlýses','1960-03-01',0,'+905361132587','Operatör Doktor',10,NUll)	-- doktor ýd 14

--Nöroloji	ID = 11
insert Doctors (DoctorTC,HospitalID,DoctorName,DoctorLastname,DoctorBirthDate,DoctorGender,DoctorPhoneNumber,DoctorTitle,DoctorDepartment_ID,ReportsTo)
Values ('12378768159',1,'Taha','Duymaz','1984-07-10',0,'+905361132599','Operatör Doktor',11,NUll)		-- doktor ýd 15

--Ortopedi ve Travmatoloji ID = 12
insert Doctors (DoctorTC,HospitalID,DoctorName,DoctorLastname,DoctorBirthDate,DoctorGender,DoctorPhoneNumber,DoctorTitle,DoctorDepartment_ID,ReportsTo)
Values ('84928061359',1,'Recep','Köseoðlu','1972-09-02',0,'+905361232537','Operatör Doktor',12,NUll)	-- doktor ýd 16

--Plastik, Rekonstrüktif ve Estetik Cerrahi ID = 13
insert Doctors (DoctorTC,HospitalID,DoctorName,DoctorLastname,DoctorBirthDate,DoctorGender,DoctorPhoneNumber,DoctorTitle,DoctorDepartment_ID,ReportsTo)
Values ('81378068159',1,'Suzan','Gündeþ','1984-11-07',0,'+905361132577','Operatör Doktor',13,NUll)		-- doktor ýd 17

--Ruh Saðlýðý ve Hastalýklarý (Psikiyatri) ID = 14
insert Doctors (DoctorTC,HospitalID,DoctorName,DoctorLastname,DoctorBirthDate,DoctorGender,DoctorPhoneNumber,DoctorTitle,DoctorDepartment_ID,ReportsTo)
Values ('44378068159',2,'Bayram','Duran','1984-09-02',0,'+905361132577','Operatör Doktor',14,NUll)		-- doktor ýd 18

--Üroloji ID = 15
insert Doctors (DoctorTC,HospitalID,DoctorName,DoctorLastname,DoctorBirthDate,DoctorGender,DoctorPhoneNumber,DoctorTitle,DoctorDepartment_ID,ReportsTo)
Values ('57479068159',2,'Abuzer','Kömürcü','1984-09-02',0,'+905361132577','Operatör Doktor',15,NUll)	-- doktor ýd 19    -- doçent olucak itogluit

insert Doctors (DoctorTC,HospitalID,DoctorName,DoctorLastname,DoctorBirthDate,DoctorGender,DoctorPhoneNumber,DoctorTitle,DoctorDepartment_ID,ReportsTo)
Values ('87546129873',2,'Özge','Özenli','1995-01-02',1,'+905365784577','Pratisyen Doktor',8,NUll)	

insert Doctors (DoctorTC,HospitalID,DoctorName,DoctorLastname,DoctorBirthDate,DoctorGender,DoctorPhoneNumber,DoctorTitle,DoctorDepartment_ID,ReportsTo)
Values ('21548159874',2,'Büþra','Mutlu','1987-07-08',1,'+905378967187','Uzman Doktor',5,NUll)	

insert Doctors (DoctorTC,HospitalID,DoctorName,DoctorLastname,DoctorBirthDate,DoctorGender,DoctorPhoneNumber,DoctorTitle,DoctorDepartment_ID,ReportsTo)
Values ('27584691526',2,'Yasin','Karanlý','1992-09-09',0,'+905373248745','Operatör Doktor',8,NUll)

insert Doctors (DoctorTC,HospitalID,DoctorName,DoctorLastname,DoctorBirthDate,DoctorGender,DoctorPhoneNumber,DoctorTitle,DoctorDepartment_ID,ReportsTo)
Values ('21548159879',3,'Hande','Neþeli','1989-01-02',1,'+905378942577','Doçent Doktor',8,NUll)		

insert Doctors (DoctorTC,HospitalID,DoctorName,DoctorLastname,DoctorBirthDate,DoctorGender,DoctorPhoneNumber,DoctorTitle,DoctorDepartment_ID,ReportsTo)
Values ('68754659879',3,'Elif','Atalar','1982-05-02',1,'+905387242577','Pratisyen Doktor',4,NUll)	

insert Doctors (DoctorTC,HospitalID,DoctorName,DoctorLastname,DoctorBirthDate,DoctorGender,DoctorPhoneNumber,DoctorTitle,DoctorDepartment_ID,ReportsTo)
Values ('74125159879',3,'Seval','Sevinçli','1992-01-12',1,'+905358949517','Operatör Doktor',7,NUll)	

insert Doctors (DoctorTC,HospitalID,DoctorName,DoctorLastname,DoctorBirthDate,DoctorGender,DoctorPhoneNumber,DoctorTitle,DoctorDepartment_ID,ReportsTo)
Values ('24569898797',3,'Ýsmail','Güven','1979-08-02',0,'+905342842567','Doçent Doktor',3,NUll)	

insert Doctors (DoctorTC,HospitalID,DoctorName,DoctorLastname,DoctorBirthDate,DoctorGender,DoctorPhoneNumber,DoctorTitle,DoctorDepartment_ID,ReportsTo)
Values ('21548159856',3,'Ümit','Ateþ','1985-12-12',0,'+905365742154','Operatör Doktor',12,NUll)	





------ PATIENTS-------------------	

INSERT Patients(PatientTC,PatientName,PatientLastname,PatientBirthDate,PatientGender,PatientPhoneNumber) VALUES ('49131245678','Hüseyin','Cemil','1993-01-01',0,'+905453415798')			--ID:1

INSERT Patients(PatientTC,PatientName,PatientLastname,PatientBirthDate,PatientGender,PatientPhoneNumber) VALUES ('98654321781','Kamile','Gürsu','1966-03-12',1,'+905654321781')			--ID:2

INSERT Patients(PatientTC,PatientName,PatientLastname,PatientBirthDate,PatientGender,PatientPhoneNumber) VALUES ('23689702345','Þeyma','Demir','2004-08-08',1,'+905689702345')			--ID:3

INSERT Patients(PatientTC,PatientName,PatientLastname,PatientBirthDate,PatientGender,PatientPhoneNumber) VALUES ('56789421369','Ferhat','Korkmaz','1995-01-22',0,'+905789421369')			--ID:4

INSERT Patients(PatientTC,PatientName,PatientLastname,PatientBirthDate,PatientGender,PatientPhoneNumber) VALUES ('57321789045','Fýrat','Keser','1987-06-18',0,'+905321789045')			--5

INSERT Patients(PatientTC,PatientName,PatientLastname,PatientBirthDate,PatientGender,PatientPhoneNumber) VALUES ('49131245673','Güneþ','Ay','1981-09-14',1,'+905131245673')				--6

INSERT Patients(PatientTC,PatientName,PatientLastname,PatientBirthDate,PatientGender,PatientPhoneNumber) VALUES ('43267845345','Zeynep','Kýzýlkaya','1996-08-15',1,'+905267845345')		--7

INSERT Patients(PatientTC,PatientName,PatientLastname,PatientBirthDate,PatientGender,PatientPhoneNumber) VALUES ('98076543612','Nisa','Nur','1956-04-19',1,'+905076543612')				--8

INSERT Patients(PatientTC,PatientName,PatientLastname,PatientBirthDate,PatientGender,PatientPhoneNumber) VALUES ('34567890123','Bayram','Kýzýl','1973-10-01',1,'+905567890123')			--9

INSERT Patients(PatientTC,PatientName,PatientLastname,PatientBirthDate,PatientGender,PatientPhoneNumber) VALUES ('11212456788','Cemalettin','Üçbacak','1938-05-29',0,'+905212456785')		--10	

INSERT Patients(PatientTC,PatientName,PatientLastname,PatientBirthDate,PatientGender,PatientPhoneNumber) VALUES ('11215456787','Ali','Can','1999-11-24',0,'+905215456787')				--11

INSERT Patients(PatientTC,PatientName,PatientLastname,PatientBirthDate,PatientGender,PatientPhoneNumber) VALUES ('11212413570','Seda','Sayýn','1949-07-03',1,'+905212413570')				--12

INSERT Patients(PatientTC,PatientName,PatientLastname,PatientBirthDate,PatientGender,PatientPhoneNumber) VALUES ('45709874321','Kübra','Yýldýrým','1996-08-05',1,'+905709874321')			--13

INSERT Patients(PatientTC,PatientName,PatientLastname,PatientBirthDate,PatientGender,PatientPhoneNumber) VALUES ('55503052906','Emre','Ayvaz','2000-02-29',0,'+905503052906')				--14

INSERT Patients(PatientTC,PatientName,PatientLastname,PatientBirthDate,PatientGender,PatientPhoneNumber) VALUES ('34567812345','Berat Ozan','Kiraz','1998-01-01',0,'+905456781234')		--15

INSERT Patients(PatientTC,PatientName,PatientLastname,PatientBirthDate,PatientGender,PatientPhoneNumber) VALUES ('36789034521','Gamze','Tuna','1994-05-24',1,'+905415744389')				--16

INSERT Patients(PatientTC,PatientName,PatientLastname,PatientBirthDate,PatientGender,PatientPhoneNumber) VALUES ('98765434562','Volkan','Ercan','1995-05-24',0,'+905567812345')			--ID:17

INSERT Patients(PatientTC,PatientName,PatientLastname,PatientBirthDate,PatientGender,PatientPhoneNumber)          
VALUES ('41831225678','Erdal','Kömürcü','1979-06-20',0,'+905333419098')

INSERT Patients(PatientTC,PatientName,PatientLastname,PatientBirthDate,PatientGender,PatientPhoneNumber)         
VALUES ('19131245888','Elif Eylül','Cemil','1984-09-09',1,'+905363447798')
INSERT Patients(PatientTC,PatientName,PatientLastname,PatientBirthDate,PatientGender,PatientPhoneNumber)         
VALUES ('39199845678','Ali','Kýlýç','1963-03-14',0,'+905366669988')

INSERT Patients(PatientTC,PatientName,PatientLastname,PatientBirthDate,PatientGender,PatientPhoneNumber)         
VALUES ('12194245678','Nizamettin','Güvenç','1973-01-01',0,'+905553445798')

INSERT Patients(PatientTC,PatientName,PatientLastname,PatientBirthDate,PatientGender,PatientPhoneNumber)         
VALUES ('22294245678','Halil Ýbrahim','Kapar','1955-02-11',0,'+905551115798')



INSERT Patients(PatientTC,PatientName,PatientLastname,PatientBirthDate,PatientGender,PatientPhoneNumber)        
VALUES ('12111145577','Kaya','Çilingiroðlu','1973-01-01',0,'+905511447788')

INSERT Patients(PatientTC,PatientName,PatientLastname,PatientBirthDate,PatientGender,PatientPhoneNumber)         
VALUES ('22222225678','Kuzey','Tekinoðlu','1983-09-15',0,'+905553411111')

INSERT Patients(PatientTC,PatientName,PatientLastname,PatientBirthDate,PatientGender,PatientPhoneNumber)         
VALUES ('22266665678','Güney','Tekinoðlu','1985-09-15',0,'+905553422222')

INSERT Patients(PatientTC,PatientName,PatientLastname,PatientBirthDate,PatientGender,PatientPhoneNumber)         
VALUES ('33336665678','Cemre','Çaylak','1985-09-15',1,'+905553433333')

INSERT Patients(PatientTC,PatientName,PatientLastname,PatientBirthDate,PatientGender,PatientPhoneNumber)         
VALUES ('55555665678','Rýza','Soylu','1965-09-25',0,'+905553555555')




--HASTA KAYIT VERÝ
--insert PatientRegistrations (Patient_ID,Doctor_ID,AppointmentDate,AppointmentTime,PatientSymptoms) Values ()
insert PatientRegistrations(Patient_ID,Doctor_ID,AppointmentDate,AppointmentTime,PatientSymptoms)  Values (1,14,'2022-05-22','02:23:25','Ateþ')    
insert PatientRegistrations(Patient_ID,Doctor_ID,AppointmentDate,AppointmentTime,PatientSymptoms)  Values (2,13,'2022-01-22','09:23:25','Hýzlý Kalp Ritmi') 
insert PatientRegistrations(Patient_ID,Doctor_ID,AppointmentDate,AppointmentTime,PatientSymptoms)  Values (3,18,'2022-02-24','09:23:25','Depresyon')
insert PatientRegistrations(Patient_ID,Doctor_ID,AppointmentDate,AppointmentTime,PatientSymptoms)  Values (4,10,'2022-05-25','13:23:25','Göðüs aðrýsý')
insert PatientRegistrations(Patient_ID,Doctor_ID,AppointmentDate,AppointmentTime,PatientSymptoms)  Values (5,15,'2022-03-25','14:23:25','Epilepsi')
insert PatientRegistrations(Patient_ID,Doctor_ID,AppointmentDate,AppointmentTime,PatientSymptoms) Values (6,14,'2022-01-26','15:23:25','Kulak aðrýsý')
insert PatientRegistrations(Patient_ID,Doctor_ID,AppointmentDate,AppointmentTime,PatientSymptoms)  Values (7,9,'2022-03-27','16:23:25','Mide yanmasý')
insert PatientRegistrations(Patient_ID,Doctor_ID,AppointmentDate,AppointmentTime,PatientSymptoms)  Values (8,18,'2022-02-28','16:23:25','Koyu idrar')   
insert PatientRegistrations(Patient_ID,Doctor_ID,AppointmentDate,AppointmentTime,PatientSymptoms)  Values (9,10,'2022-04-26','13:23:25','Öksürük')
insert PatientRegistrations(Patient_ID,Doctor_ID,AppointmentDate,AppointmentTime,PatientSymptoms)  Values (10,2,'2022-05-22','10:23:25','Çene Kýrýðý')
insert PatientRegistrations(Patient_ID,Doctor_ID,AppointmentDate,AppointmentTime,PatientSymptoms)  Values (11,6,'2022-06-22','12:23:25','Egzema')
insert PatientRegistrations(Patient_ID,Doctor_ID,AppointmentDate,AppointmentTime,PatientSymptoms)  Values (12,11,'2022-07-22','10:23:25','Görme bozukluðu')
insert PatientRegistrations(Patient_ID,Doctor_ID,AppointmentDate,AppointmentTime,PatientSymptoms)  Values (13,16,'2022-09-22','11:23:25','Kol kýrýðý')
insert PatientRegistrations(Patient_ID,Doctor_ID,AppointmentDate,AppointmentTime,PatientSymptoms)  Values (14,12,'2022-07-22','13:23:25','Ateþ')
insert PatientRegistrations(Patient_ID,Doctor_ID,AppointmentDate,AppointmentTime,PatientSymptoms)  Values (15,1,'2022-05-22','14:23:25','Çene Aðrýsý')
insert PatientRegistrations(Patient_ID,Doctor_ID,AppointmentDate,AppointmentTime,PatientSymptoms)  Values (16,19,'2022-02-28','16:23:25','Koyu idrar')
insert PatientRegistrations(Patient_ID,Doctor_ID,AppointmentDate,AppointmentTime,PatientSymptoms)  Values (17,4,'2022-05-26','13:23:25','MS Hastalýðý')
insert PatientRegistrations(Patient_ID,Doctor_ID,AppointmentDate,AppointmentTime,PatientSymptoms)  Values (15,9,'2022-05-22','10:23:25','Halsizlik')
insert PatientRegistrations(Patient_ID,Doctor_ID,AppointmentDate,AppointmentTime,PatientSymptoms)  Values (3,8,'2022-03-22','12:23:25','Diþ Aðrýsý')
insert PatientRegistrations(Patient_ID,Doctor_ID,AppointmentDate,AppointmentTime,PatientSymptoms)  Values (11,6,'2022-01-22','10:23:25','Egzema')
insert PatientRegistrations(Patient_ID,Doctor_ID,AppointmentDate,AppointmentTime,PatientSymptoms)  Values (3,7,'2022-05-22','11:23:25','Sedef Hastalýðý')
insert PatientRegistrations(Patient_ID,Doctor_ID,AppointmentDate,AppointmentTime,PatientSymptoms)  Values (4,17,'2022-01-22','02:23:25','Burun estetik')
insert PatientRegistrations(Patient_ID,Doctor_ID,AppointmentDate,AppointmentTime,PatientSymptoms)  Values (8,13,'2022-06-22','09:23:25','Hýzlý Kalp Ritmi')
insert PatientRegistrations(Patient_ID,Doctor_ID,AppointmentDate,AppointmentTime,PatientSymptoms)  Values (9,18,'2022-05-24','09:23:25','Depresyon')
insert PatientRegistrations(Patient_ID,Doctor_ID,AppointmentDate,AppointmentTime,PatientSymptoms)  Values (10,12,'2022-03-25','14:23:25','karaciðerde sýkýntý')
insert PatientRegistrations(Patient_ID,Doctor_ID,AppointmentDate,AppointmentTime,PatientSymptoms)  Values (3,14,'2022-01-26','15:23:25','Sinüs týkanma ve aðrý')
insert PatientRegistrations(Patient_ID,Doctor_ID,AppointmentDate,AppointmentTime,PatientSymptoms) Values (1,18,'2022-06-22','03:23:25','Öksürük')  
insert PatientRegistrations(Patient_ID,Doctor_ID,AppointmentDate,AppointmentTime,PatientSymptoms) Values (21,20,'2022-04-20','10:23:25','Ateþ')  
insert PatientRegistrations(Patient_ID,Doctor_ID,AppointmentDate,AppointmentTime,PatientSymptoms) Values (22,22,'2022-04-02','11:30:25','Öksürük')  
insert PatientRegistrations(Patient_ID,Doctor_ID,AppointmentDate,AppointmentTime,PatientSymptoms) Values (17,27,'2022-03-03','10:00:25','Mide Bulantýsý')  
insert PatientRegistrations(Patient_ID,Doctor_ID,AppointmentDate,AppointmentTime,PatientSymptoms) Values (6,19,'2022-03-05','09:30:00','Öksürük')  
insert PatientRegistrations(Patient_ID,Doctor_ID,AppointmentDate,AppointmentTime,PatientSymptoms) Values (2,18,'2022-03-07','08:50:00','Ateþ')  
insert PatientRegistrations(Patient_ID,Doctor_ID,AppointmentDate,AppointmentTime,PatientSymptoms) Values (27,21,'2022-05-01','12:00:25','Baþ Aðrýsý')

-- HASTA MUAYENE VERÝ

--insert PatientExaminations (ProcessName,ProcessUnitPrice) VALUES()

insert PatientExaminations(PatientExaminationName,PatientExaminationUnitPrice) VALUES('Ayakta Muayene',200)	
insert PatientExaminations(PatientExaminationName,PatientExaminationUnitPrice) VALUES('Ýþitme Testi',250)		
insert PatientExaminations(PatientExaminationName,PatientExaminationUnitPrice) VALUES('Röntgen',150)			
insert PatientExaminations(PatientExaminationName,PatientExaminationUnitPrice) VALUES('MR',1000)				
insert PatientExaminations(PatientExaminationName,PatientExaminationUnitPrice) VALUES('Görme testi',150)		
insert PatientExaminations(PatientExaminationName,PatientExaminationUnitPrice) VALUES('Kan Alma',100)
insert PatientExaminations(PatientExaminationName,PatientExaminationUnitPrice) VALUES('EKG',150)
insert PatientExaminations(PatientExaminationName,PatientExaminationUnitPrice) VALUES('Akciðer Grafisi',200)
insert PatientExaminations(PatientExaminationName,PatientExaminationUnitPrice) VALUES('Solunum Fonksiyon Testi',250)


-- HASTA MUAYENE DETAY

insert ExaminationDetails (PatientRegistration_ID,PatientExamination_ID,PatientExaminationQuantity) Values (1,1,1)
insert ExaminationDetails (PatientRegistration_ID,PatientExamination_ID,PatientExaminationQuantity) Values (2,7,1)
insert ExaminationDetails (PatientRegistration_ID,PatientExamination_ID,PatientExaminationQuantity) Values (3,8,1)
insert ExaminationDetails (PatientRegistration_ID,PatientExamination_ID,PatientExaminationQuantity) Values (4,9,1)
insert ExaminationDetails (PatientRegistration_ID,PatientExamination_ID,PatientExaminationQuantity) Values (5,6,1)
insert ExaminationDetails (PatientRegistration_ID,PatientExamination_ID,PatientExaminationQuantity) Values (6,1,1)
insert ExaminationDetails (PatientRegistration_ID,PatientExamination_ID,PatientExaminationQuantity) Values (7,7,1)
insert ExaminationDetails (PatientRegistration_ID,PatientExamination_ID,PatientExaminationQuantity)Values (8,1,1)
insert ExaminationDetails (PatientRegistration_ID,PatientExamination_ID,PatientExaminationQuantity) Values (9,1,1)
insert ExaminationDetails (PatientRegistration_ID,PatientExamination_ID,PatientExaminationQuantity) Values (10,8,1)
insert ExaminationDetails (PatientRegistration_ID,PatientExamination_ID,PatientExaminationQuantity) Values (11,1,1)
insert ExaminationDetails (PatientRegistration_ID,PatientExamination_ID,PatientExaminationQuantity) Values (12,5,1)
insert ExaminationDetails (PatientRegistration_ID,PatientExamination_ID,PatientExaminationQuantity) Values (13,6,1)
insert ExaminationDetails (PatientRegistration_ID,PatientExamination_ID,PatientExaminationQuantity) Values (14,9,1)
insert ExaminationDetails (PatientRegistration_ID,PatientExamination_ID,PatientExaminationQuantity) Values (15,1,1)
insert ExaminationDetails (PatientRegistration_ID,PatientExamination_ID,PatientExaminationQuantity) Values (16,8,1)
insert ExaminationDetails (PatientRegistration_ID,PatientExamination_ID,PatientExaminationQuantity) Values (17,1,1)
insert ExaminationDetails (PatientRegistration_ID,PatientExamination_ID,PatientExaminationQuantity) Values (4,2,1)    
insert ExaminationDetails (PatientRegistration_ID,PatientExamination_ID,PatientExaminationQuantity) Values (3,2,1)
insert ExaminationDetails (PatientRegistration_ID,PatientExamination_ID,PatientExaminationQuantity) Values (11,5,1)   
insert ExaminationDetails (PatientRegistration_ID,PatientExamination_ID,PatientExaminationQuantity) Values (3,3,1)
insert ExaminationDetails (PatientRegistration_ID,PatientExamination_ID,PatientExaminationQuantity) Values (4,3,1)
insert ExaminationDetails (PatientRegistration_ID,PatientExamination_ID,PatientExaminationQuantity) Values (8,6,1)
insert ExaminationDetails (PatientRegistration_ID,PatientExamination_ID,PatientExaminationQuantity) Values (9,3,1)		
insert ExaminationDetails (PatientRegistration_ID,PatientExamination_ID,PatientExaminationQuantity) Values (10,4,1)		
insert ExaminationDetails (PatientRegistration_ID,PatientExamination_ID,PatientExaminationQuantity) Values (3,6,1)	

--Cinsiyet  erkek : 0 - KAdýn :  1 

------------------------------Nurses----------------------------------------------------

INSERT Nurses(Hospital_ID,NurseName,NurseLastname,NurseBirthdate,NurseAdress,NurseGender,NursePhoneNumber) VALUES (1,'Gamze','Küçük','1997-12-07','Kozyataðý mh. Çayýr Cd. No:2/5 Kadýköy/Ýstanbul',1,'+905453415798')
INSERT Nurses(Hospital_ID,NurseName,NurseLastname,NurseBirthdate,NurseAdress,NurseGender,NursePhoneNumber)  VALUES (1,'Özge','Camgöz','1995-10-12','Ataþehir mh. Panayýr Sk. No:6/3 Ataþehir/Ýstanbul',1,'+905654321781')
INSERT Nurses(Hospital_ID,NurseName,NurseLastname,NurseBirthdate,NurseAdress,NurseGender,NursePhoneNumber)VALUES (1,'Murat','Sakin','1998-06-24','Altayçeþme mh. Panayýr Sk. No:3/6 Maltepe/Ýstanbul',0,'+905689702345')
INSERT Nurses(Hospital_ID,NurseName,NurseLastname,NurseBirthdate,NurseAdress,NurseGender,NursePhoneNumber) VALUES (1,'Kerim','Duman','1992-05-08','Kordonboyu mh. Cevahir Sk. No:114/6 Kartal/Ýstanbul',0,'+905076543612')
INSERT Nurses(Hospital_ID,NurseName,NurseLastname,NurseBirthdate,NurseAdress,NurseGender,NursePhoneNumber) VALUES (1,'Ceren','Sað','1986-11-14','Alibeyköy mh. Tutmaç Sk. No:1/10  Alibeyköy/Ýstanbul',1,'+905567890123')
INSERT Nurses(Hospital_ID,NurseName,NurseLastname,NurseBirthdate,NurseAdress,NurseGender,NursePhoneNumber) VALUES (1,'Simge','Sagýn','1994-03-21','Küçükyalý mh .Tutmaç Sk. No:2/10  Maltepe/Ýstanbul',1,'+905212456785')
INSERT Nurses(Hospital_ID,NurseName,NurseLastname,NurseBirthdate,NurseAdress,NurseGender,NursePhoneNumber)VALUES (1,'Raþit','Basri','1990-02-14','Þahapgürler mh. Cevahir Sk. No:114/6 Sultanbeyli/Ýstanbul',0,'+905215456787')
INSERT Nurses(Hospital_ID,NurseName,NurseLastname,NurseBirthdate,NurseAdress,NurseGender,NursePhoneNumber) VALUES (1,'Harun','Camgöz','1988-07-22','YukarýGümüþ mh. Zeytin Sk. No:11/8 Tuzla/Ýstanbul',0,'+905709874321')
INSERT Nurses(Hospital_ID,NurseName,NurseLastname,NurseBirthdate,NurseAdress,NurseGender,NursePhoneNumber) VALUES (1,'Feridun','Düz','1996-04-29','Aþkolsun mh. Peynir Sk. No:12/20 Kadýköy/Ýstanbul',0,'+905503052906')
INSERT Nurses(Hospital_ID,NurseName,NurseLastname,NurseBirthdate,NurseAdress,NurseGender,NursePhoneNumber) VALUES (1,'Eren','Yaldýz','1999-01-17','Atatürk mh. Gazoz Sk. No:25/8  Ataþehir/Ýstanbul',0,'+905212456785')
INSERT Nurses(Hospital_ID,NurseName,NurseLastname,NurseBirthdate,NurseAdress,NurseGender,NursePhoneNumber) VALUES (1,'Özge','Çelik','1997-01-19','Þiþli mh. Gazoz Sk. No:25/8  Þiþli/Ýstanbul',1,'+905212413570')

INSERT Nurses(Hospital_ID,NurseName,NurseLastname,NurseBirthdate,NurseAdress,NurseGender,NursePhoneNumber) VALUES (2,'Gamze','Tuna','1986-06-30','Altýndað mh. Piryani Sk. No:13/2 Altýndað/Ankara',1,'+905415744389')
INSERT Nurses(Hospital_ID,NurseName,NurseLastname,NurseBirthdate,NurseAdress,NurseGender,NursePhoneNumber) VALUES (2,'Beyza','Þimþek','1998-04-02','Sevgi mah. Gül sokaðý no:3/3 Mamak/Ankara',1,'+905439638521')
INSERT Nurses(Hospital_ID,NurseName,NurseLastname,NurseBirthdate,NurseAdress,NurseGender,NursePhoneNumber) VALUES (2,'Yýlmaz','Biçer','1997-05-05','Günýþýðý mh. Iþýk sk. No10/5 Keçiören/Ankara',0,'+905331892036')
INSERT Nurses(Hospital_ID,NurseName,NurseLastname,NurseBirthdate,NurseAdress,NurseGender,NursePhoneNumber)VALUES (2,'Mert','Ersin','1987-06-07','Leylak mh. Gül Cd. No:5/6 Pursaklar/Ankara',0,'+905437896543')
INSERT Nurses(Hospital_ID,NurseName,NurseLastname,NurseBirthdate,NurseAdress,NurseGender,NursePhoneNumber) VALUES (2,'Defne','Kýlýç','1993-03-05','Kalem mh. silgi sokak No:1/10 Çankaya/Ankara',1,'+905467843256')

INSERT Nurses(Hospital_ID,NurseName,NurseLastname,NurseBirthdate,NurseAdress,NurseGender,NursePhoneNumber) VALUES (3,'Zümra','Ozan','1995-07-12','Ýnönü mh.Badem sk. No: 5 Dikili/Ýzmir',1,'+905366667777')
INSERT Nurses(Hospital_ID,NurseName,NurseLastname,NurseBirthdate,NurseAdress,NurseGender,NursePhoneNumber) VALUES (3,'YiðitCan','Kütük','1997-04-08','Çýnar mh. Baba sk. No: 3 Foça/Ýzmir',0,'+90537779988')
INSERT Nurses(Hospital_ID,NurseName,NurseLastname,NurseBirthdate,NurseAdress,NurseGender,NursePhoneNumber)VALUES (3,'Serra','Akkaya','1990-06-03','Aþýkveysel mh. Ceviz sk. No: 10/5 Karþýyaka/Ýzmir',1,'+905413546789')
INSERT Nurses(Hospital_ID,NurseName,NurseLastname,NurseBirthdate,NurseAdress,NurseGender,NursePhoneNumber) VALUES (3,'Yakup','Aslan','1983-07-10','Atatürk mh. Peyami sk. No: 8 Bornova/Ýzmir',0,'+905435678945')
INSERT Nurses(Hospital_ID,NurseName,NurseLastname,NurseBirthdate,NurseAdress,NurseGender,NursePhoneNumber) VALUES (3,'Akif Emre','Arslan','1970-10-11','Özdemir mh. Asaf sk. No:1/3  Buca/Ýzmir',0,'+905214567890')

-------------------------------ROOMS--------------------------------


-- hospitalID = 1
INSERT Rooms(RoomNumber) VALUES (1) ------INSERT Patients VALUES (12,7,1,'2022-02-02','2022-03-14',1)
INSERT Rooms(RoomNumber) VALUES (2) --------INSERT Patients VALUES (10,7,2,'2021-12-24','2022-03-31',1)
INSERT Rooms(RoomNumber,[Status]) VALUES (3,0)
INSERT Rooms(RoomNumber,[Status]) VALUES (4,0)
INSERT Rooms(RoomNumber) VALUES (5)  -------INSERT Patients VALUES (2,12,5,'2022-02-22','2022-02-28'1) 
INSERT Rooms(RoomNumber,[Status]) VALUES (6,0)
INSERT Rooms(RoomNumber) VALUES (7) --------INSERT Patients VALUES (5,5,7,'2022-02-25','2022-03-11',1)
INSERT Rooms(RoomNumber,[Status]) VALUES (8,0)
INSERT Rooms(RoomNumber,[Status]) VALUES (9,0)
INSERT Rooms(RoomNumber,[Status]) VALUES (10,0)

-- hospitalID = 2
INSERT Rooms(RoomNumber,[Status]) VALUES (11,0)
INSERT Rooms(RoomNumber,[Status]) VALUES (12,0)
INSERT Rooms(RoomNumber) VALUES (13)
INSERT Rooms(RoomNumber,[Status]) VALUES (14,0)
INSERT Rooms(RoomNumber,[Status]) VALUES (15,0)
INSERT Rooms(RoomNumber,[Status]) VALUES (16,0)
INSERT Rooms(RoomNumber,[Status]) VALUES (17,0)
INSERT Rooms(RoomNumber,[Status]) VALUES (18,0)
INSERT Rooms(RoomNumber) VALUES (19)
INSERT Rooms(RoomNumber,[Status]) VALUES (20,0)

-- hospitalID = 3
INSERT Rooms(RoomNumber) VALUES (21)
INSERT Rooms(RoomNumber,[Status]) VALUES (22,0)
INSERT Rooms(RoomNumber,[Status]) VALUES (23,0)
INSERT Rooms(RoomNumber,[Status]) VALUES (24,0)
INSERT Rooms(RoomNumber,[Status]) VALUES (25,0)
INSERT Rooms(RoomNumber,[Status]) VALUES (26,0)
INSERT Rooms(RoomNumber) VALUES (27)
INSERT Rooms(RoomNumber,[Status]) VALUES (28,0)
INSERT Rooms(RoomNumber,[Status]) VALUES (29,0)
INSERT Rooms(RoomNumber,[Status]) VALUES (30,0)

------------------------------INPATIENTS----------------------------------------------------
-- HospitalId = 1 
INSERT InPatients(Patient_ID,Nurse_ID,Room_ID,HospitalizationDate,DischargedDate) VALUES (1,12,5,'2022-02-22','2022-02-28') 
INSERT InPatients(Patient_ID,Nurse_ID,Room_ID,HospitalizationDate,DischargedDate) VALUES (2,5,9,'2022-02-22','2022-02-28')
INSERT InPatients(Patient_ID,Nurse_ID,Room_ID,HospitalizationDate,DischargedDate) VALUES (5,6,7,'2022-02-25','2022-03-11')
INSERT InPatients(Patient_ID,Nurse_ID,Room_ID,HospitalizationDate,DischargedDate,[Status]) VALUES (8,3,3,'2022-01-03','2022-01-17',0)
INSERT InPatients(Patient_ID,Nurse_ID,Room_ID,HospitalizationDate,DischargedDate,[Status]) VALUES (9,2,4,'2021-12-06','2021-12-10',0)
INSERT InPatients(Patient_ID,Nurse_ID,Room_ID,HospitalizationDate,DischargedDate) VALUES (10,7,2,'2021-12-24','2022-03-31')
INSERT InPatients(Patient_ID,Nurse_ID,Room_ID,HospitalizationDate,DischargedDate) VALUES (12,8,1,'2022-02-02','2022-03-14')
INSERT InPatients(Patient_ID,Nurse_ID,Room_ID,HospitalizationDate,DischargedDate) VALUES (11,12,8,'2022-02-02','2022-04-02')

--- HospitalID = 2
INSERT InPatients(Patient_ID,Nurse_ID,Room_ID,HospitalizationDate,DischargedDate) VALUES (18,11,13,'2022-02-25','2022-02-28')
INSERT InPatients(Patient_ID,Nurse_ID,Room_ID,HospitalizationDate,DischargedDate) VALUES (20,14,19,'2022-02-03','2022-04-02')

--Hospital = 3

INSERT InPatients(Patient_ID,Nurse_ID,Room_ID,HospitalizationDate,DischargedDate) VALUES (24,18,27,'2022-02-25','2022-02-28')
INSERT InPatients(Patient_ID,Nurse_ID,Room_ID,HospitalizationDate,DischargedDate) VALUES (26,15,21,'2022-02-02','2022-03-14')

-- ÝLAÇLAR
 
 Insert Medicines(MedicineName) VALUES ('APRANAX FORTE 550 mg 20 tablet')
 Insert Medicines(MedicineName) VALUES ('APRANAX PLUS 20 film tablet')
 Insert Medicines(MedicineName) VALUES ('ASPIRIN 100 mg 20 tablet')
 Insert Medicines(MedicineName) VALUES ('A-FERIN PLUS pediatrik 100 ml þurup')
 Insert Medicines(MedicineName) VALUES ('BUSCOPAN 10 mg 20 draje {Zentiva}')
 Insert Medicines(MedicineName) VALUES ('BUSCOPAN PLUS 20 film tablet {Zentiva}')
 Insert Medicines(MedicineName) VALUES ('CALPOL 120 mg 150 ml süspansiyon')
 Insert Medicines(MedicineName) VALUES ('CIPRO 500 mg 14 tablet ilaç')
 Insert Medicines(MedicineName) VALUES ('CORASPIN 100 mg 30 tablet')
 Insert Medicines(MedicineName) VALUES ('ETOL FORT 400 mg 14 film tablet')
 Insert Medicines(MedicineName) VALUES ('FUCIDIN % 2 20 gr krem')
 Insert Medicines(MedicineName) VALUES ('GAVISCON ADVANCE 200 ml oral süspansiyon ')
 Insert Medicines(MedicineName) VALUES ('HIRUDOID FORT 445 mg 40 gr krem')
 Insert Medicines(MedicineName) VALUES ('HIRUDOID FORT 445 mg 40 gr jel')
 Insert Medicines(MedicineName) VALUES ('HAMETAN 30 gr pomad')
 Insert Medicines(MedicineName) VALUES ('KLACID 500 mg 14 film tablet')
 Insert Medicines(MedicineName) VALUES ('KLACID 250 mg/5 ml oral süspansiyon için granül 100 ml')
 Insert Medicines(MedicineName) VALUES ('MAJEZIK 100 mg 15 film tablet')
 Insert Medicines(MedicineName) VALUES ('MAJEZIK %0.25 oral sprey 30 ml ')
 Insert Medicines(MedicineName) VALUES ('MUSCOFLEX 4 mg 20 kapsül')
 Insert Medicines(MedicineName) VALUES ('MOMECON %0.1 krem')
 Insert Medicines(MedicineName) VALUES ('METPAMID 10 mg 5 ampül')


 ----------------- reçeteler


Insert Prescriptions(Patient_ID,PrescriptionDate) Values(1,'2022-05-22')

Insert Prescriptions(Patient_ID,PrescriptionDate) Values(2,'2022-01-22')

Insert Prescriptions(Patient_ID,PrescriptionDate) Values(3,'2022-02-24')

Insert Prescriptions(Patient_ID,PrescriptionDate) Values(4,'2022-05-25')

Insert Prescriptions(Patient_ID,PrescriptionDate) Values(5,'2022-03-25')

Insert Prescriptions(Patient_ID,PrescriptionDate) Values(6,'2022-01-26')

Insert Prescriptions(Patient_ID,PrescriptionDate) Values(7,'2022-03-27')

Insert Prescriptions(Patient_ID,PrescriptionDate) Values(8,'2022-02-28')

Insert Prescriptions(Patient_ID,PrescriptionDate) Values(9,'2022-04-26')

Insert Prescriptions(Patient_ID,PrescriptionDate) Values(10,'2022-05-22')

Insert Prescriptions(Patient_ID,PrescriptionDate) Values(11,'2022-06-22')

Insert Prescriptions(Patient_ID,PrescriptionDate) Values(12,'2022-07-22')

Insert Prescriptions(Patient_ID,PrescriptionDate) Values(13,'2022-09-22')

Insert Prescriptions(Patient_ID,PrescriptionDate) Values(14,'2022-07-22')

Insert Prescriptions(Patient_ID,PrescriptionDate) Values(15,'2022-02-28')

Insert Prescriptions(Patient_ID,PrescriptionDate) Values(16,'2022-02-28')

Insert Prescriptions(Patient_ID,PrescriptionDate) Values(17,'2022-05-26')

 -- REÇETE DETAY

 
Insert PrescriptionDetails(Prescription_ID,Medicine_ID) Values (1,2)
Insert PrescriptionDetails(Prescription_ID,Medicine_ID) Values (2,1)
Insert PrescriptionDetails(Prescription_ID,Medicine_ID) Values (3,4)
Insert PrescriptionDetails(Prescription_ID,Medicine_ID) Values (4,5)
Insert PrescriptionDetails(Prescription_ID,Medicine_ID) Values (10,1)
Insert PrescriptionDetails(Prescription_ID,Medicine_ID) Values (5,1)
Insert PrescriptionDetails(Prescription_ID,Medicine_ID) Values (6,5)