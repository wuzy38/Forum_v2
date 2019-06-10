<%@ page language="java" 
import="java.util.*,java.sql.*, com.*"
contentType="text/html; charset=utf-8"%>
<%@ page import="java.io.*, org.apache.commons.io.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<% 
    System.out.println();
    boolean isMultipart = ServletFileUpload.isMultipartContent(request);//是否用multipart提交的?
    System.out.println(isMultipart);
    if (true || isMultipart) 
    {
        FileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        FileItem fi = (FileItem) request.getAttribute("__sourse");
        DiskFileItem dfi = (DiskFileItem) fi;
        out.print("文件被上传到服务上的实际位置： ");
        String fileName=application.getRealPath("/images/user")
                        + System.getProperty("file.separator")
                        + FilenameUtils.getName("username");
        out.print(new File(fileName).getAbsolutePath());
        dfi.write(new File(fileName));
    }
%>