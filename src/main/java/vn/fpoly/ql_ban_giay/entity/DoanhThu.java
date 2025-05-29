package vn.fpoly.ql_ban_giay.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "DoanhThu")
public class DoanhThu {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "ma_doanh_thu")
    private String maDoanhThu;

    @Min(1)
    @Max(12)
    @Column(name = "thang")
    private Integer thang;

    @Min(1)
    @Column(name = "nam")
    private Integer nam;

    @DecimalMin("0.0")
    @Column(name = "tien_doanh_thu")
    private BigDecimal tienDoanhThu;
}