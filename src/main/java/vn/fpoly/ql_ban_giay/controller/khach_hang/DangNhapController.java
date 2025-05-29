package vn.fpoly.ql_ban_giay.controller.khach_hang;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.fpoly.ql_ban_giay.entity.KhachHang;
import vn.fpoly.ql_ban_giay.service.KhachHangService;

@Controller
public class DangNhapController {
    @Autowired
    private KhachHangService khachHangService;

    @GetMapping("/dangNhapKhachHang")
    public String dangNhapKhachHang() {
        return "login/DangNhapKhachHang";
    }

    @PostMapping("/loginKhachHang")
    public String loginKhachHang(@RequestParam String email,
                                 @RequestParam String password,
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes) {
        KhachHang khachHang = khachHangService.loginKhachHang(email, password);
        if (khachHang == null) {
            redirectAttributes.addFlashAttribute("error", "Email hoặc mật khẩu không đúng!");
            return "redirect:/dangNhapKhachHang";
        }
        if (!khachHang.getTrangThai()) {
            redirectAttributes.addFlashAttribute("error", "Tài khoản của bạn đã bị khóa!");
            return "redirect:/dangNhapKhachHang";
        }
        session.setAttribute("loggedInKhachHang", khachHang);
        return "layout/KhachHangLayout";
    }

    @GetMapping("/dangXuatKhachHang")
    public String dangXuatKhachHang(HttpSession session) {
        session.invalidate();
        return "login/DangNhapKhachHang";
    }
}