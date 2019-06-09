import java.util.*;
import java.sql.*;
// package com;

public class MysqlConnector{
    private String connStr;
    private Connection con;
    private Statement stmt;
    public static void main(String[] args){
        MysqlConnector test = new MysqlConnector();
        
    }
    public MysqlConnector(){
        connStr = "jdbc:mysql://localhost:3306/forum?serverTimezone=GMT" 
        + "useUnicode=true&characterEncoding=utf-8";
        String msg=""; 
        String table="";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); //数据库驱动
            con = DriverManager.getConnection(connStr, "root", "88720073"); 
            stmt = con.createStatement();   //创建mysql对象
            ResultSet result = stmt.executeQuery("select * from user"); //执行，返回结果
            while(result.next()) {                  //cuscor移到下一个记录
                table=result.getString("user_name"); //如果还有记录，就得到数据
                System.out.println(table);
            }
            System.out.println("theme");
            result=stmt.executeQuery("select * from theme");
            while(result.next()) {               
                table=result.getString("theme_id"); 
                System.out.println(table);
            }
            result.close(); 
            stmt.close();
            con.close();
        }
        catch (Exception e){
            msg = e.getMessage();
            System.out.println(msg);
        }
    }
    
    // public GetUserData(){
    // }
    // public Get
    

}