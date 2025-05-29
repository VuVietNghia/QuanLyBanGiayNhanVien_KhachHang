package vn.fpoly.ql_ban_giay.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import vn.fpoly.ql_ban_giay.entity.KhachHang;

public interface KhachHangRepo extends JpaRepository<KhachHang, Integer> {
    boolean existsByEmail(String email);
    KhachHang findByEmailAndPassword(String email, String password);
    Page<KhachHang> findAll(Pageable pageable);
}
