import java.util.*;
import java.sql.*;
// package com;

public class MysqlConnector {
    // private connStr;
    private Connection con;
    private Statement stmt;

    public static void main(String[] args) {
        System.out.println(111);
        MysqlConnector test = new MysqlConnector();
        System.out.println(test.checkPassword("user_name999", "password999"));
    }

    public MysqlConnector() {
        String connStr = "jdbc:mysql://localhost:3306/forum?serverTimezone=GMT"
                + "&useUnicode=true&characterEncoding=utf-8";

        con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // 数据库驱动
            con = DriverManager.getConnection(connStr, "root", "88720073");
        } catch (Exception e) {
            String msg = e.getMessage();
            // out.write(msg);
            System.out.println(msg);
        }
    }

    public boolean checkPassword(String user, String password) {
        // stmt = con.createStatement(); //创建mysql对象
        try {
            String table = "";
            String sql = "select * from user where user_name = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, user);
            ResultSet result = ps.executeQuery();
            while (result.next()) { // cuscor移到下一个记录
                table = result.getString("user_password"); // 如果还有记录，就得到数据
                if (table == password) {
                    return true;
                }
            }
            result.close();
            con.close();

        } catch (Exception e) {
            String msg = e.getMessage();
            // out.write(msg);
            System.out.println(msg);
        }
        return false;

    }

    // public GetUserData(){
    // }
    // public Get


}