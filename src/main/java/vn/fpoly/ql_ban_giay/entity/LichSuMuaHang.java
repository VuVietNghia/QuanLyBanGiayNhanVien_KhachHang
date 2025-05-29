package vn.fpoly.ql_ban_giay.entity;

import jakarta.persistence.*;
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
@Table(name = "LichSuMuaHang")
public class LichSuMuaHang {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "ma_lich_su")
    private String maLichSu;

    @Column(name = "ngay_mua")
    private LocalDateTime ngayMua;

    @Column(name = "tong_tien")
    private BigDecimal tongTien;

    @Column(name = "trang_thai")
    private Integer trangThai;

    @ManyToOne
    @JoinColumn(name = "id_khach_hang")
    private KhachHang idKhachHang;

    @ManyToOne
    @JoinColumn(name = "id_hoa_don")
    private HoaDon idHoaDon;
}
