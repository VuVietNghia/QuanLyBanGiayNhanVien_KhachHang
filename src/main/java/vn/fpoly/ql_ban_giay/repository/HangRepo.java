package vn.fpoly.ql_ban_giay.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import vn.fpoly.ql_ban_giay.entity.Hang;

public interface HangRepo extends JpaRepository<Hang, Integer> {
}
