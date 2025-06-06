package vn.fpoly.ql_ban_giay.controller.nhan_vien;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.fpoly.ql_ban_giay.entity.KhachHang;
import vn.fpoly.ql_ban_giay.entity.NhanVien;
import vn.fpoly.ql_ban_giay.service.DiaChiGiaoHangService;
import vn.fpoly.ql_ban_giay.service.KhachHangService;

@Controller
public class QL_KhachHangController {

    @Autowired
    private KhachHangService khachHangService;

    @Autowired
    private DiaChiGiaoHangService diaChiGiaoHangService;

    private boolean isLoggedIn(HttpSession session) {
        return session.getAttribute("loggedInUser") != null;
    }

    private String getLayout(HttpSession session) {
        NhanVien user = (NhanVien) session.getAttribute("loggedInUser");
        return user != null && user.getRole() != null && user.getRole() == 1 ? "layout/AdminLayout" : "layout/NhanVienLayout";
    }

    @GetMapping("/quan-ly/khach-hang")
    public String quanLyKhachHang(@RequestParam(name = "pageKH", defaultValue = "0") int pageKH,
                                  @RequestParam(name = "sizeKH", defaultValue = "5") int sizeKH,
                                  Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!isLoggedIn(session)) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập!");
            return "redirect:/dangNhapNhanVien";
        }

        Page<KhachHang> pageKhachHang = khachHangService.getAllKhachHangNotDeleted(pageKH, sizeKH);
        model.addAttribute("trangDau", pageKH);
        model.addAttribute("tongTrang", pageKhachHang.getTotalPages());
        model.addAttribute("listKH", pageKhachHang);
        model.addAttribute("newKH", new KhachHang());
        model.addAttribute("diaChiGiaoHang", diaChiGiaoHangService.getAllDiaChiGiaoHangNotDeleted());
        model.addAttribute("template", "admin_nhanVien/QuanLyKhachHang");
        return getLayout(session);
    }

    @GetMapping("/quan-ly/khach-hang/edit/{id}")
    public String editKhachHang(@PathVariable("id") Integer id, Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!isLoggedIn(session)) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập!");
            return "redirect:/dangNhapNhanVien";
        }

        KhachHang khachHang = khachHangService.getByIdKhachHang(id);
        if (khachHang == null || khachHang.getIsDeleted()) {
            redirectAttributes.addFlashAttribute("error", "Khách hàng không tồn tại hoặc đã bị xóa!");
            return "redirect:/quan-ly/khach-hang";
        }

        NhanVien nhanVien = (NhanVien) session.getAttribute("loggedInUser");
        String updatedBy = nhanVien != null && nhanVien.getHoTenNv() != null ? nhanVien.getHoTenNv() : "System";
        khachHang.setTrangThai(!khachHang.getTrangThai()); // Đảo ngược trạng thái
        khachHangService.saveKhachHang(khachHang, updatedBy); // Gán updateBy
        redirectAttributes.addFlashAttribute("type", "Cập nhật trạng thái khách hàng thành công!");
        return "redirect:/quan-ly/khach-hang";
    }

    @GetMapping("/quan-ly/khach-hang/delete/{id}")
    public String deleteKhachHang(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes,
                                  HttpSession session) {
        if (!isLoggedIn(session)) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập!");
            return "redirect:/dangNhapNhanVien";
        }

        KhachHang khachHang = khachHangService.getByIdKhachHang(id);
        if (khachHang == null || khachHang.getIsDeleted()) {
            redirectAttributes.addFlashAttribute("error", "Khách hàng không tồn tại hoặc đã bị xóa!");
            return "redirect:/quan-ly/khach-hang";
        }

        NhanVien nhanVien = (NhanVien) session.getAttribute("loggedInUser");
        String updatedBy = nhanVien != null && nhanVien.getHoTenNv() != null ? nhanVien.getHoTenNv() : "System";
        khachHang.setIsDeleted(true);
        khachHangService.saveKhachHang(khachHang, updatedBy); // Gán updateBy
        redirectAttributes.addFlashAttribute("type", "Xóa khách hàng thành công!");
        return "redirect:/quan-ly/khach-hang";
    }
}