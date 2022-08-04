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



