package vn.fpoly.ql_ban_giay.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import vn.fpoly.ql_ban_giay.entity.KhachHang;
import vn.fpoly.ql_ban_giay.repository.KhachHangRepo;
import vn.fpoly.ql_ban_giay.repository.NhanVienRepo;

@Service
public class KhachHangService {
    @Autowired
    private KhachHangRepo khachHangRepo;

    @Autowired
    private NhanVienRepo nhanVienRepo;

    public Page<KhachHang> getAllKhachHang(int page, int size) {
        return khachHangRepo.findAll(PageRequest.of(page, size));
    }

    public Page<KhachHang> getAllKhachHangNotDeleted(int page, int size) {
        return khachHangRepo.findByIsDeletedFalse(PageRequest.of(page, size));
    }

    public KhachHang getByEmail(String email) {
        return khachHangRepo.findByEmail(email);
    }

    public KhachHang loginKhachHang(String email, String password) {
        return khachHangRepo.findByEmailAndPassword(email, password);
    }

    public KhachHang saveKhachHang(KhachHang khachHang, String updatedBy) {
        khachHang.setUpdateBy(updatedBy); // Gán updateBy trước khi lưu
        return khachHangRepo.save(khachHang);
    }

    public KhachHang getByIdKhachHang(Integer id) {
        return khachHangRepo.findById(id).orElse(null);
    }

    public Boolean checkEmailNhanVien(String email) {
        return nhanVienRepo.existsByEmail(email);
    }

    public Boolean checkEmailKhachHang(String email) {
        return khachHangRepo.existsByEmail(email);
    }
}