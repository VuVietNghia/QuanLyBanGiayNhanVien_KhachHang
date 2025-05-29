package vn.fpoly.ql_ban_giay.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import vn.fpoly.ql_ban_giay.entity.KhachHang;
import vn.fpoly.ql_ban_giay.repository.KhachHangRepo;
import vn.fpoly.ql_ban_giay.repository.NhanVienRepo;

import java.util.List;

@Service
public class KhachHangService {
    @Autowired
    private KhachHangRepo khachHangRepo;

    @Autowired
    private NhanVienRepo nhanVienRepo;

    public Page<KhachHang> getAllKhachHang(int page, int size) {
        return khachHangRepo.findAll(PageRequest.of(page, size));
    }

    public KhachHang loginKhachHang(String email, String password) {
        return khachHangRepo.findByEmailAndPassword(email, password);
    }

    public void saveKhachHang(KhachHang khachHang) {
        khachHangRepo.save(khachHang);
    }

    public Boolean checkEmailNhanVien(String email) {
        return nhanVienRepo.existsByEmail(email);
    }

    public Boolean checkEmailKhachHang(String email) {
        return khachHangRepo.existsByEmail(email);
    }
}
