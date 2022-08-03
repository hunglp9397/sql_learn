USE learn_mysql;
CREATE TABLE TBLKhoa
(Makhoa char(10)primary key,
 Tenkhoa char(30),
 Dienthoai char(10));
CREATE TABLE TBLGiangVien(
Magv int primary key,
Hotengv char(30),
Luong decimal(5,2),
Makhoa char(10) references TBLKhoa);
CREATE TABLE TBLSinhVien(
Masv int primary key,
Hotensv char(40),
Makhoa char(10),foreign key (Makhoa) references TBLKhoa(MaKhoa),
Namsinh int,
Quequan char(30));
CREATE TABLE TBLDeTai(
Madt char(10)primary key,
Tendt char(30),
Kinhphi int,
Noithuctap char(30));
CREATE TABLE TBLHuongDan(
Masv int primary key,
Madt char(10), foreign key (Madt) references TBLDeTai(Madt),
Magv int, foreign key (Magv) references TBLGiangVien(Magv),
KetQua decimal(5,2));
INSERT INTO TBLKhoa VALUES
('Geo','Dia ly va QLTN',3855413),
('Math','Toan',3855411),
('Bio','Cong nghe Sinh hoc',3855412);
INSERT INTO TBLGiangVien VALUES
(11,'Thanh Binh',700,'Geo'),    
(12,'Thu Huong',500,'Math'),
(13,'Chu Vinh',650,'Geo'),
(14,'Le Thi Ly',500,'Bio'),
(15,'Tran Son',900,'Math');
INSERT INTO TBLSinhVien VALUES
(1,'Le Van Son','Bio',1990,'Nghe An'),
(2,'Nguyen Thi Mai','Geo',1990,'Thanh Hoa'),
(3,'Bui Xuan Duc','Math',1992,'Ha Noi'),
(4,'Nguyen Van Tung','Bio',null,'Ha Tinh'),
(5,'Le Khanh Linh','Bio',1989,'Ha Nam'),
(6,'Tran Khac Trong','Geo',1991,'Thanh Hoa'),
(7,'Le Thi Van','Math',null,'null'),
(8,'Hoang Van Duc','Bio',1992,'Nghe An');
INSERT INTO TBLDeTai VALUES
('Dt01','GIS',100,'Nghe An'),
('Dt02','ARC GIS',500,'Nam Dinh'),
('Dt03','Spatial DB',100, 'Ha Tinh'),
('Dt04','MAP',300,'Quang Binh' );
INSERT INTO TBLHuongDan VALUES
(1,'Dt01',13,8),
(2,'Dt03',14,0),
(3,'Dt03',12,10),
(5,'Dt04',14,7),
(6,'Dt01',13,Null),
(7,'Dt04',11,10),
(8,'Dt03',15,6);

-- 1. Lấy thông tin gồm mã số, họ tên, tên khoa của tất cả các giảng viên

select gv.Magv, gv.Hotengv, k.Tenkhoa from tblgiangvien gv 
 join tblkhoa k on gv.Makhoa = k.Makhoa;
 
 -- 2. Lấy thông tin gồm mã số, họ tên, tên khoa của các giảng viên khoa dia ly va QLTN
 
 SELECT GV.Magv, GV.Hotengv, K.Tenkhoa
FROM TBLGiangVien GV JOIN TBLKhoa K
ON GV.Makhoa = K.Makhoa 
WHERE K.Tenkhoa = 'Dia ly va QLTN';

-- 3. Cho biết số sinh viên của khoa ‘CONG NGHE SINH HOC’

select count(*) from tblsinhvien where Makhoa='Bio';

-- 4 Đưa ra danh sách gồm mã số, họ tênvà tuổi của các sinh viên khoa ‘TOAN’

select sv.Masv, sv.Hotensv, year(curdate()) - sv.Namsinh AS age from tblsinhvien sv where sv.Makhoa='Math';

-- 5. Cho biết số giảng viên của khoa ‘CONG NGHE SINH HOC’

select count(*) from tblgiangvien gv join tblkhoa k on k.Makhoa = gv.Makhoa where k.Tenkhoa = 'CONG NGHE SINH HOC';




-- Câu 6: Lay thong tin cua sinh vien khong tham gia thuc tap
SELECT SV.Masv,SV.Hotensv
FROM TBLSinhVien SV 
WHERE NOT EXISTS(
SELECT HD.Masv
FROM TBLHuongDan HD 
WHERE SV.Masv = HD.Masv);

-- cau 7 :Đưa ra mã khoa, tên khoa và số giảng viên của mỗi khoa

select k.Makhoa, k.Tenkhoa, count(gv.Magv) as sogiangvien from tblkhoa k 
join tblgiangvien gv on gv.Makhoa =k.Makhoa
group by k.Makhoa;

SELECT K.Makhoa,K.Tenkhoa, COUNT(K.Makhoa) AS SO_GV
FROM TBLGiangVien GV JOIN TBLKhoa K
ON GV.Makhoa = K.Makhoa
GROUP BY K.Makhoa,K.Tenkhoa;


-- Cau 8. Cho biết số điện thoại của khoa mà sinh viên có tên ‘Le van son’ đang theo học

select k.Dienthoai from tblsinhvien sv join tblkhoa k
on sv.Makhoa = k.Makhoa where sv.Hotensv='Le Van Son';

select k.Dienthoai from tblkhoa k join tblsinhvien sv on k.Makhoa = sv.Makhoa where sv.Hotensv = 'Le Van Son';


-- 1. Cho biết mã số và tên của các đề tài do giảng viên ‘Tran son’ hướng dẫn

select dt.Madt, dt.Tendt from tbldetai dt
join tblhuongdan hd on dt.Madt = hd.Madt
join tblgiangvien gv on gv.Magv = hd.Magv
where gv.Hotengv = 'Tran Son';

-- 2 Cho biết tên đề tài không có sinh viên nào thực tập

select tbldetai.Madt, tbldetai.Tendt from tbldetai where  madt not in  (select madt from tblhuongdan);

select * from tbldetai dt where not exists (select hd.Madt from tblhuongdan hd where hd.Madt = dt.Madt);


-- 3 Cho biết mã số, họ tên, tên khoa của các giảng viên hướng dẫn từ 1 sinh viên trở lên
SELECT GV.Magv,GV.Hotengv,K.Tenkhoa
FROM TBLGiangVien GV JOIN TBLKhoa K
ON GV.Makhoa = K.Makhoa
WHERE GV.Magv IN (
SELECT HD.Magv
FROM TBLHuongDan HD
GROUP BY HD.Magv
HAVING COUNT(HD.MaSV)>1);


-- 4 Cho biết mã số, tên đề tài của đề tài có kinh phí cao nhất 
select dt.Madt, dt.Tendt from tbldetai dt where dt.Kinhphi = (select max(dt.Kinhphi) from tbldetai dt);

 -- 5 Cho biết mã số và tên các đề tài có nhiều hơn 2 sinh viên tham gia thực tập
select * from tbldetai where tbldetai.Madt in (
select hd.madt from tblhuongdan hd group by hd.Madt having count(hd.madt) > 2);

-- 6 Đưa ra mã số, họ tên và điểm của các sinh viên khoa ‘DIALY và QLTN’

SELECT SV.Masv,SV.Hotensv,HD.KetQua FROM TBLSinhVien SV 
JOIN TBLHuongDan HD ON SV.Masv = HD.Masv
JOIN TBLKhoa K ON K.Makhoa = SV.Makhoa
WHERE K.Tenkhoa = 'Dia ly va QLTN';

-- 7 Lấy ra tên khoa, số lượng sinh vien của mỗi khoa

select k.Tenkhoa, Count(sv.Masv) as sosinhvien
from tblkhoa k join tblsinhvien sv on sv.Makhoa = k.Makhoa
group by k.Makhoa;



-- 8. Cho biết thoong tin về các sinh viên thực tập tại quê nhà

select * from tblsinhvien sv 
join tblhuongdan hd on hd.Masv = sv.Masv
join tbldetai dt on dt.Madt = hd.Madt
where dt.Noithuctap = sv.Quequan;



-- 9 Hãy cho biết thông tin về những sinh viên chưa có điểm thực tập

SELECT *
FROM TBLSinhVien SV JOIN TBLHuongDan HD
ON HD.Masv = SV.Masv
WHERE HD.KetQua is Null;

-- 10 Đưa ra danh sách gồm mã số, họ tên các sinh viên có điểm thực tập bằng 0
SELECT SV.Masv,SV.Hotensv
FROM TBLSinhVien SV JOIN TBLHuongDan HD
ON HD.Masv = SV.Masv
WHERE HD.KetQua = 0;












 






