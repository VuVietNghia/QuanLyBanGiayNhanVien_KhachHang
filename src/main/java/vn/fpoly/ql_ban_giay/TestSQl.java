package vn.fpoly.ql_ban_giay;

import java.sql.Connection;
import java.sql.DriverManager;

public class TestSQl {
    public static void main(String[] args) {
        String url = "jdbc:sqlserver://localhost:1433;databaseName=HyperWalk;user=sa;password=123456;encrypt=true;trustServerCertificate=true;";

        try (Connection conn = DriverManager.getConnection(url)) {
            if (conn != null) {
                System.out.println("✅ Kết nối SQL Server thành công!");
            }
        } catch (Exception e) {
            System.out.println("❌ Lỗi kết nối: " + e.getMessage());
        }
    }
}


