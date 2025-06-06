package vn.fpoly.ql_ban_giay.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
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
@Table(name = "HoTro")
public class HoTro {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NotBlank
    @Column(name = "ma_ho_tro")
    private String maHoTro;

    @NotBlank
    @Column(name = "van_de_ho_tro")
    private String vanDeHoTro;

    @NotBlank
    @Column(name = "mo_ta_van_de")
    private String moTaVanDe;

    @Column(name = "ngay_gui")
    private LocalDateTime ngayGui;

    @Column(name = "trang_thai_ht")
    private Integer trangThaiHT; // 1: đã giải quyết, 2: đang giải quyết, 3: chưa giải quyết

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