<%@ page language="java" import="java.util.*,java.sql.*, com.*"
contentType="text/html; charset=utf-8"%>
<h1>test</h1>
<% 
	MysqlConnector conn = new MysqlConnector();
	ArrayList<HashMap<String, String>> res = conn.GetUserData();
	for(int i = 0 ; i < res.size() ; i++) {
		out.write(res.get(i).get("user_name"));
	}
%>

