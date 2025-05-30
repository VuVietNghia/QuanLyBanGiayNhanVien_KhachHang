package vn.fpoly.ql_ban_giay.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.fpoly.ql_ban_giay.entity.DiaChiGiaoHang;
import vn.fpoly.ql_ban_giay.repository.DiaChiGiaoHangRepo;

import java.util.List;

@Service
public class DiaChiGiaoHangService {
    @Autowired
    private DiaChiGiaoHangRepo diaChiGiaoHangRepo;

    public List<DiaChiGiaoHang> getAllDiaChiGiaoHang() {
        return diaChiGiaoHangRepo.findAll();
    }
}
