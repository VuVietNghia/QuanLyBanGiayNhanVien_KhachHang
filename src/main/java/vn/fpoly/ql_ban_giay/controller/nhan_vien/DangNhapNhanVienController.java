package vn.fpoly.ql_ban_giay.controller.nhan_vien;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.fpoly.ql_ban_giay.entity.NhanVien;
import vn.fpoly.ql_ban_giay.service.NhanVienService;

@Controller
public class DangNhapNhanVienController {
    @Autowired
    private NhanVienService nhanVienService;

    @GetMapping("/dangNhapNhanVien")
    public String dangNhapNhanVien() {
        return "login/DangNhapNhanVien";
    }

    @PostMapping("/loginNhanVien")
    public String loginNhanVien(@RequestParam String email,
                                @RequestParam String password,
                                HttpSession session,
                                RedirectAttributes redirectAttributes,
                                Model model) {
        NhanVien nguoiDung = nhanVienService.loginNhanVien(email, password);
        if (nguoiDung == null) {
            redirectAttributes.addFlashAttribute("error", "Email hoặc mật khẩu không đúng!");
            return "redirect:/dangNhapNhanVien";
        }
        if (!nguoiDung.getTrangThai()) {
            redirectAttributes.addFlashAttribute("error", "Tài khoản của bạn đã bị khóa!");
            return "redirect:/dangNhapNhanVien";
        }
        Integer role = nguoiDung.getRole();
        if (role == null) {
            redirectAttributes.addFlashAttribute("error", "Vai trò không hợp lệ!");
            return "redirect:/dangNhapNhanVien";
        }
        session.setAttribute("loggedInUser", nguoiDung); // Store user in session
        if (role == 1) {
            model.addAttribute("template", "admin_nhanVien/Dashboard");
            return "layout/AdminLayout";
        } else if (role == 2) {
            model.addAttribute("template", "admin_nhanVien/Dashboard");
            return "layout/NhanVienLayout";
        }
        redirectAttributes.addFlashAttribute("error", "Vai trò không hợp lệ!");
        return "redirect:/dangNhapNhanVien";
    }

    @GetMapping("/dangXuatNhanVien")
    public String dangXuatNhanVien(HttpSession session) {
        session.invalidate();
        return "redirect:/dangNhapNhanVien";
    }
}