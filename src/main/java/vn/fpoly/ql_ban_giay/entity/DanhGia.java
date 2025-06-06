package vn.fpoly.ql_ban_giay.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
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
@Table(name = "DanhGia")
public class DanhGia {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "ma_danh_gia")
    private String maDanhGia;

    @Column(name = "binh_luan")
    private String binhLuan;

    @Min(1)
    @Max(5)
    @Column(name = "danh_gia_sao")
    private Integer danhGiaSao;

    @Min(0)
    @Column(name = "danh_gia_huu_ich")
    private Integer danhGiaHuuIch;

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

    @Min(0)
    @Column(name = "danh_gia_khong_huu_ich")
    private Integer danhGiaKhongHuuIch;

    @ManyToOne
    @JoinColumn(name = "id_hoa_don_chi_tiet")
    private HoaDonChiTiet idHoaDonChiTiet;

    @ManyToOne
    @JoinColumn(name = "id_khach_hang")
    private KhachHang idKhachHang;
}