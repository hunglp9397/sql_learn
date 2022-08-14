use learn_sql_student_management;


CREATE TABLE DMHOCPHAN(
	mahp int primary key,
    tenhp varchar(255),
    sodvht int,
    manganh varchar(255),
    hocky int
);

CREATE TABLE DMKHOA(
	makhoa char(20) primary key,
    tenkhoa varchar(255)
);

CREATE TABLE DMNGANH(
	manganh int primary key,
    tennganh varchar(255),
    makhoa char(20),
    FOREIGN KEY (makhoa) REFERENCES DMKhoa(makhoa)
);

CREATE TABLE DMLOP(
	malop char(20) primary key,
    tenlop varchar(255),
    manganh int,
    khoahoc int,
    hedt varchar(255),
    namnhaphoc int,
    FOREIGN KEY (manganh) REFERENCES dmnganh(manganh)

);

CREATE TABLE SINHVIEN(
	masv int primary key,
    hoten varchar(255),
    gioitinh boolean,
    ngaysinh date,
    diachi varchar(255),
    malop char(20),
    FOREIGN KEY (malop) REFERENCES DMLOP(malop)
);

CREATE TABLE DIEMHP(
	masv int NOT NULL,
    mahp int NOT NULL,
    diemhp double,
   FOREIGN KEY (masv) REFERENCES SINHVIEN(masv),
    FOREIGN KEY (mahp) REFERENCES DMHOCPHAN(mahp)

);

INSERT INTO `diemhp` VALUES (2,2,5.9),(2,3,4.5),(3,1,4.3),(3,2,6.7),(3,3,7.3),(4,1,4),(4,2,5.2),(4,3,3.5),(5,1,9.8),(5,2,7.9),(5,3,7.5),(6,1,6.1),(6,2,5.6),(6,3,4),(7,1,6.2);
INSERT INTO `dmhocphan` VALUES (1,'Toán cao cấp A1',4,'480202',1),(2,'Tiếng Anh 1',3,'480202',1),(3,'Vật lý đại cương',4,'480202',1),(4,'Tiếng Anh 2',7,'480202',1),(5,'Tiếng Anh 1',3,'140909',2),(6,'Xác suất thống kê',3,'140909',2);
INSERT INTO `dmkhoa` VALUES ('CNTT','Công nghệ thông tin '),('KT',' Kế toán'),('SP','Sư phạm');
INSERT INTO `dmlop` VALUES ('CT11','Cao đẳng tin học',480202,11,'TC',2013),('CT12','Cao đẳng tin học',480202,12,'CĐ',2013),('CT13','Cao đẳng tin học',480202,13,'CĐ',2014);
INSERT INTO `dmngdiemhpdmhocphananh` VALUES (140902,'Sư phạm toán tin','CNTT'),(480202,'Tin học ứng dụng ','CNTT');
INSERT INTO `sinhvien` VALUES (1,'Phan Thanh ',0,'1990-12-09','Tuyen Quang','CT12'),(2,'Nguyễn Thị Cẩm',1,'1994-12-01','Quy Nhơn','CT12'),(3,'Võ Thị Hà',1,'1995-02-07','Anh Nhơn','CT12'),(4,'Trần Hoài Nam',0,'1994-05-04','Tây Sơn','CT12'),(5,'Trần Văn Hoàng',0,'1995-04-08','Vĩnh Thạnh','CT13'),(6,'Đặng Thị Thảo',1,'1995-12-06','Quy Nhơn','CT13'),(7,'Lê Thị Sen',1,'1994-12-08','Phù Cát','CT13'),(8,'Nguyễn Văn Huy',0,'1995-04-06','Phù Mỹ','CT11'),(9,'Trần Thị Hoa',1,'1994-09-08','Hoài Nhơn','CT11');



-- 0.01 Cho biết các sinh viên đang theo học
select * from sinhvien sv  where exists (select dhp.masv from diemhp dhp where dhp.masv = sv.masv);


-- 0.02 Cho biết các sinh viên đang ko theo học

select * from sinhvien sv where not exists (select dhp.masv from diemhp dhp where dhp.masv = sv.masv);

-- 1 Hiển thị danh sách gồm MaSV, HoTên, MaLop, DiemHP, MaHP của những sinh viên có điểm HP >= 5.
SELECT sv.masv, sv.hoten, l.malop, dhp.diemhp, dhp.mahp FROM sinhvien sv
JOIN diemhp dhp on sv.masv = dhp.masv 
JOIN dmlop l on l.malop = sv.malop
where diemhp >=5;

-- 2  Hiển thị danh sách MaSV, HoTen , MaLop, MaHP, DiemHP được sắp xếp theo ưu tiên Mã lớp, Họ tên tăng dần
SELECT sv.MaSV, sv.HoTen, L.MaLop, L.TenLop ,HP.DiemHP,
HP.MaHP
FROM SINHVIEN SV
INNER JOIN DIEMHP HP ON HP.MaSV=SV.MaSV
INNER JOIN DMLOP L ON SV.MaLop= L.MaLop
ORDER BY L.MaLop, SV.HoTen ASC;

-- 3. Hiển thị danh sách gồm MaSV, HoTen, MaLop, DiemHP, MaHP của những sinh viên có điểm HP từ 5 đến 7 ở học kỳ I
SELECT sv.masv, sv.hoten, l.malop, dhp.diemhp, hp.mahp, hp.hocky
from sinhvien sv
join dmlop l on l.malop = sv.malop
join diemhp dhp on dhp.masv = sv.masv
join dmhocphan hp on hp.mahp = dhp.mahp
where (dhp.diemhp >= 5 and dhp.diemhp <= 7 ) and hp.hocky = 1;


-- 4 Hiển thị danh sách sinh viên gồm MaSV, HoTen, MaLop, TenLop, MaKhoa của Khoa có mã CNTT
SELECT sv.MaSV, sv.HoTen, sv.MaLop, l.TenLop, k.MaKhoa
FROM SINHVIEN sv
INNER JOIN dmlop l  ON sv.MaLop=l.MaLop
INNER JOIN DMNGANH N ON n.MaNganh=l.MaNganh
INNER JOIN dmkhoa K on k.makhoa = n.makhoa
WHERE k.MaKhoa='CNTT';


-- ---------------------------------CÂU LỆNH PHÂN NHÓM ---------------------------------------------------------

-- 1. Cho biết MaLop, TenLop, tổng số sinh viên của mỗi lớp.

select l.malop, l.tenlop, count(sv.masv) as sosinhvien from dmlop l join sinhvien sv on l.malop = sv.malop group by l.malop, l.tenlop;

-- 2.Cho biết điểm trung bình chung của mỗi sinh viên, xuất ra bảng mới có tên DIEMTBC, biết rằng công thức tính DiemTBC như sau:
-- DiemTBC = Tổng sích ma (DiemHP * SoDvht) / tổng sích ma (SoDvht)

select dhp.masv, sv.hoten, sum(dhp.diemhp * hp.sodvht) / sum(hp.sodvht) as diemtbc from dmhocphan hp
 join diemhp dhp on dhp.mahp = hp.mahp 
 join sinhvien sv on sv.masv = dhp.masv
 group by dhp.masv;

-- Cho biết điểm trung bình chung của mỗidiemhpdmhocphan sinh viên ở mỗi học kỳ
SELECT HocKy,MaSV,SUM(DiemHP*Sodvht)/SUM(Sodvht) AS
DiemTBC
FROM DMHOCPHAN
INNER JOIN DIEMHP ON DMHOCPHAN.MaHP=DIEMHP.MaHP
GROUP BY HocKy, MAsv;

-- Cho biết mã lớp, tên lớp, số lượng nam nữ theo lớp
SELECT SINHVIEN.MaLop,Tenlop,CASE GioiTinh WHEN 0
THEN N'Nữ' ELSE N'Nam' END AS GioiTinh, COUNT(MaSV)
AS Soluong
FROM DMLOP
INNER JOIN SINHVIEN ON DMLOP.MaLop=SINHVIEN.MaLop
GROUP BY SINHVIEN.MaLop,Tenlop,gioitinh
ORDER BY SINHVIEN.MaLop;

-- =========================== Câu lệnh cấu trúc lồng nhau ============
-- 1. Cho biết họ tên sinh viên không học học phần nào
select * from sinhvien sv where masv not in (select masv from diemhp);

select * from dmhocphan;



-- 2. Cho biết sinh viên ko học học phần có mã 1;
select * from sinhvien sv where masv not in (select masv from diemhp where mahp = 01);

-- 3. Cho biết tên học phần không có sinhvien điểm hp < 5;
select * from dmhocphan hp where mahp not in (select mahp from diemhp where diemhp < 5);

-- 4. Cho biết sinhvieen không có học phần điểm < 5
select * from sinhvien sv where masv not in (select masv from diemhp where diemhp < 5);


-- ============================Cấu trúc lồng nhau không kết nối===========
-- 1.cho biết tên lớp có sinh viên tên Hoa
select * from dmlop where malop in (select malop from sinhvien where hoten like N'%Hoa');

-- 2. Cho biết HoTen sinh viên có điểm học phần ‘001’ và <5
select * from sinhvien where masv in (select masv from diemhp where diemhp < 5 and mahp = 1);

select * from sinhvien sv 
join diemhp dhp on dhp.masv = sv.masv
where dhp.mahp = 1 and dhp.diemhp < 5;

-- 3. Cho biết danh sách các học phần có số lượng đơn vị lớn hơn hoặc bằng số đơn vị học phần mã 01
select * from dmhocphan where sodvht >= (select sodvht from dmhocphan where mahp = 1);



