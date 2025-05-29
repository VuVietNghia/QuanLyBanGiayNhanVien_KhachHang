package vn.fpoly.ql_ban_giay.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.fpoly.ql_ban_giay.entity.NhanVien;
import vn.fpoly.ql_ban_giay.repository.NhanVienRepo;

import java.util.List;

@Service
public class NhanVienService {
    @Autowired
    private NhanVienRepo nhanVienRepo;

    public List<NhanVien> getAllNhanVien() {
        return nhanVienRepo.findAll();
    }

    public NhanVien loginNhanVien(String email, String password) {
        return nhanVienRepo.findByEmailAndPassword(email, password);
    }
}
