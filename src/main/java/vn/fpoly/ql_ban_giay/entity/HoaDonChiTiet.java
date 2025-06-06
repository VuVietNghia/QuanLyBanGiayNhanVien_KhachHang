package vn.fpoly.ql_ban_giay.entity;

import jakarta.persistence.*;
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
@Table(name = "HoaDonChiTiet")
public class HoaDonChiTiet {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "ma_hdct")
    private String maHdct;

    @Min(1)
    @Column(name = "so_luong")
    private Integer soLuong;

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
    @JoinColumn(name = "id_hoa_don")
    private HoaDon idHoaDon;

    @ManyToOne
    @JoinColumn(name = "id_chi_tiet_giay")
    private ChiTietGiay idChiTietGiay;
}