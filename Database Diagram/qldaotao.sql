-- DROP TABLE IF EXISTS không được hỗ trợ trong SQL Server, bạn có thể sử dụng IF OBJECT_ID để kiểm tra.
--IF OBJECT_ID('dbo.bangdiem', 'U') IS NOT NULL DROP TABLE dbo.bangdiem;
CREATE TABLE bangdiem (
  MSSV CHAR(8) NOT NULL,
  MaMH VARCHAR(8) NOT NULL,
  DiemKT DECIMAL(4,2) DEFAULT NULL,
  DiemThang4 DECIMAL(2,1) DEFAULT NULL,
  PRIMARY KEY (MSSV, MaMH),
  FOREIGN KEY (MSSV) References lylichsinhvien(MSSV),
  FOREIGN KEY (MaMH) References monhoc(MaMon)
);

--IF OBJECT_ID('dbo.bangiamhieu', 'U') IS NOT NULL DROP TABLE dbo.bangiamhieu;
CREATE TABLE bangiamhieu (
  MaTruong VARCHAR(8) NOT NULL,
  MaCanBo VARCHAR(16) NOT NULL,
  ChucVu VARCHAR(64) NOT NULL,
  ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  FOREIGN KEY (MaTruong) REFERENCES truong(MaTruong)
);


--IF OBJECT_ID('dbo.ctdt', 'U') IS NOT NULL DROP TABLE dbo.ctdt;
CREATE TABLE ctdt (
  MaCTDT VARCHAR(8) PRIMARY KEY NOT NULL,
  MaKhoa VARCHAR(16) NOT NULL,
  TenCTDT VARCHAR(255) NOT NULL,
  TongSoTinChi INT NOT NULL,
  NamBatDau DATE NOT NULL,
  FOREIGN KEY (MaKhoa) REFERENCES khoa(MaKhoa)
);

ALTER TABLE ctdt 
ALTER COLUMN TenCTDT NVARCHAR(255) NOT NULL;

CREATE TABLE dssv_lophoc (
  MaLop VARCHAR(10) NOT NULL,
  MSSV CHAR(8) NOT NULL,
  DQT DECIMAL(4,2) DEFAULT NULL,
  DCK DECIMAL(4,2) DEFAULT NULL,
  DTK DECIMAL(4,2) DEFAULT NULL,
  FOREIGN KEY (MaLop) References lophoc(MaLop),
  FOREIGN KEY (MSSV) References lylichsinhvien(MSSV)
);

--IF OBJECT_ID('dbo.giangvien', 'U') IS NOT NULL DROP TABLE dbo.giangvien;
CREATE TABLE giangvien (
  MaGV VARCHAR(10) PRIMARY KEY NOT NULL,
  TenGV VARCHAR(255) NOT NULL,
  NamSinh DATE NOT NULL,
  QueQuan VARCHAR(255) NOT NULL,
  Email VARCHAR(255) NOT NULL,
  SDT VARCHAR(20) NOT NULL,
  MaKhoa VARCHAR(16) NOT NULL,
  CMND VARCHAR(20) NOT NULL,
  FOREIGN KEY (MaKhoa) References khoa(MaKhoa)
);

ALTER TABLE giangvien
ALTER COLUMN TenGV NVARCHAR(255) NOT NULL;

--IF OBJECT_ID('dbo.gv_dugiang', 'U') IS NOT NULL DROP TABLE dbo.gv_dugiang;
CREATE TABLE gv_dugiang (
  MaGV VARCHAR(10) NOT NULL,
  MaLop VARCHAR(10) NOT NULL,
  FOREIGN KEY (MaGV) references giangvien(MaGV),
  FOREIGN KEY (MaLop) references lophoc(MaLop)
);


--IF OBJECT_ID('dbo.khoa', 'U') IS NOT NULL DROP TABLE dbo.khoa;
CREATE TABLE khoa (
  MaKhoa VARCHAR(16) PRIMARY KEY NOT NULL,
  MaTruong VARCHAR(8) NOT NULL,
  TenKhoa VARCHAR(64) NOT NULL,
  MaTruongKhoa VARCHAR(10) NOT NULL,
  FOREIGN KEY (MaTruong) REFERENCES truong(MaTruong)
);

ALTER TABLE khoa
ALTER COLUMN TenKhoa NVARCHAR(255) NOT NULL;
ALTER TABLE khoa ADD CONSTRAINT gv_truongkhoa FOREIGN KEY (MaTruongKhoa) REFERENCES giangvien(MaGV);
DROP TABLE khoa;
--IF OBJECT_ID('dbo.lophoc', 'U') IS NOT NULL DROP TABLE dbo.lophoc;
CREATE TABLE lophoc (
  MaLop VARCHAR(10) NOT NULL PRIMARY KEY,
  MaMon VARCHAR(8) NOT NULL,
  Ki VARCHAR(8) NOT NULL,
  TuanHoc VARCHAR(20) NOT NULL,
  PhongHoc VARCHAR(10) NOT NULL,
  ThoiGianBatDau TIME NOT NULL,
  ThoiGianKetThuc TIME NOT NULL,
  FOREIGN KEY (MaMon) REFERENCES monhoc(MaMon)
);
ALTER TABLE lophoc ADD CONSTRAINT FK_Lop_Ki FOREIGN KEY (Ki) REFERENCES kyhoc(Ki);
--IF OBJECT_ID('dbo.lopsinhvien', 'U') IS NOT NULL DROP TABLE dbo.lopsinhvien;
CREATE TABLE lopsinhvien (
  MaCTDT VARCHAR(8) NOT NULL,
  MaGiangVienQuanLy VARCHAR(10) NOT NULL,
  MSSVLopTruong CHAR(8) NOT NULL,
  MSSVBiThu CHAR(8) NOT NULL,
  MSSVUyVien CHAR(8) NOT NULL,
  MaLop VARCHAR(16) NOT NULL PRIMARY KEY,
  FOREIGN KEY (MaCTDT) REFERENCES ctdt(MaCTDT),
  FOREIGN KEY (MaGiangVienQuanLy) REFERENCES giangvien(MaGV),
  FOREIGN KEY (MSSVLopTruong) REFERENCES lylichsinhvien(MSSV),
  FOREIGN KEY (MSSVBiThu) REFERENCES lylichsinhvien(MSSV),
  FOREIGN KEY (MSSVUyVien) REFERENCES lylichsinhvien(MSSV)
);

--IF OBJECT_ID('dbo.lylichsinhvien', 'U') IS NOT NULL DROP TABLE dbo.lylichsinhvien;
CREATE TABLE lylichsinhvien (
  MSSV CHAR(8) PRIMARY KEY NOT NULL,
  MaLopSinhVien VARCHAR(16) NOT NULL,
  NgaySinh DATE NOT NULL,
  SoCMND VARCHAR(20) NOT NULL,
  QueQuan VARCHAR(128) NOT NULL,
  GioiTinh VARCHAR(10) NOT NULL,
  TonGiao VARCHAR(32) NOT NULL,
  NgayVaoDang DATE DEFAULT NULL,
  NgayVaoDoan DATE DEFAULT NULL,
  ChiDoan VARCHAR(64) DEFAULT NULL,
  DanToc VARCHAR(32) NOT NULL,
  NoiOHienTai VARCHAR(128) NOT NULL,
  DoiTuongChinhSach VARCHAR(128) DEFAULT NULL,
  SoTheBaoHiem VARCHAR(32) DEFAULT NULL,
  DiaChiThuongTru VARCHAR(256) NOT NULL,
  ThuocHo VARCHAR(64) DEFAULT NULL,
  SoSo VARCHAR(32) DEFAULT NULL,
  HoTen VARCHAR(255) NOT NULL,
  Email VARCHAR(255) NOT NULL,
  SDT VARCHAR(20) NOT NULL
);

ALTER TABLE lylichsinhvien
ALTER COLUMN HoTen NVARCHAR(255) NOT NULL;


ALTER TABLE lylichsinhvien
ALTER COLUMN QueQuan NVARCHAR(255) NOT NULL;

ALTER TABLE lylichsinhvien
ALTER COLUMN DiaChiThuongTru NVARCHAR(255) NOT NULL;


ALTER TABLE lylichsinhvien ADD CONSTRAINT FK_SV_LOP FOREIGN KEY (MaLopSinhVien) REFERENCES lopsinhvien(MaLop);
--IF OBJECT_ID('dbo.monhoc', 'U') IS NOT NULL DROP TABLE dbo.monhoc;
CREATE TABLE monhoc (
  MaCTDT VARCHAR(8) NOT NULL,
  MaMon VARCHAR(8) primary key NOT NULL,
  TenMon VARCHAR(255) NOT NULL,
  SoTinChi INT NOT NULL,
  MaHocPhanHocTruoc VARCHAR(8) DEFAULT NULL,
  MaHocPhanSongHanh VARCHAR(8) DEFAULT NULL,
  SoGioBaiTap INT NOT NULL,
  SoGioLyThuyet INT DEFAULT NULL,
  SoGioTuHoc INT NOT NULL,
  SoGioTN_TH INT DEFAULT NULL,
  HinhThucThi VARCHAR(64) NOT NULL,
  MoTa VARCHAR(256) DEFAULT NULL,
  DeCuong VARBINARY(MAX) NOT NULL,
  NgonNguGiangDay VARCHAR(64) NOT NULL,
  FOREIGN KEY (MaCTDT) REFERENCES ctdt(MaCTDT)
);
ALTER TABLE monhoc
ALTER COLUMN TenMon NVARCHAR(255) NOT NULL;



--IF OBJECT_ID('dbo.nguoithan', 'U') IS NOT NULL DROP TABLE dbo.nguoithan;
CREATE TABLE nguoithan (
  MSSV CHAR(8) NOT NULL,
  HoVaTen NVARCHAR(255) NOT NULL,
  NamSinh VARCHAR(4) NOT NULL,
  QuocTich VARCHAR(64) NOT NULL,
  NoiLamViec NVARCHAR(255) DEFAULT NULL,
  TonGiao VARCHAR(32) DEFAULT NULL,
  NgheNghiep VARCHAR(64) DEFAULT NULL,
  LienHe VARCHAR(20) NOT NULL,
  DiaChiThuongTru NVARCHAR(255) DEFAULT NULL,
  VaiTro NVARCHAR(32) NOT NULL,
  PRIMARY KEY(MSSV, HoVaTen),
  FOREIGN KEY (MSSV) REFERENCES lylichsinhvien(MSSV)
);
DROP TABLE nguoithan;


--IF OBJECT_ID('dbo.trangthaisinhvien', 'U') IS NOT NULL DROP TABLE dbo.trangthaisinhvien;
CREATE TABLE trangthaisinhvien (
  CPA DECIMAL(4,2) NOT NULL,
  SoTinChiTichLuy INT NOT NULL,
  MSSV CHAR(8) NOT NULL,
  TrangThai VARCHAR(20) NOT NULL,
  No INT NOT NULL,
  MucCanhCao CHAR(1) NOT NULL,
  TrinhDo VARCHAR(10) NOT NULL,
  FOREIGN KEY (MSSV) REFERENCES lylichsinhvien(MSSV)
);
DROP TABLE trangthaisinhvien;
--IF OBJECT_ID('dbo.truong', 'U') IS NOT NULL DROP TABLE dbo.truong;
CREATE TABLE truong (
  MaTruong VARCHAR(8) PRIMARY KEY NOT NULL,
  TenTruong VARCHAR(64) NOT NULL,
  DiaChi VARCHAR(512) NOT NULL,
  Email VARCHAR(128) NOT NULL,
  SoDienThoai VARCHAR(16) NOT NULL
);
ALTER TABLE Truong 
ALTER COLUMN TenTruong NVARCHAR(255) NOT NULL;

ALTER TABLE Truong 
ALTER COLUMN DiaChi NVARCHAR(255) NOT NULL;
CREATE TABLE nguoidung(
ID INT IDENTITY(1,1) NOT NULL,
TenDangNhap VARCHAR(255) NOT NULL,
MatKhau VARCHAR(512) NOT NULL,
Email VARCHAR(255) NOT NULL,
SDT VARCHAR(16) not null,
ThoiGianTaoTaiKhoan DATETIME NOT NULL,
LanDangNhapCuoi DATETIME NOT NULL,
VaiTro VARCHAR(10) NOT NULL);

CREATE TABLE dangkihocphan(
SoTinChi INT NOT NULL,
MaMon VARCHAR(8) NOT NULL,
MSSV CHAR(8) NOT NULL,
Ki VARCHAR(8) NOT NULL,
PRIMARY KEY (MaMon, MSSV, Ki),
FOREIGN KEY (MaMon) REFERENCES monhoc(MaMon),
FOREIGN KEY (MSSV) REFERENCES lylichsinhvien(MSSV),
FOREIGN KEY (Ki) REFERENCES kyhoc(Ki)
);

CREATE TABLE kyhoc (
  Ki VARCHAR(8) PRIMARY KEY,
  TenKiHoc NVARCHAR(50) NOT NULL,
  ThoiGianBatDau DATE NOT NULL,
  ThoiGianKetThuc DATE NOT NULL
);

ALTER TABLE nguoidung ADD DaDangNhap INT NOT NULL;
ALTER TABLE nguoidung ADD MSSV CHAR(8) NOT NULL;
ALTER TABLE nguoidung ADD CONSTRAINT FK_ND_SV FOREIGN KEY (MSSV) REFERENCES lylichsinhvien(MSSV);

/*DELIMITER $$

CREATE FUNCTION trinh_do(so_tin_chi INT)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE trinh_do VARCHAR(50);

    IF so_tin_chi < 30 THEN
        SET trinh_do = N'Năm 1';
    ELSEIF so_tin_chi < 60 THEN
        SET trinh_do = N'Năm 2';
    ELSEIF so_tin_chi < 90 THEN
        SET trinh_do = N'Năm 3';
    ELSE
        SET trinh_do = N'Năm 4';
    END IF;

    RETURN trinh_do;
END $$

DELIMITER ;*/

CREATE TRIGGER update_ttsv_trinhdo
ON trangthaisinhvien
AFTER INSERT, UPDATE -- Có thể là INSERT, UPDATE, DELETE
AS
BEGIN
    -- Logic xử lý trong trigger
    DECLARE @so_tin_chi INT;
    DECLARE @trinh_do NVARCHAR(50);

    -- Lấy số tín chỉ từ bảng vừa chèn hoặc cập nhật
    SELECT @so_tin_chi = SoTinChiTichLuy FROM inserted;

    -- Tính toán trình độ dựa trên số tín chỉ
    IF @so_tin_chi < 32
        SET @trinh_do = N'Năm 1';
    ELSE IF @so_tin_chi < 64
        SET @trinh_do = N'Năm 2';
    ELSE IF @so_tin_chi < 96
        SET @trinh_do = N'Năm 3';
    ELSE IF @so_tin_chi <128
        SET @trinh_do = N'Năm 4';
	ELSE SET @trinh_do = N'Năm 5';
    -- Cập nhật trình độ cho sinh viên trong bảng
    UPDATE trangthaisinhvien
    SET TrinhDo = @trinh_do
    WHERE SoTinChiTichLuy = @so_tin_chi;
END;

CREATE TRIGGER update_ttsv_cc
ON trangthaisinhvien
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @No INT;
    DECLARE @canh_cao CHAR(1);

    -- Lấy giá trị của trường No từ bảng ảo inserted (chứa các bản ghi vừa được chèn hoặc cập nhật)
    SELECT @No = No FROM inserted;

    -- Kiểm tra và gán giá trị cho biến @canh_cao dựa trên giá trị @No
    IF @No = 0
        SET @canh_cao = '0';
    ELSE IF @No = 4
        SET @canh_cao = '1';
    ELSE IF @No = 8
        SET @canh_cao = '2';
    ELSE IF @No = 16
        SET @canh_cao = '3';
    ELSE
        SET @canh_cao = '4'; -- Đặt giá trị mặc định nếu không thỏa mãn các điều kiện trên

    -- Cập nhật bảng trangthaisinhvien với giá trị MucCanhCao mới
    UPDATE trangthaisinhvien
    SET MucCanhCao = @canh_cao
    WHERE No = @No;
END;



ALTER TABLE monhoc
ADD TrongSo VARCHAR(12) NOT NULL;

ALTER TABLE bangdiem ADD DiemChu varchar(2) NOT NULL;

CREATE TRIGGER update_bang_diem
ON bangdiem
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @diemKT DECIMAL(4,2);
    DECLARE @diemChu VARCHAR(2);
    DECLARE @diemSo DECIMAL(2,1);

    -- Xử lý nhiều bản ghi trong bảng inserted
    -- Cập nhật các bản ghi trong bảng bangdiem
    UPDATE b
    SET 
        b.DiemChu = CASE
                        WHEN i.diemKT >= 9.5 THEN 'A+'
                        WHEN i.diemKT >= 8.5 THEN 'A'
                        WHEN i.diemKT >= 8.0 THEN 'B+'
                        WHEN i.diemKT >= 7.0 THEN 'B'
                        WHEN i.diemKT >= 6.5 THEN 'C+'
                        WHEN i.diemKT >= 5.5 THEN 'C'
                        WHEN i.diemKT >= 5.0 THEN 'D+'
                        WHEN i.diemKT >= 4.0 THEN 'D'
                        ELSE 'F'
                    END,
        b.DiemThang4 = CASE
                        WHEN i.diemKT >= 9.5 THEN 4
                        WHEN i.diemKT >= 8.5 THEN 4
                        WHEN i.diemKT >= 8.0 THEN 3.5
                        WHEN i.diemKT >= 7.0 THEN 3
                        WHEN i.diemKT >= 6.5 THEN 2.5
                        WHEN i.diemKT >= 5.5 THEN 2
                        WHEN i.diemKT >= 5.0 THEN 1.5
                        WHEN i.diemKT >= 4.0 THEN 1
                        ELSE 0
                    END
    FROM bangdiem b
    INNER JOIN inserted i ON b.diemKT = i.diemKT;
END;
DROP TABLE bangiamhieu;
DROP TABLE nguoithan;
DROP TABLE truong;
ALTER TABLE khoa DROP CONSTRAINT FK__khoa__MaTruong__403A8C7D;
ALTER TABLE khoa
DROP COLUMN MaTruong;

CREATE TRIGGER update_ttsv_cpa
ON trangthaisinhvien
AFTER INSERT, UPDATE
AS 
BEGIN
    DECLARE @studentID INT;
    
    -- Assuming the primary key is called StudentID
    SELECT @studentID = StudentID FROM INSERTED;
    
    UPDATE trangthaisinhvien
    SET CPA = (
        SELECT AVG(bd.DiemThang4 * mh.SoTinChi)
        FROM bangdiem bd 
        JOIN monhoc mh ON bd.MaMH = mh.MaMon
        WHERE bd.StudentID = @studentID
    )
    WHERE trangthaisinhvien.StudentID = @studentID;
END

ALTER TABLE monhoc
DROP COLUMN SoGioBaiTap;
ALTER TABLE monhoc
DROP COLUMN SoGioLyThuyet;
ALTER TABLE monhoc
DROP COLUMN SoGioTuHoc;
ALTER TABLE monhoc
DROP COLUMN SoGioTN_TH;
ALTER TABLE monhoc DROP CONSTRAINT DF__monhoc__SoGioTN___4D94879B;
ALTER TABLE monhoc DROP CONSTRAINT DF__monhoc__SoGioLyT__4CA06362;
ALTER TABLE monhoc
DROP COLUMN HinhThucThi;
ALTER TABLE monhoc
DROP COLUMN MoTa;
ALTER TABLE monhoc DROP CONSTRAINT DF__monhoc__MoTa__4E88ABD4;
ALTER TABLE monhoc
DROP COLUMN NgonNguGiangDay;
ALTER TABLE monhoc
DROP COLUMN DeCuong;
ALTER TABLE nguoidung DROP CONSTRAINT FK_ND_SV;
ALTER TABLE nguoidung DROP COLUMN MSSV;

ALTER TABLE lylichsinhvien DROP COLUMN QueQuan;

ALTER TABLE lylichsinhvien DROP COLUMN TonGiao;

ALTER TABLE lylichsinhvien
DROP CONSTRAINT DF__lylichsin__NgayV__52593CB8;
ALTER TABLE lylichsinhvien DROP COLUMN NgayVaoDang;


ALTER TABLE lylichsinhvien
DROP CONSTRAINT DF__lylichsin__NgayV__534D60F1;
ALTER TABLE lylichsinhvien DROP COLUMN NgayVaoDoan;


ALTER TABLE lylichsinhvien DROP COLUMN ChiDoan;

ALTER TABLE lylichsinhvien DROP COLUMN DanToc;

ALTER TABLE lylichsinhvien DROP COLUMN NoiOHienTai;

ALTER TABLE lylichsinhvien
DROP CONSTRAINT DF__lylichsin__DoiTu__5535A963;
ALTER TABLE lylichsinhvien DROP COLUMN DoiTuongChinhSach;

ALTER TABLE lylichsinhvien
DROP CONSTRAINT DF__lylichsin__SoThe__5629CD9C;
ALTER TABLE lylichsinhvien DROP COLUMN SoTheBaoHiem;

ALTER TABLE lylichsinhvien
DROP CONSTRAINT DF__lylichsin__Thuoc__571DF1D5;
ALTER TABLE lylichsinhvien DROP COLUMN ThuocHo;

ALTER TABLE lylichsinhvien
DROP CONSTRAINT DF__lylichsinh__SoSo__5812160E;
ALTER TABLE lylichsinhvien DROP COLUMN SoSo;

ALTER TABLE lylichsinhvien DROP COLUMN DiaChiThuongTru;

ALTER TABLE lophoc
DROP COLUMN TuanHoc;

ALTER TABLE monhoc
DROP CONSTRAINT DF__monhoc__MaHocPha__4AB81AF0;
ALTER TABLE monhoc
DROP COLUMN MaHocPhanHocTruoc;

ALTER TABLE monhoc
DROP CONSTRAINT DF__monhoc__MaHocPha__4BAC3F29;
ALTER TABLE monhoc
DROP COLUMN MaHocPhanSongHanh;


