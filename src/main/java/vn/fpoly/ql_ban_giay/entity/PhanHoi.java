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
@Table(name = "PhanHoi")
public class PhanHoi {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "ma_phan_hoi")
    private String maPhanHoi;

    @NotBlank
    @Column(name = "van_de_phan_hoi")
    private String vanDePhanHoi;

    @Column(name = "ngay_gui")
    private LocalDateTime ngayGui;

    @ManyToOne
    @JoinColumn(name = "id_ho_tro")
    private HoTro idHoTro;

    @ManyToOne
    @JoinColumn(name = "id_nhan_vien")
    private NhanVien idNhanVien;

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
}