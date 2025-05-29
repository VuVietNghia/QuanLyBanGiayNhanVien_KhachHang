package vn.fpoly.ql_ban_giay.controller.khach_hang;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.fpoly.ql_ban_giay.entity.KhachHang;
import vn.fpoly.ql_ban_giay.service.KhachHangService;

import jakarta.validation.Valid;
import java.time.LocalDateTime;

@Controller
public class DangKyController {
    @Autowired
    private KhachHangService khachHangService;

    @GetMapping("/dangKyKhachHang")
    public String dangKyKhachHang(Model model, @RequestParam(name = "page", defaultValue = "0") int page,
                                  @RequestParam(name = "size", defaultValue = "5") int size) {
        Page<KhachHang> listKH = khachHangService.getAllKhachHang(page, size);
        model.addAttribute("listKH", listKH);
        model.addAttribute("newKH", new KhachHang());
        return "login/DangKyKhachHang";
    }

    @PostMapping("/dangKyKhachHang_register")
    public String dangKyKhachHang(@Valid @ModelAttribute("newKH") KhachHang khachHang,
                                  BindingResult result, Model model, RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            model.addAttribute("message", "Vui lòng điền đầy đủ và đúng định dạng các trường!");
            return "login/DangKyKhachHang";
        }

        if (khachHangService.checkEmailKhachHang(khachHang.getEmail())) {
            model.addAttribute("message", "Email đã tồn tại!");
            return "login/DangKyKhachHang";
        }

        if (khachHangService.checkEmailNhanVien(khachHang.getEmail())) {
            model.addAttribute("message", "Email đã tồn tại!");
            return "login/DangKyKhachHang";
        }

        if (khachHang.getPassword() == null || khachHang.getPassword().isEmpty()) {
            model.addAttribute("message", "Mật khẩu không được để trống!");
            return "login/DangKyKhachHang";
        }

        khachHang.setTrangThai(true);
        khachHang.setNgayDangKy(LocalDateTime.now());
        khachHangService.saveKhachHang(khachHang);
        redirectAttributes.addFlashAttribute("successMessage", "Đăng ký tài khoản thành công!");
        return "redirect:/dangKyKhachHang";
    }
}