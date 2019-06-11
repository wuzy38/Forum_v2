<%@ page language="java" import="java.util.*"
	contentType="text/html;charset=utf-8"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
</head>
<body>
	<h3>test</h3>
	
	<% 
		String jspName = this.getClass().getSimpleName().replaceAll("_", "."); 
		String url = new String(jspName);
		String query = "back=" + url + "&" + request.getQueryString();
	%>
	<form name="f1" id="f1" action="<%="uploadFile.jsp?" + query%>"  method="POST" enctype="multipart/form-data">
		<input type="file" name="txt1" size=100> 
		<input type="submit" value="OK">
	</form>

	<p>
		提示信息: <span id="txtHint"></span>
	</p>

</body>
</html>
