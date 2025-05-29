package vn.fpoly.ql_ban_giay.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "NhanVien")
public class NhanVien {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "ma_nhan_vien")
    private String maNhanVien;

    @Column(name = "ho_ten_nv")
    private String hoTenNV;

    @Column(name = "email")
    private String email;

    @Column(name = "password")
    private String password;

    @Column(name = "sdt")
    private String sdt;

    @Column(name = "gioi_tinh")
    private Integer gioiTinh;

    @Column(name = "ngay_sinh")
    private Date ngaySinh;

    @Column(name = "cccd")
    private String cccd;

    @Column(name = "ngay_dang_ky")
    private LocalDateTime ngayDangKy;

    @Column(name = "role")
    private Integer role;

    @Column(name = "avatar")
    private String avatar;

    @Column(name = "trang_thai")
    private Boolean trangThai;
}
