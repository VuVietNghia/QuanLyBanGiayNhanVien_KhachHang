package vn.fpoly.ql_ban_giay.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.fpoly.ql_ban_giay.entity.NhanVien;

@Controller
public class HomeController {

    private boolean isAdmin(HttpSession session) {
        NhanVien user = (NhanVien) session.getAttribute("loggedInUser");
        return user != null && user.getRole() != null && user.getRole() == 1;
    }

    private boolean isLoggedIn(HttpSession session) {
        return session.getAttribute("loggedInUser") != null;
    }

    private String getLayout(HttpSession session) {
        NhanVien user = (NhanVien) session.getAttribute("loggedInUser");
        return user != null && user.getRole() != null && user.getRole() == 1 ? "layout/AdminLayout" : "layout/NhanVienLayout";
    }

    @GetMapping("/quay-ly/ban-hang")
    public String quayHang(Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!isLoggedIn(session)) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập!");
            return "redirect:/dangNhapNhanVien";
        }
        model.addAttribute("template", "admin_nhanVien/QuanLyBanHangVaHoaDon");
        return getLayout(session);
    }

    @GetMapping("/quan-ly/danh-gia")
    public String danhGia(Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!isLoggedIn(session)) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập!");
            return "redirect:/dangNhapNhanVien";
        }
        model.addAttribute("template", "admin_nhanVien/QuanLyDanhGia");
        return getLayout(session);
    }

    @GetMapping("/quan-ly/doanh-thu")
    public String doanhThu(Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!isLoggedIn(session)) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập!");
            return "redirect:/dangNhapNhanVien";
        }
        model.addAttribute("template", "admin_nhanVien/QuanLyDoanhThu");
        return getLayout(session);
    }

    @GetMapping("/quan-ly/giay")
    public String giay(Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!isLoggedIn(session)) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập!");
            return "redirect:/dangNhapNhanVien";
        }
        model.addAttribute("template", "admin_nhanVien/QuanLyGiay");
        return getLayout(session);
    }

    @GetMapping("/quan-ly/ho-tro")
    public String hoTro(Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!isLoggedIn(session)) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập!");
            return "redirect:/dangNhapNhanVien";
        }
        model.addAttribute("template", "admin_nhanVien/QuanLyHoTro");
        return getLayout(session);
    }

    @GetMapping("/quan-ly/khach-hang")
    public String khachHang(Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!isLoggedIn(session)) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập!");
            return "redirect:/dangNhapNhanVien";
        }
        model.addAttribute("template", "admin_nhanVien/QuanLyKhachHang");
        return getLayout(session);
    }

    @GetMapping("/quan-ly/nhan-vien")
    public String nhanVien(Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!isLoggedIn(session)) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập!");
            return "redirect:/dangNhapNhanVien";
        }
        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("error", "Bạn không có quyền truy cập!");
            return "redirect:/dashboard";
        }
        model.addAttribute("template", "admin_nhanVien/QuanLyNhanVien");
        return "layout/AdminLayout";
    }

    @GetMapping("/quan-ly/voucher")
    public String voucher(Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!isLoggedIn(session)) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập!");
            return "redirect:/dangNhapNhanVien";
        }
        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("error", "Bạn không có quyền truy cập!");
            return "redirect:/dashboard";
        }
        model.addAttribute("template", "admin_nhanVien/QuanLyVoucher");
        return "layout/AdminLayout";
    }

    @GetMapping("/home")
    public String trangChu() {
        return "TrangChu";
    }

    @GetMapping("/dashboard")
    public String adminDashboard(Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!isLoggedIn(session)) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập!");
            return "redirect:/dangNhapNhanVien";
        }
        model.addAttribute("template", "admin_nhanVien/Dashboard");
        return getLayout(session);
    }
}