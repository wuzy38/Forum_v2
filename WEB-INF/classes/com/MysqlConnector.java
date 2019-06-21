package com;
import java.util.*;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.sql.*;
// 

public class MysqlConnector {
    private Connection con;
    
    public static void main(String[] args) {
        MysqlConnector test = new MysqlConnector();
        System.out.println(test.getTableData("plate").size());
//        System.out.println(test.inUserName("user_name999"));
//        System.out.println(test.checkPassword("user_name999", "password999"));
//        ArrayList<HashMap<String, String>> res = test.getTableData("user");
//        for(int i = 0 ; i < res.size() ; i++) {
//        	System.out.println(res.get(i).get("user_name"));
//        }

//        List< HashMap<String, String>> a = test.getThemeInOrder(1, 2);
//        for(int i = 0 ; i < a.size(); i++) {
//        	HashMap<String, String> hm = a.get(i);
//        	Iterator<String> it = hm.keySet().iterator();
//            while(it.hasNext()) { // 无序遍历
//    	        String key = it.next();
//    	        String value = hm.get(key); // 根据键值取出值
//    	        System.out.print(value + " ");
//            }
//            System.out.println();
//        }
        System.out.println(test.getTableData("plate").size());
        System.out.println(test.getThemeInOrder(-1, 3).size());
        test.incClickNum(1);
    }

    public MysqlConnector() {
//        String connStr = "jdbc:mysql://172.18.35.138:3306/forum?serverTimezone=GMT"
//                + "&useUnicode=true&characterEncoding=utf-8";
      String connStr = "jdbc:mysql://172.18.187.10:3306/16337254_forum?serverTimezone=GMT"
      + "&useUnicode=true&characterEncoding=utf-8";
        con = null;
        try {
            Class.forName("com.mysql.jdbc.Driver"); // 数据库驱动
            con = DriverManager.getConnection(connStr, "user", "123");
        } catch (Exception e) {
            String msg = e.getMessage();
            System.out.println(msg);
        }
    }

    public boolean checkPassword(String user, String password) {
        try{
            String table = "";
            String sql = "select * from user where user_name = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, user);
            ResultSet result = ps.executeQuery();
            while (result.next()) {
                table = result.getString("user_password");
                if (table.equals(password) ) {
                    return true;
                }
            }
            result.close();
        } catch(Exception e){
            String msg = e.getMessage();
            System.out.println("checkpasswordExp:" + msg);
        }
        return false;   
    }
    
    public boolean inUserName(String user_name) {
    	try{
            String sql = "select * from user where user_name = ?";
            PreparedStatement pstm = con.prepareStatement(sql);
            pstm.setString(1, user_name);
            ResultSet result = pstm.executeQuery();
            if(result.next())
            	return true;
            result.close();
        } catch(Exception e){
            String msg = e.getMessage();
            System.out.println("inUserNameExp:" + msg);
        }
        return false;  
    }
    
    public ArrayList<HashMap<String, String>> getTableData(String tableName){
    	ArrayList<HashMap<String, String>> result = new ArrayList<HashMap<String, String>>();
    	try {
    		PreparedStatement pstm = con.prepareStatement("select * from " + tableName);
    		ResultSet rs = pstm.executeQuery();
    		result = convertToList(rs);
    	} catch(Exception e) {
    		String msg = e.getMessage();
    		System.out.println(msg);
    	}
    	return result;
    }
    
    public boolean addUser(String user, String password) {
    	// test
    	int num = 0;
    	try{
            String sql = "SELECT max(user_id) FROM user";
            PreparedStatement pstm = con.prepareStatement(sql);
            ResultSet result = pstm.executeQuery();
            if(result.next())
            	num = result.getInt(1) + 1;
            result.close();
            sql = "insert into user(user_id, user_name, register_time, grade, user_password, photo)" 
            		+ "values(?, ?, ?, 0, ?, ?)";
            pstm = con.prepareStatement(sql);
            pstm.setInt(1, num);
            pstm.setString(2, user);
            String time_str = getTimeString();
            pstm.setString(3, time_str);
            pstm.setString(4, password);
            pstm.setString(5, "default.jpg");
            int influcenced_row = pstm.executeUpdate();
            if(influcenced_row > 0) return true;
        } catch(Exception e) {
        	String msg = e.getMessage();
        	System.out.println(msg);
        }
    	return false;
    }
    
    public int addTheme(String theme_name, int plate_id, int user_id) {
    	// test
    	int num = -1;
    	try {
    		String sql = "select max(theme_id) from theme";
    		PreparedStatement pstm = con.prepareStatement(sql);
            ResultSet result = pstm.executeQuery();
            if(result.next())
            	num = result.getInt(1) + 1;
            result.close();
            sql = "insert into theme(theme_id, theme_name, theme_time, plate_id, user_id"
            		+ ", click_num, newest_reply, reply_cnt, themecol) VALUES"
            		+ "(?, ?, ?, ?, ?, ? , ?, ?, ?)";
            pstm = con.prepareStatement(sql);
            pstm.setInt(1, num);
            pstm.setString(2, theme_name);
            pstm.setString(3, getTimeString());
            pstm.setInt(4, plate_id);
            pstm.setInt(5, user_id);
            pstm.setInt(6, 0);
            pstm.setString(7, getTimeString());
            pstm.setInt(8, 0);
            pstm.setString(9, "");
            int influcenced_row = pstm.executeUpdate();
            if(influcenced_row > 0) return num;
    	}catch(Exception e) {
    		String msg = e.getMessage();
    		System.out.println(msg);
    		num = -1;
    	}
    	return num;
    }
    
    public boolean addReply(int user_id, String content, int theme_id) {
    	// test
    	try {
    		int num = 0;
    		String sql = "select max(reply_id) from reply";
    		PreparedStatement pstm = con.prepareStatement(sql);
            ResultSet result = pstm.executeQuery();
            if(result.next())
            	num = result.getInt(1) + 1;
            result.close();
            sql = "insert into reply(reply_id, user_id, content, reply_time, theme_id) VALUES"
            		+ "(?, ?, ?, ?, ?)";
            pstm = con.prepareStatement(sql);
            pstm.setInt(1, num);
            pstm.setInt(2, user_id);
            pstm.setString(3, content);
            pstm.setString(4, getTimeString());
            pstm.setInt(5, theme_id);
            int influcenced_row = pstm.executeUpdate();
            if(influcenced_row > 0) return true;
    	}catch(Exception e) {
    		String msg = e.getMessage();
    		System.out.println(msg);
    	}
    	return false;
    }
    
    public HashMap<String, String> getRowByID(String table_name, int id){
    	// test
    	HashMap<String, String> res = new HashMap<String, String>();
    	ArrayList<HashMap<String, String>> result = new ArrayList<HashMap<String, String>>();
    	try {
    		PreparedStatement pstm = con.prepareStatement("select * from "+ table_name 
    						+  " where " + table_name + "_id = ?");
    		pstm.setInt(1, id);
    		ResultSet rs = pstm.executeQuery();
    		result = convertToList(rs);
    		if(result.size() > 0) {
    			res = result.get(0);
    		}
    	} catch(Exception e) {
    		String msg = e.getMessage();
    		System.out.println(msg);
    	}
    	return res;
    }
    
    public int getIDbyUsername(String user_name) {
    	int res = -1;
    	try {
    		String sql = "select user_id from user where user_name = ?";
    		PreparedStatement pstm = con.prepareStatement(sql);
    		pstm.setString(1, user_name);
    		ResultSet rs = pstm.executeQuery();		
    		if(rs.next()) {
    			res = rs.getInt(1);
    		}
    		return res;
    	}
    	catch(Exception e) {
    		String msg = e.getMessage();
    		System.out.println(msg);
    	}
    	return res;
    }
     
    public ArrayList<HashMap<String, String>> getThemeInOrder(int plate_id, int sort_type){
    	String order = "newest_reply desc";
    	if(sort_type == 1) {
    		order = "newest_reply desc";
    	}
    	if(sort_type == 2) {
    		order = "theme_time desc";
    	}
    	if(sort_type == 3) {
    		order = "reply_cnt desc";
    	}
    	ArrayList<HashMap<String, String>> result = new ArrayList<HashMap<String, String>>();
    	try {
    		String tmp = "where plate_id = ?";
    		if(plate_id <= 0) {
    			tmp = " ";
    		}
    		String sql = "select * from theme "+ tmp + " order by "+ order;
    		PreparedStatement pstm = con.prepareStatement(sql);
    		if(plate_id > 0) {
    			pstm.setInt(1, plate_id);
    		}
    		ResultSet rs = pstm.executeQuery();
    		result = convertToList(rs);
    	} catch(Exception e) {
    		String msg = e.getMessage();
    		System.out.println(msg);
    	}
    	return result;
    }
    
    public ArrayList<HashMap<String, String>> getReplyByThemeID(int theme_id){
    	ArrayList<HashMap<String, String>> result = new ArrayList<HashMap<String, String>>();
    	try {
    		String sql = "select * from reply where theme_id = ?";
    		PreparedStatement pstm = con.prepareStatement(sql);
    		pstm.setInt(1, theme_id);
    		ResultSet rs = pstm.executeQuery();
    		result = convertToList(rs);
    	}catch(Exception e) {
    		String msg = e.getMessage();
    		System.out.println(msg);
    	}
    	return result;
    }
    
    
    public ArrayList<HashMap<String, String>> getThemeByContent(String content){
    	ArrayList<HashMap<String, String>> result = new ArrayList<HashMap<String, String>>();
    	try {
    		String sql = "select * from theme where theme_name like ?";
    		PreparedStatement pstm = con.prepareStatement(sql);
    		pstm.setString(1, "%" + content + "%" );
    		ResultSet rs = pstm.executeQuery();
    		result = convertToList(rs);
    	}catch(Exception e) {
    		String msg = e.getMessage();
    		System.out.println(msg);
    	}
    	return result;
    }
    
    public void incClickNum(int theme_id) {
    	try {
    		String sql = "update theme set click_num = click_num + 1 where theme_id = ?";
    		PreparedStatement pstm = con.prepareStatement(sql);
    		pstm.setInt(1, theme_id);
    		pstm.executeUpdate();
    	}catch(Exception e) {
    		String msg = e.getMessage();
    		System.out.println(msg);
    	}
    	return;
    }
    
    
    private String getTimeString() {
    	Date date = new Date(); 
        Timestamp time = new Timestamp(date.getTime());
        String time_str = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(time);
        return time_str;
    }
    
    
    private static ArrayList<HashMap<String, String>> convertToList(ResultSet rs) throws Exception {
    	ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
    	ResultSetMetaData md = rs.getMetaData(); // 获取键名
    	int columnCount = md.getColumnCount();// 列数量
    	while (rs.next()) {
    		HashMap<String, String> rowData = new HashMap<String, String>();// 声明Map
    		for (int i = 1; i <= columnCount; i++) {
    			rowData.put(md.getColumnName(i), rs.getString(i));// 获取键名及值
    		}
    		list.add(rowData);
    	}
    	return list;
    }
    
    
    
    
    
}