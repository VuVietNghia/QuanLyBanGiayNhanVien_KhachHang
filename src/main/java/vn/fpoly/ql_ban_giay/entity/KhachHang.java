package vn.fpoly.ql_ban_giay.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "KhachHang")
public class KhachHang {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "ho_ten_kh")
    private String hoTenKH;

    @Column(name = "email")
    private String email;

    @Column(name = "password")
    private String password;

    @Column(name = "sdt")
    private String sdt;

    @Column(name = "ngay_dang_ky")
    private LocalDateTime ngayDangKy;

    @Column(name = "trang_thai")
    private Boolean trangThai;

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

    @PrePersist
    public void prePersist() {
        if (createAt == null) {
            createAt = LocalDateTime.now();
        }
        if (ngayDangKy == null) {
            ngayDangKy = LocalDateTime.now();
        }
        // createBy phải được gán từ nơi khác nếu có thêm mới
    }

    @PreUpdate
    public void preUpdate() {
        updateAt = LocalDateTime.now();
        // updateBy phải được gán từ controller hoặc service
    }
}