<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.io.*,java.util.*"%>
<%@ page import="org.apache.commons.io.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
	%>
	<%
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);//是否用multipart提交的?
		if (isMultipart) {
			
			FileItemFactory factory = new DiskFileItemFactory();
			//factory.setSizeThreshold(yourMaxMemorySize);   //设置使用的内存最大值
			//factory.setRepository(yourTempDirectory);   //设置文件临时目录
			ServletFileUpload upload = new ServletFileUpload(factory);
			//upload.setSizeMax(yourMaxRequestSize); //允许的最大文件尺寸
			List items = upload.parseRequest(request);
			out.print(items.size());
			for (int i = 0; i < items.size(); i++) {
				FileItem fi = (FileItem) items.get(i);
				if (fi.isFormField()) {//如果是表单字段
					out.print(fi.getFieldName() + ":" + fi.getString("utf-8"));

				} else {//如果是文件
					DiskFileItem dfi = (DiskFileItem) fi;
					System.out.println(dfi.getName().trim());
					if (!dfi.getName().trim().equals("")) {//getName()返回文件名称或空串
						out.print("文件被上传到服务上的实际位置：");
// 						System.out.println("application.getRealPath()=" + application.getRealPath("") );
// 						System.out.println("System.getProperty(file.separator)=" + System.getProperty("file.separator"));
// 						System.out.println("FilenameUtils.getName(dfi.getName())=" + FilenameUtils.getName(dfi.getName()));
						String fileAdd = application.getRealPath("photo") 
								+ System.getProperty("file.separator");
								
						File uploadDir = new File(fileAdd);
				        if (!uploadDir.exists()) {
				            uploadDir.mkdir();
				        }
				        String fileName = fileAdd + FilenameUtils.getName(dfi.getName());
						out.print(new File(fileName).getAbsolutePath());
						dfi.write(new File(fileName));
					} //if
				} //if
			} //for
		} //if
		String url = request.getParameter("back") + "?";
		String query = request.getQueryString();
		int idx = query.indexOf('&');
		String rQuery = new String(query.getBytes(), idx + 1, query.length() -1 -idx);
		System.out.println(url + rQuery);
		response.sendRedirect(url + rQuery);
		
	%>
</body>

</html>