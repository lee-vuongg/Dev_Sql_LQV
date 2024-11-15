create database DEV2410SQL35__LEQUOCVUONG__0355778077
go 
use DEV2410SQL35__LEQUOCVUONG__0355778077
go
create table SalesPerson(
SlsPerID int Primary key,
Name Nvarchar (50)
);
create table Customer (
CustID int Primary key,
Name Nvarchar (50)
);
create table Inventory (
InvtID int Primary key,
Descr Nvarchar (100),
StkBasePrc Decimal (18,2)
);
create table xswSalesOrd (
OrderNbr int primary key,
OrderDate Date,
SlsperId Int  foreign key References SalesPerson(SlsperId),
CustID Int  foreign key References Customer (CustID),
OrdAmt decimal (18,2)
);
create table xswSlsOrdDet (
OrderNbr Int,
InvtID Int,
LineQty Int,
LineAmt Decimal (18,2),
SlsPrice Decimal (18,2),
Primary key (OrderNbr,InvtID),
foreign key(OrderNbr)References xswSalesOrd(OrderNbr),
foreign key(InvtID)References Inventory(InvtID)
);
--Thêm Dữ Liệu
Insert Into SalesPerson (SlsPerID,Name) values 
(001,N'Lê Quốc Vương'),
(002,N'Nguyẽn Thị Diễm Hương');
select *from SalesPerson
Insert Into Customer (CustID,Name) values 
(001,N'Nguyễn Văn A'),
(002,N'Nguyẽn Thị B');
select *from Customer
Insert Into Inventory (InvtID,Descr,StkBasePrc) values 
(101,N'Sữa Rửa Mặt',150.00),
(102,N'Kem Đánh  Răng',300.00);
Insert Into xswSalesOrd (OrderNbr,OrderDate,SlsperId,CustID,OrdAmt) values
(1001,'2024-10-20',1,001,300.00),
(1002,'2024-09-15',1,002,100.00);
Insert Into xswSlsOrdDet (OrderNbr,InvtID,LineQty,LineAmt,SlsPrice) values
(1001,101,1,500.00,300.00),
(1002,102,1,500.00,100.00);

--Bài Tập-----------------------------------------

--4.2 
select i.[Descr] from [dbo].[Inventory] i 
where i.[InvtID] 
not in ( select d.[InvtID] from [dbo].[xswSalesOrd] o
join [dbo].[xswSlsOrdDet] d On o.[OrderNbr]=d.OrderNbr
join [dbo].[Inventory] i  On d.InvtID= i.InvtID
where i.Descr ='Kem Đánh Răng' and year(o.[OrderDate])= 2024
);


--4.4
select top 1 i.[Descr]
from [dbo].[Inventory] i
join [dbo].[xswSlsOrdDet] d On i.InvtID=d.InvtID
join [dbo].[xswSalesOrd] o On d.OrderNbr=o.OrderNbr
where month(o.OrderDate)<=6 and year(o.OrderDate)=2024
group by i.Descr
order by sum(d.[LineQty]) Desc;

--4.6
select top 1 sp.[Name]
from [dbo].[SalesPerson] sp 
join [dbo].[xswSalesOrd] o On sp.SlsPerID=o.SlsperId
group by sp.Name
order by Count( Distinct o.CustID) Desc;
--4.7

select top 1 c.[Name]
from [dbo].[Customer] c
join [dbo].[xswSalesOrd] o On c.CustID=o.CustID
where year(o.OrderDate) =2024
group by c.Name
order by count(o.OrderNbr) Desc;

--4.9
select top 10 c.[Name]
from [dbo].[Customer] c 
join [dbo].[xswSalesOrd] o On c.CustID=o.CustID 
where  year (o.[OrderDate])=2024
group by c.Name
order by sum(o.[OrdAmt]) desc;
