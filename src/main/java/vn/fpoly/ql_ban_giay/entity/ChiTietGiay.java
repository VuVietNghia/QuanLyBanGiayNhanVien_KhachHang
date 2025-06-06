package vn.fpoly.ql_ban_giay.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Min;
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
@Table(name = "ChiTietGiay")
public class ChiTietGiay {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "ma_chi_tiet_giay")
    private String maChiTietGiay;

    @DecimalMin("0.0")
    @Column(name = "gia")
    private BigDecimal gia;

    @Column(name = "ghi_chu")
    private String ghiChu;

    @Min(0)
    @Column(name = "so_luong")
    private Integer soLuong;

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

    @ManyToOne
    @JoinColumn(name = "id_giay", referencedColumnName = "id")
    private Giay idGiay;

    @ManyToOne
    @JoinColumn(name = "id_mau_sac_va_anh_giay", referencedColumnName = "id")
    private MauSacVaAnhGiay idMauSacVaAnhGiay;

    @ManyToOne
    @JoinColumn(name = "id_size", referencedColumnName = "id")
    private Size idSize;

    @ManyToOne
    @JoinColumn(name = "id_chat_lieu", referencedColumnName = "id")
    private ChatLieu idChatLieu;

    @ManyToOne
    @JoinColumn(name = "id_de_giay", referencedColumnName = "id")
    private DeGiay idDeGiay;

    @ManyToOne
    @JoinColumn(name = "id_hang", referencedColumnName = "id")
    private Hang idHang;

    @ManyToOne
    @JoinColumn(name = "id_danh_muc", referencedColumnName = "id")
    private DanhMuc idDanhMuc;
}