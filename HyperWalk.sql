CREATE DATABASE HyperWalk;
GO
USE HyperWalk;
GO

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
	role INT,  -- 1. admin, 2. nhân viên
	avatar VARCHAR(255),
	trang_thai BIT
);

CREATE TABLE KhachHang (
	id INT PRIMARY KEY IDENTITY(1,1),
	ho_ten_kh NVARCHAR(100),
	email VARCHAR(255) UNIQUE NOT NULL,
	password VARCHAR(255) NOT NULL,
	sdt VARCHAR(15),
	ngay_dang_ky DATETIME DEFAULT GETDATE(),
	trang_thai BIT
);

CREATE TABLE DiaChiGiaoHang (
    id INT PRIMARY KEY IDENTITY(1,1),
    dia_chi NVARCHAR(500),
    mac_dinh BIT DEFAULT 0,
    id_khach_hang INT,
    FOREIGN KEY (id_khach_hang) REFERENCES KhachHang(id)
);

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
    trang_thai INT, -- 1. chưa diễn ra, 2. đang diễn ra, 3. đã diễn ra
    CHECK (ngay_ket_thuc >= ngay_bat_dau)
);

CREATE TABLE MauSacVaAnhGiay (
    id INT PRIMARY KEY IDENTITY(1,1),
	anh_giay VARCHAR(255),
    mau_sac NVARCHAR(100)
);

CREATE TABLE Size (
    id INT PRIMARY KEY IDENTITY(1,1),
    size NVARCHAR(100)
);

CREATE TABLE ChatLieu (
	id INT PRIMARY KEY IDENTITY(1,1),
	chat_lieu NVARCHAR(100)
);

CREATE TABLE DeGiay (
	id INT PRIMARY KEY IDENTITY(1,1),
	de_giay NVARCHAR(100)
);

CREATE TABLE Hang (
	id INT PRIMARY KEY IDENTITY(1,1),
	hang NVARCHAR(100)
);

CREATE TABLE DanhMuc (
	id INT PRIMARY KEY IDENTITY(1,1),
	danh_muc NVARCHAR(100)
);

CREATE TABLE Giay (
    id INT PRIMARY KEY IDENTITY(1,1),
    ma_giay VARCHAR(20),
    ten_giay NVARCHAR(100),
    trang_thai BIT -- 1. còn hàng, 2. hết hàng
);

CREATE TABLE ChiTietGiay (
    id INT PRIMARY KEY IDENTITY(1,1),
    ma_chi_tiet_giay VARCHAR(20),
    gia_ban DECIMAL(18,2),
    ghi_chu NVARCHAR(255),
    so_luong INT NOT NULL DEFAULT 0 CHECK (so_luong >= 0),
    trang_thai BIT,  
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

CREATE TABLE GioHang (
    id INT PRIMARY KEY IDENTITY(1,1),
    ngay_tao DATETIME DEFAULT GETDATE(),
	id_khach_hang INT,
    FOREIGN KEY (id_khach_hang) REFERENCES KhachHang(id)
);

CREATE TABLE GioHangChiTiet (
    id INT PRIMARY KEY IDENTITY(1,1),
    so_luong INT CHECK (so_luong > 0),
	id_gio_hang INT,
    id_chi_tiet_giay INT,
    FOREIGN KEY (id_gio_hang) REFERENCES GioHang(id),
    FOREIGN KEY (id_chi_tiet_giay) REFERENCES ChiTietGiay(id)
);

CREATE TABLE DoanhThu (
	id INT PRIMARY KEY IDENTITY(1,1),
    ma_doanh_thu VARCHAR(20) UNIQUE NOT NULL,
    thang INT NOT NULL CHECK (thang BETWEEN 1 AND 12),
    nam INT NOT NULL CHECK (nam > 0),
    tien_doanh_thu DECIMAL(18,2) NOT NULL CHECK (tien_doanh_thu >= 0),
);

-- bán hàng tại quầy + bán hàng online
CREATE TABLE HoaDon (
    id INT PRIMARY KEY IDENTITY(1,1),
    ma_hoa_don VARCHAR(20),
	loai_hoa_don INT,  -- 1. thanh toán online, 2. thanh toán tại quầy
    ngay_tao DATETIME DEFAULT GETDATE(),
    tong_tien DECIMAL(18,2),
    phi_van_chuyen DECIMAL(18,2),  -- bán tại quầy ghi = 0
    so_tien_giam DECIMAL(18,2),
    thanh_tien DECIMAL(18,2),
	hinh_thuc_thanh_toan INT, --1. tiền mặt, 2. chuyển khoản
	trang_thai INT,  -- 1. chờ xác nhận, --> 2. chờ giao hàng, --> 3. đang giao hàng, --> 4. đã giao hàng, 5. --> đã hoàn thành, || 6. đã hủy
	xac_nhan_hoa_don BIT, --1. đã nhận được hàng, 0. chưa nhận được hàng
    id_voucher INT,
	id_nhan_vien INT,
    id_khach_hang INT,
    id_dia_chi_giao_hang INT,
	id_doanh_thu INT,
    FOREIGN KEY (id_voucher) REFERENCES Voucher(id),
	FOREIGN KEY (id_nhan_vien) REFERENCES NhanVien(id),
    FOREIGN KEY (id_khach_hang) REFERENCES KhachHang(id),
    FOREIGN KEY (id_dia_chi_giao_hang) REFERENCES DiaChiGiaoHang(id),
	FOREIGN KEY (id_doanh_thu) REFERENCES DoanhThu(id)
);

CREATE TABLE HoaDonChiTiet (
    id INT PRIMARY KEY IDENTITY(1,1),
    ma_hdct VARCHAR(20),
	gia_mua DECIMAL(18, 2),
    so_luong INT NOT NULL CHECK (so_luong > 0),
    id_hoa_don INT,
    id_chi_tiet_giay INT,
    FOREIGN KEY (id_hoa_don) REFERENCES HoaDon(id),
    FOREIGN KEY (id_chi_tiet_giay) REFERENCES ChiTietGiay(id)
);

CREATE TABLE LichSuMuaHang (
    id INT PRIMARY KEY IDENTITY(1,1),
    ma_lich_su VARCHAR(20),
    ngay_mua DATETIME DEFAULT GETDATE(),
    tong_tien DECIMAL(18,2) NOT NULL CHECK (tong_tien >= 0),
    trang_thai INT NOT NULL,  -- 1. đã hoàn thành, 2. đã hủy
	id_khach_hang INT,
    id_hoa_don INT,
    FOREIGN KEY (id_khach_hang) REFERENCES KhachHang(id),
    FOREIGN KEY (id_hoa_don) REFERENCES HoaDon(id)
);

CREATE TABLE DanhGia (
    id INT PRIMARY KEY IDENTITY(1,1),
    ma_danh_gia VARCHAR(20) UNIQUE NOT NULL,
    binh_luan NVARCHAR(500),
    danh_gia_sao INT NOT NULL CHECK (danh_gia_sao BETWEEN 1 AND 5),
    danh_gia_huu_ich INT DEFAULT 0 CHECK (danh_gia_huu_ich >= 0),
    danh_gia_khong_huu_ich INT DEFAULT 0 CHECK (danh_gia_khong_huu_ich >= 0),
    id_hoa_don_chi_tiet INT,
    id_khach_hang INT,
    FOREIGN KEY (id_hoa_don_chi_tiet) REFERENCES HoaDonChiTiet(id),
    FOREIGN KEY (id_khach_hang) REFERENCES KhachHang(id)
);

CREATE TABLE HoTro (
	id INT PRIMARY KEY IDENTITY(1,1),
	ma_ho_tro VARCHAR(20) UNIQUE NOT NULL,
	van_de_ho_tro NVARCHAR(50) NOT NULL,
	mo_ta_van_de NVARCHAR(500) NOT NULL,
	ngay_gui DATETIME DEFAULT GETDATE(),
	trang_thai_ht INT NOT NULL CHECK (trang_thai_ht IN (1, 2, 3)), -- 1. đã được giải quyết, 2. đang được giải quyết, 3. chưa được giải quyết
	id_khach_hang INT, -- lấy thông tin của người cần hỗ trợ
	FOREIGN KEY (id_khach_hang) REFERENCES KhachHang(id)
);

CREATE TABLE PhanHoi (
	id INT PRIMARY KEY IDENTITY(1,1),
	ma_phan_hoi VARCHAR(20),
	van_de_phan_hoi NVARCHAR(500) NOT NULL,
	ngay_gui DATETIME DEFAULT GETDATE(),
	id_ho_tro INT,
	id_nhan_vien INT,
	FOREIGN KEY (id_ho_tro) REFERENCES HoTro(id),
	FOREIGN KEY (id_nhan_vien) REFERENCES NhanVien(id)
);

INSERT INTO NhanVien(ma_nhan_vien, ho_ten_nv, email, password, sdt, gioi_tinh, ngay_sinh, role, trang_thai)
VALUES
    ('NV001', N'Vũ Việt Nghĩa', 'vuvietnghia23@gmail.com', '123456', '0886545918', 1, '2005-10-28', 1, 1),
    ('NV002', N'Dương Cao Kỳ', 'kydc@gmail.com', 'abcxyz', '0903781234', 2, '2005-03-15', 2, 1),
    ('NV003', N'Nguyễn Sỹ Phong', 'phongns@gmail.com', '098765', '0365987412', 1, '2005-11-28', 2, 1),
    ('NV004', N'Nguyên Xuân Tùng', 'tungnx@gmail.com', 'qwert', '0772548963', 2, '2003-12-20', 2, 1),
    ('NV005', N'Ngô Tiên Tùng', 'tungnt@gmail.com', 'asdfgh', '0899123076', 2, '2005-07-04', 2, 1);
GO

-- Insert data for KhachHang
INSERT INTO KhachHang(ho_ten_kh, email, password, sdt, trang_thai)
VALUES
    (N'Nguyễn Văn An', 'nguyenvanan@gmail.com', '123456', '0912345678', 1),
    (N'Trần Thị Bình', 'tranthibinh@gmail.com', 'password123', '0923456789', 1),
    (N'Lê Hoàng Cường', 'lehoangcuong@gmail.com', 'cuong2023', '0934567890', 1),
    (N'Phạm Thị Dung', 'phamthidung@gmail.com', 'dungpham', '0945678901', 1),
    (N'Võ Minh Đức', 'vominhduc@gmail.com', 'minhduc', '0956789012', 1);
GO

-- Insert data for DiaChiGiaoHang
INSERT INTO DiaChiGiaoHang(dia_chi, mac_dinh, id_khach_hang)
VALUES
    (N'123 Đường Lê Lợi, Quận 1, TP.HCM', 1, 1),
    (N'456 Đường Nguyễn Huệ, Quận 1, TP.HCM', 0, 1),
    (N'789 Đường Trần Hưng Đạo, Quận 5, TP.HCM', 1, 2),
    (N'321 Đường Võ Văn Tần, Quận 3, TP.HCM', 1, 3),
    (N'654 Đường Pasteur, Quận 1, TP.HCM', 1, 4),
    (N'987 Đường Hai Bà Trưng, Quận 1, TP.HCM', 1, 5);
GO

-- Insert data for Voucher
INSERT INTO Voucher(ma_voucher, ten_voucher, hinh_thuc_giam, muc_giam, gia_tri_don_hang_toi_thieu, so_luong, ngay_bat_dau, ngay_ket_thuc, trang_thai)
VALUES
    ('VC001', N'Giảm 10% đơn hàng đầu tiên', 1, 10.00, 200000.00, 100, '2024-01-01', '2024-12-31', 2),
    ('VC002', N'Giảm 50k cho đơn từ 500k', 2, 50000.00, 500000.00, 200, '2024-06-01', '2024-12-31', 2),
    ('VC003', N'Giảm 15% Black Friday', 1, 15.00, 300000.00, 50, '2024-11-25', '2024-11-30', 3),
    ('VC004', N'Giảm 100k sinh nhật shop', 2, 100000.00, 800000.00, 30, '2024-03-01', '2024-03-31', 3),
    ('VC005', N'Giảm 20% Tết Nguyên Đán', 1, 20.00, 400000.00, 150, '2025-01-20', '2025-02-10', 1);
GO

-- Insert data for MauSacVaAnhGiay
INSERT INTO MauSacVaAnhGiay(anh_giay, mau_sac)
VALUES
    ('giay_den_1.jpg', N'Đen'),
    ('giay_trang_1.jpg', N'Trắng'),
    ('giay_xanh_1.jpg', N'Xanh navy'),
    ('giay_do_1.jpg', N'Đỏ'),
    ('giay_nau_1.jpg', N'Nâu'),
    ('giay_xam_1.jpg', N'Xám'),
    ('giay_vang_1.jpg', N'Vàng'),
    ('giay_hong_1.jpg', N'Hồng');
GO

-- Insert data for Size
INSERT INTO Size(size)
VALUES
    ('36'), ('37'), ('38'), ('39'), ('40'), ('41'), ('42'), ('43'), ('44'), ('45');
GO

-- Insert data for ChatLieu
INSERT INTO ChatLieu(chat_lieu)
VALUES
    (N'Da thật'),
    (N'Da tổng hợp'),
    (N'Canvas'),
    (N'Mesh'),
    (N'Vải dệt'),
    (N'Suede'),
    (N'Nylon');
GO

-- Insert data for DeGiay
INSERT INTO DeGiay(de_giay)
VALUES
    (N'Đế cao su'),
    (N'Đế EVA'),
    (N'Đế PU'),
    (N'Đế phylon'),
    (N'Đế da'),
    (N'Đế TPU');
GO

-- Insert data for Hang
INSERT INTO Hang(hang)
VALUES
    ('Nike'),
    ('Adidas'),
    ('Puma'),
    ('Converse'),
    ('Vans'),
    ('New Balance'),
    ('Reebok'),
    ('Fila');
GO

-- Insert data for DanhMuc
INSERT INTO DanhMuc(danh_muc)
VALUES
    (N'Giày thể thao'),
    (N'Giày công sở'),
    (N'Giày sneaker'),
    (N'Giày chạy bộ'),
    (N'Giày bóng đá'),
    (N'Giày đi bộ'),
    (N'Giày thời trang');
GO

-- Insert data for Giay
INSERT INTO Giay(ma_giay, ten_giay, trang_thai)
VALUES
    ('G001', N'Nike Air Force 1', 1),
    ('G002', N'Adidas Ultraboost 22', 1),
    ('G003', N'Puma RS-X', 1),
    ('G004', N'Converse Chuck Taylor', 1),
    ('G005', N'Vans Old Skool', 1),
    ('G006', N'New Balance 574', 1),
    ('G007', N'Nike Air Max 90', 1),
    ('G008', N'Adidas Stan Smith', 1);
GO

-- Insert data for ChiTietGiay
INSERT INTO ChiTietGiay(ma_chi_tiet_giay, gia_ban, ghi_chu, so_luong, trang_thai, id_giay, id_mau_sac_va_anh_giay, id_size, id_chat_lieu, id_de_giay, id_hang, id_danh_muc)
VALUES
    ('CTG001', 2500000.00, N'Giày thể thao cao cấp', 50, 1, 1, 2, 5, 1, 1, 1, 1),
    ('CTG002', 3200000.00, N'Giày chạy bộ chuyên nghiệp', 30, 1, 2, 1, 6, 4, 2, 2, 4),
    ('CTG003', 1800000.00, N'Giày sneaker thời trang', 40, 1, 3, 4, 4, 2, 1, 3, 3),
    ('CTG004', 1500000.00, N'Giày canvas cổ điển', 60, 1, 4, 2, 7, 3, 1, 4, 1),
    ('CTG005', 2100000.00, N'Giày skateboard', 25, 1, 5, 1, 5, 3, 1, 5, 3),
    ('CTG006', 2800000.00, N'Giày retro running', 35, 1, 6, 6, 6, 5, 2, 6, 4),
    ('CTG007', 2700000.00, N'Giày thể thao Air Max', 45, 1, 7, 3, 5, 4, 1, 1, 1),
    ('CTG008', 2000000.00, N'Giày tennis cổ điển', 55, 1, 8, 2, 4, 1, 1, 2, 2);
GO

-- Insert data for GioHang
INSERT INTO GioHang(id_khach_hang)
VALUES
    (1), (2), (3), (4), (5);
GO

-- Insert data for GioHangChiTiet
INSERT INTO GioHangChiTiet(so_luong, id_gio_hang, id_chi_tiet_giay)
VALUES
    (2, 1, 1),
    (1, 1, 3),
    (3, 2, 2),
    (1, 3, 4),
    (2, 4, 5),
    (1, 5, 6);
GO

-- Insert data for DoanhThu
INSERT INTO DoanhThu(ma_doanh_thu, thang, nam, tien_doanh_thu)
VALUES
    ('DT202401', 1, 2024, 150000000.00),
    ('DT202402', 2, 2024, 180000000.00),
    ('DT202403', 3, 2024, 200000000.00),
    ('DT202404', 4, 2024, 170000000.00),
    ('DT202405', 5, 2024, 220000000.00),
    ('DT202406', 6, 2024, 250000000.00);
GO

-- Insert data for HoaDon
INSERT INTO HoaDon(ma_hoa_don, loai_hoa_don, tong_tien, phi_van_chuyen, so_tien_giam, thanh_tien, hinh_thuc_thanh_toan, trang_thai, xac_nhan_hoa_don, id_voucher, id_nhan_vien, id_khach_hang, id_dia_chi_giao_hang, id_doanh_thu)
VALUES
    ('HD001', 1, 2500000.00, 30000.00, 250000.00, 2280000.00, 2, 5, 1, 1, 2, 1, 1, 1),
    ('HD002', 1, 3200000.00, 30000.00, 0.00, 3230000.00, 2, 4, 0, NULL, 3, 2, 3, 2),
    ('HD003', 2, 1800000.00, 0.00, 0.00, 1800000.00, 1, 5, 1, NULL, 1, 3, NULL, 3),
    ('HD004', 1, 4500000.00, 30000.00, 450000.00, 4080000.00, 2, 5, 1, 2, 4, 4, 5, 4),
    ('HD005', 1, 2100000.00, 30000.00, 0.00, 2130000.00, 2, 3, 0, NULL, 5, 5, 6, 5);
GO

-- Insert data for HoaDonChiTiet
INSERT INTO HoaDonChiTiet(ma_hdct, gia_mua, so_luong, id_hoa_don, id_chi_tiet_giay)
VALUES
    ('HDCT001', 2500000.00, 1, 1, 1),
    ('HDCT002', 3200000.00, 1, 2, 2),
    ('HDCT003', 1800000.00, 1, 3, 3),
    ('HDCT004', 2100000.00, 2, 4, 5),
    ('HDCT005', 300000.00, 1, 4, 8),
    ('HDCT006', 2100000.00, 1, 5, 5);
GO

-- Insert data for LichSuMuaHang
INSERT INTO LichSuMuaHang(ma_lich_su, tong_tien, trang_thai, id_khach_hang, id_hoa_don)
VALUES
    ('LS001', 2280000.00, 1, 1, 1),
    ('LS002', 3230000.00, 1, 2, 2),
    ('LS003', 1800000.00, 1, 3, 3),
    ('LS004', 4080000.00, 1, 4, 4);
GO

-- Insert data for DanhGia
INSERT INTO DanhGia(ma_danh_gia, binh_luan, danh_gia_sao, danh_gia_huu_ich, danh_gia_khong_huu_ich, id_hoa_don_chi_tiet, id_khach_hang)
VALUES
    ('DG001', N'Giày rất đẹp và chất lượng tốt, giao hàng nhanh', 5, 12, 1, 1, 1),
    ('DG002', N'Sản phẩm ok, đúng như mô tả', 4, 8, 2, 2, 2),
    ('DG003', N'Giày đẹp nhưng hơi chật', 3, 5, 3, 3, 3),
    ('DG004', N'Rất hài lòng về chất lượng và dịch vụ', 5, 15, 0, 4, 4),
    ('DG005', N'Giày thoải mái, phù hợp để đi chơi', 4, 7, 1, 6, 5);
GO

-- Insert data for HoTro
INSERT INTO HoTro(ma_ho_tro, van_de_ho_tro, mo_ta_van_de, trang_thai_ht, id_khach_hang)
VALUES
    ('HT001', N'Đổi trả sản phẩm', N'Tôi muốn đổi size giày vì mua nhầm size', 1, 1),
    ('HT002', N'Hỏi về vận chuyển', N'Đơn hàng của tôi bao giờ được giao?', 1, 2),
    ('HT003', N'Khiếu nại chất lượng', N'Giày bị lỗi sau 1 tuần sử dụng', 2, 3),
    ('HT004', N'Hỏi về voucher', N'Làm sao để sử dụng mã giảm giá?', 1, 4),
    ('HT005', N'Thanh toán', N'Tôi thanh toán nhưng chưa nhận được xác nhận', 3, 5);
GO

-- Insert data for PhanHoi
INSERT INTO PhanHoi(ma_phan_hoi, van_de_phan_hoi, id_ho_tro, id_nhan_vien)
VALUES
    ('PH001', N'Chúng tôi sẽ hỗ trợ bạn đổi size trong vòng 7 ngày. Vui lòng mang giày và hóa đơn đến cửa hàng.', 1, 2),
    ('PH002', N'Đơn hàng của bạn đang được vận chuyển và sẽ đến trong 2-3 ngày tới.', 2, 3),
    ('PH003', N'Chúng tôi rất tiếc về sự cố này. Vui lòng mang sản phẩm đến để chúng tôi kiểm tra và hỗ trợ bảo hành.', 3, 1),
    ('PH004', N'Để sử dụng voucher, bạn chỉ cần nhập mã voucher ở bước thanh toán. Mã phải còn hiệu lực và đơn hàng đủ điều kiện.', 4, 4);
GO

select ho_ten_nv
from NhanVien 
where email like N'vuvietnghia23@gmail.com'

delete KhachHang
where id in (6, 7)
select * from NhanVien
select * from KhachHang