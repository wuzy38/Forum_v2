<%@ page language="java" import="java.util.*,java.sql.*, com.*"
contentType="text/html; charset=utf-8"%>

<%!

int getUserIdByName(String user_name)
{
    return 1;
}

%>

<%
    int block_id = request.getParameter("block_id")==null ? 1 :Integer.parseInt(request.getParameter("block_id"));
    if (request.getMethod().equalsIgnoreCase("post"))
    {
        String userName = (String)session.getAttribute("userName");
        String post_title = request.getParameter("title");
        String post_content = request.getParameter("content");
        MysqlConnector conn = new MysqlConnector();
        conn.addTheme(post_title, block_id, getUserIdByName(userName));
        response.sendRedirect("block.jsp?block_id="+block_id);
    }

%>


<html>
    <head>
        <title>
            Forum Write
        </title>
        <link rel="stylesheet" type="text/css" href="css/font-awesome.css" />
        <%-- 导航条css模板 --%>
        <link rel="stylesheet" type="text/css" href="css/nav.css" />
        <style>
            /* 导航条 当前界面为第3个 */
            .nav-content .nav-main ul li:nth-of-type(3) a
            {
                border-bottom: 4px solid blue;
                color: #000;
            }
            .container
            {
                margin: 50px auto;
                width: 1000px;
            }
            .main-content
            {
                padding-top: 20px;
            }
            
            .post-title
            {
                margin-top: 50px;
                text-align: center;
            }
            
            .post-title .title
            {
                height: 50px;
                width: 1000px;
                text-align: center;
                font-size: 30px;
            }

            .post-content
            {
                padding-top: 50px;
            }

            .post-content .content
            {
                height: 600px;
                width: 1000px;
                font-size: 15px;
            }

            .post-submit
            {
                padding-top: 20px;
                text-align: right;
                
            }
            .post-submit .submit-btn
            {
                height: 30px;
                width: 100px;
            }

        </style>
        <script>
            function clickSubmit()
            {
                <% if (session.getAttribute("userName") == null){ %>
                    alert("请先登录");
                <% } %>
                var post_title = document.querySelector(".post-title .title");
                if (post_title.value == "")
                {
                    alert("标题不能为空");
                    return false;
                }
                var post_content = document.querySelector(".post-content .content");
                if (post_content.value == "")
                {
                    alert("内容不能为空");
                    return false;
                }
                return true;
            }
        </script>
    </head>
    <body>
        <%-- 导航条html模板 高度50 --%>
        <%@ include file="jsp/nav.jsp"%>
        <%-- 主体 --%>
        <div class="container">

            <div class="main-content">
                <form action="writePost.jsp" method="POST">
                    <div class="post-title">
                        <input name="title" class="title" type="text" placeholder="请输入标题">
                    </div>
                    <div class="post-content">
                        <textarea name="content" class="content"></textarea>
                    </div>
                    <div class="post-submit">
                        <button class="submit-btn" type="submit" onclick="return clickSubmit()"> 发表 </button>
                    </div>
                </form>
            </div>
            
        </div>
        
    </body>
</html>

