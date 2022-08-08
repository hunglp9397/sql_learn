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
INSERT INTO `dmnganh` VALUES (140902,'Sư phạm toán tin','CNTT'),(480202,'Tin học ứng dụng ','CNTT');
INSERT INTO `sinhvien` VALUES (1,'Phan Thanh ',0,'1990-12-09','Tuyen Quang','CT12'),(2,'Nguyễn Thị Cẩm',1,'1994-12-01','Quy Nhơn','CT12'),(3,'Võ Thị Hà',1,'1995-02-07','Anh Nhơn','CT12'),(4,'Trần Hoài Nam',0,'1994-05-04','Tây Sơn','CT12'),(5,'Trần Văn Hoàng',0,'1995-04-08','Vĩnh Thạnh','CT13'),(6,'Đặng Thị Thảo',1,'1995-12-06','Quy Nhơn','CT13'),(7,'Lê Thị Sen',1,'1994-12-08','Phù Cát','CT13'),(8,'Nguyễn Văn Huy',0,'1995-04-06','Phù Mỹ','CT11'),(9,'Trần Thị Hoa',1,'1994-09-08','Hoài Nhơn','CT11');





