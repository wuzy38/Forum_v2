<%@ page language="java" 
import="java.util.*,java.sql.*, com.*"
contentType="text/html; charset=utf-8"%>
<%@ page import="java.io.*, org.apache.commons.io.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<% 
    request.setCharacterEncoding("utf-8");
    System.out.println("uploadImg test");
    boolean isMultipart = ServletFileUpload.isMultipartContent(request);//是否用multipart提交的?
    System.out.println(isMultipart);
    if (isMultipart) 
    {
        FileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        List items = upload.parseRequest(request);
        for (int i = 0; i < items.size(); i++) 
        {
            FileItem fi = (FileItem) items.get(i);
            if (fi.isFormField()) 
            {//如果是表单字段
                out.print(fi.getFieldName()+":"+fi.getString("utf-8"));
            }
            else 
            {
                DiskFileItem dfi = (DiskFileItem) fi;
                out.print("文件被上传到服务上的实际位置： ");
                String fileName=application.getRealPath("/Forum/images/user")
                + System.getProperty("file.separator")
                + FilenameUtils.getName(dfi.getName());
                out.print(new File(fileName).getAbsolutePath());
                dfi.write(new File(fileName));
                // FileItem fi = (FileItem) request.getParameter("file_obj");
                // System.out.println(request.getParameter("test"));
                // System.out.println(fi);
                // DiskFileItem dfi = (DiskFileItem) fi;
                // out.print("文件被上传到服务上的实际位置： ");
                // String fileName=application.getRealPath("Forum/images/user")
                //                 + System.getProperty("file.separator")
                //                 + FilenameUtils.getName("username");
                System.out.println(new File(fileName).getAbsolutePath());
                // out.print(new File(fileName).getAbsolutePath());
                // dfi.write(new File(fileName));
            }
        }
    }
%>