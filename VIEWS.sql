--HANGÝ HASTANEDE KAÇ HASTA VAR 

CREATE view vw_WhichHospitalPatient
AS
(
Select h.HospitalName,count(distinct p.PatientID) as [Total Number of Patients] from Patients p
JOIN PatientRegistrations pr ON p.PatientID=pr.Patient_ID
JOIN Doctors dr ON pr.Doctor_ID=dr.DoctorID
JOIN Hospitals h ON dr.HospitalID=h.HospitalID
Group by h.HospitalName
)
--Select * from vw_WhichHospitalPatient 


--HANGÝ HASTANEDE HANGÝ DEPARTMAN VAR

create view vw_WhichHospitalWhichDepartman
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
--SELECT * from vw_WhichHospitalWhichDepartman

--TÜM ODALARIN BOÞ DOLU BÝLGÝLERÝ
create view vw_RoomInfo 
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

--SELECT * FROM vw_RoomInfo


-- BOÞ ODALAR HANGÝLERÝ

create view vw_RoomEmpty
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
--select * from vw_RoomEmpty

--HASTANE BAZLI TOPLAM CÝRO
CREATE VIEW vw_HastaneGiro
As(
Select  h.HospitalName, SUM(pe.PatientExaminationUnitPrice*ed.PatientExaminationQuantity) AS [Toplam Ciro]from ExaminationDetails ed
JOIN PatientRegistrations p    ON ed.PatientRegistration_ID = p.PatientRegistrationID
JOIN Doctors d			ON p.Doctor_ID = d.DoctorID
JOIN Hospitals  h ON d.HospitalID= h.HospitalID
JOIN PatientExaminations pe    ON pe.PatientExaminationID =ed.PatientExamination_ID
--where h.HospitalID= 2
GROUP BY h.HospitalName
)
-- select * from vw_HastaneGiro

--HANGÝ BÖLÜMDE KAÇ DOKTOR ÇALIÞIYOR 
create view vw_WhichDoktorDepartment
AS
(
Select D.DepartmentID,D.DepartmentName , Count (DC.DoctorDepartment_ID) AS [Number of Doctors Working] from Doctors DC 
JOIN Departments D
ON DC.DoctorDepartment_ID=D.DepartmentID
Group BY D.DepartmentID,D.DepartmentName
)

--select * from vw_WhichDoktorDepartment

--PERSONEL YAÞLARINI HESAPLAMA 
Create view vw_EmployeesAge 
AS
(
select e.EmployeeName,e.EmployeeLastname,h.HospitalName,DATEDIFF(YEAR,e.EmployeeBirthdate,GETDATE()) as [Employee Age] from Employees e 
JOIN Hospitals h
ON e.Hospital_ID = h.HospitalID
)

--select * from vw_EmployeesAge


--DOKTOR YAÞLARINI HESAPLAMA
Create view vw_DoctorAge 
AS
(
select d.DoctorName,d.DoctorLastname,h.HospitalName,DATEDIFF(YEAR,d.DoctorBirthDate,GETDATE()) as [Doctor Age] from Doctors d
JOIN Hospitals h
ON d.HospitalID= h.HospitalID
)
--select * from vw_DoctorAge


--HASTA YAÞ HESAPLAMA 

Create view vw_PatientsAge
AS
(
select PatientID, PatientName +' '+ PatientLastname AS [Patient Full Name],DATEDIFF(YEAR,PatientBirthDate,GETDATE()) as [Patient Age] from Patients
)

--select * from vw_PatientsAge

-- Özel Fenerbahçe Ataþehir Hastanesindeki yatan hastalar
Create View vw_HospitalInPatient
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

--Select * from vw_HospitalInPatient 


--HASTANEDE ÇALIÞAN HEMÞÝRELER
Create View vw_HospitalNurses
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
--Select * from vw_HospitalNurses

--HER DOKTORUN BAKTIÐI HASTA SAYISI 
create view vw_TotalPatientsOfDoctorsInHospitals
as
(select d.DoctorID,d.DoctorName +' '+d.DoctorLastname as [Doctor Name],h.HospitalName, COUNT(PR.Patient_ID) as [Total Patients] from Doctors d
left join PatientRegistrations pr
on d.DoctorID=pr.Doctor_ID
join Hospitals h
on d.HospitalID=h.HospitalID
group by d.DoctorID,d.DoctorName,d.DoctorLastname,h.HospitalName)

--select * from vw_TotalPatientsOfDoctorsInHospitals

--EN ÇOK ÜCRETÝ ÖDEYEN HASTA 

select TOP 1 p.PatientName+' '+p.PatientLastname,SUM(pe.PatientExaminationUnitPrice *ed.PatientExaminationQuantity) as ToplamTutar from ExaminationDetails ed
JOIN PatientRegistrations pr
on ed.PatientRegistration_ID=pr.PatientRegistrationID
JOIN Patients p
on p.PatientID=pr.Patient_ID
JOIN PatientExaminations pe
on pe.PatientExaminationID=ed.PatientExamination_ID
group by p.PatientName,p.PatientLastname
order by ToplamTutar desc

-- reçetenin hangi hastaya hangi doktor tarafýndan hangi tarihte yazýldýðý 

create view vw_Prescriptions
as
select p.PatientName+' '+p.PatientLastname as [Patient Name],d.DoctorName+' '+d.DoctorLastname as [Doctor Name],ps.PrescriptionsCode,pr.AppointmentDate from PatientRegistrations pr
JOIN Doctors d
on pr.Doctor_ID=d.DoctorID
JOIN Patients p
on pr.Patient_ID=p.PatientID
JOIN Prescriptions ps
on p.PatientID=ps.Patient_ID
group by ps.PrescriptionsCode,p.PatientName,p.PatientLastname,d.DoctorName,d.DoctorLastname,pr.AppointmentDate

--select * from vw_Prescriptions

--reçete detay
create view vw_PrescriptionDetails
as 
select p.PrescriptionsCode,m.MedicineName from Prescriptions p
JOIN  PrescriptionDetails pd
on p.PrescriptionID=pd.Prescription_ID
JOIN  Medicines m
on m.MedicineID=pd.Medicine_ID
group by p.PrescriptionsCode,m.MedicineName

--select * from vw_PrescriptionDetails


--ataþehirdeki doktorlarýn hastanaye kazandýrdýðý para miktarý
create view vw_EarningsOfEachDoctorsInIstanbulAtasehir
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

--select * from vw_EarningsOfEachDoctorsInIstanbulAtasehir

--çankayadaki doktorlarýn hastanaye kazandýrdýðý para miktarý
create view vw_EarningsOfEachDoctorsInAnkaraCankaya
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

-- select * from vw_EarningsOfEachDoctorsInAnkaraCankaya

-- ÝZMÝR KONAKTAKÝ doktorlarýn hastanaye kazandýrdýðý para miktarý
create view vw_EarningsOfEachDoctorsInIzmirKonak
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

--SELECT * FROM vw_EarningsOfEachDoctorsInIzmirKonak

--HER HASTANEDE KAÇ DEPARTMAN OLDUÐUNUN PÝVOT TABLE ÝLE GÖSTERÝMÝ 

--PIVOT (HANGÝ ÞEHÝRDE NE KADAR DEPARTMAN VAR)
Select * from(
Select count(d.DepartmentID) as DepartmentCount ,c.CityName as CityName from Departments d
JOIN DepartmentDetails dd ON d.DepartmentID=dd.Department_ID
JOIN Hospitals h ON dd.Hospital_ID=h.HospitalID
JOIN Districts di ON h.District_ID=di.DistrictID
JOIN Cities c ON di.City_ID=c.CityID
GROUP BY C.CityName)DepartmentCity
PIVOT
(
 Sum(DepartmentCount ) For [CityName] in ([ÝSTANBUL],[ANKARA],[ÝZMÝR])
 )pivotDepartmentCity