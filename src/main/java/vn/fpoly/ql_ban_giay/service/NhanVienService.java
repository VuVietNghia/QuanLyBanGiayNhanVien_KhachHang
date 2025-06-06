package vn.fpoly.ql_ban_giay.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import vn.fpoly.ql_ban_giay.entity.NhanVien;
import vn.fpoly.ql_ban_giay.repository.NhanVienRepo;

@Service
public class NhanVienService {
    @Autowired
    private NhanVienRepo nhanVienRepo;

    public Page<NhanVien> getAllNhanVien(int page, int size) {
        return nhanVienRepo.findByIsDeletedFalse(PageRequest.of(page, size));
    }

    public NhanVien loginNhanVien(String email, String password) {
        return nhanVienRepo.findByEmailAndPassword(email, password);
    }

    public NhanVien getNhanVienById(Integer id) {
        return nhanVienRepo.findByIdAndIsDeletedFalse(id);
    }

    public NhanVien saveNhanVien(NhanVien nhanVien, String createdBy) {
        if (nhanVienRepo.existsByEmail(nhanVien.getEmail())) {
            throw new IllegalArgumentException("Email đã tồn tại!");
        }
        nhanVien.setIsDeleted(false);
        nhanVien.setCreateBy(createdBy);
        nhanVien.setUpdateBy(createdBy); // Khi thêm mới, updateBy giống createBy
        return nhanVienRepo.save(nhanVien);
    }

    public NhanVien updateNhanVien(NhanVien nhanVien, String updatedBy) {
        NhanVien existing = nhanVienRepo.findByIdAndIsDeletedFalse(nhanVien.getId());
        if (existing == null) {
            throw new IllegalArgumentException("Nhân viên không tồn tại hoặc đã bị xóa!");
        }
        existing.setMaNhanVien(nhanVien.getMaNhanVien());
        existing.setHoTenNv(nhanVien.getHoTenNv());
        existing.setEmail(nhanVien.getEmail());
        existing.setPassword(nhanVien.getPassword());
        existing.setSdt(nhanVien.getSdt());
        existing.setGioiTinh(nhanVien.getGioiTinh());
        existing.setNgaySinh(nhanVien.getNgaySinh());
        existing.setCccd(nhanVien.getCccd());
        existing.setRole(nhanVien.getRole());
        existing.setAvatar(nhanVien.getAvatar());
        existing.setTrangThai(nhanVien.getTrangThai());
        existing.setUpdateBy(updatedBy); // Gán updateBy
        return nhanVienRepo.save(existing);
    }

    public void deleteNhanVien(Integer id, String updatedBy) {
        NhanVien nhanVien = nhanVienRepo.findByIdAndIsDeletedFalse(id);
        if (nhanVien == null) {
            throw new IllegalArgumentException("Nhân viên không tồn tại hoặc đã bị xóa!");
        }
        nhanVien.setIsDeleted(true);
        nhanVien.setUpdateBy(updatedBy); // Gán updateBy khi xóa mềm
        nhanVienRepo.save(nhanVien);
    }
}