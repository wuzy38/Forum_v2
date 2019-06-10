<%@ page contentType="text/html; charset=utf-8" %>
<!-- 导航条 -->
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
            <input type="file" class="img-submit" id="img_submit" onchange="submitImg()">
            <button>
                <img class="user-img" src="">
            </button>
        </div>
    </div>
</div>
<script>
    function submitImg() {
        // alert("发送1");
        var file_dom = document.getElementById("img_submit"); // file控件
        var file_obj = file_dom.files[0];     // 获取file控件中的内容
        // alert("发送2");
        var formData = new FormData();
        formData.append("file_obj", file_obj);
        formData.append("test", "test_text");
        // alert("发送3");
        var xhr = new XMLHttpRequest();
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






    <% if (session.getAttribute("userName") != null){ %>

    <% } else { %>

    <% } %>
</script>