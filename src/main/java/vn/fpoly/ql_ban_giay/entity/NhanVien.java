package vn.fpoly.ql_ban_giay.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;
import java.time.LocalDateTime;

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
    private String hoTenNv;

    @Column(name = "email")
    private String email;

    @Column(name = "password")
    private String password;

    @Column(name = "sdt")
    private String sdt;

    @Column(name = "gioi_tinh")
    private Integer gioiTinh;

    @Column(name = "ngay_sinh")
    private LocalDateTime ngaySinh;

    @Column(name = "cccd")
    private String cccd;

    @Column(name = "ngay_dang_ky")
    private LocalDateTime ngayDangKy;

    @Column(name = "role")
    private Integer role;

    @Column(name = "avatar")
    private String avatar;

    @Column(name = "create_at")
    private LocalDateTime createAt;

    @Column(name = "create_by")
    private String createBy;

    @Column(name = "update_at")
    private LocalDateTime updateAt;

    @Column(name = "update_by")
    private String updateBy;

    @Column(name = "is_deleted")
    private Boolean isDeleted;

    @Column(name = "trang_thai")
    private Boolean trangThai;

    @PrePersist
    public void prePersist() {
        if (createAt == null) {
            createAt = LocalDateTime.now();
        }
        if (ngayDangKy == null) {
            ngayDangKy = LocalDateTime.now();
        }
        // createBy phải được gán từ controller hoặc service
    }

    @PreUpdate
    public void preUpdate() {
        updateAt = LocalDateTime.now();
        // updateBy phải được gán từ controller hoặc service
    }
}