USE ENTV
GO

INSERT INTO Vendor VALUES
('VE016', 'Agus Jaya Iskandar', 'agusji@gmail.com', '+6285971993841', 'Jl Cakung Jatikramat RT 02/02, DKI Jakarta'),
('VE017', 'Soemanto Setiawan', 'soemantosetia@yahoo.com', '+6282857442300', 'Psr Melawai Bl ECT/2-3 Lt Dasar, DKI Jakarta')

INSERT INTO TelevisionBrand VALUES
('TB016', 'Apple'),
('TB017', 'Banana')

INSERT INTO Television VALUES
('TE016','TB016','Apple XXX TV 120 inch UHD','10999000'),
('TE017','TB017','Banana ++ Dragon Force ROAR UDH Shining','6799000')

INSERT INTO Staff VALUES
('ST016','Muhammad Fatah','muhammadfatah@gmail.com','Male','+6282818838005','Jl Kb Pala I 17 RT 007/05, Dki Jakarta','14200000','1987-3-4'),
('ST017','Isabela Cinta','isabel@yahoo.com','Female','+6285931847278','Jl Tri Lomba Juang 24 A, Jawa Tengah','18000000','1980-9-22')

INSERT INTO PurchaseTransaction VALUES
('PE016','ST015','VE003','2022-1-3'),
('PE017','ST001','VE004','2022-1-4')

INSERT INTO PurchaseTransactionDetail VALUES
('PE016', 'TE016', '20'),
('PE016', 'TE017', '30')

INSERT INTO Customer VALUES
('CU016', 'Bryan Kurniawan', 'briankurniawan@gmail.com', 'Male','+6283836613554' , 'Jl Taman Surya 5 C3/5','1990-12-12'),
('CU017','Tobey Maguire','spiderman@gmail.com','Male','+6283823001412','Jl Cikawao Permai Bl B/8, Jawa Barat','1998-4-20')

INSERT INTO SalesTransaction VALUES
('SA016','ST013','CU013','2022-1-2'),
('SA017','ST014','CU014','2022-1-3')

INSERT INTO SalesTransactionDetail VALUES
('SA016', 'TE016', '1'),
('SA016', 'TE017', '2')