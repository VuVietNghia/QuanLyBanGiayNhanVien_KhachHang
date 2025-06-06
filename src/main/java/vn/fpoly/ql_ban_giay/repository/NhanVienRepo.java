package vn.fpoly.ql_ban_giay.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import vn.fpoly.ql_ban_giay.entity.NhanVien;

public interface NhanVienRepo extends JpaRepository<NhanVien, Integer> {
    boolean existsByEmail(String email);
    NhanVien findByEmailAndPassword(String email, String password);
    Page<NhanVien> findByIsDeletedFalse(Pageable pageable);
    NhanVien findByIdAndIsDeletedFalse(Integer id);
}