-- Tạo database và sử dụng
CREATE DATABASE HyperWalk;
GO
USE HyperWalk;
GO

-- Bảng nhân viên
CREATE TABLE NhanVien (
	id INT PRIMARY KEY IDENTITY(1,1),
	ma_nhan_vien VARCHAR(20),
	ho_ten_nv NVARCHAR(100),
	email VARCHAR(255) UNIQUE NOT NULL,
	password VARCHAR(255) NOT NULL,
	sdt VARCHAR(15),
	gioi_tinh INT,  -- 1. nam, 2. nữ, 3. why are you gay?
	ngay_sinh DATE,
	cccd VARCHAR(12),
	ngay_dang_ky DATETIME DEFAULT GETDATE(),
	role INT,
	avatar VARCHAR(255),
	create_at DATETIME DEFAULT GETDATE(),
	create_by NVARCHAR(100),
	update_at DATETIME DEFAULT GETDATE(),
	update_by NVARCHAR(100),
	is_deleted BIT,
	trang_thai BIT
);

-- Bảng khách hàng
CREATE TABLE KhachHang (
	id INT PRIMARY KEY IDENTITY(1,1),
	ho_ten_kh NVARCHAR(100),
	email VARCHAR(255) UNIQUE NOT NULL,
	password VARCHAR(255) NOT NULL,
	sdt VARCHAR(15),
	ngay_dang_ky DATETIME DEFAULT GETDATE(),
	create_at DATETIME DEFAULT GETDATE(),
	create_by NVARCHAR(100),
	update_at DATETIME DEFAULT GETDATE(),
	update_by NVARCHAR(100),
	is_deleted BIT,
	trang_thai BIT
);

-- Bảng địa chỉ giao hàng
CREATE TABLE DiaChiGiaoHang (
    id INT PRIMARY KEY IDENTITY(1,1),
    dia_chi NVARCHAR(500),
    mac_dinh BIT DEFAULT 0,
	sdt_dia_chi VARCHAR(15),
	create_at DATETIME DEFAULT GETDATE(),
	create_by NVARCHAR(100),
	update_at DATETIME DEFAULT GETDATE(),
	update_by NVARCHAR(100),
	is_deleted BIT,
    id_khach_hang INT,
    FOREIGN KEY (id_khach_hang) REFERENCES KhachHang(id)
);

-- Bảng voucher
CREATE TABLE Voucher (
    id INT PRIMARY KEY IDENTITY(1,1),
    ma_voucher VARCHAR(20),
    ten_voucher NVARCHAR(100),
    hinh_thuc_giam INT NOT NULL,
    muc_giam DECIMAL(18,2) NOT NULL CHECK (muc_giam >= 0),
    gia_tri_don_hang_toi_thieu DECIMAL(18,2) NOT NULL CHECK (gia_tri_don_hang_toi_thieu >= 0),
    so_luong INT NOT NULL DEFAULT 0 CHECK (so_luong >= 0),
    ngay_bat_dau DATE NOT NULL,
    ngay_ket_thuc DATE NOT NULL,
	create_at DATETIME DEFAULT GETDATE(),
	create_by NVARCHAR(100),
	update_at DATETIME DEFAULT GETDATE(),
	update_by NVARCHAR(100),
	is_deleted BIT,
    trang_thai INT,
    CHECK (ngay_ket_thuc >= ngay_bat_dau)
);

-- Các bảng thuộc tính giày
CREATE TABLE MauSacVaAnhGiay (
    id INT PRIMARY KEY IDENTITY(1,1),
	ma_mau VARCHAR(20) UNIQUE NOT NULL, -- Thêm mã màu duy nhất
	anh_giay VARCHAR(255),
    mau_sac NVARCHAR(100),
	create_at DATETIME DEFAULT GETDATE(),
	create_by NVARCHAR(100),
	update_at DATETIME DEFAULT GETDATE(),
	update_by NVARCHAR(100),
	is_deleted BIT
);

CREATE TABLE Size (
    id INT PRIMARY KEY IDENTITY(1,1),
    size NVARCHAR(100),
	create_at DATETIME DEFAULT GETDATE(),
	create_by NVARCHAR(100),
	update_at DATETIME DEFAULT GETDATE(),
	update_by NVARCHAR(100),
	is_deleted BIT
);

CREATE TABLE ChatLieu (
	id INT PRIMARY KEY IDENTITY(1,1),
	chat_lieu NVARCHAR(100),
	create_at DATETIME DEFAULT GETDATE(),
	create_by NVARCHAR(100),
	update_at DATETIME DEFAULT GETDATE(),
	update_by NVARCHAR(100),
	is_deleted BIT
);

CREATE TABLE DeGiay (
	id INT PRIMARY KEY IDENTITY(1,1),
	de_giay NVARCHAR(100),
	create_at DATETIME DEFAULT GETDATE(),
	create_by NVARCHAR(100),
	update_at DATETIME DEFAULT GETDATE(),
	update_by NVARCHAR(100),
	is_deleted BIT
);

CREATE TABLE Hang (
	id INT PRIMARY KEY IDENTITY(1,1),
	hang NVARCHAR(100),
	create_at DATETIME DEFAULT GETDATE(),
	create_by NVARCHAR(100),
	update_at DATETIME DEFAULT GETDATE(),
	update_by NVARCHAR(100),
	is_deleted BIT
);

CREATE TABLE DanhMuc (
	id INT PRIMARY KEY IDENTITY(1,1),
	danh_muc NVARCHAR(100),
	create_at DATETIME DEFAULT GETDATE(),
	create_by NVARCHAR(100),
	update_at DATETIME DEFAULT GETDATE(),
	update_by NVARCHAR(100),
	is_deleted BIT
);

-- Bảng giày
CREATE TABLE Giay (
    id INT PRIMARY KEY IDENTITY(1,1),
    ma_giay VARCHAR(20),
    ten_giay NVARCHAR(100),
    trang_thai BIT,
	create_at DATETIME DEFAULT GETDATE(),
	create_by NVARCHAR(100),
	update_at DATETIME DEFAULT GETDATE(),
	update_by NVARCHAR(100),
	is_deleted BIT
);

-- Bảng chi tiết giày
CREATE TABLE ChiTietGiay (
    id INT PRIMARY KEY IDENTITY(1,1),
    ma_chi_tiet_giay VARCHAR(20),
    gia_ban DECIMAL(18,2),
    ghi_chu NVARCHAR(255),
    so_luong INT NOT NULL DEFAULT 0 CHECK (so_luong >= 0),
    trang_thai BIT,
	create_at DATETIME DEFAULT GETDATE(),
	create_by NVARCHAR(100),
	update_at DATETIME DEFAULT GETDATE(),
	update_by NVARCHAR(100),
	is_deleted BIT,
    id_giay INT,
    id_mau_sac_va_anh_giay INT,
    id_size INT,
	id_chat_lieu INT,
	id_de_giay INT,
	id_hang INT,
	id_danh_muc INT,
    FOREIGN KEY (id_giay) REFERENCES Giay(id),
    FOREIGN KEY (id_mau_sac_va_anh_giay) REFERENCES MauSacVaAnhGiay(id),
	FOREIGN KEY (id_size) REFERENCES Size(id),
    FOREIGN KEY (id_chat_lieu) REFERENCES ChatLieu(id),
	FOREIGN KEY (id_de_giay) REFERENCES DeGiay(id),
	FOREIGN KEY (id_hang) REFERENCES Hang(id),
	FOREIGN KEY (id_danh_muc) REFERENCES DanhMuc(id)
);

-- Bảng giỏ hàng
CREATE TABLE GioHang (
    id INT PRIMARY KEY IDENTITY(1,1),
    ngay_tao DATETIME DEFAULT GETDATE(),
	create_at DATETIME DEFAULT GETDATE(),
	create_by NVARCHAR(100),
	update_at DATETIME DEFAULT GETDATE(),
	update_by NVARCHAR(100),
	is_deleted BIT,
	id_giay INT,
	id_khach_hang INT,
    FOREIGN KEY (id_khach_hang) REFERENCES KhachHang(id),
	FOREIGN KEY (id_giay) REFERENCES Giay(id)
);

-- Bảng doanh thu
CREATE TABLE DoanhThu (
	id INT PRIMARY KEY IDENTITY(1,1),
    ma_doanh_thu VARCHAR(20) UNIQUE NOT NULL,
    thang INT NOT NULL CHECK (thang BETWEEN 1 AND 12),
    nam INT NOT NULL CHECK (nam > 0),
    tien_doanh_thu DECIMAL(18,2) NOT NULL CHECK (tien_doanh_thu >= 0),
	create_at DATETIME DEFAULT GETDATE(),
	create_by NVARCHAR(100),
	update_at DATETIME DEFAULT GETDATE(),
	update_by NVARCHAR(100),
	is_deleted BIT
);

-- Bảng hóa đơn
CREATE TABLE HoaDon (
    id INT PRIMARY KEY IDENTITY(1,1),
    ma_hoa_don VARCHAR(20),
    loai_hoa_don INT,  -- 1. tại quầy, 2. vận chuyển
    ngay_tao DATETIME DEFAULT GETDATE(),
    tong_tien DECIMAL(18,2),
    phi_van_chuyen DECIMAL(18,2),
    so_tien_giam DECIMAL(18,2),
    thanh_tien DECIMAL(18,2),
    hinh_thuc_thanh_toan INT,  -- 1. chuyển khoản, 2. tiền mặt
    trang_thai INT,  -- 1. chờ xác nhân, 2. chuẩn bị giao, 3. đang giao hàng, 4. đã giao hàng, 5. đã nhận hàng, || 6. đã hủy
	create_at DATETIME DEFAULT GETDATE(),
	create_by NVARCHAR(100),
	update_at DATETIME DEFAULT GETDATE(),
	update_by NVARCHAR(100),
	is_deleted BIT,
    xac_nhan_hoa_don BIT,  -- 1. đã nhận được hàng, 0. chưa nhận được hàng
    id_voucher INT,
    id_nhan_vien INT,
    id_khach_hang INT NULL,
    id_dia_chi_giao_hang INT,
    id_doanh_thu INT,
    FOREIGN KEY (id_voucher) REFERENCES Voucher(id),
    FOREIGN KEY (id_nhan_vien) REFERENCES NhanVien(id),
    FOREIGN KEY (id_khach_hang) REFERENCES KhachHang(id),
    FOREIGN KEY (id_dia_chi_giao_hang) REFERENCES DiaChiGiaoHang(id),
    FOREIGN KEY (id_doanh_thu) REFERENCES DoanhThu(id)
);

-- Bảng chi tiết hóa đơn
CREATE TABLE HoaDonChiTiet (
    id INT PRIMARY KEY IDENTITY(1,1),
    ma_hdct VARCHAR(20),
	gia_mua DECIMAL(18, 2),
    so_luong INT NOT NULL CHECK (so_luong > 0),
	create_at DATETIME DEFAULT GETDATE(),
	create_by NVARCHAR(100),
	update_at DATETIME DEFAULT GETDATE(),
	update_by NVARCHAR(100),
	is_deleted BIT,
    id_hoa_don INT,
    id_chi_tiet_giay INT,
    FOREIGN KEY (id_hoa_don) REFERENCES HoaDon(id),
    FOREIGN KEY (id_chi_tiet_giay) REFERENCES ChiTietGiay(id)
);

-- Bảng lịch sử mua hàng
CREATE TABLE LichSuMuaHang (
    id INT PRIMARY KEY IDENTITY(1,1),
    ma_lich_su VARCHAR(20),
    ngay_mua DATETIME DEFAULT GETDATE(),
    tong_tien DECIMAL(18,2) NOT NULL CHECK (tong_tien >= 0),
    trang_thai INT NOT NULL,
	create_at DATETIME DEFAULT GETDATE(),
	create_by NVARCHAR(100),
	update_at DATETIME DEFAULT GETDATE(),
	update_by NVARCHAR(100),
	is_deleted BIT,
	id_khach_hang INT NULL,
    id_hoa_don INT,
    FOREIGN KEY (id_khach_hang) REFERENCES KhachHang(id),
    FOREIGN KEY (id_hoa_don) REFERENCES HoaDon(id)
);

-- Bảng đánh giá
CREATE TABLE DanhGia (
    id INT PRIMARY KEY IDENTITY(1,1),
    ma_danh_gia VARCHAR(20) UNIQUE NOT NULL,
    binh_luan NVARCHAR(500),
    danh_gia_sao INT NOT NULL CHECK (danh_gia_sao BETWEEN 1 AND 5),  -- từ 1 -> 5
    danh_gia_huu_ich INT DEFAULT 0 CHECK (danh_gia_huu_ich >= 0),
    danh_gia_khong_huu_ich INT DEFAULT 0 CHECK (danh_gia_khong_huu_ich >= 0),
	create_at DATETIME DEFAULT GETDATE(),
	create_by NVARCHAR(100),
	update_at DATETIME DEFAULT GETDATE(),
	update_by NVARCHAR(100),
	is_deleted BIT,
    id_hoa_don_chi_tiet INT,
    id_khach_hang INT NULL,
    FOREIGN KEY (id_hoa_don_chi_tiet) REFERENCES HoaDonChiTiet(id),
    FOREIGN KEY (id_khach_hang) REFERENCES KhachHang(id)
);

-- Bảng hỗ trợ
CREATE TABLE HoTro (
	id INT PRIMARY KEY IDENTITY(1,1),
	ma_ho_tro VARCHAR(20) UNIQUE NOT NULL,
	van_de_ho_tro NVARCHAR(50) NOT NULL,
	mo_ta_van_de NVARCHAR(500) NOT NULL,
	ngay_gui DATETIME DEFAULT GETDATE(),
	trang_thai_ht INT NOT NULL CHECK (trang_thai_ht IN (1, 2, 3)),  -- 1. vẫn đề chưa được giải quyết, 2. vấn đề đang được giải quyết, 3. vấn đề đã được giải quyết
	create_at DATETIME DEFAULT GETDATE(),
	create_by NVARCHAR(100),
	update_at DATETIME DEFAULT GETDATE(),
	update_by NVARCHAR(100),
	is_deleted BIT,
	id_khach_hang INT,
	FOREIGN KEY (id_khach_hang) REFERENCES KhachHang(id)
);

-- Bảng phản hồi
CREATE TABLE PhanHoi (
	id INT PRIMARY KEY IDENTITY(1,1),
	ma_phan_hoi VARCHAR(20),
	van_de_phan_hoi NVARCHAR(500) NOT NULL,
	ngay_gui DATETIME DEFAULT GETDATE(),
	create_at DATETIME DEFAULT GETDATE(),
	create_by NVARCHAR(100),
	update_at DATETIME DEFAULT GETDATE(),
	update_by NVARCHAR(100),
	is_deleted BIT,
	id_ho_tro INT,
	id_nhan_vien INT,
	FOREIGN KEY (id_ho_tro) REFERENCES HoTro(id),
	FOREIGN KEY (id_nhan_vien) REFERENCES NhanVien(id)
);

-- Insert data for NhanVien (bao gồm cccd, create_at, create_by, update_at, update_by)
INSERT INTO NhanVien(ma_nhan_vien, ho_ten_nv, email, password, sdt, gioi_tinh, ngay_sinh, cccd, role, avatar, create_at, create_by, update_at, update_by, is_deleted, trang_thai)
VALUES
    ('NV001', N'Vũ Việt Nghĩa', 'vuvietnghia23@gmail.com', '123456', '0886545918', 1, '2005-10-28', '123456789012', 1, NULL, '2025-06-05 10:00:00', N'System', '2025-06-05 10:00:00', N'System', 0, 1),
    ('NV002', N'Dương Cao Kỳ', 'kydc@gmail.com', 'abcxyz', '0903781234', 2, '2005-03-15', '234567890123', 2, NULL, '2025-06-05 10:15:00', N'System', '2025-06-05 10:15:00', N'System', 0, 1),
    ('NV003', N'Nguyễn Sỹ Phong', 'phongns@gmail.com', '098765', '0365987412', 1, '2005-11-28', '345678901234', 2, NULL, '2025-06-05 10:30:00', N'System', '2025-06-05 10:30:00', N'System', 0, 1),
    ('NV004', N'Nguyên Xuân Tùng', 'tungnx@gmail.com', 'qwert', '0772548963', 2, '2003-12-20', '456789012345', 2, NULL, '2025-06-05 10:45:00', N'System', '2025-06-05 10:45:00', N'System', 0, 1),
    ('NV005', N'Ngô Tiên Tùng', 'tungnt@gmail.com', 'asdfgh', '0899123076', 2, '2005-07-04', '567890123456', 2, NULL, '2025-06-05 11:00:00', N'System', '2025-06-05 11:00:00', N'System', 0, 1);
GO

-- Insert data for KhachHang
INSERT INTO KhachHang(ho_ten_kh, email, password, sdt, ngay_dang_ky, create_at, create_by, update_at, update_by, is_deleted, trang_thai)
VALUES
    (N'Nguyễn Văn An', 'nguyenvanan@gmail.com', '123456', '0912345678', '2025-06-05 09:00:00', '2025-06-05 09:00:00', N'System', '2025-06-05 09:00:00', N'System', 0, 1),
    (N'Trần Thị Bình', 'tranthibinh@gmail.com', 'password123', '0923456789', '2025-06-05 09:15:00', '2025-06-05 09:15:00', N'System', '2025-06-05 09:15:00', N'System', 0, 1),
    (N'Lê Hoàng Cường', 'lehoangcuong@gmail.com', 'cuong2023', '0934567890', '2025-06-05 09:30:00', '2025-06-05 09:30:00', N'System', '2025-06-05 09:30:00', N'System', 0, 1),
    (N'Phạm Thị Dung', 'phamthidung@gmail.com', 'dungpham', '0945678901', '2025-06-05 09:45:00', '2025-06-05 09:45:00', N'System', '2025-06-05 09:45:00', N'System', 0, 1),
    (N'Võ Minh Đức', 'vominhduc@gmail.com', 'minhduc', '0956789012', '2025-06-05 10:00:00', '2025-06-05 10:00:00', N'System', '2025-06-05 10:00:00', N'System', 0, 1);
GO

-- Insert data for DiaChiGiaoHang
INSERT INTO DiaChiGiaoHang(dia_chi, mac_dinh, sdt_dia_chi, create_at, create_by, update_at, update_by, is_deleted, id_khach_hang)
VALUES
    (N'123 Đường Lê Lợi, Quận 1, TP.HCM', 1, '0886545918', '2025-06-05 10:00:00', N'Nguyễn Văn An', '2025-06-05 10:00:00', N'Nguyễn Văn An', 0, 1),
    (N'456 Đường Nguyễn Huệ, Quận 1, TP.HCM', 0, '0887001234', '2025-06-05 10:15:00', N'Nguyễn Văn An', '2025-06-05 10:15:00', N'Nguyễn Văn An', 0, 1),
    (N'789 Đường Trần Hưng Đạo, Quận 5, TP.HCM', 1, '0887012345', '2025-06-05 10:30:00', N'Trần Thị Bình', '2025-06-05 10:30:00', N'Trần Thị Bình', 0, 2),
    (N'321 Đường Võ Văn Tần, Quận 3, TP.HCM', 1, '0887023456', '2025-06-05 10:45:00', N'Lê Hoàng Cường', '2025-06-05 10:45:00', N'Lê Hoàng Cường', 0, 3),
    (N'654 Đường Pasteur, Quận 1, TP.HCM', 1, '0887034567', '2025-06-05 11:00:00', N'Phạm Thị Dung', '2025-06-05 11:00:00', N'Phạm Thị Dung', 0, 4),
    (N'987 Đường Hai Bà Trưng, Quận 1, TP.HCM', 1, '0887045678', '2025-06-05 11:15:00', N'Võ Minh Đức', '2025-06-05 11:15:00', N'Võ Minh Đức', 0, 5);
GO

-- Insert data for Voucher
INSERT INTO Voucher(ma_voucher, ten_voucher, hinh_thuc_giam, muc_giam, gia_tri_don_hang_toi_thieu, so_luong, ngay_bat_dau, ngay_ket_thuc, create_at, create_by, update_at, update_by, is_deleted, trang_thai)
VALUES
    ('VC001', N'Giảm 10% đơn hàng đầu tiên', 1, 10.00, 200000.00, 100, '2024-01-01', '2024-12-31', '2025-06-05 08:00:00', N'Vũ Việt Nghĩa', '2025-06-05 08:00:00', N'Vũ Việt Nghĩa', 0, 2),
    ('VC002', N'Giảm 50k cho đơn từ 500k', 2, 50000.00, 500000.00, 200, '2024-06-01', '2024-12-31', '2025-06-05 08:15:00', N'Vũ Việt Nghĩa', '2025-06-05 08:15:00', N'Vũ Việt Nghĩa', 0, 2),
    ('VC003', N'Giảm 15% Black Friday', 1, 15.00, 300000.00, 50, '2024-11-25', '2024-11-30', '2025-06-05 08:30:00', N'Vũ Việt Nghĩa', '2025-06-05 08:30:00', N'Vũ Việt Nghĩa', 0, 3),
    ('VC004', N'Giảm 100k sinh nhật shop', 2, 100000.00, 800000.00, 30, '2024-03-01', '2024-03-31', '2025-06-05 08:45:00', N'Vũ Việt Nghĩa', '2025-06-05 08:45:00', N'Vũ Việt Nghĩa', 0, 3),
    ('VC005', N'Giảm 20% Tết Nguyên Đán', 1, 20.00, 400000.00, 150, '2025-01-20', '2025-02-10', '2025-06-05 09:00:00', N'Vũ Việt Nghĩa', '2025-06-05 09:00:00', N'Vũ Việt Nghĩa', 0, 1);
GO

-- Insert data for MauSacVaAnhGiay
INSERT INTO MauSacVaAnhGiay(ma_mau, anh_giay, mau_sac, create_at, create_by, update_at, update_by, is_deleted)
VALUES
    ('#000000', 'giay_den_1.jpg', N'Đen', '2025-06-05 09:00:00', N'Vũ Việt Nghĩa', '2025-06-05 09:00:00', N'Vũ Việt Nghĩa', 0),
    ('#FFFFFF', 'giay_trang_1.jpg', N'Trắng', '2025-06-05 09:15:00', N'Vũ Việt Nghĩa', '2025-06-05 09:15:00', N'Vũ Việt Nghĩa', 0),
    ('#000080', 'giay_xanh_1.jpg', N'Xanh navy', '2025-06-05 09:30:00', N'Vũ Việt Nghĩa', '2025-06-05 09:30:00', N'Vũ Việt Nghĩa', 0),
    ('#FF0000', 'giay_do_1.jpg', N'Đỏ', '2025-06-05 09:45:00', N'Vũ Việt Nghĩa', '2025-06-05 09:45:00', N'Vũ Việt Nghĩa', 0),
    ('#8B4513', 'giay_nau_1.jpg', N'Nâu', '2025-06-05 10:00:00', N'Vũ Việt Nghĩa', '2025-06-05 10:00:00', N'Vũ Việt Nghĩa', 0),
    ('#808080', 'giay_xam_1.jpg', N'Xám', '2025-06-05 10:15:00', N'Vũ Việt Nghĩa', '2025-06-05 10:15:00', N'Vũ Việt Nghĩa', 0),
    ('#FFFF00', 'giay_vang_1.jpg', N'Vàng', '2025-06-05 10:30:00', N'Vũ Việt Nghĩa', '2025-06-05 10:30:00', N'Vũ Việt Nghĩa', 0),
    ('#FFC1CC', 'giay_hong_1.jpg', N'Hồng', '2025-06-05 10:45:00', N'Vũ Việt Nghĩa', '2025-06-05 10:45:00', N'Vũ Việt Nghĩa', 0);
GO

-- Insert data for Size
INSERT INTO Size(size, create_at, create_by, update_at, update_by, is_deleted)
VALUES
    ('36', '2025-06-05 09:00:00', N'Vũ Việt Nghĩa', '2025-06-05 09:00:00', N'Vũ Việt Nghĩa', 0),
    ('37', '2025-06-05 09:15:00', N'Vũ Việt Nghĩa', '2025-06-05 09:15:00', N'Vũ Việt Nghĩa', 0),
    ('38', '2025-06-05 09:30:00', N'Vũ Việt Nghĩa', '2025-06-05 09:30:00', N'Vũ Việt Nghĩa', 0),
    ('39', '2025-06-05 09:45:00', N'Vũ Việt Nghĩa', '2025-06-05 09:45:00', N'Vũ Việt Nghĩa', 0),
    ('40', '2025-06-05 10:00:00', N'Vũ Việt Nghĩa', '2025-06-05 10:00:00', N'Vũ Việt Nghĩa', 0),
    ('41', '2025-06-05 10:15:00', N'Vũ Việt Nghĩa', '2025-06-05 10:15:00', N'Vũ Việt Nghĩa', 0),
    ('42', '2025-06-05 10:30:00', N'Vũ Việt Nghĩa', '2025-06-05 10:30:00', N'Vũ Việt Nghĩa', 0),
    ('43', '2025-06-05 10:45:00', N'Vũ Việt Nghĩa', '2025-06-05 10:45:00', N'Vũ Việt Nghĩa', 0),
    ('44', '2025-06-05 11:00:00', N'Vũ Việt Nghĩa', '2025-06-05 11:00:00', N'Vũ Việt Nghĩa', 0),
    ('45', '2025-06-05 11:15:00', N'Vũ Việt Nghĩa', '2025-06-05 11:15:00', N'Vũ Việt Nghĩa', 0);
GO

-- Insert data for ChatLieu
INSERT INTO ChatLieu(chat_lieu, create_at, create_by, update_at, update_by, is_deleted)
VALUES
    (N'Da thật', '2025-06-05 09:00:00', N'Vũ Việt Nghĩa', '2025-06-05 09:00:00', N'Vũ Việt Nghĩa', 0),
    (N'Da tổng hợp', '2025-06-05 09:15:00', N'Vũ Việt Nghĩa', '2025-06-05 09:15:00', N'Vũ Việt Nghĩa', 0),
    (N'Canvas', '2025-06-05 09:30:00', N'Vũ Việt Nghĩa', '2025-06-05 09:30:00', N'Vũ Việt Nghĩa', 0),
    (N'Mesh', '2025-06-05 09:45:00', N'Vũ Việt Nghĩa', '2025-06-05 09:45:00', N'Vũ Việt Nghĩa', 0),
    (N'Vải dệt', '2025-06-05 10:00:00', N'Vũ Việt Nghĩa', '2025-06-05 10:00:00', N'Vũ Việt Nghĩa', 0),
    (N'Suede', '2025-06-05 10:15:00', N'Vũ Việt Nghĩa', '2025-06-05 10:15:00', N'Vũ Việt Nghĩa', 0),
    (N'Nylon', '2025-06-05 10:30:00', N'Vũ Việt Nghĩa', '2025-06-05 10:30:00', N'Vũ Việt Nghĩa', 0);
GO

-- Insert data for DeGiay
INSERT INTO DeGiay(de_giay, create_at, create_by, update_at, update_by, is_deleted)
VALUES
    (N'Đế cao su', '2025-06-05 09:00:00', N'Vũ Việt Nghĩa', '2025-06-05 09:00:00', N'Vũ Việt Nghĩa', 0),
    (N'Đế EVA', '2025-06-05 09:15:00', N'Vũ Việt Nghĩa', '2025-06-05 09:15:00', N'Vũ Việt Nghĩa', 0),
    (N'Đế PU', '2025-06-05 09:30:00', N'Vũ Việt Nghĩa', '2025-06-05 09:30:00', N'Vũ Việt Nghĩa', 0),
    (N'Đế phylon', '2025-06-05 09:45:00', N'Vũ Việt Nghĩa', '2025-06-05 09:45:00', N'Vũ Việt Nghĩa', 0),
    (N'Đế da', '2025-06-05 10:00:00', N'Vũ Việt Nghĩa', '2025-06-05 10:00:00', N'Vũ Việt Nghĩa', 0),
    (N'Đế TPU', '2025-06-05 10:15:00', N'Vũ Việt Nghĩa', '2025-06-05 10:15:00', N'Vũ Việt Nghĩa', 0);
GO

-- Insert data for Hang
INSERT INTO Hang(hang, create_at, create_by, update_at, update_by, is_deleted)
VALUES
    ('Nike', '2025-06-05 09:00:00', N'Vũ Việt Nghĩa', '2025-06-05 09:00:00', N'Vũ Việt Nghĩa', 0),
    ('Adidas', '2025-06-05 09:15:00', N'Vũ Việt Nghĩa', '2025-06-05 09:15:00', N'Vũ Việt Nghĩa', 0),
    ('Puma', '2025-06-05 09:30:00', N'Vũ Việt Nghĩa', '2025-06-05 09:30:00', N'Vũ Việt Nghĩa', 0),
    ('Converse', '2025-06-05 09:45:00', N'Vũ Việt Nghĩa', '2025-06-05 09:45:00', N'Vũ Việt Nghĩa', 0),
    ('Vans', '2025-06-05 10:00:00', N'Vũ Việt Nghĩa', '2025-06-05 10:00:00', N'Vũ Việt Nghĩa', 0),
    ('New Balance', '2025-06-05 10:15:00', N'Vũ Việt Nghĩa', '2025-06-05 10:15:00', N'Vũ Việt Nghĩa', 0),
    ('Reebok', '2025-06-05 10:30:00', N'Vũ Việt Nghĩa', '2025-06-05 10:30:00', N'Vũ Việt Nghĩa', 0),
    ('Fila', '2025-06-05 10:45:00', N'Vũ Việt Nghĩa', '2025-06-05 10:45:00', N'Vũ Việt Nghĩa', 0);
GO

-- Insert data for DanhMuc
INSERT INTO DanhMuc(danh_muc, create_at, create_by, update_at, update_by, is_deleted)
VALUES
    (N'Giày thể thao', '2025-06-05 09:00:00', N'Vũ Việt Nghĩa', '2025-06-05 09:00:00', N'Vũ Việt Nghĩa', 0),
    (N'Giày công sở', '2025-06-05 09:15:00', N'Vũ Việt Nghĩa', '2025-06-05 09:15:00', N'Vũ Việt Nghĩa', 0),
    (N'Giày sneaker', '2025-06-05 09:30:00', N'Vũ Việt Nghĩa', '2025-06-05 09:30:00', N'Vũ Việt Nghĩa', 0),
    (N'Giày chạy bộ', '2025-06-05 09:45:00', N'Vũ Việt Nghĩa', '2025-06-05 09:45:00', N'Vũ Việt Nghĩa', 0),
    (N'Giày bóng đá', '2025-06-05 10:00:00', N'Vũ Việt Nghĩa', '2025-06-05 10:00:00', N'Vũ Việt Nghĩa', 0),
    (N'Giày đi bộ', '2025-06-05 10:15:00', N'Vũ Việt Nghĩa', '2025-06-05 10:15:00', N'Vũ Việt Nghĩa', 0),
    (N'Giày thời trang', '2025-06-05 10:30:00', N'Vũ Việt Nghĩa', '2025-06-05 10:30:00', N'Vũ Việt Nghĩa', 0);
GO

-- Insert data for Giay
INSERT INTO Giay(ma_giay, ten_giay, is_deleted, trang_thai)
VALUES
    ('G001', N'Nike Air Force 1', 0, 1),
    ('G002', N'Adidas Ultraboost 22', 0, 1),
    ('G003', N'Puma RS-X', 0, 1),
    ('G004', N'Converse Chuck Taylor', 0, 1),
    ('G005', N'Vans Old Skool', 0, 1),
    ('G006', N'New Balance 574', 0, 1),
    ('G007', N'Nike Air Max 90', 0, 1),
    ('G008', N'Adidas Stan Smith', 0, 1);
GO

-- Insert data for ChiTietGiay
INSERT INTO ChiTietGiay(ma_chi_tiet_giay, gia_ban, ghi_chu, so_luong, is_deleted, trang_thai, id_giay, id_mau_sac_va_anh_giay, id_size, id_chat_lieu, id_de_giay, id_hang, id_danh_muc)
VALUES
    ('CTG001', 2500000.00, N'Giày thể thao cao cấp', 50, 0, 1, 1, 2, 5, 1, 1, 1, 1),
    ('CTG002', 3200000.00, N'Giày chạy bộ chuyên nghiệp', 30, 0, 1, 2, 1, 6, 4, 2, 2, 4),
    ('CTG003', 1800000.00, N'Giày sneaker thời trang', 40, 0, 1, 3, 4, 4, 2, 1, 3, 3),
    ('CTG004', 1500000.00, N'Giày canvas cổ điển', 60, 0, 1, 4, 2, 7, 3, 1, 4, 1),
    ('CTG005', 2100000.00, N'Giày skateboard', 25, 0, 1, 5, 1, 5, 3, 1, 5, 3),
    ('CTG006', 2800000.00, N'Giày retro running', 35, 0, 1, 6, 6, 6, 5, 2, 6, 4),
    ('CTG007', 2700000.00, N'Giày thể thao Air Max', 45, 0, 1, 7, 3, 5, 4, 1, 1, 1),
    ('CTG008', 2000000.00, N'Giày tennis cổ điển', 55, 0, 1, 8, 2, 4, 1, 1, 2, 2);
GO

-- Insert data for GioHang
INSERT INTO GioHang(ngay_tao, create_at, create_by, update_at, update_by, is_deleted, id_giay, id_khach_hang)
VALUES
    ('2025-06-05 10:00:00', '2025-06-05 10:00:00', N'Nguyễn Văn An', '2025-06-05 10:00:00', N'Nguyễn Văn An', 0, 1, 1),
    ('2025-06-05 10:15:00', '2025-06-05 10:15:00', N'Trần Thị Bình', '2025-06-05 10:15:00', N'Trần Thị Bình', 0, 2, 2),
    ('2025-06-05 10:30:00', '2025-06-05 10:30:00', N'Lê Hoàng Cường', '2025-06-05 10:30:00', N'Lê Hoàng Cường', 0, 3, 3),
    ('2025-06-05 10:45:00', '2025-06-05 10:45:00', N'Phạm Thị Dung', '2025-06-05 10:45:00', N'Phạm Thị Dung', 0, 4, 4),
    ('2025-06-05 11:00:00', '2025-06-05 11:00:00', N'Võ Minh Đức', '2025-06-05 11:00:00', N'Võ Minh Đức', 0, 5, 5);
GO

-- Insert data for DoanhThu
INSERT INTO DoanhThu(ma_doanh_thu, thang, nam, tien_doanh_thu, create_at, create_by, update_at, update_by, is_deleted)
VALUES
    ('DT202401', 1, 2024, 150000000.00, '2025-06-05 09:00:00', N'Vũ Việt Nghĩa', '2025-06-05 09:00:00', N'Vũ Việt Nghĩa', 0),
    ('DT202402', 2, 2024, 180000000.00, '2025-06-05 09:15:00', N'Vũ Việt Nghĩa', '2025-06-05 09:15:00', N'Vũ Việt Nghĩa', 0),
    ('DT202403', 3, 2024, 200000000.00, '2025-06-05 09:30:00', N'Vũ Việt Nghĩa', '2025-06-05 09:30:00', N'Vũ Việt Nghĩa', 0),
    ('DT202404', 4, 2024, 170000000.00, '2025-06-05 09:45:00', N'Vũ Việt Nghĩa', '2025-06-05 09:45:00', N'Vũ Việt Nghĩa', 0),
    ('DT202405', 5, 2024, 220000000.00, '2025-06-05 10:00:00', N'Vũ Việt Nghĩa', '2025-06-05 10:00:00', N'Vũ Việt Nghĩa', 0),
    ('DT202406', 6, 2024, 250000000.00, '2025-06-05 10:15:00', N'Vũ Việt Nghĩa', '2025-06-05 10:15:00', N'Vũ Việt Nghĩa', 0);
GO

-- Insert data for HoaDon
INSERT INTO HoaDon(ma_hoa_don, loai_hoa_don, ngay_tao, tong_tien, phi_van_chuyen, so_tien_giam, thanh_tien, hinh_thuc_thanh_toan, create_at, create_by, update_at, update_by, is_deleted, trang_thai, xac_nhan_hoa_don, id_voucher, id_nhan_vien, id_khach_hang, id_dia_chi_giao_hang, id_doanh_thu)
VALUES
    ('HD001', 1, '2025-06-05 10:00:00', 2500000.00, 30000.00, 250000.00, 2280000.00, 2, '2025-06-05 10:00:00', N'Dương Cao Kỳ', '2025-06-05 10:00:00', N'Dương Cao Kỳ', 0, 5, 1, 1, 2, 1, 1, 1),
    ('HD002', 1, '2025-06-05 10:15:00', 3200000.00, 30000.00, 0.00, 3230000.00, 2, '2025-06-05 10:15:00', N'Nguyễn Sỹ Phong', '2025-06-05 10:15:00', N'Nguyễn Sỹ Phong', 0, 4, 0, NULL, 3, 2, 3, 2),
    ('HD003', 2, '2025-06-05 10:30:00', 1800000.00, 0.00, 0.00, 1800000.00, 1, '2025-06-05 10:30:00', N'Vũ Việt Nghĩa', '2025-06-05 10:30:00', N'Vũ Việt Nghĩa', 0, 5, 1, NULL, 1, 3, NULL, 3),
    ('HD004', 1, '2025-06-05 10:45:00', 4500000.00, 30000.00, 450000.00, 4080000.00, 2, '2025-06-05 10:45:00', N'Nguyên Xuân Tùng', '2025-06-05 10:45:00', N'Nguyên Xuân Tùng', 0, 5, 1, 2, 4, 4, 5, 4),
    ('HD005', 1, '2025-06-05 11:00:00', 2100000.00, 30000.00, 0.00, 2130000.00, 2, '2025-06-05 11:00:00', N'Ngô Tiên Tùng', '2025-06-05 11:00:00', N'Ngô Tiên Tùng', 0, 3, 0, NULL, 5, 5, 6, 5);
GO

-- Insert data for HoaDonChiTiet
INSERT INTO HoaDonChiTiet(ma_hdct, gia_mua, so_luong, create_at, create_by, update_at, update_by, is_deleted, id_hoa_don, id_chi_tiet_giay)
VALUES
    ('HDCT001', 2500000.00, 1, '2025-06-05 10:00:00', N'Dương Cao Kỳ', '2025-06-05 10:00:00', N'Dương Cao Kỳ', 0, 1, 1),
    ('HDCT002', 3200000.00, 1, '2025-06-05 10:15:00', N'Nguyễn Sỹ Phong', '2025-06-05 10:15:00', N'Nguyễn Sỹ Phong', 0, 2, 2),
    ('HDCT003', 1800000.00, 1, '2025-06-05 10:30:00', N'Vũ Việt Nghĩa', '2025-06-05 10:30:00', N'Vũ Việt Nghĩa', 0, 3, 3),
    ('HDCT004', 2100000.00, 2, '2025-06-05 10:45:00', N'Nguyên Xuân Tùng', '2025-06-05 10:45:00', N'Nguyên Xuân Tùng', 0, 4, 5),
    ('HDCT005', 300000.00, 1, '2025-06-05 10:45:00', N'Nguyên Xuân Tùng', '2025-06-05 10:45:00', N'Nguyên Xuân Tùng', 0, 4, 8),
    ('HDCT006', 2100000.00, 1, '2025-06-05 11:00:00', N'Ngô Tiên Tùng', '2025-06-05 11:00:00', N'Ngô Tiên Tùng', 0, 5, 5);
GO

-- Insert data for LichSuMuaHang
INSERT INTO LichSuMuaHang(ma_lich_su, ngay_mua, tong_tien, create_at, create_by, update_at, update_by, is_deleted, trang_thai, id_khach_hang, id_hoa_don)
VALUES
    ('LS001', '2025-06-05 10:00:00', 2280000.00, '2025-06-05 10:00:00', N'Nguyễn Văn An', '2025-06-05 10:00:00', N'Nguyễn Văn An', 0, 1, 1, 1),
    ('LS002', '2025-06-05 10:15:00', 3230000.00, '2025-06-05 10:15:00', N'Trần Thị Bình', '2025-06-05 10:15:00', N'Trần Thị Bình', 0, 1, 2, 2),
    ('LS003', '2025-06-05 10:30:00', 1800000.00, '2025-06-05 10:30:00', N'Lê Hoàng Cường', '2025-06-05 10:30:00', N'Lê Hoàng Cường', 0, 1, 3, 3),
    ('LS004', '2025-06-05 10:45:00', 4080000.00, '2025-06-05 10:45:00', N'Phạm Thị Dung', '2025-06-05 10:45:00', N'Phạm Thị Dung', 0, 1, 4, 4);
GO

-- Insert data for DanhGia
INSERT INTO DanhGia(ma_danh_gia, binh_luan, danh_gia_sao, danh_gia_huu_ich, danh_gia_khong_huu_ich, create_at, create_by, update_at, update_by, is_deleted, id_hoa_don_chi_tiet, id_khach_hang)
VALUES
    ('DG001', N'Giày rất đẹp và chất lượng tốt, giao hàng nhanh', 5, 12, 1, '2025-06-05 10:00:00', N'Nguyễn Văn An', '2025-06-05 10:00:00', N'Nguyễn Văn An', 0, 1, 1),
    ('DG002', N'Sản phẩm ok, đúng như mô tả', 4, 8, 2, '2025-06-05 10:15:00', N'Trần Thị Bình', '2025-06-05 10:15:00', N'Trần Thị Bình', 0, 2, 2),
    ('DG003', N'Giày đẹp nhưng hơi chật', 3, 5, 3, '2025-06-05 10:30:00', N'Lê Hoàng Cường', '2025-06-05 10:30:00', N'Lê Hoàng Cường', 0, 3, 3),
    ('DG004', N'Rất hài lòng về chất lượng và dịch vụ', 5, 15, 0, '2025-06-05 10:45:00', N'Phạm Thị Dung', '2025-06-05 10:45:00', N'Phạm Thị Dung', 0, 4, 4),
    ('DG005', N'Giày thoải mái, phù hợp để đi chơi', 4, 7, 1, '2025-06-05 11:00:00', N'Võ Minh Đức', '2025-06-05 11:00:00', N'Võ Minh Đức', 0, 6, 5);
GO

-- Insert data for HoTro
INSERT INTO HoTro(ma_ho_tro, van_de_ho_tro, mo_ta_van_de, ngay_gui, create_at, create_by, update_at, update_by, is_deleted, trang_thai_ht, id_khach_hang)
VALUES
    ('HT001', N'Đổi trả sản phẩm', N'Tôi muốn đổi size giày vì mua nhầm size', '2025-06-05 10:00:00', '2025-06-05 10:00:00', N'Nguyễn Văn An', '2025-06-05 10:00:00', N'Nguyễn Văn An', 0, 1, 1),
    ('HT002', N'Hỏi về vận chuyển', N'Đơn hàng của tôi bao giờ được giao?', '2025-06-05 10:15:00', '2025-06-05 10:15:00', N'Trần Thị Bình', '2025-06-05 10:15:00', N'Trần Thị Bình', 0, 1, 2),
    ('HT003', N'Khiếu nại chất lượng', N'Giày bị lỗi sau 1 tuần sử dụng', '2025-06-05 10:30:00', '2025-06-05 10:30:00', N'Lê Hoàng Cường', '2025-06-05 10:30:00', N'Lê Hoàng Cường', 0, 2, 3),
    ('HT004', N'Hỏi về voucher', N'Làm sao để sử dụng mã giảm giá?', '2025-06-05 10:45:00', '2025-06-05 10:45:00', N'Phạm Thị Dung', '2025-06-05 10:45:00', N'Phạm Thị Dung', 0, 1, 4),
    ('HT005', N'Thanh toán', N'Tôi thanh toán nhưng chưa nhận được xác nhận', '2025-06-05 11:00:00', '2025-06-05 11:00:00', N'Võ Minh Đức', '2025-06-05 11:00:00', N'Võ Minh Đức', 0, 3, 5);
GO

-- Insert data for PhanHoi
INSERT INTO PhanHoi(ma_phan_hoi, van_de_phan_hoi, ngay_gui, create_at, create_by, update_at, update_by, is_deleted, id_ho_tro, id_nhan_vien)
VALUES
    ('PH001', N'Chúng tôi sẽ hỗ trợ bạn đổi size trong vòng 7 ngày. Vui lòng mang giày và hóa đơn đến cửa hàng.', '2025-06-05 10:15:00', '2025-06-05 10:15:00', N'Dương Cao Kỳ', '2025-06-05 10:15:00', N'Dương Cao Kỳ', 0, 1, 2),
    ('PH002', N'Đơn hàng của bạn đang được vận chuyển và sẽ đến trong 2-3 ngày tới.', '2025-06-05 10:30:00', '2025-06-05 10:30:00', N'Nguyễn Sỹ Phong', '2025-06-05 10:30:00', N'Nguyễn Sỹ Phong', 0, 2, 3),
    ('PH003', N'Chúng tôi rất tiếc về sự cố này. Vui lòng mang sản phẩm đến để chúng tôi kiểm tra và hỗ trợ bảo hành.', '2025-06-05 10:45:00', '2025-06-05 10:45:00', N'Vũ Việt Nghĩa', '2025-06-05 10:45:00', N'Vũ Việt Nghĩa', 0, 3, 1),
    ('PH004', N'Để sử dụng voucher, bạn chỉ cần nhập mã voucher ở bước thanh toán. Mã phải còn hiệu lực và đơn hàng đủ điều kiện.', '2025-06-05 11:00:00', '2025-06-05 11:00:00', N'Nguyên Xuân Tùng', '2025-06-05 11:00:00', N'Nguyên Xuân Tùng', 0, 4, 4);
GO

select ho_ten_nv
from NhanVien 
where email like N'vuvietnghia23@gmail.com'

select * from NhanVien

delete KhachHang
where id in (6, 7)
select * from NhanVien

select kh.ho_ten_kh, kh.email, dckh.dia_chi, dckh.sdt_dia_chi
from KhachHang kh
inner join DiaChiGiaoHang dckh on dckh.id_khach_hang = kh.id

select * from KhachHang