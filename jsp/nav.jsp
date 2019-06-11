<%@ page contentType="text/html; charset=utf-8" %>
<!-- 导航条 -->
<% 
    String jspName = this.getClass().getSimpleName().replaceAll("_", "."); 
    String url = new String(jspName);
    String query = "back=" + url + "&" + request.getQueryString();
%>
	
<div class="nav-bar">
    <div class="nav-content">
        <div class="nav-logo" >
            <h1 id="title-text"> 简单论坛 </h1>
        </div>
        <div class="nav-main">
            <ul>
                <li>
                    <a href="index.jsp"> 首页 </a>
                </li>
                <li>
                    <a href="block.jsp"> 板块 </a>
                </li>
                <li>
                    <a href="rank.jsp"> 热榜 </a>
                </li>
            </ul>
            <div class="search-bar">
                <div class="search-bar-input">
                    <input >
                </div>
                <div class="search-bar-btn">
                    <a class="fa fa-search" aria-hidden="true"></a>
                </div>
            </div>
        </div>
        <div class="nav-user">
            <form name="f1" id="f1" action="<%="uploadFile.jsp?" + query%>"  method="POST" enctype="multipart/form-data">
                <button type="button">
                    <img class="user-img" src="images/default.png" onclick="clickImg()" onerror="imgError(this)">
                </button>

                <input type="hidden" name="test" value="testval">
                <input style="display:none" type="file" id="img_file" name="txt1" size=100 onchange="onChangeFile()"> 
                <input style="display:none" type="submit" id="img_submit" value="OK">
            </form>
        </div>
    </div>
</div>
<script>
    function clickImg()
    {
        // alert("click img");
        <% if (session.getAttribute("userName") == null){ %>
            window.location.href="login.jsp";
        <% } else{ %>
            var file_dom = document.querySelector(".nav-user #f1 #img_file");
            file_dom.click();
        <% } %>
    }
    function onChangeFile()
    {
        // alert("file submit");
        var submit_dom = document.querySelector(".nav-user #f1 #img_submit");
        submit_dom.click();
    }
    function setImg()
    {
        // alert("setImg");
        // var img_dom = document.querySelector(".nav-user #f1 .user-img");
        // img_dom.src = "images/user/" + "test" + ".png";
        <% if (session.getAttribute("userName") != null){ %>
            var img_dom = document.querySelector(".nav-user #f1 .user-img");
            img_dom.setAttribute("src", "images/user/" + "<%=session.getAttribute("userName")%>" + ".png");
            // if ()
        <% } %>
    }
    function imgError(img)
    {
        img.src="images/default.png";
    }
    setImg();
    // 无效函数
    // 使用ajax传送表单
    function submitImg() {
        // alert("发送1");
        var file_dom = document.getElementById("img_submit"); // file控件
        var file_obj = file_dom.files[0];       // 获取file控件中的内容
        // alert("发送2");
        var formData = new FormData();          // 创建表单元素
        formData.append("file_obj", file_obj);  // 添加文件
        formData.append("test", "test_text");
        // alert("发送3");
        var xhr = new XMLHttpRequest();         // 创建请求
        xhr.onreadystatechange=function()
        {
            if (xhr.readyState==4 && xhr.status==200)
            {
                alert(xhr.responseText);
            }
        }
        xhr.open("POST", "uploadImg.jsp");
        // xhr.setRequestHeader("Content-Type","multipart/form-data");
        xhr.send(formData);
        // alert("发送4");
    }
</script>