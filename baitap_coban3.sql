

-- TABLE
use learn_sql_product_management;
CREATE TABLE KHACHHANG(
	makh char(10) primary key,
    tenkh varchar(255),
    diachi varchar(255),
    dienthoai char(11),
    email varchar(255),
    loaikh char(10)
);

CREATE TABLE HANGHOA(
	maH char(10) primary key,
    tenh varchar(255),
    donvitinh varchar(255),
    dongia int
   
);

CREATE TABLE HOADON(
	mahd int primary key,
    makh char(10),
    ngaylaphd date,
    FOREIGN KEY (makh) REFERENCES KHACHHANG(makh)
);

CREATE TABLE CHITIETHD(
	mahd int ,
    mah char(10),
    soluong int

);

-- Data
INSERT INTO `hanghoa` VALUES ('H0007','Sữa tươi TH truemilk','lốc ',30000),('H001','Sữa đặc ông thọ','lon',23000),('H002','Kẹo  dẻo Hồng Hà','gói',8000),('H003','Bánh xốp Kinh đô','hộp ',120000),('H004','Bánh quy Lũy','hộp',150000),('H005','Đường trắng Quy Hòa','gói',20000),('H006','Bánh Luxy Sài Gòn','hộp',100000);
INSERT INTO `hoadon` VALUES (1,'KH001','2018-02-01'),(2,'KH002','2018-03-02'),(3,'KH002','2018-02-01'),(4,'KH002','2018-03-01'),(5,'KH003','2018-03-02'),(6,'KH004','2018-05-02'),(7,'KH003','2018-05-03'),(8,'KH003','2018-05-04');
INSERT INTO `khachhang` VALUES ('KH001','Nguễn Thị Mai Chi','Quy Nhơn','0987654321','maichi@gmail.com','VIP'),('KH002','Phan Thị Thanh','Quy Nhơn','0123456789',NULL,'TV'),('KH003','Trần Văn Toàn','Tuy Phước','0769145611',NULL,'TV'),('KH004','Trần Văn Ấn','Quy Nhơn','0955432187',NULL,'VIP');
INSERT INTO `chitiethd` VALUES (1,'H001',1),(1,'H002',3),(2,'H003',12),(2,'H004',2),(3,'H001',7),(3,'H004',5),(4,'H001',12),(5,'H003',20),(5,'H005',19),(6,'H007',20),(6,'H003',45),(7,'H002',60),(7,'H008',35);

-- Query
-- 1. Cho biết số lượng hoá đơn xuất vào tháng 5
select count(*) from hoadon where EXTRACT(MONTH FROM ngaylaphd) = 5;

-- 2. Cho biết MaHD, MaH, SoLuong có số lượng bán >10
select * from hanghoa h join chitiethd cthd on h.mah = cthd.mah where cthd.soluong > 10;

-- 3. Cho biết MaHD, MaH, TenH, DonGia, SoLuong, ThanhTien của hoá đơn 001.


-- 4.Cho biết thông tin khách hàng không mua hàng vào tháng 6
select * from khachhang kh where not exists (select hd.makh from hoadon hd where hd.makh = kh.makh and EXTRACT(MONTH FROM ngaylaphd) = 6 ); 


-- 5. Cho biết MaHD, NgayLapHD, MaHK, TenH, DonGia, SoLuong, ThanhTien bán vào tháng 3
select hd.mahd, hd.ngaylaphd, kh.makh, hh.tenh, hh.dongia, cthd.soluong , (hh.dongia * cthd.soluong) as thanhtien 
from hoadon hd 
join khachhang kh on hd.makh = kh.makh
join chitiethd cthd on cthd.mahd = hd.mahd
join hanghoa hh on hh.mah = cthd.mah
where  EXTRACT(MONTH FROM ngaylaphd) = 3;

-- 6. Cho biết danh sách các mặt hàng đã bán được

select * from hanghoa hh where exists (select cthd.mah from chitiethd cthd where cthd.mah = hh.maH);

-- 6.1 Cho biết danh sách các mặt hàng ko được bán

select * from hanghoa hh where not exists (select cthd.mah from chitiethd cthd where cthd.mah = hh.mah);






