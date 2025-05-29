package vn.fpoly.ql_ban_giay.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "Voucher")
public class Voucher {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "ma_voucher")
    private String maVoucher;

    @Column(name = "ten_voucher")
    private String tenVoucher;

    @NotNull
    @Column(name = "hinh_thuc_giam")
    private Integer hinhThucGiam;

    @NotNull
    @DecimalMin("0.0")
    @Column(name = "muc_giam")
    private BigDecimal mucGiam;

    @NotNull
    @DecimalMin("0.0")
    @Column(name = "gia_tri_don_hang_toi_thieu")
    private BigDecimal giaTriDonHangToiThieu;

    @NotNull
    @Min(0)
    @Column(name = "so_luong")
    private Integer soLuong;

    @NotNull
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Column(name = "ngay_bat_dau")
    private Date ngayBatDau;

    @NotNull
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Column(name = "ngay_ket_thuc")
    private Date ngayKetThuc;

    @Column(name = "trang_thai")
    private Integer trangThai;
}