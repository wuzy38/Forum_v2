<%@ page language="java" 
import="java.util.*,java.sql.*, com.*"
contentType="text/html; charset=utf-8"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<% 
    System.out.println(request.getAttribute("__sourse"));
    boolean isMultipart = ServletFileUpload.isMultipartContent(request);//是否用multipart提交的?
    System.out.println(isMultipart);
    if (true || isMultipart) 
    {
        FileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        List items = upload.parseRequest(request);
        for (int i = 0; i < items.size(); i++) 
        {
            FileItem fi = (FileItem) items.get(i);
            if (fi.isFormField()) 
            {   //如果是表单字段
                out.print(fi.getFieldName()+":"+fi.getString("utf-8"));
            }
            else 
            {   //如果是文件
                DiskFileItem dfi = (DiskFileItem) fi;
                if (!dfi.getName().trim().equals("")) 
                {   //getName()返回文件名称或空串
                    out.print("文件被上传到服务上的实际位置： ");
                    String fileName=application.getRealPath("/images/user")
                                    + System.getProperty("file.separator")
                                    + FilenameUtils.getName("username");
                    out.print(new File(fileName).getAbsolutePath());
                    dfi.write(new File(fileName));
                }
            }
        }
    }
%>