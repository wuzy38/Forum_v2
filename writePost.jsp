<%@ page contentType="text/html; charset=utf-8" %>
<html>
    <head>
        <title>
            Forum rank
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
                margin-top: 20px;
                width: 700px;
                float: left;
            }
            
        </style>
    </head>
    <body>
        <%-- 导航条html模板 高度50 --%>
        <%@ include file="jsp/nav.jsp"%>
        <%-- 主体 --%>
        <div class="container">

            <div class="main-content">
                
            </div>
            
        </div>
        
    </body>
</html>

