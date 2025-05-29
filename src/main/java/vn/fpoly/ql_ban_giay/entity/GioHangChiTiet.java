package vn.fpoly.ql_ban_giay.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "GioHangChiTiet")
public class GioHangChiTiet {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "so_luong")
    private Integer soLuong;

    @ManyToOne
    @JoinColumn(name = "id_gio_hang")
    private GioHang idGioHang;

    @ManyToOne
    @JoinColumn(name = "id_chi_tiet_giay")
    private ChiTietGiay idChiTietGiay;
}
