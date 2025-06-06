package vn.fpoly.ql_ban_giay.controller.nhan_vien;

import jakarta.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.fpoly.ql_ban_giay.entity.NhanVien;
import vn.fpoly.ql_ban_giay.service.NhanVienService;

import jakarta.validation.Valid;

@Controller
public class QL_NhanVienController {
    private static final Logger log = LoggerFactory.getLogger(QL_NhanVienController.class);

    @Autowired
    private NhanVienService nhanVienService;

    private boolean isLoggedIn(HttpSession session) {
        return session.getAttribute("loggedInUser") != null;
    }

    private boolean isAdmin(HttpSession session) {
        NhanVien user = (NhanVien) session.getAttribute("loggedInUser");
        return user != null && user.getRole() != null && user.getRole() == 1;
    }

    private String getLayout(HttpSession session) {
        NhanVien user = (NhanVien) session.getAttribute("loggedInUser");
        return user != null && user.getRole() != null && user.getRole() == 1 ? "layout/AdminLayout" : "layout/NhanVienLayout";
    }

    @GetMapping("/quan-ly/nhan-vien")
    public String quanLyNhanVien(@RequestParam(name = "pageNV", defaultValue = "0") int pageNV,
                                 @RequestParam(name = "sizeNV", defaultValue = "5") int sizeNV,
                                 Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!isLoggedIn(session)) {
            log.warn("Unauthorized access attempt to /quan-ly/nhan-vien without loggedInUser in session");
            redirectAttributes.addFlashAttribute("error", "Vui lòng đăng nhập!");
            return "redirect:/dangNhapNhanVien";
        }
        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("error", "Bạn không có quyền truy cập!");
            return "redirect:/dashboard";
        }

        try {
            Page<NhanVien> pageNhanVien = nhanVienService.getAllNhanVien(pageNV, sizeNV);
            model.addAttribute("currentPage", pageNV);
            model.addAttribute("tongTrang", pageNhanVien.getTotalPages());
            model.addAttribute("listNV", pageNhanVien);
            model.addAttribute("newNV", new NhanVien());
            model.addAttribute("template", "admin_nhanVien/QuanLyNhanVien");
            return getLayout(session);
        } catch (Exception e) {
            log.error("Error fetching employee list: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("error", "Lỗi khi tải danh sách nhân viên!");
            return "redirect:/dashboard";
        }
    }

    @PostMapping("/admin/nhanVien/them")
    public String addNhanVien(@Valid @ModelAttribute("newNV") NhanVien nhanVien,
                              BindingResult result,
                              @RequestParam(name = "pageNV", defaultValue = "0") int pageNV,
                              @RequestParam(name = "sizeNV", defaultValue = "5") int sizeNV,
                              HttpSession session, RedirectAttributes redirectAttributes) {
        if (!isLoggedIn(session) || !isAdmin(session)) {
            redirectAttributes.addFlashAttribute("error", "Bạn không có quyền truy cập!");
            return "redirect:/dashboard";
        }
        if (result.hasErrors()) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng điền đầy đủ và đúng định dạng các trường!");
            return "redirect:/quan-ly/nhan-vien?pageNV=" + pageNV + "&sizeNV=" + sizeNV;
        }
        try {
            NhanVien loggedInUser = (NhanVien) session.getAttribute("loggedInUser");
            String createdBy = loggedInUser != null && loggedInUser.getHoTenNv() != null ? loggedInUser.getHoTenNv() : "System";
            nhanVien.setTrangThai(true); // Mặc định trạng thái hoạt động
            nhanVienService.saveNhanVien(nhanVien, createdBy);
            redirectAttributes.addFlashAttribute("success", "Thêm nhân viên thành công!");
        } catch (IllegalArgumentException e) {
            log.error("Error adding employee: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        } catch (Exception e) {
            log.error("Unexpected error adding employee: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("error", "Lỗi khi thêm nhân viên!");
        }
        return "redirect:/quan-ly/nhan-vien?pageNV=" + pageNV + "&sizeNV=" + sizeNV;
    }

    @GetMapping("/admin/nhanVien/sua/{id}")
    public String showEditNhanVienForm(@PathVariable("id") Integer id,
                                       @RequestParam(name = "pageNV", defaultValue = "0") int pageNV,
                                       @RequestParam(name = "sizeNV", defaultValue = "5") int sizeNV,
                                       Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        if (!isLoggedIn(session) || !isAdmin(session)) {
            redirectAttributes.addFlashAttribute("error", "Bạn không có quyền truy cập!");
            return "redirect:/dashboard";
        }
        NhanVien nhanVien = nhanVienService.getNhanVienById(id);
        if (nhanVien == null) {
            redirectAttributes.addFlashAttribute("error", "Nhân viên không tồn tại hoặc đã bị xóa!");
            return "redirect:/quan-ly/nhan-vien?pageNV=" + pageNV + "&sizeNV=" + sizeNV;
        }
        model.addAttribute("nhanVien", nhanVien);
        model.addAttribute("currentPage", pageNV);
        model.addAttribute("sizeNV", sizeNV);
        return getLayout(session);
    }

    @PostMapping("/admin/nhanVien/sua")
    public String updateNhanVien(@Valid @ModelAttribute("nhanVien") NhanVien nhanVien,
                                 BindingResult result,
                                 @RequestParam(name = "pageNV", defaultValue = "0") int pageNV,
                                 @RequestParam(name = "sizeNV", defaultValue = "5") int sizeNV,
                                 HttpSession session, RedirectAttributes redirectAttributes) {
        if (!isLoggedIn(session) || !isAdmin(session)) {
            redirectAttributes.addFlashAttribute("error", "Bạn không có quyền truy cập!");
            return "redirect:/dashboard";
        }
        if (result.hasErrors()) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng điền đầy đủ và đúng định dạng các trường!");
            return "redirect:/admin/nhanVien/sua/" + nhanVien.getId() + "?pageNV=" + pageNV + "&sizeNV=" + sizeNV;
        }
        try {
            NhanVien loggedInUser = (NhanVien) session.getAttribute("loggedInUser");
            String updatedBy = loggedInUser != null && loggedInUser.getHoTenNv() != null ? loggedInUser.getHoTenNv() : "System";
            nhanVienService.updateNhanVien(nhanVien, updatedBy);
            redirectAttributes.addFlashAttribute("success", "Cập nhật nhân viên thành công!");
        } catch (IllegalArgumentException e) {
            log.error("Error updating employee: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        } catch (Exception e) {
            log.error("Unexpected error updating employee: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("error", "Lỗi khi cập nhật nhân viên!");
        }
        return "redirect:/quan-ly/nhan-vien?pageNV=" + pageNV + "&sizeNV=" + sizeNV;
    }

    @GetMapping("/admin/nhanVien/xoa/{id}")
    public String deleteNhanVien(@PathVariable("id") Integer id,
                                 @RequestParam(name = "pageNV", defaultValue = "0") int pageNV,
                                 @RequestParam(name = "sizeNV", defaultValue = "5") int sizeNV,
                                 HttpSession session, RedirectAttributes redirectAttributes) {
        if (!isLoggedIn(session) || !isAdmin(session)) {
            redirectAttributes.addFlashAttribute("error", "Bạn không có quyền truy cập!");
            return "redirect:/dashboard";
        }
        try {
            NhanVien loggedInUser = (NhanVien) session.getAttribute("loggedInUser");
            String updatedBy = loggedInUser != null && loggedInUser.getHoTenNv() != null ? loggedInUser.getHoTenNv() : "System";
            nhanVienService.deleteNhanVien(id, updatedBy);
            redirectAttributes.addFlashAttribute("success", "Xóa nhân viên thành công!");
        } catch (IllegalArgumentException e) {
            log.error("Error deleting employee: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        } catch (Exception e) {
            log.error("Unexpected error deleting employee: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("error", "Lỗi khi xóa nhân viên!");
        }
        return "redirect:/quan-ly/nhan-vien?pageNV=" + pageNV + "&sizeNV=" + sizeNV;
    }
}