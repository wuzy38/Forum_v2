<%@ page language="java" import="java.util.*,java.sql.*, com.*"
contentType="text/html; charset=utf-8"%>
<%-- java 方法 --%>
<%! 
// 登陆用户  
// 1. 注册( submit_type="sign_up")->验证用户名是否重复 
// 2. 登陆( submit_type="sign_in")->验证用户名和密码是否正确
boolean LoginUser(String userName, String passWord, String submit_type) 
{
    MysqlConnector conn = new MysqlConnector();
    if (submit_type.equals("sign_up"))
    {
        return conn.addUser(userName, passWord);
    }
    else if (submit_type.equals("sign_in"))
    {
        return conn.checkPassword(userName, passWord);
    }
    else 
    {
        return false;
    }
}
%>

<% 
    System.out.println("login test");
    if (session.getAttribute("userName") != null)
    {
        // 重定向->跳转到index.jsp
        response.sendRedirect("block.jsp");
    }
    request.setCharacterEncoding("UTF-8");
    String userName = "";
    String passWord = "";
    // 当前是注册还是登陆
    String submit_type = "sign_in";
    // 是否遇到登陆错误了
    if (request.getMethod().equalsIgnoreCase("post"))
    {
        userName = request.getParameter("userName");
        passWord = request.getParameter("passWord");
        submit_type = request.getParameter("submit_type");
        // 验证是否登陆成功
        if (LoginUser(userName, passWord, submit_type))
        {
            // 设置session
            session.setAttribute("userName", userName);
            // 重定向->跳转到index.jsp
            response.sendRedirect("block.jsp");
        }
        // else 注册登录错误 -> js处理
    }
%>

<html>
    <head>
        <script>

        </script>
        <title> Forum Login </title>
        <link rel="stylesheet" type="text/css" href="css/font-awesome.css" />
        <link rel="stylesheet" type="text/css" href="css/nav.css" />
        <style>
            body 
            { 
                /* background-image:url("hy2.jpg"); */
                background-size: cover;    
            }
            /* 主体 */
            #container
            { 
                width:1000px;
                margin:0 auto;
                overflow:hidden;
            }
            .header
            {
                margin-top: 100px;
            }
            .header>h1
            {
                margin: 0 auto;
                width: 200px;
                font-family: "宋体";
                text-align: center;
                color:mediumblue;
            }
            .header .l-line,.header .r-line
            {
                border-top: 1px solid #eee;
                position: relative;
                top: 110px;
                width: 300px;
            }
            .header .l-line { left: 100px; }
            .header .r-line { left: 600px; }
            .header .header-wrapper 
            {
                position: relative;
                left: 420px;
                width: 160px;
                top: 100px;
                height: 20px;
            }
            .header .header-wrapper a
            {
                float: left;
                width: 80px;
                height: 20px;
                line-height: 20px;
                font-size: 18px;
                text-align: center;
                text-decoration: none;
                color: black;
            }
            .header .header-wrapper .rgt-sel { color:mediumblue; }
            /* .header .header-wrapper .lg-sel { color:mediumblue; } */
            .form-wrapper
            {
                padding-top: 150px; 
                width:750px;
                margin: auto;
            }
            .form-item 
            { 
                padding:0 0 20px 250px; 
            }
            .form-item .form-label 
            { 
                float: left;
                margin-left:-250px;
                width:240px;
                /* height=line-height高度等于行高可使字体垂直居中 */
                height:36px;
                line-height:36px;
                font-size:18px;
                text-align:right;
                overflow:hidden;
            }
            .form-item .form-label i
            {
                color: blue;
                height: 36px;
                line-height: 36px;
            }
            .form-item .form-field .form-text
            {
                border-radius:5px;
                font-size:14px;
                border:1px solid #dedede;
                padding:3px 10px;
                width:250px;
                height:36px;
                line-height:36px;
                vertical-align:middle;
            }
            .form-item .form-field .form-tips
            {
                display:inline-block;
                margin-left:5px;
                font-size:12px;
                line-height:20px;
                vertical-align:middle;
                text-align:justify;
                min-height:20px;
                max-height:40px;
                overflow:hidden;
            }
            .form-item .form-field .tips-des
            {
                color:#999;
            }
            .form-item .form-field .tips-error
            {
                color:#E44;
            }
            .form-item .submit-btn
            {
                width: 250px; 
                height: 40px; 
                margin: 0 0 0 250 auto;
                border: 0 none;
                border-radius: 5px;
                font-size: 20px;
                color: white; 
                background:#4ba0d7;
            }
        </style>
        <script>
            function onRgtSel()
            {
                document.getElementById("sign_up").style.display = "unset";
                document.getElementById("sign_in").style.display = "none";
                document.querySelector(".rgt-sel").style.color = "mediumblue";
                document.querySelector(".lg-sel").style.color = "black";
            }
            function onLgSel()
            {
                document.getElementById("sign_up").style.display = "none";
                document.getElementById("sign_in").style.display = "unset";
                document.querySelector(".rgt-sel").style.color = "black";
                document.querySelector(".lg-sel").style.color = "mediumblue";
            }
            // 点击注册
            function onRgtSubmit()
            {
                var username = document.querySelector("#sign_up #userName");
                if (username.value.length < 6 || username.value.length > 10)
                {
                    let user_tip = document.querySelector("#sign_up #userName_tips");
                    user_tip.innerHTML = "用户名不合规范，请输入6~10个字符";
                    user_tip.setAttribute("class", "form-tips tips-error");
                    return false;
                }
                var password = document.getElementById("#sign_up #passWord");
                if (password.value.length != 6 || isNaN(password.value))
                {
                    let pwd_tip = document.querySelector("#sign_up #passWord_tips");
                    pwd_tip.innerHTML = "密码不合规范，请输入6个数字";
                    pwd_tip.setAttribute("class", "form-tips tips-error");
                    return false;
                }
                return true;
            }
            // 点击登录
            function onLgSubmit()
            {
                var username = document.querySelector("#sign_in #userName");
                var password = document.getElementById("#sign_in #passWord");
                if (username.value.length < 6 || username.value.length > 10
                || password.value.length != 6 || isNaN(password.value))
                {
                    alert("用户名或密码错误");
                    return false;
                }
                return true;
            }
            // 注册失败
            function onRgtError()
            {
                onRgtSel();
                var userName = document.querySelector("#sign_up #userName");
                var passWord = document.querySelector("#sign_up #passWord");
                userName.value = "<%= userName %>";
                passWord.value = "<%= passWord %>";
                var user_tip = document.querySelector("#sign_up #userName_tips");
                user_tip.innerHTML = "用户名已被占用";
                user_tip.setAttribute("class", "form-tips tips-error");
            }
            // 登录失败
            function onLgError()
            {
                onLgSel();
                var userName = document.querySelector("#sign_in #userName");
                var passWord = document.querySelector("#sign_in #passWord");
                userName.value = "<%= userName %>";
                passWord.value = "<%= passWord %>";
                alert("用户名或密码错误");
            }
        </script>
    </head>

    <body>
        <%-- 导航条html模板 高度50 --%>
        <%@ include file="jsp/nav.jsp"%>
        <%-- 主体 --%>
        <div id="container">
            <div class="header">
                <h1>简单论坛</h1>
                <div class="l-line"></div>
                <div class="r-line"></div>
                <div class="header-wrapper">
                    <a class="rgt-sel" href="JavaScript:onRgtSel()">注册</a>
                    <a class="lg-sel" href="JavaScript:onLgSel()">登录</a>
                </div>
                
            </div>
            <%-- 注册界面 --%>
            <div class="form-wrapper" id="sign_up" style="display:unset">
                <form action="login.jsp" method="post">
                    <input type="hidden" name="submit_type" value="sign_up">
                    <div class="form-item">
                        <label class="form-label" for="userName">
                            <i class="fa fa-user" aria-hidden="true"></i>
                        </label>
                        <div class="form-field">
                            <input type="text" placeholder="请输入用户名" class="form-text" name="userName" id="userName" value="" />
                            <span id="userName_tips" class="form-tips tips-des">6~10个字符，注册成功后不可修改。</span>
                            <!-- <span id="userName_tips" class="form-tips tips-error">该用户名已被使用，请使用其他用户名注册</span> -->
                        </div>
                    </div>
                    <div class="form-item">
                        <label class="form-label" for="passWord">
                            <i class="fa fa-key" aria-hidden="true"></i>
                        </label>
                        <div class="form-field">
                            <input type="password" placeholder="请输入密码" class="form-text" name="passWord" id="passWord" value=""/>
                            <span id="passWord_tips" class="form-tips tips-des">6个数字</span>
                            <!-- <span id="passWord_tips" class="form-tips tips-error">密码不符合要求</span> -->
                        </div>
                    </div>
                    <div class="form-item">
                        <button type="submit" class="submit-btn" onclick="return onRgtSubmit()">注册</button>
                    </div>
                    
                </form>
            </div>
            <%-- 登录界面 --%>
            <div class="form-wrapper" id="sign_in" style="display: none">
                <form action="login.jsp" method="post">
                    <input type="hidden" name="submit_type" value="sign_in">
                    <div class="form-item">
                        <label class="form-label" for="userName">
                            <i class="fa fa-user" aria-hidden="true"></i>
                        </label>
                        <div class="form-field">
                            <input type="text" placeholder="请输入用户名" class="form-text" name="userName" id="userName" value="" />
                        </div>
                    </div>
                    <div class="form-item">
                        <label class="form-label" for="passWord">
                            <i class="fa fa-key" aria-hidden="true"></i>
                        </label>
                        <div class="form-field">
                            <input type="password" placeholder="请输入密码" class="form-text" name="passWord" id="passWord" value="" />
                        </div>
                    </div>
                    <div class="form-item">
                        <button type="submit"  class="submit-btn" onclick="return onLgSubmit()">登录</button>
                    </div>
                    
                </form>
            </div>
            <div class="footer">
                <%-- <p> <%= userName %> </p> --%>
            </div>

        </div>
        <%-- 处理注册登录错误 --%>
        <script>
            // 注册错误
            <% if (request.getMethod().equalsIgnoreCase("post") && submit_type.equals("sign_up")) { %>
                onRgtError();
            <% } %>
            // 登录错误
            <% if (request.getMethod().equalsIgnoreCase("post") && submit_type.equals("sign_in")) { %>
                onLgError();
            <% } %>
        </script>
    </body>
</html>