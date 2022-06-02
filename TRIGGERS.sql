--�LA� S�LME TR�GGER 
GO
create trigger trg_MedicineDelete				
on Medicines
instead of DELETE
AS
declare @m_id int
select @m_id=MedicineID from deleted
UPDATE Medicines set [Status]=0 where MedicineID=@m_id
GO


--RE�ETE S�LME TR�GGER
GO
create trigger  trg_PrescriptionDelete			
on Prescriptions
instead of DELETE
AS
DECLARE @p_id int
select @p_id=PrescriptionID from deleted
UPDATE Prescriptions set [Status]=0 where PrescriptionID=@p_id
GO

--RE�ETE �LA� S�LME TR�GGER 
GO
create trigger trg_PrescriptionDetailsDelete	--RE�ETE �LA� S�LME TRIGGER
on PrescriptionDetails
instead of DELETE
AS
DECLARE @m_id int
select @m_id = Medicine_ID from deleted
UPDATE PrescriptionDetails set [Status]=0 where Medicine_ID=@m_id 
GO


--DEPARTMAN S�LME TR�GGER
GO 
create trigger trg_DepartmentDelete 
on Departments
INSTEAD OF DELETE
AS
DECLARE @trgDepartmentID int
select @trgDepartmentID = DepartmentID from deleted
UPDATE Departments SET [Status] = 0 where DepartmentID = @trgDepartmentID
GO

--�EH�R S�LME TR�GGER
create trigger trg_CityDelete				
on Cities
instead of DELETE
AS
declare @c_ID int
select @c_ID=CityID from deleted
UPDATE Cities set [Status]=0 where CityID=@c_ID
GO

--�L�E S�LME TR�GGER 
create trigger trg_DistrictDelete				
on Districts
instead of DELETE
AS
declare @d_ID int
select @d_ID=DistrictID from deleted
UPDATE Districts set [Status]=0 where DistrictID=@d_ID
GO

--HASTANE S�LME TR�GGER 
create trigger trg_HospitalDelete
on Hospitals
instead of DELETE
AS
declare @h_ID int 
select @h_ID=HospitalID from deleted
UPDATE Hospitals set [Status]=0 where HospitalID=@h_ID
GO

--�ALI�AN S�LME TR�GGER
create trigger trg_EmployeeDelete
on Employees
instead of delete
AS
declare @e_ID int 
select @e_ID=EmployeeID from deleted
UPDATE Employees set [Status]=0 where EmployeeID=@e_ID
GO

--DOKTOR S�LME TR�GGER 
create trigger trg_DoctorsDelete 
on Doctors
INSTEAD OF DELETE
AS
DECLARE @D_ID int
select @D_ID = DoctorID from deleted
UPDATE Doctors set [Status] = 0 where DoctorID = @D_ID
GO
