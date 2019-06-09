<%-- jsp传递block_id --%>
<%@ page contentType="text/html; charset=UTF-8" %>
<!-- 获取所有版块id和title -->
<!-- 根据版块id获取当前版块信息Map -->
<%-- 根据板块id获取当前板块所有帖子 --%>
<%-- <%!

ArrayList<Map<String, String>> getAllBlocks()
{
    return new ArrayList<Map<String, String>>();
}

ArrayList<Map<String, String>> getBlock(int block_id)
{
    return new ArrayList<Map<String, String>>();
}

ArrayList<Map<String, String>> getPostList(int block_id)
{
    return new ArrayList<Map<String, String>>();
}
%> --%>
<%
    // ArrayList<Map<String, String>> blockList = getAllBlocks();
    int block_id = 1;
    if (request.getParameter("block_id") != null)
    {
        String block_id_str = request.getParameter("block_id");
        if (Integer.parseInt(block_id_str) > 0 && Integer.parseInt(block_id_str) <= 10)
        {
            block_id = Integer.parseInt(block_id_str);
        }
    }
    // Map<String, String> cur_block = getBlock(block_id)[0];
    String block_str = "体育";
    int main_post_cnt = 1240;
    int reply_post_cnt = 126614;
    String block_intro = "游泳是最好的运动";
    String block_open_time = "2019年6月1日";
%>
<html>
    <head>
        <title>
            Forum Block
        </title>
        <link rel="stylesheet" type="text/css" href="css/font-awesome.css" />
        <%-- 导航条css模板 --%>
        <link rel="stylesheet" type="text/css" href="css/nav.css" />
        <style>
            /* 导航条 当前界面为第一个 */
            .nav-content .nav-main ul li:nth-of-type(2) a
            {
                border-bottom: 4px solid blue;
                color: #000;
            }
            /* 主体 */
            .container
            {
                margin: 50px auto;
                width: 1000px;
            }
            /* 左导航条 */
            .left-subnav
            {
                position: fixed;
                float: left;
                height: 100%;
                width: 180px;
                overflow-y: auto;
                background: #69c;
            }
            .left-subnav .block-list
            {
                margin: 0;
                padding: 0;
            }
            .left-subnav .block-list li
            {
                list-style: none;
                margin: 0;
                padding: 5px 5px;
            }
            .left-subnav .block-list li a
            {
                color: #fff;
                text-decoration: none;
            }
            .left-subnav .block-list li:nth-of-type(<%= block_id %>) a
            {
                color: yellow;
            }
            /* 正文 */
            .main-content
            {
                margin-left: 200px;
                padding-top: 20px;
                width: 700px;
                /* height: 700px; */
            }
            .main-content .block-inf
            {
                position: relative;
            }
            .main-content .block-inf .header-line
            {
                position: relative;
                height: 30px;
            }
            .main-content .block-inf .header-line .block-name
            {
                float: left;
                font-size: 18px;
                height: 30px;
                line-height: 30px;
            }
            .main-content .block-inf .header-line .block-data
            {
                float: right;
                font-size: 12px;
                height: 30px;
                line-height: 30px;
            }
            .main-content .block-inf .block-intro
            {
                border: 5px solid #d2e4ff;
                border-radius: 4px;
                height: 150px;
            }
            .main-content .block-inf .block-intro p
            {
                margin: 10px;
            }
            .main-content .block-inf .block-intro p strong
            {
                color: #666;
            }
            .main-content .post-header
            {
                background: #5993cc;
                height: 36px;
                margin-top: 20px;
            }
            .main-content .post-header ul
            {
                margin: 0;
                padding: 6px 6px 0 6px; 
            }
            .main-content .post-header ul li
            {
                list-style: none;
                float: left;
                height: 30px;
                padding: 0 8px;
            }
            .main-content .post-header ul li a
            {
                height: 30px;
                line-height: 30px;
                color: whitesmoke;
            }
            .main-content .post-header ul li.cur
            {
                background-color: white;
            }
            .main-content .post-header ul li.cur a
            {
                color: black;
                font-weight: bold;
            }
            .main-content .post-header ul li.post
            {
                float: right;
                height: 24px;

            }
            .main-content .post-header ul li.post button
            {
                width: 60px;
                height: 24px;
                text-align: center;
                font-size: 15px;
                color: black;
            }
            .main-content .post-list
            {
                margin-top: 10px;
            }
            .main-content .post-list table
            {
                width: 100%;
                /* 指定固定宽度 */
                table-layout: fixed;
                /* 表格间距 */
                border-spacing: 0;
            }
            .main-content .post-list table tr:nth-of-type(1)
            {
                background: #ddd;
                height: 25px;
            }
            .main-content .post-list table tr:nth-of-type(n+2)
            {
                height: 40px;
            }
            .main-content .post-list table tr:nth-of-type(2n+3)
            {
                background: #f8f8f8;
            }
            .main-content .post-list table tr th
            {
                text-align: left;
                overflow: hidden;
                padding: 0;
            }
            .main-content .post-list table tr td
            {
                text-align: left;
                overflow: hidden;
                padding: 0;
            }
            .main-content .post-list table tr th.title { width: 400px; }
            .main-content .post-list table tr th.author { width: 120px; }
            .main-content .post-list table tr th.click { width: 50px; }
            .main-content .post-list table tr th.reply { width: 50px; }
            .main-content .post-list table tr th.time { width: 80px; }
            .main-content .post-list table tr td.title { width: 400px; }
            .main-content .post-list table tr td.author 
            { 
                width: 120px;
                font-size: 14px;
            }
            .main-content .post-list table tr td.click 
            { 
                width: 50px;
                color: #777;
                font-size: 12px;
            }
            .main-content .post-list table tr td.reply
            { 
                width: 50px;
                color: #777;
                font-size: 12px;
            }
            .main-content .post-list table tr td.time 
            { 
                width: 80px; 
                color: #777;
                font-size: 12px;
            }
            .main-content .post-list table tr td.title a
            { 
                text-decoration: none;
            }
            .main-content .post-list table tr td.author a
            { 
                text-decoration: none;
            }
        </style>
        <script>
            function clickUser()
            {

            }

            function clickPost()
            {
                
            }
        </script>
    </head>
    <body>
        <%-- 导航条html模板 高度50 --%>
        <%@ include file="jsp/nav.jsp"%>
        
        <div class="container">
            <div class="left-subnav">
                <ul class="block-list">
                    <% for (int i = 0; i < 100; i++) { %>
                        <li><a href="block.jsp"> - my jsp index java </a></li>
                    <% } %>
                </ul>
            </div>
            <div class="main-content">
                <div class="block-inf">
                    <div class="header-line"> 
                        <div class="block-name"> 
                            <strong> <%= block_str %> </strong>
                        </div>
                        <div class="block-data">
                            <span> 主帖数: <%= main_post_cnt %> </span>
                            <span> 回复数: <%= reply_post_cnt %> </span>
                        </div>
                    </div>
                    <div class="block-intro">
                        <p>
                            <strong> 本版介绍: </strong> <%= block_intro %>
                        </p>
                        <p> 
                            <strong> 开版时间: </strong> <%= block_open_time %>
                        </p>
                    </div>
                </div>
                <div class="post-header">
                    <ul>
                        <li class="cur"> <a> 默认 </a> </li>
                        <li> <a> 最新 </a> </li>
                        <li> <a> 最热 </a> </li>
                        <li class="post"> <button> 发帖 </button></li>
                    </ul>
                </div>
                <div class="post-list">
                    <table>
                        <tr>
                            <th class="title">  标题 </th>
                            <th class="author"> 作者 </th>
                            <th class="click"> 点击 </th>
                            <th class="reply"> 回复 </th>
                            <th class="time"> 发表时间 </th>
                        </tr>
                        <% for (int i = 0; i < 200; i++) { %>
                            <tr>
                                <td class="title"> <a href="JavaScript:clickPost()">标题是很长很长的，宽度需要很大的哎哎哎</a> </td>
                                <td class="author"> <a href="JavaScript:clickUser()">作者也可能比较长</a> </td>
                                <td class="click"> 1254932 </td>
                                <td class="reply"> 12532 </td>
                                <td class="time"> 2019.06.05 </td>
                            </tr>
                        <% } %>
                    </table>
                </div>
            </div>
        </div>
        
    </body>
</html>