--Tạo database
create database LnL_SQL;

--Tạo bảng
CREATE TABLE LoaiSanPham (
    MaLoaiSP    VARCHAR(20) NOT NULL,
    TenLoaiSP   NVARCHAR(250) NOT NULL
	CONSTRAINT LOAISANPHAM_PK PRIMARY KEY (MaLoaiSP),
	CONSTRAINT LOAISANPHAM_TENLOAISP_UK UNIQUE (TenLoaiSP)
);
CREATE TABLE DonViTinh (
    MaDVT      VARCHAR(10) NOT NULL,
    TenDVT     NVARCHAR(100) NOT NULL,
    CONSTRAINT DVT_PK PRIMARY KEY (MaDVT),
    CONSTRAINT DVT_TENDVT_UK UNIQUE (TenDVT)
);
CREATE TABLE SanPham (
    MaSP           VARCHAR(20) NOT NULL,
    TenSP          NVARCHAR(250) NOT NULL,
    MoTa           NVARCHAR(250) NULL,
    ThoiGianDoiTra VARCHAR(50) NULL,
    MaLoaiSP       VARCHAR(20) NOT NULL,
    MaDVT          VARCHAR(10) NOT NULL,
    CONSTRAINT SANPHAM_PK PRIMARY KEY (MaSP),
    CONSTRAINT SANPHAM_TENSP_UK UNIQUE (TenSP),
    CONSTRAINT SANPHAM_MALOAISP_FK FOREIGN KEY (MaLoaiSP)
        REFERENCES LoaiSanPham(MaLoaiSP),
    CONSTRAINT SANPHAM_MADVT_FK FOREIGN KEY (MaDVT)
        REFERENCES DonViTinh(MaDVT)
);
CREATE TABLE BienDongGia (
    MaSP         VARCHAR(20) NOT NULL,
    NgayCapNhatBDG  DATE NOT NULL,
    GiaBan       FLOAT NOT NULL,
    CONSTRAINT BIENTONGGIA_PK PRIMARY KEY (MaSP, NgayCapNhatBDG),
    CONSTRAINT BIENTONGGIA_MASP_FK FOREIGN KEY (MaSP)
        REFERENCES SanPham(MaSP)
);
CREATE TABLE ChuongTrinhKM (
    MaCT       VARCHAR(20) NOT NULL,
    TenCT      NVARCHAR(255) NOT NULL,
    NgayBatDau DATE NOT NULL,
    NgayKetThuc DATE NOT NULL,
    LyDoKM     NVARCHAR(255) NULL,
    CONSTRAINT KHUYENMAI_PK PRIMARY KEY (MaCT),
    CONSTRAINT KHUYENMAI_TENCT_UK UNIQUE (TenCT)
);
CREATE TABLE CTCTKM (
    MaSP          VARCHAR(20) NOT NULL,
    MaCT          VARCHAR(20) NOT NULL,
    MucGiamGia    FLOAT,
    CONSTRAINT CTCTKM_PK PRIMARY KEY (MaSP, MaCT),
    CONSTRAINT CTCTKM_MASP_FK FOREIGN KEY (MaSP)
        REFERENCES SanPham(MaSP),
    CONSTRAINT CTCTKM_MACT_FK FOREIGN KEY (MaCT)
        REFERENCES ChuongTrinhKM(MaCT)
);
CREATE TABLE LoaiQuyen (
    MaLQ       VARCHAR(20) NOT NULL,
    TenLQ      NVARCHAR(255) NOT NULL,
    CONSTRAINT LOAIQUYEN_PK PRIMARY KEY (MaLQ),
);
CREATE TABLE Quyen (
    MaQuyen       VARCHAR(20) NOT NULL,
    TenQuyen      NVARCHAR(255) NOT NULL,
	MaLQ          VARCHAR (20) NOT NULL, 
    CONSTRAINT QUYEN_PK PRIMARY KEY (MaQuyen),
	  CONSTRAINT QUYEN_MALQ_FK FOREIGN KEY (MaLQ)
        REFERENCES LoaiQuyen(MaLQ)
);
CREATE TABLE LoaiDoiTuong (
    MaLDT       VARCHAR(20) NOT NULL,
    TenLDT      NVARCHAR(255) NOT NULL,
    CONSTRAINT LOAIDOITUONG_PK PRIMARY KEY (MaLDT),
);
CREATE TABLE DoiTuong (
    MaDT      VARCHAR(20) NOT NULL,
    TenDT     NVARCHAR(255) NOT NULL,
	MaLDT     VARCHAR (20) NOT NULL, 
    CONSTRAINT DOITUONG_PK PRIMARY KEY (MaDT),
	  CONSTRAINT DOITUONG_MALDT_FK FOREIGN KEY (MaLDT)
        REFERENCES LoaiDoiTuong(MaLDT)
);
CREATE TABLE NhomNguoiDung (
    MaNhom     VARCHAR(20) NOT NULL,
    TenNhom    NVARCHAR(255) NOT NULL,
    CONSTRAINT NHOMNGUOIDUNG_PK PRIMARY KEY (MaNhom),
);
CREATE TABLE PhanQuyen (
    MaNhom       VARCHAR(20) NOT NULL,
	MaDT         VARCHAR(20) NOT NULL,
    MaQuyen      VARCHAR(20) NOT NULL,
	NgayCapQuyen DATE NOT NULL, 
	GhiChu       NVARCHAR (255) NULL, 
    CONSTRAINT PHANQUYEN_PK PRIMARY KEY (MaNhom, MaDT, MaQuyen),
	CONSTRAINT PHANQUYEN_MANHOM_FK FOREIGN KEY (MaNhom)
        REFERENCES NhomNguoiDung(MaNhom),
    CONSTRAINT PHANQUYEN_MADT_FK FOREIGN KEY (MaDT)
        REFERENCES DoiTuong(MaDT),
    CONSTRAINT PHANQUYEN_MAQUYEN_FK FOREIGN KEY (MaQuyen)
        REFERENCES Quyen(MaQuyen),
);

CREATE TABLE KhachHang (
    MaKH        VARCHAR(20) NOT NULL,
    TenKH       NVARCHAR(250) NOT NULL,
    SDTKH       VARCHAR(20) NULL,
    EmailKH     VARCHAR(50) NULL,
    DiaChiKH    NVARCHAR(250) NULL,
    NgaySinhKH  DATE NULL,
    MST         VARCHAR(20) NULL,
    CONSTRAINT KHACHHANG_PK PRIMARY KEY (MaKH),
    CONSTRAINT KHACHHANG_EMAIL_UK UNIQUE (EmailKH),
);
CREATE TABLE TheThanhVien (
    SoThe           VARCHAR(50) NOT NULL,
	NgayCapThe      DATE NOT NULL,
	NgayCapNhatDTL  DATE NOT NULL,
    DTLHienTai      FLOAT NOT NULL,
    DTLTrongNgay    FLOAT NOT NULL,
    DTLCuoiKy       FLOAT NOT NULL,
	GhiChuDTL       NVARCHAR (255) NULL, 
	MaKH            VARCHAR (20) NOT NULL,
    CONSTRAINT THETHANHVIEN_PK PRIMARY KEY (SoThe),
	CONSTRAINT TheThanhVien_MAKH_FK FOREIGN KEY (MaKH)
        REFERENCES KhachHang(MaKH)
);
CREATE TABLE TaiKhoanNganHang (
    MaTKNH      VARCHAR(20) NOT NULL,
    TenNH       NVARCHAR(250) NOT NULL,
    MaKH        VARCHAR(20) NOT NULL,
    CONSTRAINT TAIKHOANNGANHANG_PK PRIMARY KEY (MaTKNH),
   CONSTRAINT TAIKHOANNGANHANG_MAKH_FK FOREIGN KEY (MaKH)
        REFERENCES KhachHang(MaKH)
);
CREATE TABLE ChiNhanh (
    MaCN      VARCHAR(20) NOT NULL,
    TenCN     NVARCHAR(255) NOT NULL,
    SDTCN     VARCHAR(20) NULL,
    EmailCN   NVARCHAR(255) NULL,
    CONSTRAINT CHINHANH_PK PRIMARY KEY (MaCN),
    CONSTRAINT CHINHANH_EMAIL_UK UNIQUE (EmailCN)
);
CREATE TABLE PhongBan (
    MaPB     VARCHAR(20) NOT NULL,
    MaCN     VARCHAR(20) NOT NULL,
    TenPB    NVARCHAR(255) NOT NULL,
    SDTPB    VARCHAR(20) NULL,
    EmailPB  NVARCHAR(255) NULL,
    CONSTRAINT PHONGBAN_PK PRIMARY KEY (MaPB),
    CONSTRAINT PHONGBAN_MACN_FK FOREIGN KEY (MaCN)
        REFERENCES ChiNhanh(MaCN),
    CONSTRAINT PHONGBAN_EMAIL_UK UNIQUE (EmailPB)
);
CREATE TABLE BoPhan (
    MaBP     VARCHAR(20) NOT NULL,
    MaPB     VARCHAR(20) NOT NULL,
    TenBP    NVARCHAR(255) NOT NULL,
    EmailBP  NVARCHAR(50) NULL,
    SDTBP    VARCHAR(20) NULL,
    CONSTRAINT BOPHAN_PK PRIMARY KEY (MaBP),
    CONSTRAINT BOPHAN_MAPB_FK FOREIGN KEY (MaPB)
        REFERENCES PhongBan(MaPB),
    CONSTRAINT BOPHAN_EMAIL_UK UNIQUE (EmailBP)
);
CREATE TABLE ChucVu (
    MaCV    VARCHAR(20) NOT NULL,
    TenCV   NVARCHAR(255) NOT NULL,
    CONSTRAINT CHUCVU_PK PRIMARY KEY (MaCV),
    CONSTRAINT CHUCVU_TENCV_UK UNIQUE (TenCV)
);
CREATE TABLE NhanVien (
    MaNV        VARCHAR(20) NOT NULL,
    MaBP        VARCHAR(20) NOT NULL,
    MaCV        VARCHAR(20) NOT NULL,
    TenNV       NVARCHAR(250) NOT NULL,
    SDTNV       VARCHAR(20) NULL,
    EmailNV     NVARCHAR(200) NULL,
	TrangThaiNV NVARCHAR(255) NOT NULL,
    CONSTRAINT NHANVIEN_PK PRIMARY KEY (MaNV),
    CONSTRAINT NHANVIEN_MAPB_FK FOREIGN KEY (MaBP)
        REFERENCES BoPhan(MaBP),
    CONSTRAINT NHANVIEN_MACV_FK FOREIGN KEY (MaCV)
        REFERENCES ChucVu(MaCV),
    CONSTRAINT NHANVIEN_EMAIL_UK UNIQUE (EmailNV)
);
CREATE TABLE TaiKhoan (
    MaTK        VARCHAR(20) NOT NULL,
    MaNV        VARCHAR(20) NOT NULL,
    MaNhom      VARCHAR(20) NOT NULL,
    TenTK       NVARCHAR(255) NOT NULL,
    MatKhau     VARCHAR(255) NULL,
    CONSTRAINT TAIKHOAN_PK PRIMARY KEY (MaTK),
    CONSTRAINT TAIKHOAN_MANV_FK FOREIGN KEY (MaNV)
        REFERENCES NhanVien(MaNV),
    CONSTRAINT NHANVIEN_MANHOM_FK FOREIGN KEY (MaNhom)
        REFERENCES NhomNguoiDung(MaNhom),
);
CREATE TABLE HoaDon (
    SoHD            VARCHAR(20) NOT NULL,
    MaKH            VARCHAR(20) NOT NULL,
    MaNV            VARCHAR(20) NOT NULL,
    NgayLapHD       DATE NOT NULL,
    TriGiaTruocThue FLOAT NOT NULL,
	VAT             FLOAT NOT NULL,
    TriGiaSauThue   FLOAT NOT NULL,
	PTTT            NVARCHAR(200) NULL,
    NgayTT          DATE NULL,
    TienCoc         FLOAT NULL,
	TrangThaiHD     NVARCHAR(255) NOT NULL,
    CONSTRAINT HOADON_PK PRIMARY KEY (SoHD),
    CONSTRAINT HOADON_MAKH_FK FOREIGN KEY (MaKH)
        REFERENCES KhachHang(MaKH),
    CONSTRAINT HOADON_MANV_FK FOREIGN KEY (MaNV)
        REFERENCES NhanVien(MaNV),
);
CREATE TABLE CTHD (
    SoHD        VARCHAR(20) NOT NULL,
    MaSP        VARCHAR(20) NOT NULL,
    SoLuongHD   INT NOT NULL,
    DonGiaHD    FLOAT NOT NULL,
	GiamGiaSP   FLOAT NULL,
	TTienHD     FLOAT NOT NULL,
    CONSTRAINT CTHD_PK PRIMARY KEY (SoHD, MaSP),
    CONSTRAINT CTHD_SOHD_FK FOREIGN KEY (SoHD)
        REFERENCES HoaDon(SoHD),
    CONSTRAINT CTHD_MASP_FK FOREIGN KEY (MaSP)
        REFERENCES SanPham(MaSP)
);
CREATE TABLE Kho (
    MaKho       VARCHAR(20) NOT NULL,
    MaCN        VARCHAR(20) NOT NULL,
    TenKho      NVARCHAR(255) NOT NULL,
    DiaChiKho   NVARCHAR(255) NULL,
    SDTKho      VARCHAR(20) NULL,
    EmailKho    NVARCHAR(50) NULL,
    CONSTRAINT KHO_PK PRIMARY KEY (MaKho),
    CONSTRAINT KHO_MACN_FK FOREIGN KEY (MaCN)
        REFERENCES ChiNhanh(MaCN),
    CONSTRAINT KHO_EMAIL_UK UNIQUE (EmailKho)
);
CREATE TABLE TonKho (
    MaKho          VARCHAR(20) NOT NULL,
    MaSP           VARCHAR(20) NOT NULL,
    ThangTK        INT NOT NULL,
    NamTK          INT NOT NULL,
    TonDK          INT NOT NULL,
    TriGiaTonDK    FLOAT NOT NULL,
    NhapTK         INT NOT NULL,
    TriGiaNhapTK   FLOAT NOT NULL,
    XuatTK         INT NOT NULL,
    TriGiaXuatTK   FLOAT NOT NULL,
    TonCK          INT NOT NULL,
    TriGiaTonCK    FLOAT NOT NULL,
    CONSTRAINT TONKHO_PK PRIMARY KEY (MaKho, MaSP, ThangTK, NamTK),
    CONSTRAINT TONKHO_MAKHO_FK FOREIGN KEY (MaKho)
        REFERENCES Kho(MaKho),
    CONSTRAINT TONKHO_MASP_FK FOREIGN KEY (MaSP)
        REFERENCES SanPham(MaSP)
);
CREATE TABLE PhieuXuat (
    SoPX        VARCHAR(20) NOT NULL,
    MaKho       VARCHAR(20) NOT NULL,
    SoHD        VARCHAR(20) NOT NULL,
    MaNV        VARCHAR(20) NOT NULL,
    NgayPX      DATE NOT NULL,
    TriGiaPX    FLOAT NULL,
	LyDoPX      NVARCHAR(255) NOT NULL,
	GhiChuPX    NVARCHAR (255) NULL,
    CONSTRAINT PHIEUXUAT_PK PRIMARY KEY (SoPX),
    CONSTRAINT PHIEUXUAT_MAKHO_FK FOREIGN KEY (MaKho)
    REFERENCES Kho(MaKho),
    CONSTRAINT PHIEUXUAT_SOHD_FK FOREIGN KEY (SoHD)
    REFERENCES HoaDon(SoHD),
    CONSTRAINT PHIEUXUAT_MANV_FK FOREIGN KEY (MaNV)
    REFERENCES NhanVien(MaNV)
);
CREATE TABLE CTPX (
    MaSP        VARCHAR(20) NOT NULL,
    SoPX        VARCHAR(20) NOT NULL,
    SoLuongXuat INT NOT NULL,
    DonGiaXuat  FLOAT NOT NULL,
    TTienPX     FLOAT NOT NULL,
    CONSTRAINT CTPX_PK PRIMARY KEY (MaSP, SoPX),
    CONSTRAINT CTPX_MASP_FK FOREIGN KEY (MaSP)
        REFERENCES SanPham(MaSP),
    CONSTRAINT CTPX_SOPX_FK FOREIGN KEY (SoPX)
        REFERENCES PhieuXuat(SoPX)
);
CREATE TABLE PhieuNhap (
    SoPN         VARCHAR(20) NOT NULL,
	SoHD         VARCHAR (20) NOT NULL,
    MaKho        VARCHAR(20) NOT NULL,
    MaNV         VARCHAR(20) NOT NULL,
    NgayPN       DATE NOT NULL,
    TriGiaPN     FLOAT NULL,
	LyDoPN       NVARCHAR(255) NOT NULL,
	GhiChuPN     NVARCHAR (255) NULL,
    CONSTRAINT PHIEUNHAP_PK PRIMARY KEY (SoPN),
    CONSTRAINT PHIEUNHAP_MAKHO_FK FOREIGN KEY (MaKho)
        REFERENCES Kho(MaKho),
    CONSTRAINT PHIEUNHAP_MANV_FK FOREIGN KEY (MaNV)
        REFERENCES NhanVien(MaNV),
    CONSTRAINT PHIEUNHAP_SOHD_FK FOREIGN KEY (SoHD)
        REFERENCES HoaDon(SoHD)
);
CREATE TABLE CTPN (
    SoPN         VARCHAR(20) NOT NULL,
    MaSP         VARCHAR(20) NOT NULL,
    SoLuongNhap  INT NOT NULL,
    DonGiaNhap   FLOAT NOT NULL,
    TTienPN      FLOAT NULL,
    CONSTRAINT CTPN_PK PRIMARY KEY (SoPN, MaSP),
    CONSTRAINT CTPN_SOPN_FK FOREIGN KEY (SoPN)
        REFERENCES PhieuNhap(SoPN),
    CONSTRAINT CTPN_MASP_FK FOREIGN KEY (MaSP)
        REFERENCES SanPham(MaSP)
);

--Dữ liệu mẫu
INSERT INTO LoaiSanPham (MaLoaiSP, TenLoaiSP) VALUES
('L001', N'Cân điện tử'),
('L002', N'Máy sấy tóc'),
('L003', N'Chăm sóc răng miệng'),
('L004', N'Máy lọc không khí'),
('L005', N'Quạt máy'),
('L006', N'Bàn ủi'),
('L007', N'Đèn'),
('L008', N'Máy hút bụi'),
('L009', N'Nồi chiên không dầu/ ngập dầu'),
('L010', N'Máy xay/ máy vắt'),
('L011', N'Máy pha cà phê'),
('L012', N'Bếp điện từ/ Bếp hồng ngoại'),
('L013', N'Bếp nướng điện & Nồi điện đa năng'),
('L014', N'Bình đun nước'),
('L015', N'Máy nướng bánh mì'),
('L016', N'Nồi cơm điện'),
('L017', N'Thùng đựng gạo hút chân không'),
('L018', N'Máy làm sữa chua');
INSERT INTO DonViTinh (MaDVT, TenDVT) VALUES
('DVT001', N'Cái'),
('DVT002', N'Chiếc'),
('DVT003', N'Bộ'),
('DVT004', N'Thùng'),
('DVT005', N'Hộp');
INSERT INTO SanPham (MaSP, TenSP, MoTa, ThoiGianDoiTra, MaLoaiSP, MaDVT) VALUES
('SP001', N'Cân Sức Khỏe LocknLock Dùng Trong Gia Đình', N'Cân Sức Khỏe LocknLock Dùng Trong Gia Đình giúp theo dõi các mục tiêu sức khỏe của mình', N'6 tháng', 'L001', 'DVT001'),
('SP002', N'Máy Sấy Tóc Tạo Kiểu LocknLock Multi Hair Dryer Công Nghệ ION Âm', N'Máy Sấy Tóc Tạo Kiểu LocknLock Multi Hair Dryer Công Nghệ ION Âm - 5 Đầu Sấy - Màu Xám', N'24 tháng', 'L002', 'DVT001'),
('SP003', N'Máy tăm nước không dây LocknLock Cordless Oral Irrigator', N'Máy Tăm Nước Không Dây LocknLock Cordless Oral Irrigator, 200ml - Màu Xanh Da Trời', N'24 tháng', 'L003', 'DVT001'),
('SP004', N'Bàn Chải Đánh Răng Điện LocknLock Electric Toothbrush', N'Bàn Chải Đánh Răng Điện LocknLock Electric Toothbrush 3.7V, 1.8W - Màu Trắng', N'24 tháng', 'L003', 'DVT001'),
('SP005', N'Bộ Lọc Của Máy Lọc Không Khí Air Furifier Filter', N'Bộ Lọc Của Máy Lọc Không Khí Air Furifier Filter, 165x165x220mm - LocknLock', N'6 tháng', 'L004', 'DVT003'),
('SP006', N'Máy Lọc Không Khí LocknLock Coverage màu trắng', N'Máy Lọc Không Khí LocknLock Coverage màu trắng 220 - 240V, 50/60Hz, 23W, Cadr 130㎥/H, Coverage 16㎡', N'24 tháng', 'L004', 'DVT002'),
('SP007', N'Quạt sạc điện gấp gọn Jenniferoom Foldable fan', N'Quạt sạc điện gấp gọn Jenniferoom Foldable fan 8W, 8000mAh - Màu be', N'12 tháng', 'L005', 'DVT001'),
('SP008', N'Bàn ủi hơi nước LocknLock Garment steamer', N'Bàn ủi hơi nước LocknLock Garment steamer -ENI218IVY', N'24 tháng', 'L006', 'DVT001'),
('SP009', N'Đèn Bàn Locknlock Mono(Không Có Bóng Đèn)', N'Đèn Bàn Locknlock Mono(Không Có Bóng Đèn) - 180X180X300', N'24 tháng', 'L007', 'DVT001'),
('SP010', N'Máy Hút BụI Locknlock', N'Máy Hút BụI Locknlock 0.4L, 400W, 220V, 50Hz - Màu Đen', N'24 tháng', 'L008', 'DVT001'),
('SP011', N'Nồi Chiên Không Dầu Kết Hợp Chức Năng Hấp LocknLock', N'Nồi Chiên Không Dầu Kết Hợp Chức Năng Hấp LocknLock EJF881', N'24 tháng', 'L009', 'DVT001'),
('SP012', N'Máy Làm Sữa Hạt Đa Năng Locknlock Bianco Heating Blender', N'Máy Làm Sữa Hạt Đa Năng Locknlock Bianco Heating Blender 1.75L, 800W, 220V, 50Hz - Màu ngà', N'24 tháng', 'L010', 'DVT001'),
('SP013', N'Máy pha cà phê tự động Steam Latte PRO', N'Máy pha cà phê hoàn toàn tự động có vòi đánh sữa tạo bọt Steam Latte PRO Màu be', N'24 tháng', 'L011', 'DVT001'),
('SP014', N'Bếp Hồng Ngoại Mini Locknlock Mini Infrared Cooker', N'Bếp Hồng Ngoại Mini Locknlock Mini Infrared Cooker 220V, 50Hz, 1300W - Màu Ngà', N'24 tháng', 'L012', 'DVT001'),
('SP015', N'Bếp Nướng Điện LocknLock', N'Bếp Nướng Điện LocknLock, 220~240V - Màu Đen', N'24 tháng', 'L013', 'DVT001'),
('SP016', N'Ấm đun siêu tốc LocknLock Smart Glow', N'Ấm đun siêu tốc 5 mức nhiệt LocknLock Smart glow glass electric kettle 1.7L', N'24 tháng', 'L014', 'DVT001'),
('SP017', N'Lò nướng điện Jenniferoom Steam oven toaster', N'Lò nướng điện Jenniferoom Steam oven toaster 1000W, 12L', N'24 tháng', 'L015', 'DVT001'),
('SP018', N'Nồi cơm điện LocknLock', N'Nồi cơm điện LocknLock 220V, 50Hz, 700W, 1.8L – Màu ngà', N'24 tháng', 'L016', 'DVT001'),
('SP019', N'Thùng Đựng Gạo Chân Không LocknLock', N'Thùng Đựng Gạo Chân Không LocknLock', N'24 tháng', 'L017', 'DVT004'),
('SP020', N'Máy Làm Sữa Chua LocknLock', N'Máy Làm Sữa Chua LocknLock, 220V, 50 Hz, 20W, 175x175x198mm', N'24 tháng', 'L018', 'DVT001');
INSERT INTO BienDongGia (MaSP, NgayCapNhatBDG, GiaBan) VALUES
('SP001', '2024-01-01', 288000),
('SP001', '2024-03-15', 275000),
('SP001', '2024-06-01', 288000),
('SP001', '2025-12-08', 300000),
('SP002', '2024-01-01', 2101000),
('SP002', '2024-04-20', 2050000),
('SP003', '2024-01-01', 734000),
('SP004', '2024-01-01', 756000),
('SP004', '2024-03-01', 780000),
('SP005', '2024-01-01', 525000),
('SP005', '2024-05-10', 500000),
('SP006', '2024-01-01', 2888000),
('SP006', '2024-02-15', 2950000),
('SP007', '2024-01-01', 2682000),
('SP008', '2024-01-01', 2240000),
('SP008', '2024-05-20', 2200000),
('SP009', '2024-01-01', 265000),
('SP010', '2024-01-01', 2053000),
('SP010', '2024-07-10', 2100000),
('SP011', '2024-01-01', 2921000),
('SP011', '2024-03-05', 2850000),
('SP012', '2024-01-01', 2486000),
('SP013', '2024-01-01', 10575000),
('SP014', '2024-01-01', 1147000),
('SP014', '2024-04-15', 1100000),
('SP015', '2024-01-01', 1062000),
('SP016', '2024-01-01', 936000),
('SP016', '2024-06-20', 950000),
('SP017', '2024-01-01', 2808000),
('SP018', '2024-01-01', 1323000),
('SP018', '2024-02-01', 1350000),
('SP019', '2024-01-01', 905000),
('SP020', '2024-01-01', 395000);
INSERT INTO ChuongTrinhKM (MaCT, TenCT, NgayBatDau, NgayKetThuc, LyDoKM) VALUES
('KM001', N'Khuyến Mãi Giáng Sinh', '2025-12-01', '2025-12-31', N'Khuyến mãi mừng Lễ Giáng Sinh và đón năm mới'),
('KM002', N'Xả Kho Hàng Hè', '2025-07-15', '2025-08-15', N'Thanh lý các mặt hàng tồn kho mùa hè'),
('KM003', N'Ưu Đãi Đặc Biệt Cho Khách Hàng Thân Thiết', '2025-11-10', '2025-11-30', N'Tri ân khách hàng đã mua sắm thường xuyên'),
('KM004', N'Flash Sale Cuối Tuần', '2025-11-15', '2025-11-16', N'Chương trình giảm giá chớp nhoáng áp dụng cuối tuần'),
('KM005', N'Mừng Ra Mắt Sản Phẩm Mới LocknLock', '2025-10-01', '2025-10-31', N'Giới thiệu và thúc đẩy doanh số các sản phẩm điện gia dụng mới');
INSERT INTO CTCTKM (MaSP, MaCT, MucGiamGia) VALUES
('SP001', 'KM003', 0.05),
('SP002', 'KM004', 0.3),
('SP002', 'KM005', 0.1),
('SP003', 'KM003', 0.1),
('SP004', 'KM003', 0.1),
('SP005', 'KM002', 0.2),
('SP006', 'KM001', 0.1),
('SP007', 'KM002', 0.15),
('SP008', 'KM005', 0.15),
('SP009', 'KM002', 0.1),
('SP010', 'KM005', 0.1),
('SP011', 'KM001', 0.15),
('SP012', 'KM005', 0.12),
('SP013', 'KM001', 0.05),
('SP014', 'KM004', 0.25),
('SP015', 'KM002', 0.25),
('SP016', 'KM004', 0.35),
('SP017', 'KM001', 0.1),
('SP018', 'KM001', 0.12),
('SP019', 'KM003', 0.05),
('SP020', 'KM005', 0.1);
INSERT INTO KhachHang (MaKH, TenKH, SDTKH, EmailKH, DiaChiKH, NgaySinhKH, MST) VALUES
('KH001', N'Nguyễn Thị Hồng', '0901234567', 'hong.nguyen@email.com', N'45 Lê Lợi, Phường 1, TP.HCM', '1990-05-15', NULL),
('KH002', N'Trần Văn Nam', '0918765432', 'nam.tran@email.com', N'102 Điện Biên Phủ, Quận 3, Hà Nội', '1985-11-20', NULL),
('KH003', N'Lê Hoàng Anh', '0987654321', 'hoang.anh@email.com', N'Tầng 5, Tòa nhà ABC, 20 Cộng Hòa, TP.HCM', '1978-03-01', '0312345678'), -- Khách hàng doanh nghiệp
('KH004', N'Phạm Thu Hà', '0945678901', 'ha.pham@email.com', N'22/5 Nguyễn Trãi, Quận 5, Đà Nẵng', '1995-07-25', NULL),
('KH005', N'Võ Minh Dũng', '0978112233', 'dung.vo@email.com', N'79 Trần Hưng Đạo, Quận Hoàn Kiếm, Hà Nội', '1982-01-10', NULL),
('KH006', N'Đỗ Thị Mai', '0905445566', 'mai.do@email.com', N'Lô C, Khu công nghiệp Tân Bình, TP.HCM', '1992-09-30', '0109876543'), -- Khách hàng doanh nghiệp
('KH007', N'Hoàng Thanh Tùng', '0933778899', 'tung.hoang@email.com', N'15 Hùng Vương, Thành phố Huế', '2000-12-05', NULL),
('KH008', N'Bùi Thị Thanh', '0966223344', 'thanh.bui@email.com', N'345 Trường Chinh, Quận Tân Bình, TP.HCM', '1988-04-18', NULL);
INSERT INTO TheThanhVien (SoThe, NgayCapThe, NgayCapNhatDTL, DTLHienTai, DTLTrongNgay, DTLCuoiKy, GhiChuDTL, MaKH) VALUES
('MEM0001', '2024-06-10', '2025-12-01', 500.5, 50.0, 550.5, N'Điểm tích lũy từ đơn hàng tháng 11', 'KH001'),
('MEM0002', '2023-01-25', '2025-12-01', 1200.0, 0.0, 1200.0, N'Điểm không thay đổi trong ngày', 'KH002'),
('MEM0003', '2024-09-01', '2025-12-01', 350.75, 20.0, 370.75, NULL, 'KH003'),
('MEM0004', '2025-02-20', '2025-12-01', 80.25, 0.0, 80.25, N'Hạng thành viên Bạc', 'KH004'),
('MEM0005', '2023-05-18', '2025-12-01', 2500.0, 100.0, 2600.0, N'Điểm tích lũy lớn, hạng Vàng', 'KH005'),
('MEM0006', '2024-03-01', '2025-12-01', 620.5, 0.0, 620.5, NULL, 'KH006'),
('MEM0007', '2025-11-05', '2025-12-01', 10.0, 0.0, 10.0, N'Thành viên mới', 'KH007'),
('MEM0008', '2023-10-12', '2025-12-01', 400.0, 0.0, 400.0, NULL, 'KH008');
INSERT INTO TaiKhoanNganHang (MaTKNH, TenNH, MaKH) VALUES
('TKNH001', N'Ngân hàng Ngoại thương Việt Nam (Vietcombank)', 'KH001'),
('TKNH002', N'Ngân hàng Công thương Việt Nam (Vietinbank)', 'KH002'),
('TKNH003', N'Ngân hàng TMCP Kỹ thương Việt Nam (Techcombank)', 'KH003'),
('TKNH004', N'Ngân hàng Á Châu (ACB)', 'KH004'),
('TKNH005', N'Ngân hàng Quân đội (MBBank)', 'KH005'),
('TKNH006', N'Ngân hàng Nông nghiệp và Phát triển Nông thôn Việt Nam (Agribank)', 'KH005'), -- Khách hàng KH005 có 2 tài khoản
('TKNH007', N'Ngân hàng TMCP Việt Nam Thịnh Vượng (VPBank)', 'KH006'),
('TKNH008', N'Ngân hàng Đầu tư và Phát triển Việt Nam (BIDV)', 'KH007'),
('TKNH009', N'Ngân hàng Sài Gòn Thương Tín (Sacombank)', 'KH008');
INSERT INTO ChiNhanh (MaCN, TenCN, SDTCN, EmailCN) VALUES
('CN001', N'Chi Nhánh Quận 1 (Trụ Sở Chính)', '02838221122', 'truso@cuahang.com'),
('CN002', N'Chi Nhánh Cầu Giấy (Hà Nội)', '02437835566', 'caugiaihn@cuahang.com'),
('CN003', N'Chi Nhánh Hải Phòng', '02253890123', 'haiphong@cuahang.com'),
('CN004', N'Chi Nhánh Đà Nẵng', '02363567890', 'danang@cuahang.com'),
('CN005', N'Chi Nhánh Quận 7 (TP.HCM)', '02837754433', 'quan7hcm@cuahang.com');
INSERT INTO PhongBan (MaPB, MaCN, TenPB, SDTPB, EmailPB) VALUES
('PB001', 'CN001', N'Phòng Tổng Hợp & Quản Trị', '02838221123', 'admin.cn001@cuahang.com'),
('PB002', 'CN001', N'Phòng Kinh Doanh & Tiếp Thị', '02838221124', 'sales.cn001@cuahang.com'),
('PB003', 'CN001', N'Phòng Kế Toán & Tài Chính', '02838221125', 'acc.cn001@cuahang.com'),
('PB004', 'CN002', N'Phòng Bán Hàng', '02437835567', 'sales.cn002@cuahang.com'),
('PB005', 'CN002', N'Phòng Kho Vận', '02437835568', 'warehouse.cn002@cuahang.com'),
('PB006', 'CN002', N'Phòng Hành Chính', '02437835569', 'hr.cn002@cuahang.com'),
('PB007', 'CN003', N'Phòng Bán Hàng', '02253890124', 'sales.cn003@cuahang.com'),
('PB008', 'CN003', N'Phòng Kho Vận', '02253890125', 'warehouse.cn003@cuahang.com'),
('PB009', 'CN004', N'Phòng Bán Hàng', '02363567891', 'sales.cn004@cuahang.com'),
('PB010', 'CN004', N'Phòng Kho Vận', '02363567892', 'warehouse.cn004@cuahang.com'),
('PB011', 'CN005', N'Phòng Bán Hàng', '02837754434', 'sales.cn005@cuahang.com'),
('PB012', 'CN005', N'Phòng Hành Chính', '02837754435', 'hr.cn005@cuahang.com');
INSERT INTO BoPhan (MaBP, TenBP, EmailBP, SDTBP, MaPB) VALUES
('BP001', N'Bộ Phận Hành Chính Nhân Sự', 'hr.bp001@cuahang.com', '02838221123', 'PB001'),
('BP002', N'Bộ Phận IT & Bảo Trì', 'it.bp002@cuahang.com', '02838221123', 'PB001'),
('BP003', N'Bộ Phận Bán Hàng Trực Tiếp', 'directsales.bp003@cuahang.com', '02838221124', 'PB002'),
('BP004', N'Bộ Phận Marketing Online', 'onlinemarketing.bp004@cuahang.com', '02838221124', 'PB002'),
('BP005', N'Bộ Phận Kế Toán Thu Chi', 'accounting.bp005@cuahang.com', '02838221125', 'PB003'),
('BP006', N'Bộ Phận Phân Tích Tài Chính', 'finance.bp006@cuahang.com', '02838221125', 'PB003'),
('BP007', N'Bộ Phận Chăm Sóc Khách Hàng', 'cskh.bp007@cuahang.com', '02437835567', 'PB004'),
('BP008', N'Bộ Phận Quản Lý Tồn Kho', 'stock.bp008@cuahang.com', '02437835568', 'PB005'),
('BP009', N'Bộ Phận Giao Nhận', 'delivery.bp009@cuahang.com', '02437835568', 'PB005'),
('BP010', N'Bộ Phận Hỗ Trợ Kỹ Thuật', 'support.bp010@cuahang.com', '02253890124', 'PB007');
INSERT INTO ChucVu (MaCV, TenCV) VALUES
('CV001', N'Giám Đốc Chi Nhánh'),
('CV002', N'Trưởng Phòng'),
('CV003', N'Quản Lý Bộ Phận'),
('CV004', N'Nhân Viên Bán hàng'),
('CV005', N'Nhân Viên Kho Vận'),
('CV006', N'Kế Toán Viên'),
('CV007', N'Nhân Viên Hành Chính Nhân Sự'),
('CV008', N'Nhân Viên IT'),
('CV009', N'Thực Tập Sinh');
INSERT INTO NhanVien (MaNV, MaBP, MaCV, TenNV, SDTNV, EmailNV, TrangThaiNV) VALUES
('NV001', 'BP001', 'CV002', N'Lê Văn Phát', '0901001001', 'phat.le@cuahang.com', N'Đang làm việc'),
('NV002', 'BP001', 'CV007', N'Trần Thị Mai', '0902002002', 'mai.tran@cuahang.com', N'Đang làm việc'),
('NV003', 'BP002', 'CV008', N'Hoàng Quốc Việt', '0903003003', 'viet.hoang@cuahang.com', N'Đang làm việc'),
('NV004', 'BP003', 'CV002', N'Phạm Minh Duy', '0904004004', 'duy.pham@cuahang.com', N'Đang làm việc'),
('NV005', 'BP003', 'CV004', N'Ngô Thanh Thảo', '0905005005', 'thao.ngo@cuahang.com', N'Đang làm việc'),
('NV006', 'BP004', 'CV004', N'Đinh Tuấn Anh', '0906006006', 'anh.dinh@cuahang.com', N'Đang làm việc'),
('NV007', 'BP005', 'CV006', N'Võ Thị Ngọc', '0907007007', 'ngoc.vo@cuahang.com', N'Đang làm việc'),
('NV008', 'BP006', 'CV006', N'Bùi Thanh Trúc', '0908008008', 'truc.bui@cuahang.com', N'Đang làm việc'),
('NV009', 'BP007', 'CV001', N'Đặng Văn Hùng', '0909009009', 'hung.dang@cuahang.com', N'Đang làm việc'),
('NV010', 'BP007', 'CV004', N'Nguyễn Đức Tài', '0910010010', 'tai.nguyen@cuahang.com', N'Đang làm việc'),
('NV011', 'BP007', 'CV009', N'Lương Thanh Tâm', '0911011011', 'tam.luong@cuahang.com', N'Thử việc'),
('NV012', 'BP008', 'CV005', N'Tô Hữu Dũng', '0912012012', 'dung.to@cuahang.com', N'Đang làm việc'),
('NV013', 'BP009', 'CV005', N'Phan Thị Kiều', '0913013013', 'kieu.phan@cuahang.com', N'Đang làm việc');
INSERT INTO HoaDon (SoHD, MaKH, MaNV, NgayLapHD, TriGiaTruocThue, VAT, TriGiaSauThue, PTTT, NgayTT, TienCoc, TrangThaiHD) VALUES
('HD001', 'KH005', 'NV005', '2025-11-20', 4850000, 485000, 5335000, N'Chuyển khoản', '2025-11-20', 0, N'Đã thanh toán'),
('HD002', 'KH002', 'NV010', '2025-11-20', 2101000, 210100, 2311100, N'Tiền mặt', '2025-11-20', 0, N'Đã thanh toán'),
('HD003', 'KH001', 'NV005', '2025-11-25', 10575000, 1057500, 11632500, N'Chuyển khoản', '2025-11-25', 500000, N'Đã thanh toán'),
('HD004', 'KH004', 'NV011', '2025-11-25', 756000, 75600, 831600, N'Tiền mặt', '2025-11-25', 0, N'Đã thanh toán'),
('HD005', 'KH007', 'NV010', '2025-11-25', 288000, 28800, 316800, N'Tiền mặt', '2025-11-25', 0, N'Đã thanh toán'),
('HD006', 'KH003', 'NV004', '2025-11-20', 5000000, 500000, 5500000, N'Chuyển khoản', '2025-11-20', 0, N'Đã thanh toán'),
('HD007', 'KH008', 'NV005', '2025-11-20', 1323000, 132300, 1455300, N'Tiền mặt', '2025-11-20', 0, N'Đã thanh toán'),
('HD008', 'KH006', 'NV004', '2025-11-25', 8500000, 850000, 9350000, N'Chuyển khoản', '2025-11-25', 0, N'Đã thanh toán');
INSERT INTO CTHD (SoHD, MaSP, SoLuongHD, DonGiaHD, GiamGiaSP, TTienHD) VALUES
('HD001', 'SP009', 1, 2650000, 0.1, 2385000),
('HD001', 'SP010', 1, 2053000, 0.05, 1950350),
('HD001', 'SP012', 1, 2486000, 0, 2486000),
('HD002', 'SP002', 1, 2101000, 0, 2101000),
('HD003', 'SP013', 1, 10575000, 0, 10575000),
('HD004', 'SP004', 1, 756000, 0, 756000),
('HD005', 'SP001', 1, 288000, 0, 288000),
('HD006', 'SP006', 1, 2888000, 0, 2888000),
('HD006', 'SP014', 2, 1147000, 0.05, 2179300),
('HD007', 'SP018', 1, 1323000, 0, 1323000),
('HD008', 'SP011', 3, 2921000, 0.1, 7886700),
('HD008', 'SP016', 1, 936000, 0.02, 917280);
INSERT INTO Kho (MaKho, TenKho, DiaChiKho, SDTKho, EmailKho, MaCN) VALUES
('KHO01', N'Kho Tổng Hợp Miền Nam', N'Khu công nghiệp Vĩnh Lộc, TP.HCM', '02838221126', 'kho.cn001@cuahang.com', 'CN001'),
('KHO02', N'Kho Phân Phối Miền Bắc', N'Khu công nghiệp Quang Minh, Hà Nội', '02437835570', 'kho.cn002@cuahang.com', 'CN002'),
('KHO03', N'Kho Vận Chuyển Hải Phòng', N'Cảng Đình Vũ, Hải Phòng', '02253890126', 'kho.cn003@cuahang.com', 'CN003'),
('KHO04', N'Kho Trung Tâm Miền Trung', N'Khu công nghiệp Hòa Khánh, Đà Nẵng', '02363567893', 'kho.cn004@cuahang.com', 'CN004'),
('KHO05', N'Kho Bán Lẻ Quận 7', N'200 Nguyễn Thị Thập, Quận 7, TP.HCM', '02837754436', 'kho.cn005@cuahang.com', 'CN005');
INSERT INTO TonKho (MaKho, MaSP, ThangTK, NamTK, TonDK, TriGiaTonDK, NhapTK, TriGiaNhapTK, XuatTK, TriGiaXuatTK, TonCK, TriGiaTonCK) VALUES
('KHO01', 'SP002', 11, 2025, 200, 294140000, 50, 73535000, 10, 14707000, 240, 352968000),
('KHO01', 'SP013', 11, 2025, 50, 370125000, 0, 0, 17, 4025000, 49, 362722500),
('KHO01', 'SP015', 12, 2025, 100, 5000000, 50, 3000000, 20, 1500000, 130, 6500000),
('KHO02', 'SP004', 11, 2025, 150, 79380000, 100, 52920000, 25, 13230000, 225, 118070000),
('KHO02', 'SP018', 11, 2025, 80, 7460000, 20, 1865000, 5, 466250, 95, 8858750),
('KHO04', 'SP001', 11, 2025, 300, 60480000, 100, 20160000, 50, 10080000, 350, 70560000),
('KHO04', 'SP011', 11, 2025, 70, 143110000, 30, 61330000, 15, 30665000, 85, 173775000),
('KHO04', 'SP016', 11, 2025, 120, 86400000, 40, 28800000, 10, 7200000, 150, 108000000);
INSERT INTO PhieuXuat (SoPX, MaKho, SoHD, MaNV, NgayPX, TriGiaPX, LyDoPX, GhiChuPX) VALUES
('PX001', 'KHO01', 'HD001', 'NV012', '2025-11-20', 4850000, N'Thực hiện đơn hàng bán lẻ', N'Xuất từ Kho Tổng Hợp Miền Nam'),
('PX002', 'KHO02', 'HD002', 'NV012', '2025-11-20', 2101000, N'Thực hiện đơn hàng bán lẻ', N'Xuất từ Kho Phân Phối Miền Bắc'),
('PX003', 'KHO01', 'HD003', 'NV012', '2025-11-25', 10575000, N'Thực hiện đơn hàng bán lẻ', N'Hàng giá trị cao'),
('PX004', 'KHO02', 'HD004', 'NV013', '2025-11-25', 756000, N'Thực hiện đơn hàng bán lẻ', NULL),
('PX005', 'KHO04', 'HD005', 'NV013', '2025-11-25', 288000, N'Thực hiện đơn hàng bán lẻ', NULL),
('PX006', 'KHO04', 'HD006', 'NV012', '2025-11-20', 5000000, N'Xuất hàng cho khách hàng doanh nghiệp', N'Đơn hàng B2B'),
('PX007', 'KHO02', 'HD007', 'NV013', '2025-11-20', 1323000, N'Thực hiện đơn hàng bán lẻ', NULL),
('PX008', 'KHO04', 'HD008', 'NV013', '2025-11-25', 8500000, N'Xuất hàng cho khách hàng doanh nghiệp', N'Đơn hàng B2B lớn');
INSERT INTO CTPX (MaSP, SoPX, SoLuongXuat, DonGiaXuat, TTienPX) VALUES
('SP001', 'PX005', 1, 201600, 201600),
('SP002', 'PX002', 1, 1470700, 1470700),
('SP004', 'PX004', 1, 529200, 529200),
('SP006', 'PX006', 1, 2021600, 2021600),
('SP009', 'PX001', 1, 185500, 185500),
('SP010', 'PX001', 1, 1437100, 1437100),
('SP011', 'PX008', 3, 2044428, 6133284),
('SP012', 'PX001', 1, 1740200, 1740200),
('SP013', 'PX003', 1, 7402500, 7402500),
('SP014', 'PX006', 2, 802900, 1605800),
('SP016', 'PX008', 1, 720000, 720000),
('SP018', 'PX007', 1, 932500, 932500);
INSERT INTO PhieuNhap (SoPN, SoHD, MaKho, MaNV, NgayPN, TriGiaPN, LyDoPN, GhiChuPN)
 VALUES 
('PN001', 'HD001', 'KHO01', 'NV012', '2025-11-05', 265000, N'Nhập hàng trả lại từ HD001', N' 1 SP009'),
('PN002', 'HD002', 'KHO02', 'NV012', '2025-11-10', 2101000, N'Nhập hàng hoàn từ HD002', N'1 SP002'),
('PN003', 'HD003', 'KHO04', 'NV013', '2025-11-01', 10575000, N'Nhập hàng hoàn từ HD003', N'1 SP013'),
('PN004', 'HD004', 'KHO04', 'NV013', '2025-11-01', 2888000, N'Nhập hàng hoàn từ HD006', 'N 1 SP006'),
('PN005', 'HD005', 'KHO02', 'NV012', '2025-11-15', 2921000, N'Nhập hàng hoàn từ HD008', N'1 SP011 được trả lại'),
('PN006', 'HD006', 'KHO01', 'NV013', '2025-11-28', 3500000, N'Nhập hàng trả lại từ khách hàng', N' 1 SP012 được trả lại');
INSERT INTO CTPN (SoPN, MaSP, SoLuongNhap, DonGiaNhap, TTienPN) VALUES 
('PN001', 'SP009', 1, 265000, 265000),
('PN002', 'SP002', 1, 2101000, 2101000),
('PN003', 'SP013', 1, 10575000, 10575000),
('PN004', 'SP006', 1, 2888000, 2888000),
('PN005', 'SP013', 1, 2921000, 2921000),
('PN006', 'SP012', 1, 3500000, 3500000);
INSERT INTO LoaiQuyen (MaLQ, TenLQ) VALUES
('LQ001', N'Quản Trị Hệ Thống'),
('LQ002', N'Quản Lý Chi Nhánh'),
('LQ003', N'Quản Lý Kho Vận'),
('LQ004', N'Nghiệp Vụ Bán Hàng'),
('LQ005', N'Quản Lý Tài Chính'),
('LQ006', N'Quản Lý Marketing');
INSERT INTO Quyen (MaQuyen, TenQuyen, MaLQ) VALUES
('AD001', N'Quản lý người dùng (Thêm/Sửa/Xóa tài khoản)', 'LQ001'),
('AD002', N'Quản lý dữ liệu toàn bộ hệ thống (Chi nhánh, Phòng ban)', 'LQ001'),
('AD003', N'Thiết lập phân quyền hệ thống', 'LQ001'),
('BH001', N'Tạo đơn hàng bán lẻ tại cửa hàng', 'LQ004'),
('BH002', N'Kiểm tra thông tin khách hàng và lập hóa đơn', 'LQ004'),
('BH003', N'Thực hiện xác nhận thanh toán', 'LQ004'),
('BH004', N'Tra cứu thông tin sản phẩm và chương trình khuyến mãi', 'LQ004'),
('KHO01', N'Kiểm tra tồn kho (Số dư đầu/trong/cuối kỳ)', 'LQ003'),
('KHO02', N'Thực hiện nghiệp vụ nhập hàng hoàn về', 'LQ003'),
('KHO03', N'Thực hiện nghiệp vụ xuất hàng và bàn giao sản phẩm', 'LQ003'),
('KHO04', N'Kiểm kê và điều chỉnh kho', 'LQ003'),
('KT001', N'Truy cập các số liệu tài chính', 'LQ005'),
('KT002', N'Theo dõi doanh thu', 'LQ005'),
('KT003', N'Lập các báo cáo tài chính', 'LQ005'),
('MKT01', N'Thiết lập giá bán theo thời điểm, khu vực, kênh bán hàng', 'LQ006'),
('MKT02', N'Thiết lập chương trình khuyến mãi', 'LQ006'),
('MKT03', N'Cấu hình các chính sách về giá', 'LQ006'),
('QLCN01', N'Theo dõi doanh thu chi nhánh', 'LQ002'),
('QLCN02', N'Quản lý thông tin nhân viên trong chi nhánh', 'LQ002'),
('QLCN03', N'Giám sát tình trạng tồn kho của chi nhánh', 'LQ002');
INSERT INTO LoaiDoiTuong (MaLDT, TenLDT) VALUES
('DBO01', N'View (Khung nhìn)'),
('DBO02', N'Stored Procedure (Thủ tục lưu trữ)'),
('DBO03', N'Function (Hàm)'),
('DBO04', N'Trigger (Cơ chế kích hoạt)'),
('DBO05', N'Index (Chỉ mục)'),
('DBO06', N'Constraint (Ràng buộc)'),
('DBO07', N'Table (Bảng)');
INSERT INTO DoiTuong (MaDT, TenDT, MaLDT) VALUES
('DT001', N'vw_ThongTin_NV', 'DBO02'),
('DT002', N'vw_BaoCaoTonKho_Thang', 'DBO02'),
('DT003', N'vw_Doanhso_ChiNhanh', 'DBO02'),
('DT004', N'vw_TongSLBan', 'DBO02'),
('DT005', N'LayDS_CTKM_DangDienRa', 'DBO003'),
('DT006', N'KiemTraSPDangGiamGia', 'DBO03'),
('DT007', N'CapNhatGiaBanSP', 'DBO03'),
('DT008', N'BaoCaoDoanhThuBanHang', 'DBO03'),
('DT009', N'fn_TinhTongGiaTriHoaDon', 'DBO04'),
('DT010', N'fn_LayGiaBanHienTai', 'DBO04'),
('DT011', N'fn_BaoCaoTonKhoChiTiet', 'DBO04'),
('DT012', N'HoaDon', 'DBO07'),
('DT013', N'CTHD', 'DBO07'),
('DT014', N'Kho', 'DBO07'),
('DT015', N'NhanVien', 'DBO07'),
('DT016', N'SanPham', 'DBO07'),
('DT017', N'KhachHang', 'DBO07');
INSERT INTO NhomNguoiDung (MaNhom, TenNhom) VALUES
('NH001', N'Quản Trị Hệ Thống (Admin)'),
('NH002', N'Quản Lý Chi Nhánh'),
('NH003', N'Bộ Phận Bán Hàng'),
('NH004', N'Bộ Phận Kho Vận'),
('NH005', N'Bộ Phận Marketing'),
('NH006', N'Bộ Phận Kế Toán');
INSERT INTO PHANQUYEN (MaNhom, MaDT, MaQuyen, NgayCapQuyen, GhiChu) VALUES 
('NH001', 'DT007', 'AD001', '2025-10-25', N'Quản lý SP_CapNhatGiaBanSP'),
('NH001', 'DT008', 'AD001', '2025-10-25', N'Quản lý SP_BaoCaoDoanhThuBanHang'),
('NH001', 'DT012', 'AD001', '2025-10-25', N'Toàn quyền quản lý bảng HoaDon'),
('NH001', 'DT015', 'AD002', '2025-10-25', N'Xem/Quản lý bảng NhanVien để giám sát'),
('NH002', 'DT002', 'QLCN03', '2025-10-25', N'Xem V_BaoCaoTonKho_Thang để giám sát tồn kho'),
('NH002', 'DT003', 'QLCN01', '2025-10-25', N'Xem V_Doanhso_ChiNhanh để theo dõi doanh thu'),
('NH002', 'DT004', 'QLCN03', '2025-10-25', N'Xem V_TongSLBan để giám sát số lượng bán'),
('NH002', 'DT008', 'QLCN01', '2025-10-25', N'Thực thi SP_BaoCaoDoanhThuBanHang (để xem tổng hợp)'),
('NH003', 'DT005', 'BH002', '2025-10-25', N'Thực thi SP_LayDS_CTKM_DangDienRa để tra cứu'),
('NH003', 'DT009', 'BH002', '2025-10-25', N'Sử dụng FN_TinhTongGiaTriHoaDon để xác nhận thanh toán'),
('NH003', 'DT012', 'BH004', '2025-10-25', N'Thực thi SP_ThemHoaDon để lập Hóa Đơn'),
('NH003', 'DT013', 'BH003', '2025-10-25', N'Thao tác trên CTHD'),
('NH004', 'DT002', 'KHO01', '2025-10-25', N'Xem V_BaoCaoTonKho_Thang'),
('NH004', 'DT011', 'KHO03', '2025-10-25', N'Sử dụng FN_BaoCaoTonKhoChiTiet để kiểm tra trước khi xuất/nhập'),
('NH004', 'DT014', 'KHO02', '2025-10-25', N'Thao tác bảng kho'),
('NH005', 'DT005', 'MKT01', '2025-10-25', N'Thực thi SP_LayDS_CTKM_DangDienRa'),
('NH005', 'DT006', 'MKT02', '2025-10-25', N'Thực thi FN_KiemTraSPDangGiamGia để cấu hình KM'),
('NH005', 'DT007', 'MKT03', '2025-10-25', N'Thực thi SP_CapNhatGiaBanSP để thiết lập giá'),
('NH005', 'DT010', 'MKT03', '2025-10-25', N'Sử dụng FN_LayGiaBanHienTai để kiểm tra giá');
INSERT INTO TaiKhoan (MaTK, MaNV, MaNhom, TenTK, MatKhau) VALUES
('TK001', 'NV001', 'NH001', 'lephat_admin', 'Admin!NV001'),
('TK002', 'NV002', 'NH001', 'maitran_admin', 'Admin!NV002'),
('TK003', 'NV003', 'NH001', 'viethoang_admin', 'Admin!NV003'),
('TK004', 'NV004', 'NH002', 'duypham_qly', 'QL!NV004'),
('TK005', 'NV005', 'NH003', 'thaongo_banhang', 'BH!NV005'),
('TK006', 'NV006', 'NH003', 'anhdinh_banhang', 'BH!NV006'),
('TK007', 'NV007', 'NH006', 'ngocvo_ketoan', 'KT!NV007'),
('TK008', 'NV008', 'NH006', 'trucbui_ketoan', 'KT!NV008'),
('TK009', 'NV009', 'NH001', 'hungdang_admin', 'Admin!NV009'),
('TK010', 'NV010', 'NH003', 'tainguyen_banhang', 'BH!NV010'),
('TK011', 'NV011', 'NH003', 'tamluong_banhang', 'BH!NV011'),
('TK012', 'NV012', 'NH004', 'dungto_kho', 'Kho!NV012'),
('TK013', 'NV013', 'NH004', 'kieuphan_kho', 'Kho!NV013');

--Sysonym 1: Synonym cho bảng SanPham
CREATE SYNONYM DS_SANPHAM
FOR SanPham;
    --Kiểm thử
SELECT
    MaSP,
    TenSP,
    MoTa
FROM
    DS_SANPHAM
WHERE
    MaLoaiSP = 'L001';

-- Synonym 2: Synonym cho view vw_BaoCaoTonKho_Thang
CREATE SYNONYM BCTK_Thang
FOR DBO.vw_BaoCaoTonKho_Thang;
   --Kiểm thử
SELECT *
FROM BCTK_Thang
WHERE [Tháng Tồn Kho] = 11 AND [Năm Tồn Kho] = 2025;

--Synonym 3: Synonym cho stored procedure BaoCaoDoanhThuBanHang
CREATE SYNONYM BCDT
FOR DBO.BaoCaoDoanhThuBanHang;
   --Kiểm thử
EXEC BCDT '2025-01-01', '2025-12-31'

--Index 1: Tối ưu hóa truy vấn Phiếu Xuất theo thời gian
CREATE NONCLUSTERED INDEX IXNC_PHIEUXUAT_NGAYPX
ON PhieuXuat (NgayPX);
   --Kiểm thử
SELECT SUM(TriGiaPX) AS [Tổng Giá Trị Xuất Kho]
FROM PhieuXuat
WHERE NgayPX BETWEEN '2025-11-01' AND '2025-11-20';

--Index 2: Tối ưu hóa truy vấn số lượng bán theo Sản phẩm
CREATE NONCLUSTERED INDEX IXNC_CTHD_MASP
ON CTHD (MaSP);
    --Kiểm thử
SELECT
    sp.TenSP AS [Tên Sản Phẩm],
    SUM(ct.SoLuongHD) AS [Tổng Số Lượng Bán],
    SUM(ct.TTienHD) AS [Tổng Tiền Bán]
FROM
    CTHD ct
JOIN
    SanPham sp ON ct.MaSP = sp.MaSP
GROUP BY
    sp.TenSP
ORDER BY
    [Tổng Số Lượng Bán] DESC;
GO

--View 1: Thông tin Nhân viên cơ bản
CREATE or ALTER VIEW vw_ThongTin_NV AS
SELECT
    MaNV AS [Mã Nhân Viên],
    TenNV AS [Tên Nhân Viên],
    SDTNV AS [Số Điện Thoại],
    MaBP AS [Mã Bộ Phận],  
    MaCV AS [Mã Chức Vụ]   
FROM
    NhanVien
WHERE
    TrangThaiNV = N'Đang làm việc';
	 --Kiểm thử
SELECT * FROM vw_ThongTin_NV
GO

--View 2: áo cáo Tồn Kho cuối kỳ theo Tháng
CREATE OR ALTER VIEW vw_BaoCaoTonKho_Thang AS
SELECT
    tk.MaSP AS [Mã Sản Phẩm],
    sp.TenSP AS [Tên Sản Phẩm],
    tk.ThangTK AS [Tháng Tồn Kho],
    tk.NamTK AS [Năm Tồn Kho],
    SUM(tk.TonCK) AS [Tổng Tồn Cuối Kỳ],
    SUM(tk.TriGiaTonCK) AS [Tổng Giá Trị Tồn Cuối Kỳ]
FROM
    TonKho tk
JOIN
    SanPham sp ON tk.MaSP = sp.MaSP
GROUP BY
    tk.MaSP, sp.TenSP, tk.ThangTK, tk.NamTK;
	 --Kiểm thử
SELECT *
FROM vw_BaoCaoTonKho_Thang
WHERE [Tháng Tồn Kho] = 11 AND [Năm Tồn Kho] = 2025;
GO

--View 3: Doanh số bán hàng của từng chi nhánh
CREATE OR ALTER VIEW vw_DoanhSo_ChiNhanh AS
SELECT
    cn.MaCN AS [Mã Chi Nhánh],
    cn.TenCN AS [Tên Chi Nhánh],
    COUNT(hd.SoHD) AS [Tổng Số Hóa Đơn],
    SUM(hd.TriGiaSauThue) AS [Tổng Doanh Số Sau Thuế]
FROM
    HoaDon hd
INNER JOIN
    NhanVien nv ON hd.MaNV = nv.MaNV
INNER JOIN
    BoPhan bp ON nv.MaBP = bp.MaBP     
INNER JOIN
    PhongBan pb ON bp.MaPB = pb.MaPB     
INNER JOIN
    ChiNhanh cn ON pb.MaCN = cn.MaCN     
GROUP BY
    cn.MaCN,
    cn.TenCN;
	 --Kiểm thử
SELECT
    [Tên Chi Nhánh],
    [Tổng Doanh Số Sau Thuế]
FROM
    vw_DoanhSo_ChiNhanh 
ORDER BY
    [Tổng Doanh Số Sau Thuế] DESC;
GO

--View 4: Số lượng bán ra của các sản phẩm
CREATE OR ALTER VIEW vw_TongSLBan AS
SELECT
    ct.MaSP AS [Mã Sản Phẩm],
    sp.TenSP AS [Tên Sản Phẩm],
    SUM(ct.SoLuongHD) AS [Tổng Số Lượng Bán]
FROM
    CTHD ct
JOIN
    SanPham sp ON ct.MaSP = sp.MaSP
GROUP BY
    ct.MaSP,
    sp.TenSP
    --Kiểm thử
SELECT * 
FROM vw_TongSLBan;
GO

--View 5: Top 5 sản phẩm bán chạy nhất
CREATE OR ALTER VIEW vw_Top5_SanPhamBanChay AS
SELECT TOP 5
    [Tên Sản Phẩm],
    [Tổng Số Lượng Bán]
FROM
    VW_TONG_SL_BAN
ORDER BY
    [Tổng Số Lượng Bán] DESC;
    --Kiểm thử
SELECT * FROM vw_Top5_SanPhamBanChay;
GO

--Function 1: Tính Tổng Giá Trị Hóa Đơn (Tính sau thuế)
CREATE FUNCTION fn_TinhTongGiaTriHoaDon (@SoHD VARCHAR(20))
RETURNS FLOAT
AS
BEGIN
    DECLARE @TongTriGia FLOAT;
    SELECT @TongTriGia = TriGiaSauThue
    FROM HoaDon
    WHERE SoHD = @SoHD;
    IF @TongTriGia IS NULL
        SET @TongTriGia = 0; 
    RETURN @TongTriGia;
END;
 --Kiểm thử
SELECT
    H.SoHD AS [Số Hóa Đơn],
    KH.TenKH AS [Tên Khách Hàng],
    dbo.fn_TinhTongGiaTriHoaDon(H.SoHD) AS [Trị giá hóa đơn]
FROM
    HoaDon H
INNER JOIN
    KhachHang KH ON H.MaKH = KH.MaKH
WHERE
    H.SoHD IN ('HD001', 'HD002');
GO

--Function 2: Lấy Giá Bán Hiện Tại Của Sản Phẩm
CREATE FUNCTION fn_LayGiaBanHienTai (@MaSP VARCHAR(20), @NgayXem DATE)
RETURNS FLOAT
AS
BEGIN
    DECLARE @GiaBanHienTai FLOAT;
    SELECT TOP 1 @GiaBanHienTai = GiaBan
    FROM BienDongGia
    WHERE MaSP = @MaSP AND NgayCapNhatBDG <= @NgayXem
    ORDER BY NgayCapNhatBDG DESC; 
    IF @GiaBanHienTai IS NULL
        SET @GiaBanHienTai = 0; 
    RETURN @GiaBanHienTai;
END;
 --Kiểm thử
SELECT
    SP.MaSP AS [Mã Sản Phẩm],
    SP.TenSP AS [Tên Sản Phẩm],
    dbo.fn_LayGiaBanHienTai(SP.MaSP, '2025-12-07') AS [Giá Bán Hiện Tại],
    (
        SELECT TOP 1
            BDG.NgayCapNhatBDG
        FROM
            BienDongGia BDG
        WHERE
            BDG.MaSP = SP.MaSP
            AND BDG.NgayCapNhatBDG <= '2025-12-07' 
        ORDER BY
            BDG.NgayCapNhatBDG DESC
    ) AS [Ngày Cập Nhật]
FROM
    SanPham SP
WHERE
    SP.MaSP = 'SP001';
GO

--Function 3: Lấy Chi tiết Hóa đơn theo Mã Khách hàng
CREATE FUNCTION fn_CTHD_TheoKhachHang (@MaKH VARCHAR(20))
RETURNS TABLE
AS
RETURN
(
    SELECT
        K.TenKH AS [Tên Khách Hàng], 
		 H.SoHD AS [Số Hóa Đơn],
        H.NgayLapHD AS [Ngày Lập],
        SP.TenSP AS [Tên Sản Phẩm],
        C.SoLuongHD AS [Số Lượng Mua]
    FROM 
        HoaDon H
    INNER JOIN 
        KhachHang K ON H.MaKH = K.MaKH 
    INNER JOIN 
        CTHD C ON H.SoHD = C.SoHD
    INNER JOIN 
        SanPham SP ON C.MaSP = SP.MaSP
    WHERE 
        H.MaKH = @MaKH
);
 --Kiểm thử
SELECT * FROM fn_CTHD_TheoKhachHang('KH001');
GO

--Function 4: Báo cáo tồn kho 
CREATE FUNCTION fn_BaoCaoTonKhoChiTiet (@MaKho VARCHAR(20), @Thang INT, @Nam INT)
RETURNS @BaoCao TABLE
(
    [Mã Sản Phẩm] VARCHAR(20),
    [Tên Sản Phẩm] NVARCHAR(250),
    [Tồn Đầu Kỳ] INT, 
    [Nhập Trong Kỳ] INT, 
    [Xuất Trong Kỳ] INT, 
    [Tồn Cuối Kỳ] INT   
)
AS
BEGIN
    INSERT INTO @BaoCao ([Mã Sản Phẩm], [Tồn Đầu Kỳ], [Nhập Trong Kỳ], [Xuất Trong Kỳ])
    SELECT
        TK.MaSP,
        TK.TonDK,
        TK.NhapTK,
        TK.XuatTK
    FROM
        TonKho TK
    WHERE
        TK.MaKho = @MaKho AND TK.ThangTK = @Thang AND TK.NamTK = @Nam;
    UPDATE R
    SET R.[Tên Sản Phẩm] = SP.TenSP
    FROM @BaoCao R
    INNER JOIN SanPham SP ON R.[Mã Sản Phẩm] = SP.MaSP;
    UPDATE @BaoCao
    SET [Tồn Cuối Kỳ] = [Tồn Đầu Kỳ] + [Nhập Trong Kỳ] - [Xuất Trong Kỳ]
    WHERE [Mã Sản Phẩm] IS NOT NULL; 
    RETURN;
END;
 --Kiểm thử
SELECT *
FROM dbo.fn_BaoCaoTonKhoChiTiet('KHO02', 11, 2025);
GO

--Function 5: Thống kê khách hàng theo độ tuổi
CREATE OR ALTER FUNCTION fn_ThongKeKhachHangTheoDoTuoi ()
RETURNS @ResultTable TABLE
(
    NhomDoTuoi NVARCHAR(50),
    SoLuongKhachHang INT,
    TyLe DECIMAL(5, 2)
)
AS
BEGIN
    -- Lấy năm hiện tại
    DECLARE @NamHienTai INT = YEAR(GETDATE());
    -- Bảng tạm để tính toán số lượng khách hàng theo từng nhóm
    WITH ThongKeTheoNhom AS (
        SELECT
            CASE
                WHEN KH.NgaySinhKH IS NULL THEN N'Chưa có thông tin ngày sinh'
                WHEN (@NamHienTai - YEAR(KH.NgaySinhKH)) < 18 THEN N'1. Dưới 18 tuổi'
                WHEN (@NamHienTai - YEAR(KH.NgaySinhKH)) BETWEEN 18 AND 25 THEN N'2. Từ 18 đến 25 tuổi'
                WHEN (@NamHienTai - YEAR(KH.NgaySinhKH)) BETWEEN 26 AND 40 THEN N'3. Từ 26 đến 40 tuổi'
                ELSE N'4. Trên 40 tuổi'
            END AS Nhom,
            COUNT(KH.MaKH) AS TongSo
        FROM
            KhachHang KH
        GROUP BY
            CASE
                WHEN KH.NgaySinhKH IS NULL THEN N'Chưa có thông tin ngày sinh'
                WHEN (@NamHienTai - YEAR(KH.NgaySinhKH)) < 18 THEN N'1. Dưới 18 tuổi'
                WHEN (@NamHienTai - YEAR(KH.NgaySinhKH)) BETWEEN 18 AND 25 THEN N'2. Từ 18 đến 25 tuổi'
                WHEN (@NamHienTai - YEAR(KH.NgaySinhKH)) BETWEEN 26 AND 40 THEN N'3. Từ 26 đến 40 tuổi'
                ELSE N'4. Trên 40 tuổi'
            END
    )
    -- Chèn kết quả vào bảng đầu ra và tính tỷ lệ
    INSERT INTO @ResultTable (NhomDoTuoi, SoLuongKhachHang, TyLe)
    SELECT
        TKN.Nhom,
        TKN.TongSo,
        CAST(TKN.TongSo * 100.0 / NULLIF(SUM(TKN.TongSo) OVER(), 0) AS DECIMAL(5, 2))
    FROM
        ThongKeTheoNhom TKN
    ORDER BY
        TKN.Nhom;

    RETURN;
END
 --Kiểm thử
SELECT
    t.NhomDoTuoi AS [Nhóm Độ Tuổi],
    t.SoLuongKhachHang AS [Số Lượng Khách Hàng],
    t.TyLe AS [Tỷ Lệ Phần Trăm]
FROM
    fn_ThongKeKhachHangTheoDoTuoi() AS t;
GO

--SP 1: Lấy danh sách Chương trình Khuyến mãi đang diễn ra
CREATE OR ALTER PROCEDURE LayDS_CTKM_DangDienRa
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @NgayHienTai DATE = GETDATE();

    SELECT
        MaCT AS [Mã Chương Trình],
        TenCT AS [Tên Chương Trình],
        NgayBatDau AS [Ngày Bắt Đầu],
        NgayKetThuc AS [Ngày Kết Thúc],
        LyDoKM AS [Lý Do Khuyến Mãi]
    FROM
        ChuongTrinhKM
    WHERE
        NgayBatDau <= @NgayHienTai AND NgayKetThuc >= @NgayHienTai
    ORDER BY
        [Ngày Kết Thúc];
END;
 --Kiểm thử
EXEC LayDS_CTKM_DangDienRa;
SELECT * FROM CTCTKM
GO

--SP 2: Kiểm tra sản phẩm nào đang được giảm giá
CREATE OR ALTER PROCEDURE KiemTraSPDangGiamGia
AS
BEGIN
    -- Lấy ngày hiện tại
    DECLARE @NgayHienTai DATE = GETDATE();
    -- 1. Tìm mức giá mới nhất cho từng sản phẩm
    WITH GiaMoiNhat AS (
        SELECT
            MaSP,
            GiaBan,
            -- Xếp hạng các mức giá dựa trên ngày cập nhật giảm dần 
            ROW_NUMBER() OVER (PARTITION BY MaSP ORDER BY NgayCapNhatBDG DESC) AS Rn
        FROM
            BienDongGia
    )
    -- 2. Truy vấn chính
    SELECT
        SP.MaSP AS [Mã Sản Phẩm],
        SP.TenSP AS [Tên Sản Phẩm],
        CTKM.TenCT AS [Tên Chương Trình KM],
        CTKM.NgayBatDau AS [Ngày Bắt Đầu KM],
        CTKM.NgayKetThuc AS [Ngày Kết Thúc KM],
        CTCT.MucGiamGia AS [Mức Giảm Giá (% hoặc Giá Trị)],
        GMN.GiaBan AS [Giá Bán Mới Nhất] 
    FROM
        CTCTKM CTCT 
    JOIN
        ChuongTrinhKM CTKM ON CTCT.MaCT = CTKM.MaCT
    JOIN
        SanPham SP ON CTCT.MaSP = SP.MaSP
    LEFT JOIN
        GiaMoiNhat GMN ON SP.MaSP = GMN.MaSP AND GMN.Rn = 1
    WHERE
        -- Kiểm tra chương trình khuyến mãi đang có hiệu lực
        @NgayHienTai >= CTKM.NgayBatDau
        AND @NgayHienTai <= CTKM.NgayKetThuc
    ORDER BY
        SP.TenSP, CTKM.NgayKetThuc;
END
 --Kiểm thử
EXEC KiemTraSPDangGiamGia;
GO

--SP 3: Cập nhật Giá bán Sản phẩm 
CREATE OR ALTER PROCEDURE CapNhatGiaBanSP
    @MaSP VARCHAR(20),
    @GiaBanMoi FLOAT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM SanPham WHERE MaSP = @MaSP)
    BEGIN
        RAISERROR(N'Lỗi: Mã sản phẩm %s không tồn tại. Vui lòng kiểm tra lại.', 16, 1, @MaSP);
        RETURN;
    END
    BEGIN TRY
        INSERT INTO BienDongGia (MaSP, NgayCapNhatBDG, GiaBan)
        VALUES (@MaSP, GETDATE(), @GiaBanMoi);
        DECLARE @ThongBao NVARCHAR(500);
        SET @ThongBao = N'Cập nhật thành công: Giá bán mới cho sản phẩm ' + @MaSP + N' đã được ghi nhận vào lúc ' + CONVERT(NVARCHAR, GETDATE(), 120);
        PRINT @ThongBao; 

    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(MAX) = ERROR_MESSAGE();
        PRINT N'Lỗi hệ thống khi cập nhật giá: ' + @ErrorMessage;
    END CATCH
END;
 --Kiểm thử
EXEC CapNhatGiaBanSP
    @MaSP = 'SP001',
    @GiaBanMoi = 300000;
SELECT 
    MaSP AS [Mã Sản Phẩm], 
    NgayCapNhatBDG AS [Ngày Cập Nhật Giá], 
    GiaBan AS [Giá Bán Mới (VNĐ)]
FROM 
    BienDongGia
ORDER BY 
    NgayCapNhatBDG DESC;
GO

--SP 4: Lấy danh sách Sản phẩm theo Loại Sản phẩm 
CREATE OR ALTER PROCEDURE LayDSSanPhamTheoLoai
    @MaLoaiSP VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM LoaiSanPham WHERE MaLoaiSP = @MaLoaiSP)
    BEGIN
        RAISERROR(N'Mã Loại Sản Phẩm không tồn tại. Vui lòng kiểm tra lại.', 16, 1);
        RETURN;
    END
    SELECT
        SP.MaSP AS [Mã Sản Phẩm],
        SP.TenSP AS [Tên Sản Phẩm],
        SP.MoTa AS [Mô Tả],
        DVT.TenDVT AS [Đơn Vị Tính]
    FROM
        SanPham SP
    INNER JOIN
        DonViTinh DVT ON SP.MaDVT = DVT.MaDVT
    WHERE
        SP.MaLoaiSP = @MaLoaiSP
    ORDER BY
        [Tên Sản Phẩm];
END;
 --Kiểm thử
EXEC LayDSSanPhamTheoLoai @MaLoaiSP = 'L003';
GO

--SP 5: Báo cáo doanh thu bán hàng
CREATE OR ALTER PROCEDURE BaoCaoDoanhThuBanHang
    @NgayBatDau DATE,
    @NgayKetThuc DATE
AS
BEGIN
    -- 1. Báo cáo Tổng Doanh Thu 
    SELECT
        COUNT(HD.SoHD) AS [Tổng Số Hóa Đơn],
        SUM(HD.TriGiaTruocThue) AS [Tổng Trị Giá Trước Thuế],
        SUM(HD.VAT) AS [Tổng Thuế VAT],
        SUM(HD.TriGiaSauThue) AS [Tổng Doanh Thu] 
    FROM
        HoaDon HD
    WHERE
        HD.NgayLapHD >= @NgayBatDau
        AND HD.NgayLapHD <= @NgayKetThuc
        AND HD.TrangThaiHD = N'Đã thanh toán'

    -- 2. Báo cáo Doanh Thu Chi Tiết theo Sản Phẩm 
    SELECT
        SP.MaSP AS [Mã Sản Phẩm],
        SP.TenSP AS [Tên Sản Phẩm],
        LSP.TenLoaiSP AS [Loại Sản Phẩm],
        SUM(CT.SoLuongHD) AS [Tổng Số Lượng Bán],
        SUM(CT.TTienHD) AS [Tổng Doanh Thu Sản Phẩm]
    FROM
        HoaDon HD
    JOIN
        CTHD CT ON HD.SoHD = CT.SoHD
    JOIN
        SanPham SP ON CT.MaSP = SP.MaSP
    JOIN
        LoaiSanPham LSP ON SP.MaLoaiSP = LSP.MaLoaiSP
    WHERE
        HD.NgayLapHD >= @NgayBatDau
        AND HD.NgayLapHD <= @NgayKetThuc
        AND HD.TrangThaiHD = N'Đã thanh toán'
    GROUP BY
        SP.MaSP, SP.TenSP, LSP.TenLoaiSP
    ORDER BY
        [Tổng Doanh Thu Sản Phẩm] DESC
END
 --Kiểm thử
EXEC BaoCaoDoanhThuBanHang '2025-01-01', '2025-12-31'
GO

--SP 6: Báo cáo điểm tích lũy khách hàng
CREATE OR ALTER PROCEDURE BaoCaoDiemTichLuyKhachHang
    -- Tham số tùy chọn để chỉ lấy những khách hàng có điểm từ một mức nào đó trở lên
    @DTLToiThieu DECIMAL(18, 2) = 0 -- Giá trị mặc định là 0
AS
BEGIN
    SELECT
        KH.MaKH AS [Mã Khách Hàng],
        KH.TenKH AS [Tên Khách Hàng],
        TTV.SoThe AS [Số Thẻ Thành Viên],
        TTV.DTLHienTai AS [Điểm Tích Lũy Hiện Tại],
        TTV.DTLCuoiKy AS [Điểm Tích Lũy Cuối Kỳ Trước],
        TTV.NgayCapThe AS [Ngày Cấp Thẻ],
        TTV.NgayCapNhatDTL AS [Ngày Cập Nhật DTL Gần Nhất],
        TTV.GhiChuDTL AS [Ghi Chú Về Điểm Tích Lũy]
    FROM
        KhachHang KH
    JOIN
        TheThanhVien TTV ON KH.MaKH = TTV.MaKH 
    WHERE
        TTV.DTLHienTai >= @DTLToiThieu -- Lọc theo điểm tích lũy tối thiểu
    ORDER BY
        TTV.DTLHienTai DESC, -- Sắp xếp Khách Hàng theo Điểm Tích Lũy giảm dần
        KH.TenKH;
END
 --Kiểm thử
EXEC BaoCaoDiemTichLuyKhachHang @DTLToiThieu = 1000;
GO

--SP 7: Lịch sử giao dịch của khách hàng
CREATE OR ALTER PROCEDURE LichSuGiaoDichKhachHang
    @MaKH NVARCHAR(20),      -- Mã Khách Hàng (BẮT BUỘC)
    @NgayBatDau DATE = NULL, -- Ngày Bắt Đầu (Tùy chọn)
    @NgayKetThuc DATE = NULL  -- Ngày Kết Thúc (Tùy chọn)
AS
BEGIN
    -- 1. Báo cáo Tóm tắt Khách hàng và Điểm Tích Lũy 
    SELECT TOP 1
        KH.MaKH AS [Mã Khách Hàng],
        KH.TenKH AS [Tên Khách Hàng],
        KH.SDTKH AS [SĐT],
        KH.EmailKH AS [Email],
        TTV.SoThe AS [Số Thẻ Thành Viên],
        TTV.DTLHienTai AS [Điểm Tích Lũy Hiện Tại]
    FROM
        KhachHang KH
    LEFT JOIN 
        TheThanhVien TTV ON KH.MaKH = TTV.MaKH
    WHERE
        KH.MaKH = @MaKH;
    -- 2. Báo cáo Chi tiết Lịch sử Hóa đơn 
    SELECT
        HD.SoHD AS [Số Hóa Đơn],
        HD.NgayLapHD AS [Ngày Lập HD],
        HD.TriGiaSauThue AS [Tổng Giá Trị HD],
        HD.TrangThaiHD AS [Trạng Thái HD],
        HD.PTTT AS [Phương Thức TT],
        NV.TenNV AS [Nhân Viên Phụ Trách]
    FROM
        HoaDon HD
    JOIN
        NhanVien NV ON HD.MaNV = NV.MaNV
    WHERE
        HD.MaKH = @MaKH
        AND (@NgayBatDau IS NULL OR HD.NgayLapHD >= @NgayBatDau)
        AND (@NgayKetThuc IS NULL OR HD.NgayLapHD <= @NgayKetThuc)
    ORDER BY
        HD.NgayLapHD DESC;
END
 --Kiểm thử
EXEC LichSuGiaoDichKhachHang @MaKH = 'KH002';
GO

--Trigger 1: Ngày sinh của khách hàng phải bé hơn ngày hiện tại
CREATE OR ALTER TRIGGER trg_NgaySinhKH
ON KhachHang
INSTEAD OF INSERT, UPDATE
AS
BEGIN
    -- 1. Kiểm tra điều kiện lỗi
    IF EXISTS (
        SELECT 1
        FROM INSERTED
        WHERE NgaySinhKH >= GETDATE()
    )
    BEGIN
	ROLLBACK TRANSACTION; 
        THROW 50001, 'Lỗi RBTV: Ngày sinh khách hàng phải nhỏ hơn ngày hiện tại.', 1;
    END
    ELSE
    BEGIN
        -- 2. Thực hiện thao tác gốc nếu không có lỗi
        -- Chèn dữ liệu từ bảng ảo INSERTED vào bảng KhachHang
        INSERT INTO KhachHang (MaKH, TenKH, SDTKH, EmailKH, DiaChiKH, NgaySinhKH, MST)
        SELECT MaKH, TenKH, SDTKH, EmailKH, DiaChiKH, NgaySinhKH, MST
        FROM INSERTED;
    END
END
   --Kiểm thử
INSERT INTO KhachHang (MaKH, TenKH, SDTKH, EmailKH, DiaChiKH, NgaySinhKH, MST)
VALUES ('KH001', N'Nguyễn Văn An','0901234567','annv@example.com', N'456 Đường Lê Lợi, Quận 1, TP.HCM','2025-12-12',NULL);
GO

--Trigger 2: Giá bán của sản phẩm phải lớn hơn hoặc bằng 0
CREATE OR ALTER TRIGGER tgr_BienDongGia_GiaBan
ON BienDongGia
FOR INSERT, UPDATE 
AS
BEGIN
    -- 1. Kiểm tra điều kiện lỗi: GiaBan nhỏ hơn 0
    IF EXISTS (
        SELECT 1
        FROM inserted i
        WHERE i.GiaBan < 0
    )
    BEGIN
        ROLLBACK TRANSACTION; 
        THROW 50005, N'Lỗi RBTV: Giá Bán của sản phẩm phải lớn hơn hoặc bằng 0.', 1;
    END
END
 --Kiểm thử
INSERT INTO BienDongGia (MaSP, NgayCapNhatBDG, GiaBan)
VALUES('SP005', '2025-12-10', -50000);
GO

--Trigger 3: Tháng tồn kho phải từ tháng 1 tới tháng 12
CREATE OR ALTER TRIGGER tgr_Thang_TonKho
ON TonKho 
FOR INSERT, UPDATE 
AS
BEGIN
    -- 1. Kiểm tra điều kiện lỗi: ThangTonKho nằm ngoài phạm vi 1 đến 12
    IF EXISTS (
        SELECT 1
        FROM inserted i
        WHERE i.ThangTK < 1 OR i.ThangTK > 12
    )
    BEGIN
    ROLLBACK TRANSACTION; 
        THROW 50006, N'Lỗi RBTV: Tháng tồn kho phải nằm trong khoảng từ 1 đến 12.', 1;
    END
END
 --Kiểm thử
INSERT INTO TonKho (MaKho, MaSP, ThangTK, NamTK, TonDK, TriGiaTonDK, NhapTK, TriGiaNhapTK, XuatTK, TriGiaXuatTK, TonCK, TriGiaTonCK)
VALUES ('KHO01', 'SP015', 15, 2025,  100,  5000000.00,  50, 3000000.00, 20,  1500000.00,  130,6500000.00 );
GO

--Trigger 4: Kiểm tra ngày bắt đầu bé hơn ngày kết thúc
CREATE OR ALTER TRIGGER trg_ChuongTrinhKM_NBD_NKT
ON ChuongTrinhKM
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (
        SELECT 1
        FROM INSERTED
        WHERE NgayBatDau >= NgayKetThuc
    )
    BEGIN
        ROLLBACK TRANSACTION;
		THROW 50001, N'Lỗi RBTV: Ngày Bắt Đầu phải sớm hơn Ngày Kết Thúc của Chương trình Khuyến Mãi.', 1;
    END
END;
 --Kiểm thử
INSERT INTO ChuongTrinhKM (MaCT, TenCT, NgayBatDau, NgayKetThuc, LyDoKM)
VALUES ('KM006', N'Khuyến mãi ngày trùng', '2025-12-08', '2025-12-06', N'Sự kiện 1 ngày');
GO;

--Trigger 5: Nếu năm tồn kho là năm hiện tại, thì tháng tồn kho phải nhỏ hơn hoặc bằng tháng hiện tại.
CREATE OR ALTER TRIGGER tgr_TonKho_ThangHopLeTrongNam
ON TonKho
FOR INSERT, UPDATE
AS
BEGIN
    -- 1. Lấy năm và tháng hiện tại từ hệ thống
    DECLARE @NamHienTai INT = YEAR(GETDATE());
    DECLARE @ThangHienTai INT = MONTH(GETDATE());
    -- 2. Kiểm tra điều kiện vi phạm:
    IF EXISTS (
        SELECT 1
        FROM inserted i
        WHERE i.NamTK = @NamHienTai
        AND i.ThangTK > @ThangHienTai 
    )
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50007, N'Lỗi RBTV: Nếu năm tồn kho là năm hiện tại, tháng tồn kho phải nhỏ hơn hoặc bằng tháng hiện tại.', 1;
    END
END
 --Kiểm thử
INSERT INTO TonKho (MaKho, MaSP, ThangTK, NamTK, TonDK, TriGiaTonDK, NhapTK, TriGiaNhapTK, XuatTK, TriGiaXuatTK, TonCK, TriGiaTonCK)
VALUES ('KHO01', 'SP015', 12, 2025,  100,  5000000.00,  50, 3000000.00, 20,  1500000.00,  130,6500000.00 );
select * from TonKho
GO

--Trigger 6: Ngày lập hóa đơn phải bé hơn hoặc bằng ngày xuất hàng
CREATE OR ALTER TRIGGER tgr_XuatHang_NgayHopLe
ON PhieuXuat
FOR INSERT, UPDATE
AS
BEGIN
    -- 1. Kiểm tra điều kiện vi phạm: Ngày Lập Hóa Đơn > Ngày Xuất Hàng
    IF EXISTS (
        SELECT 1
        FROM inserted i -- Dữ liệu mới được chèn/cập nhật vào XuatHang
        INNER JOIN HoaDon hd ON i.SoHD = hd.SoHD -- Lấy NgayLapHD từ bảng HoaDon
        WHERE hd.NgayLapHD > i.NgayPX
    )
    BEGIN
	ROLLBACK TRANSACTION;
        THROW 50008, N'Lỗi RBTV: Ngày lập hóa đơn không được lớn hơn ngày xuất hàng.', 1;
    END
END
 --Kiểm thử
INSERT INTO PhieuXuat (SoPX, NgayPX, TriGiaPX, LyDoPX, GhiChuPX, SoHD, MaKho, MaNV)
VALUES ( N'PX009', '2025-12-05',  13717350,  N'Xuất hàng theo hóa đơn bán hàng',  N'Phiếu xuất cho Hóa đơn HD009', N'HD009', N'KHO01', N'NV001');
GO

--Trigger 7: Kiểm tra chỉ được cập nhật hoặc xóa giá bán tại ngày hiện tại
CREATE OR ALTER TRIGGER TR_BienDongGia
ON BienDongGia
AFTER UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (
        SELECT 1
        FROM DELETED D
        WHERE DATEDIFF(day, D.NgayCapNhatBDG, GETDATE()) > 0
    )
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50002, N'Lỗi RBTV: Chỉ được phép cập nhật hoặc xóa dữ liệu biến động giá có Ngày Cập Nhật là ngày hiện tại.', 1;
    END
END;
 --Kiểm thử
DELETE FROM BienDongGia
    WHERE MaSP = 'SP001' AND NgayCapNhatBDG = '2024-01-01'; 
GO

--Trigger 8: Trigger giám sát
CREATE TRIGGER trg_NhanVien_Audit_Insert
ON NhanVien
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @AffectedIDs NVARCHAR(MAX) = N'';
    SELECT @AffectedIDs = @AffectedIDs + CAST(MaNV AS NVARCHAR(50)) + N', '
    FROM inserted;
    IF LEN(@AffectedIDs) > 1
        SET @AffectedIDs = LEFT(@AffectedIDs, LEN(@AffectedIDs) - 1);
    INSERT INTO AuditLog (UserName, Action, TimeStamp)
    VALUES (
        SYSTEM_USER,
        N'INSERT: Bảng nhân viên. MaNV được thêm: ' + @AffectedIDs,
        GETDATE()
    );
END
GO

CREATE TRIGGER trg_NhanVien_Audit_Update
ON NhanVien
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @AffectedIDs NVARCHAR(MAX) = N'';
    SELECT @AffectedIDs = @AffectedIDs + CAST(MaNV AS NVARCHAR(50)) + N', '
    FROM inserted;
    IF LEN(@AffectedIDs) > 1
        SET @AffectedIDs = LEFT(@AffectedIDs, LEN(@AffectedIDs) - 1);
    INSERT INTO AuditLog (UserName, Action, TimeStamp)
    VALUES (
        SYSTEM_USER,
        N'UPDATE: Bảng nhân viên. MaNV được sửa: ' + @AffectedIDs,
        GETDATE()
    );
END
GO

CREATE TRIGGER trg_KhachHang_Audit_Insert
ON KhachHang
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @AffectedIDs NVARCHAR(MAX) = N'';
    SELECT @AffectedIDs = @AffectedIDs + CAST(MaKH AS NVARCHAR(50)) + N', '
    FROM inserted;
    IF LEN(@AffectedIDs) > 1
        SET @AffectedIDs = LEFT(@AffectedIDs, LEN(@AffectedIDs) - 1);
    INSERT INTO AuditLog (UserName, Action, TimeStamp)
    VALUES (
        SYSTEM_USER,
        N'INSERT: Bảng khách hàng. MaKH được thêm: ' + @AffectedIDs,
        GETDATE()
    );
END
GO

CREATE TRIGGER trg_KhachHang_Audit_Update
ON KhachHang
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @AffectedIDs NVARCHAR(MAX) = N'';
    SELECT @AffectedIDs = @AffectedIDs + CAST(MaKH AS NVARCHAR(50)) + N', '
    FROM inserted;
    IF LEN(@AffectedIDs) > 1
        SET @AffectedIDs = LEFT(@AffectedIDs, LEN(@AffectedIDs) - 1);
    INSERT INTO AuditLog (UserName, Action, TimeStamp)
    VALUES (
        SYSTEM_USER,
        N'UPDATE: Bảng khách hàng. MaKH được sửa: ' + @AffectedIDs,
        GETDATE()
    );
END
GO

--Giao dịch 1: Thêm hóa đơn
CREATE OR ALTER PROCEDURE ThemHoaDon
    @SoHD VARCHAR(20),
    @MaKH VARCHAR(20),
    @MaNV VARCHAR(20),
    @PTTT NVARCHAR(200) = NULL, 
    @TienCoc FLOAT = 0
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @NgayLapHD DATE = GETDATE();
    BEGIN TRANSACTION;
    BEGIN TRY
        -- 1. Kiểm tra tồn tại Khách hàng
        IF NOT EXISTS (SELECT 1 FROM KhachHang WHERE MaKH = @MaKH)
        BEGIN
            RAISERROR(N'Mã Khách hàng không tồn tại.', 16, 1);
            IF @@TRANCOUNT > 0
                ROLLBACK TRANSACTION;
            RETURN;
        END
        -- 2. Kiểm tra tồn tại Nhân viên
        IF NOT EXISTS (SELECT 1 FROM NhanVien WHERE MaNV = @MaNV)
        BEGIN
            RAISERROR(N'Mã Nhân viên không tồn tại.', 16, 1);
            IF @@TRANCOUNT > 0
                ROLLBACK TRANSACTION;
            RETURN;
        END
        -- 3. Thêm Hóa đơn
        INSERT INTO HoaDon (SoHD, MaKH, MaNV, NgayLapHD, TriGiaTruocThue, VAT, TriGiaSauThue, PTTT, NgayTT, TienCoc, TrangThaiHD)
        VALUES (@SoHD, @MaKH, @MaNV, @NgayLapHD, 0, 0, 0, @PTTT, NULL, @TienCoc, N'Đã lập');
        COMMIT TRANSACTION;
        PRINT N'Thêm Hóa đơn ' + @SoHD + N' thành công.';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        -- Báo lỗi ra ngoài
        THROW;
    END CATCH
END;
   -- Kiểm thử
EXEC ThemHoaDon
    @SoHD = 'HD009',
    @MaKH = 'KH001', 
    @MaNV = 'NV001',
    @PTTT = N'Tiền mặt',
    @TienCoc = 0;
SELECT
    SoHD AS [Số Hóa Đơn],
    MaKH AS [Mã Khách Hàng],
    MaNV AS [Mã Nhân Viên],
    NgayLapHD AS [Ngày Lập Hóa Đơn],
    TriGiaTruocThue AS [Tổng Tiền Trước Thuế],
    VAT AS [Thuế VAT],
    TriGiaSauThue AS [Tổng Tiền Sau Thuế],
    PTTT AS [Phương Thức Thanh Toán],
    NgayTT AS [Ngày Thanh Toán],
    TienCoc AS [Tiền Cọc],
    TrangThaiHD AS [Trạng Thái Hóa Đơn]
FROM
    HoaDon
GO

--Giao dịch 2: Thêm chi tiết hóa đơn
CREATE OR ALTER PROCEDURE ThemCTHD(
    @SoHD VARCHAR(20),
    @MaSP VARCHAR(20),
    @SoLuongHD INT,
    @PhanTramVAT DECIMAL(5,3)
)
AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @MucGiamGiaTuCTKM DECIMAL(5,3);
    DECLARE @DonGia DECIMAL(18,2);
    DECLARE @ThanhTien DECIMAL(18,2);
    DECLARE @NgayLapHD DATE;
    SELECT @NgayLapHD = NgayLapHD 
    FROM HoaDon 
    WHERE SoHD = @SoHD AND TrangThaiHD = N'Đã lập'; 
    IF @NgayLapHD IS NULL
    BEGIN
        RAISERROR(N'Số Hóa đơn không tồn tại.', 16, 1);
        RETURN;
    END
    SET @DonGia = dbo.fn_LayGiaBanHienTai(@MaSP, @NgayLapHD);
    IF @DonGia = 0
    BEGIN
        RAISERROR(N'Không tìm thấy giá bán cho Sản phẩm %s tại thời điểm lập Hóa đơn.', 16, 1, @MaSP);
        RETURN;
    END
    SELECT TOP 1 @MucGiamGiaTuCTKM = CT.MucGiamGia
    FROM CTCTKM CT
    INNER JOIN ChuongTrinhKM KM ON CT.MaCT = KM.MaCT
    WHERE 
        CT.MaSP = @MaSP AND
        KM.NgayBatDau <= @NgayLapHD AND
        KM.NgayKetThuc >= @NgayLapHD
    ORDER BY
        CT.MucGiamGia DESC; 
    SET @MucGiamGiaTuCTKM = ISNULL(@MucGiamGiaTuCTKM, 0);
    SET @ThanhTien = (@SoLuongHD * @DonGia) * (1 - @MucGiamGiaTuCTKM);
    BEGIN TRANSACTION;
    BEGIN TRY
        INSERT INTO CTHD (SoHD, MaSP, SoLuongHD, DonGiaHD, GiamGiaSP, TTienHD)
        VALUES (@SoHD, @MaSP, @SoLuongHD, @DonGia, @MucGiamGiaTuCTKM, @ThanhTien); 
        DECLARE @TongTruocThue FLOAT;
        SELECT @TongTruocThue = SUM(TTienHD)
        FROM CTHD
        WHERE SoHD = @SoHD;
        UPDATE HoaDon
        SET 
            TriGiaTruocThue = @TongTruocThue,
            VAT = @TongTruocThue * @PhanTramVAT, 
            TriGiaSauThue = @TongTruocThue * (1 + @PhanTramVAT),
            NgayTT = GETDATE(),
			TrangThaiHD = N'Đã thanh toán'
        WHERE 
            SoHD = @SoHD;
        COMMIT TRANSACTION;
        PRINT N'Thêm Chi tiết Sản phẩm ' + @MaSP + N' thành công.';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        DECLARE @ErrorMsg NVARCHAR(MAX) = ERROR_MESSAGE();
        RAISERROR(N'Lỗi khi thêm chi tiết hóa đơn: %s', 16, 1, @ErrorMsg);
    END CATCH
END
 -- Kiểm thử
EXEC ThemCTHD 
    @SoHD = 'HD009', 
    @MaSP = 'SP006', 
    @SoLuongHD = 1,
	@PhanTramVAT = 0.08
SELECT
    SoHD AS [Số Hóa Đơn],
    MaSP AS [Mã Sản Phẩm],
    SoLuongHD AS [Số Lượng],
    DonGiaHD AS [Đơn Giá (Chưa giảm)],
	GiamGiaSP AS [Mức Giảm Giá],
    TTienHD AS [Thành Tiền (Đã giảm)]
FROM
    CTHD;
SELECT
    SoHD AS [Số Hóa Đơn],
    MaKH AS [Mã Khách Hàng],
    MaNV AS [Mã Nhân Viên],
    NgayLapHD AS [Ngày Lập Hóa Đơn],
    TriGiaTruocThue AS [Tổng Tiền Trước Thuế],
    VAT AS [Thuế VAT],
    TriGiaSauThue AS [Tổng Tiền Sau Thuế],
    PTTT AS [Phương Thức Thanh Toán],
    NgayTT AS [Ngày Thanh Toán],
    TienCoc AS [Tiền Cọc],
    TrangThaiHD AS [Trạng Thái Hóa Đơn]
FROM
    HoaDon
GO

--Giao dịch 3: Cập nhật hóa đơn
CREATE OR ALTER PROCEDURE CapNhatHoaDon (
    @SoHD VARCHAR(20),  
    @MaKH VARCHAR(20) = NULL,
    @MaNV VARCHAR(20) = NULL,
    @NgayLapHD DATE = NULL,
    @PTTT NVARCHAR(200) = NULL,
    @NgayTT DATE = NULL,
    @TienCoc FLOAT = NULL
)
AS
BEGIN
    SET NOCOUNT ON;
    -- 1. Kiểm tra tồn tại Hóa đơn
    IF NOT EXISTS (SELECT 1 FROM HoaDon WHERE SoHD = @SoHD)
    BEGIN
        RAISERROR(N'Cập nhật KHÔNG thành công: Không tìm thấy Số Hóa đơn %s.', 16, 1, @SoHD);
        RETURN;
    END
    -- 2. Kiểm tra tồn tại Mã Khách hàng
    IF @MaKH IS NOT NULL AND NOT EXISTS (SELECT 1 FROM KhachHang WHERE MaKH = @MaKH)
    BEGIN
        RAISERROR(N'Mã Khách hàng không tồn tại. Vui lòng kiểm tra lại.', 16, 1);
        RETURN;
    END
    -- 3. Kiểm tra tồn tại Mã Nhân viên (nếu được truyền vào)
    IF @MaNV IS NOT NULL AND NOT EXISTS (SELECT 1 FROM NhanVien WHERE MaNV = @MaNV)
    BEGIN
        RAISERROR(N'Mã Nhân viên không tồn tại. Vui lòng kiểm tra lại.', 16, 1);
        RETURN;
    END
    -- Bắt đầu Giao dịch
    BEGIN TRANSACTION;
    BEGIN TRY
        -- Cập nhật dữ liệu
        UPDATE HoaDon
        SET
            MaKH = ISNULL(@MaKH, MaKH),
            MaNV = ISNULL(@MaNV, MaNV),
            NgayLapHD = ISNULL(@NgayLapHD, NgayLapHD),
            PTTT = ISNULL(@PTTT, PTTT),
            NgayTT = ISNULL(@NgayTT, NgayTT),
            TienCoc = ISNULL(@TienCoc, TienCoc)
        WHERE
            SoHD = @SoHD;
        -- Xác nhận giao dịch
        COMMIT TRANSACTION;
        PRINT N'Cập nhật Hóa đơn ' + @SoHD + N' thành công.';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
 -- Kiểm thử
EXEC CapNhatHoaDon 
    @SoHD = 'HD009', 
    @PTTT = N'Chuyển khoản'
SELECT
    SoHD AS [Số Hóa Đơn],
    MaKH AS [Mã Khách Hàng],
    MaNV AS [Mã Nhân Viên],
    NgayLapHD AS [Ngày Lập Hóa Đơn],
    TriGiaTruocThue AS [Tổng Tiền Trước Thuế],
    VAT AS [Thuế VAT],
    TriGiaSauThue AS [Tổng Tiền Sau Thuế],
    PTTT AS [Phương Thức Thanh Toán],
    NgayTT AS [Ngày Thanh Toán],
    TienCoc AS [Tiền Cọc],
    TrangThaiHD AS [Trạng Thái Hóa Đơn]
FROM
    HoaDon
GO

--Tạo login
CREATE OR ALTER PROCEDURE TaoLogin
    @TenLogin  sysname,
    @MatKhau   NVARCHAR(128)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @SQL NVARCHAR(MAX);
    DECLARE @EscapedMatKhau NVARCHAR(256); 
    -- 1. Kiểm tra xem Login đã tồn tại chưa
    IF NOT EXISTS (
        SELECT 1 FROM sys.server_principals
        WHERE name = @TenLogin AND type = 'S' 
    )
    BEGIN
        -- 2. Xử lý SQL Injection cho mật khẩu
        SET @EscapedMatKhau = REPLACE(@MatKhau, '''', '''''');
        -- 3. Xây dựng câu lệnh SQL động
        SET @SQL = N'CREATE LOGIN ' + QUOTENAME(@TenLogin) + N'
                     WITH PASSWORD = N''' + @EscapedMatKhau + N''', 
                          CHECK_POLICY = ON, CHECK_EXPIRATION = ON,
                          DEFAULT_DATABASE = [LnL_SQL];';
        -- 4. Thực thi
        EXEC sp_executesql @SQL;
        PRINT N'Đã tạo Login thành công: ' + @TenLogin;
    END
    ELSE
    BEGIN
        PRINT N'Login đã tồn tại: ' + @TenLogin;
    END
END
 --Kiểm thử
EXEC TaoLogin 
    @TenLogin = N'LnL_QUANLY', 
    @MatKhau = N'QL!NV004';
EXEC TaoLogin 
    @TenLogin = N'LnL_BANHANG', 
    @MatKhau = N'BH!NV005';
GO

--Tạo user và gán login
CREATE OR ALTER PROCEDURE TaoUser
    @TenLogin NVARCHAR(128),
    @TenUser NVARCHAR(128)
AS
BEGIN
    SET NOCOUNT ON;
    -- Khai báo biến cho chuỗi động
    DECLARE @SQL NVARCHAR(MAX);
    -- 1. Kiểm tra Login Server phải TỒN TẠI
    IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = @TenLogin)
    BEGIN
        PRINT N'Lỗi: LOGIN Server "' + @TenLogin + N'" không tồn tại. Vui lòng tạo Login trước.';
        RETURN; 
    END
    -- 2. Kiểm tra User Database đã tồn tại chưa
    IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = @TenUser)
    BEGIN
        -- 3. Xây dựng và thực thi chuỗi động
        SET @SQL = N'CREATE USER ' + QUOTENAME(@TenUser) + N' FOR LOGIN ' + QUOTENAME(@TenLogin) + N';';
        EXEC sp_executesql @SQL;
        PRINT N'Đã tạo User thành công cho Login "' + @TenLogin + N'": ' + @TenUser;
    END
    ELSE
    BEGIN
        PRINT N'User đã tồn tại: ' + @TenUser;
    END
END
  --Kiểm thử
EXEC TaoUser 
    @TenLogin = N'LnL_QUANLY', 
    @TenUser = N'duypham_qly';
EXEC TaoUser 
    @TenLogin = N'LnL_BANHANG', 
    @TenUser = N'thaongo_banhang';
GO

--Tạo role
CREATE OR ALTER PROCEDURE TaoRole
    @TenRole NVARCHAR(128)
AS
BEGIN
    SET NOCOUNT ON;
    -- Khai báo biến cho chuỗi động
    DECLARE @SQL NVARCHAR(MAX);
    -- 1. Kiểm tra xem Role đã tồn tại trong Database chưa
    IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = @TenRole AND type = 'R') -- type = 'R' là cho Database Role
    BEGIN
        -- 2. Xây dựng chuỗi động
        SET @SQL = N'CREATE ROLE ' + QUOTENAME(@TenRole) + N';';
        -- 3. Thực thi chuỗi động
        EXEC sp_executesql @SQL;
        PRINT N'Đã tạo Role thành công: ' + @TenRole;
    END
    ELSE
    BEGIN
        PRINT N'Role đã tồn tại: ' + @TenRole;
    END
END
  --Kiểm thử
EXEC TaoRole 
    @TenRole = N'ROLE_QUANLY';
EXEC TaoRole 
    @TenRole = N'ROLE_BANHANG';
GO;

--Gán user vào role
CREATE OR ALTER PROCEDURE GanUserVaoRole
    @TenUser NVARCHAR(128),  -- User cần được gán
    @TenRole NVARCHAR(128)   -- Role mà User sẽ trở thành thành viên
AS
BEGIN
    SET NOCOUNT ON;
    -- Khai báo biến cho chuỗi động
    DECLARE @SQL NVARCHAR(MAX);
    -- 1. Kiểm tra User có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = @TenUser AND type IN ('S', 'U', 'G'))
    BEGIN
        PRINT N'Lỗi: USER "' + @TenUser + N'" không tồn tại trong Database này.';
        RETURN;
    END
    -- 2. Kiểm tra Role có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = @TenRole AND type = 'R')
    BEGIN
        PRINT N'Lỗi: ROLE "' + @TenRole + N'" không tồn tại trong Database này.';
        RETURN;
    END
    -- 3. Kiểm tra xem User đã là thành viên của Role chưa
    IF EXISTS (
        SELECT 1
        FROM sys.database_role_members AS drm
        JOIN sys.database_principals AS dp ON drm.member_principal_id = dp.principal_id
        JOIN sys.database_principals AS dr ON drm.role_principal_id = dr.principal_id
        WHERE dp.name = @TenUser AND dr.name = @TenRole
    )
    BEGIN
        PRINT N'USER "' + @TenUser + N'" đã là thành viên của ROLE "' + @TenRole + N'".';
        RETURN;
    END
    -- 4. Xây dựng và thực thi chuỗi động để gán User vào Role
    SET @SQL = N'ALTER ROLE ' + QUOTENAME(@TenRole) + N' ADD MEMBER ' + QUOTENAME(@TenUser) + N';';
    EXEC sp_executesql @SQL;
    PRINT N'Đã gán thành công USER "' + @TenUser + N'" vào ROLE "' + @TenRole + N'".';
END
  --Kiểm thử
EXEC GanUserVaoRole 
    @TenUser = N'duypham_qly', 
    @TenRole = N'ROLE_QUANLY';
EXEC GanUserVaoRole 
    @TenUser = N'thaongo_banhang', 
    @TenRole = N'ROLE_BANHANG';
GO;

--Cấp quyền
CREATE OR ALTER PROCEDURE CapQuyenChoRole
    @LoaiQuyen NVARCHAR(50),        -- Ví dụ: 'SELECT', 'EXECUTE', 'INSERT'
    @TenDoiTuong NVARCHAR(128),     -- Tên đối tượng (ví dụ: 'HoaDon', 'SP_TinhLuong')
    @TenRole NVARCHAR(128)          -- Tên Role nhận quyền
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @SQL NVARCHAR(MAX);
    DECLARE @SchemaName sysname = N'dbo';
    DECLARE @FullDoiTuongName NVARCHAR(257);
    -- 1. Kiểm tra Role có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = @TenRole AND type = 'R')
    BEGIN
        PRINT N'Lỗi: ROLE "' + @TenRole + N'" không tồn tại trong Database này.';
        RETURN;
    END
    -- 2. Xử lý tên đối tượng: Đảm bảo chỉ lấy tên đối tượng nếu tên truyền vào đã có Schema
    SET @FullDoiTuongName = QUOTENAME(@SchemaName) + N'.' + QUOTENAME(@TenDoiTuong);
    -- 3. Kiểm tra đối tượng có tồn tại không
    IF OBJECT_ID(@FullDoiTuongName) IS NULL
    BEGIN
        PRINT N'Lỗi: Đối tượng "' + @FullDoiTuongName + N'" không tồn tại trong Database này hoặc không thuộc schema dbo.';
        RETURN;
    END
    -- 4. Xây dựng câu lệnh GRANT an toàn
    SET @SQL = N'GRANT ' + @LoaiQuyen +
                N' ON ' + @FullDoiTuongName +
                N' TO ' + QUOTENAME(@TenRole) + N';';
    -- 5. Thực thi lệnh
    EXEC sp_executesql @SQL;
    PRINT N'Đã cấp quyền: GRANT ' + @LoaiQuyen + N' trên đối tượng ' + @FullDoiTuongName + N' cho ROLE ' + @TenRole;
END
  --Kiểm thử
EXEC CapQuyenChoRole
    @LoaiQuyen = N'SELECT',
    @TenDoiTuong = N'vw_ThongTin_NV',
    @TenRole = N'ROLE_QUANLY';
EXEC CapQuyenChoRole
    @LoaiQuyen = N'SELECT',
    @TenDoiTuong = N'vw_BaoCaoTonKho_Thang',
    @TenRole = N'ROLE_QUANLY';
EXEC CapQuyenChoRole
    @LoaiQuyen = N'SELECT',
    @TenDoiTuong = N'vw_DoanhSo_ChiNhanh',
    @TenRole = N'ROLE_QUANLY';
EXEC CapQuyenChoRole
    @LoaiQuyen = N'SELECT',
    @TenDoiTuong = N'vw_TongSLBan',
    @TenRole = N'ROLE_QUANLY';
EXEC CapQuyenChoRole
    @LoaiQuyen = N'SELECT',
    @TenDoiTuong = N'vw_Top5_SanPhamBanChay',
    @TenRole = N'ROLE_QUANLY';
EXEC CapQuyenChoRole
    @LoaiQuyen = N'EXECUTE',
    @TenDoiTuong = N'fn_BaoCaoTonKhoChiTiet',
    @TenRole = N'ROLE_QUANLY';
EXEC CapQuyenChoRole
    @LoaiQuyen = N'EXECUTE',
    @TenDoiTuong = N'fn_ThongKeKhachHangTheoDoTuoi',
    @TenRole = N'ROLE_QUANLY';
EXEC CapQuyenChoRole
    @LoaiQuyen = N'EXECUTE',
    @TenDoiTuong = N'CapNhatGiaBanSP',
    @TenRole = N'ROLE_QUANLY';
EXEC CapQuyenChoRole
    @LoaiQuyen = N'EXECUTE',
    @TenDoiTuong = N'BaoCaoDoanhThuBanHang',
    @TenRole = N'ROLE_QUANLY';
EXEC CapQuyenChoRole
    @LoaiQuyen = N'EXECUTE',
    @TenDoiTuong = N'BaoCaoDiemTichLuyKhachHang',
    @TenRole = N'ROLE_QUANLY';
EXEC CapQuyenChoRole
    @LoaiQuyen = N'SELECT, INSERT, UPDATE',
    @TenDoiTuong = N'NhanVien',
    @TenRole = N'ROLE_QUANLY';

EXEC CapQuyenChoRole
    @LoaiQuyen = N'EXECUTE',
    @TenDoiTuong = N'fn_TinhTongGiaTriHoaDon',
    @TenRole = N'ROLE_BANHANG';
EXEC CapQuyenChoRole
    @LoaiQuyen = N'EXECUTE',
    @TenDoiTuong = N'fn_LayGiaBanHienTai',
    @TenRole = N'ROLE_BANHANG';
EXEC CapQuyenChoRole
    @LoaiQuyen = N'EXECUTE',
    @TenDoiTuong = N'LayDS_CTKM_DangDienRa',
    @TenRole = N'ROLE_BANHANG';
EXEC CapQuyenChoRole
    @LoaiQuyen = N'EXECUTE',
    @TenDoiTuong = N'KiemTraSPDangGiamGia',
    @TenRole = N'ROLE_BANHANG';
EXEC CapQuyenChoRole
    @LoaiQuyen = N'EXECUTE',
    @TenDoiTuong = N'LayDSSanPhamTheoLoai',
    @TenRole = N'ROLE_BANHANG';
EXEC CapQuyenChoRole
    @LoaiQuyen = N'EXECUTE',
    @TenDoiTuong = N'ThemHoaDon',
    @TenRole = N'ROLE_BANHANG';
EXEC CapQuyenChoRole
    @LoaiQuyen = N'EXECUTE',
    @TenDoiTuong = N'ThemCTHD',
    @TenRole = N'ROLE_BANHANG';
EXEC CapQuyenChoRole
    @LoaiQuyen = N'SELECT, INSERT, UPDATE',
    @TenDoiTuong = N'KhachHang',
    @TenRole = N'ROLE_BANHANG';
GO

--Thu hồi quyền
CREATE OR ALTER PROCEDURE ThuHoiQuyenKhoiRole
    @LoaiQuyen NVARCHAR(50),
    @DoiTuong NVARCHAR(128),
    @TenRole NVARCHAR(128)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @SQL NVARCHAR(MAX);
    DECLARE @ObjectScope NVARCHAR(10) = N'OBJECT::';
    IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = @TenRole AND type = 'R')
    BEGIN
        PRINT N'Lỗi: ROLE "' + @TenRole + N'" không tồn tại trong Database này.';
        RETURN;
    END
    -- Xây dựng câu lệnh REVOKE
    SET @SQL = N'REVOKE ' + @LoaiQuyen +
               N' ON ' + @ObjectScope + QUOTENAME(@DoiTuong) +
               N' FROM ' + QUOTENAME(@TenRole) + N';';
    -- Thực thi lệnh
    EXEC sp_executesql @SQL;
    PRINT N'Đã thu hồi quyền: REVOKE ' + @LoaiQuyen + N' trên ' + @DoiTuong + N' khỏi ROLE ' + @TenRole;
END
  --Kiểm thử
EXEC ThuHoiQuyenKhoiRole
    @LoaiQuyen = N'EXECUTE',
    @DoiTuong = N'CapNhatGiaBanSP',
    @TenRole = N'ROLE_QUANLY';
EXEC ThuHoiQuyenKhoiRole
    @LoaiQuyen = N'EXECUTE',
    @DoiTuong = N'fn_LayGiaBanHienTai',
    @TenRole = N'ROLE_BANHANG';
GO

--Từ chối quyền
CREATE OR ALTER PROCEDURE TuChoiQuyenChoRole
    @LoaiQuyen NVARCHAR(50),
    @DoiTuong NVARCHAR(128),
    @TenRole NVARCHAR(128)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @SQL NVARCHAR(MAX);
    DECLARE @ObjectScope NVARCHAR(10) = N'OBJECT::';
    IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = @TenRole AND type = 'R')
    BEGIN
        PRINT N'Lỗi: ROLE "' + @TenRole + N'" không tồn tại trong Database này.';
        RETURN;
    END
    -- Xây dựng câu lệnh DENY
    SET @SQL = N'DENY ' + @LoaiQuyen +
               N' ON ' + @ObjectScope + QUOTENAME(@DoiTuong) +
               N' TO ' + QUOTENAME(@TenRole) + N';';
    -- Thực thi lệnh
    EXEC sp_executesql @SQL;
    PRINT N'Đã từ chối quyền: DENY ' + @LoaiQuyen + N' trên ' + @DoiTuong + N' cho ROLE ' + @TenRole;
END
  --Kiểm thử
EXEC TuChoiQuyenChoRole
    @LoaiQuyen = N'DELETE',
    @DoiTuong = N'HoaDon',
    @TenRole = N'ROLE_QUANLY';
EXEC TuChoiQuyenChoRole
    @LoaiQuyen = N'DELETE',
    @DoiTuong = N'HoaDon',
    @TenRole = N'ROLE_BANHANG';
GO

--Tạo audit log
CREATE TABLE AuditLog (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    UserName NVARCHAR(100),
    Action NVARCHAR(200),
    TimeStamp DATETIME DEFAULT GETDATE()
);
GO
  --Kiểm thử
SELECT * from AuditLog;

--Giao dịch với cơ chế khóa và mức độ cô lập
--Giao dịch 1
--Phiên 1
SELECT NhapTK, XuatTK FROM TonKho WHERE MaKho = 'KHO01' AND MaSP = 'SP002';
SET TRANSACTION ISOLATION LEVEL READ COMMITTED; BEGIN TRAN
UPDATE TonKho SET NhapTK = NhapTK + 50 WHERE MaKho = 'KHO01' AND MaSP = 'SP002';
COMMIT;
SELECT NhapTK, XuatTK FROM TonKho WHERE MaKho = 'KHO01' AND MaSP = 'SP002';
--Phiên 2
SET TRANSACTION ISOLATION LEVEL READ COMMITTED; 
BEGIN TRAN
UPDATE TonKho SET XuatTK = XuatTK + 20 WHERE MaKho = 'KHO01' AND MaSP = 'SP002';
COMMIT;

--Giao dịch 2
--Phiên 1
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE; 
BEGIN TRAN
SELECT COUNT(*) AS [Tổng số lượng nhân viên]
FROM NhanVien WHERE MaCV = 'CV004';
COMMIT;
SELECT COUNT(*) AS [Tổng số lượng nhân viên]
FROM NhanVien WHERE MaCV = 'CV004';
--Phiên 2
SET TRANSACTION ISOLATION LEVEL READ COMMITTED; 
BEGIN TRAN
INSERT INTO NhanVien (MaNV, MaBP, MaCV, TenNV, SDTNV, EmailNV, TrangThaiNV) 
VALUES ('NV014', N'BP002', N'CV004', N'Nguyễn Thị Duong', '012345678', 'duong.nguyen@cuahang.com', N'Đang làm việc');
COMMIT; 





