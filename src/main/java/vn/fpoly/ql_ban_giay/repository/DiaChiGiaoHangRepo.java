package vn.fpoly.ql_ban_giay.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import vn.fpoly.ql_ban_giay.entity.DiaChiGiaoHang;

import java.util.List;

public interface DiaChiGiaoHangRepo extends JpaRepository<DiaChiGiaoHang, Integer> {
    List<DiaChiGiaoHang> findByIsDeletedFalse();
}
