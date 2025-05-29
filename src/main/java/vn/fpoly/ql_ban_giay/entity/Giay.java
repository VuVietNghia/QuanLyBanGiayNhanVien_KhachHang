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
@Table(name = "Giay")
public class Giay {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "ma_giay")
    private String maGiay;

    @Column(name = "ten_giay")
    private String tenGiay;

    @Column(name = "trang_thai")
    private Boolean trangThai; // 1: còn hàng, 2: hết hàng
}