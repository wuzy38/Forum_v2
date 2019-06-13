<%@ page language="java" import="java.util.*,java.sql.*, com.*"
contentType="text/html; charset=utf-8"%>

<%
	MysqlConnector conn = new MysqlConnector();
	ArrayList<HashMap<String, String>> block_list = conn.getTableData("plate");
	System.out.println(block_list.size());
%>
