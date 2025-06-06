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
@Table(name = "DiaChiGiaoHang")
public class DiaChiGiaoHang {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "dia_chi")
    private String diaChi;

    @Column(name = "mac_dinh")
    private Boolean macDinh;

    @Column(name = "sdt_dia_chi")
    private String sdt_dia_chi;

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

    @ManyToOne
    @JoinColumn(name = "id_khach_hang")
    private KhachHang idKhachHang;
}