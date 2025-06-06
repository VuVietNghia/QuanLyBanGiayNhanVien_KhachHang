package vn.fpoly.ql_ban_giay.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.DecimalMin;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "HoaDon")
public class HoaDon {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "ma_hoa_don")
    private String maHoaDon;

    @Column(name = "ngay_tao")
    private LocalDateTime ngayTao;

    @DecimalMin("0.0")
    @Column(name = "tong_tien")
    private BigDecimal tongTien;

    @DecimalMin("0.0")
    @Column(name = "phi_van_chuyen")
    private BigDecimal phiVanChuyen;

    @DecimalMin("0.0")
    @Column(name = "so_tien_giam")
    private BigDecimal soTienGiam;

    @DecimalMin("0.0")
    @Column(name = "thanh_tien")
    private BigDecimal thanhTien;

    @Column(name = "hinh_thuc_thanh_toan")
    private Integer hinhThucThanhToan; // 1: tiền mặt, 2: chuyển khoản

    @Column(name = "trang_thai")
    private Integer trangThai; // 1: chờ xác nhận, 2: chờ giao hàng, 3: đang vận chuyển, 4: đã giao hàng, 5: đã hoàn thành

    @Column(name = "xac_nhan_hoa_don")
    private Boolean xacNhanHoaDon;

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
    @JoinColumn(name = "id_voucher")
    private Voucher voucher;

    @ManyToOne
    @JoinColumn(name = "id_khach_hang")
    private KhachHang idKhachHang;

    @ManyToOne
    @JoinColumn(name = "id_dia_chi_giao_hang")
    private DiaChiGiaoHang idDiaChiGiaoHang;

    @ManyToOne
    @JoinColumn(name = "id_doanh_thu")
    private DoanhThu idDoanhThu;
}