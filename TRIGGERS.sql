--ÝLAÇ SÝLME TRÝGGER 
GO
create trigger trg_MedicineDelete				
on Medicines
instead of DELETE
AS
declare @m_id int
select @m_id=MedicineID from deleted
UPDATE Medicines set [Status]=0 where MedicineID=@m_id
GO


--REÇETE SÝLME TRÝGGER
GO
create trigger  trg_PrescriptionDelete			
on Prescriptions
instead of DELETE
AS
DECLARE @p_id int
select @p_id=PrescriptionID from deleted
UPDATE Prescriptions set [Status]=0 where PrescriptionID=@p_id
GO

--REÇETE ÝLAÇ SÝLME TRÝGGER 
GO
create trigger trg_PrescriptionDetailsDelete	--REÇETE ÝLAÇ SÝLME TRIGGER
on PrescriptionDetails
instead of DELETE
AS
DECLARE @m_id int
select @m_id = Medicine_ID from deleted
UPDATE PrescriptionDetails set [Status]=0 where Medicine_ID=@m_id 
GO


--DEPARTMAN SÝLME TRÝGGER
GO 
create trigger trg_DepartmentDelete 
on Departments
INSTEAD OF DELETE
AS
DECLARE @trgDepartmentID int
select @trgDepartmentID = DepartmentID from deleted
UPDATE Departments SET [Status] = 0 where DepartmentID = @trgDepartmentID
GO

--ÞEHÝR SÝLME TRÝGGER
create trigger trg_CityDelete				
on Cities
instead of DELETE
AS
declare @c_ID int
select @c_ID=CityID from deleted
UPDATE Cities set [Status]=0 where CityID=@c_ID
GO

--ÝLÇE SÝLME TRÝGGER 
create trigger trg_DistrictDelete				
on Districts
instead of DELETE
AS
declare @d_ID int
select @d_ID=DistrictID from deleted
UPDATE Districts set [Status]=0 where DistrictID=@d_ID
GO

--HASTANE SÝLME TRÝGGER 
create trigger trg_HospitalDelete
on Hospitals
instead of DELETE
AS
declare @h_ID int 
select @h_ID=HospitalID from deleted
UPDATE Hospitals set [Status]=0 where HospitalID=@h_ID
GO

--ÇALIÞAN SÝLME TRÝGGER
create trigger trg_EmployeeDelete
on Employees
instead of delete
AS
declare @e_ID int 
select @e_ID=EmployeeID from deleted
UPDATE Employees set [Status]=0 where EmployeeID=@e_ID
GO

--DOKTOR SÝLME TRÝGGER 
create trigger trg_DoctorsDelete 
on Doctors
INSTEAD OF DELETE
AS
DECLARE @D_ID int
select @D_ID = DoctorID from deleted
UPDATE Doctors set [Status] = 0 where DoctorID = @D_ID
GO
