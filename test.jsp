<%@ page language="java" import="java.util.*,java.sql.*, com.*"
contentType="text/html; charset=utf-8"%>

<%
	MysqlConnector conn = new MysqlConnector();
	ArrayList<HashMap<String, String>> block_list = conn.getTableData("plate");
	System.out.println(block_list.size());
%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<style>
	h3
	{
		white-space: pre-wrap;
	}
</style>
</head>
<body>
	<h3> test <%= request.getParameter("reply_content") %> </h3>
	
	<%-- <% 
		String jspName = this.getClass().getSimpleName().replaceAll("_", "."); 
		String url = new String(jspName);
		String query = "back=" + url + "&" + request.getQueryString();
	%>
	<form name="f1" id="f1" action="<%="uploadFile.jsp?" + query%>"  method="POST" enctype="multipart/form-data">
		<input type="file" name="txt1" size=100> 
		<input type="submit" value="OK">
	</form> --%>
	<form action="test.jsp" methon="post">
		<input type="hidden" name="test_key" value="test_val">
		<textarea  class="editor-text" name="reply_content"></textarea>
		<button class="editor-btn" type="submit" onclick="return onReply()">
            回复
        </button>
	</form>
	<p>
		提示信息: <span id="txtHint"></span>
	</p>
	<script>
		function onReply()
		{
			var reply_content = document.querySelector(".editor-text").value;
			if (reply_content == "")
			{
				alert("回复内容不能为空");
				return false;
			}
			alert((reply_content == "换行\n\n换行"));
			reply_content = reply_content.replace('<br />','/n');
			alert(reply_content);
			return true;
			window.location.href="test.jsp?content="+content;
		}
	</script>
</body>
</html>
