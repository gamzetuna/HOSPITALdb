
--HANGÝ REÇETEDE HANGÝ ÝLAÇ VAR

create function fnc_PrescriptionDetail
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

--SELECT * FROM dbo.fnc_PrescriptionDetail ('6B7A9A43')

--HASTANENÝN DEPARTMANLARINDA TOPLAM KAÇ HASTA YATIYOR		
create function fnc_TotalPatientsOfEachDepartmentInHospitals
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

--select * from dbo.fnc_TotalPatientsOfEachDepartmentInHospitals(1)
--**************************************************************************

--HASTA HANGÝ BÖLÜMDE YATIYOR VE YATTIÐI ODANIN NUMARASI NEDÝR?
create function fnc_InpatientInformation
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

--select * from dbo.fnc_InpatientInformation('11215456787')		

--HASTA KAYIT GEÇMÝÞÝ FONKSÝYONU

create function fnc_PatientRegistrationHistory
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

--select * from dbo.fnc_PatientRegistrationHistory('11215456787')				
