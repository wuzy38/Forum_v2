<%-- jsp传递block_id, sort_type, page_id --%>
<%@ page language="java" import="java.util.*,java.sql.*, com.*"
contentType="text/html; charset=utf-8"%>
<!-- 获取所有版块id和title -->
<!-- 根据版块id获取当前版块信息Map -->
<%-- 根据板块id获取当前板块所有帖子 --%>
<%!

int getIntVal(String key_str, String request_str, int from, int to)
{
    if (request_str != null)
    {
        String val_str = request_str;
        if (Integer.parseInt(val_str) >= from && Integer.parseInt(val_str) <= to)
        {
            return Integer.parseInt(val_str);
        }
    }
    return 1;
}

// 一页的帖子数
int PageSize = 10;
MysqlConnector conn = new MysqlConnector();
ArrayList<HashMap<String, String>> getBlockList()
{
    
    return conn.getTableData("plate");
}

ArrayList<HashMap<String, String>> getPostList(int block_id, int sort_type)
{
    return conn.getThemeInOrder(block_id, sort_type);
}

int getReplyCnt(ArrayList<HashMap<String, String>> post_list)
{
    int res = 0;
    for (int i = 0; i < post_list.size(); i++)
    {
        res += Integer.parseInt(post_list.get(i).get("reply_cnt"));
    }
    return res;
}

String getUserName(String user_id)
{
    return conn.getRowByID("user", Integer.parseInt(user_id) ).get("user_name");
}

%>
<%
    ArrayList<HashMap<String, String>> block_list = getBlockList();
    int block_id = getIntVal("block_id", request.getParameter("block_id"), 1, block_list.size());
    int sort_type = getIntVal("sort_type", request.getParameter("sort_type"), 1, 3);
    ArrayList<HashMap<String, String>> post_list = getPostList(block_id, sort_type);
    int page_cnt = post_list.size() / PageSize + 1;
    int page_id = getIntVal("page_id", request.getParameter("page_id"), 1, page_cnt);
    HashMap<String, String> cur_block = block_list.get(block_id-1);
    String block_str = cur_block.get("plate_name");
    int main_post_cnt = Integer.parseInt(cur_block.get("theme_cnt")) ;
    int reply_post_cnt = getReplyCnt(post_list);
    String block_intro = cur_block.get("introduction");
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
            /* 导航条 当前界面为第2个 */
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
            .left-subnav .block-list li.cur a
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
            /* 板块信息 */
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
            /* 帖子部分 */
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
                text-decoration: none;
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
            .main-content .post-list .page-btns
            {
                text-align: right;
                margin-top: 20px;
                padding-right: 10px;
            }
            .main-content .post-list .page-btns button
            {
                padding: 5px 10px;
            }
        </style>
        <script>
            block_id = "<%= block_id %>";
            sort_type = "<%= sort_type %>";
            page_id = "<%= page_id %>";
            function clickBlock(i)
            {
                if (i == block_id) return;
                // 重定向, 新的block
                window.location.href="block.jsp?block_id="+i;
            }
            function clickSortType(i)
            {
                if (i == sort_type) return;
                window.location.href="block.jsp?block_id="+block_id+"&sort_type="+i;
            }
            function clickNextPage()
            {
                if (post_list.size() < page_id * PageSize) return;
                window.location.href="block.jsp?block_id="+block_id+"&sort_type="+sort_type+"&page_id="+(page_id+1);
            }
            function clickPrePage()
            {
                if (page_id <= 1) return;
                window.location.href="block.jsp?block_id="+block_id+"&sort_type="+sort_type+"&page_id="+(page_id-1);
            }
            function clickPost(post_id)
            {
                width.location.href="post.jsp?block_id="+block_id+"&post_id="+post_id;
            }
            function clickUser(user_id)
            {

            }
        </script>
    </head>
    <body>
        <%-- 导航条html模板 高度50 --%>
        <%@ include file="jsp/nav.jsp"%>
        
        <div class="container">
            <%-- 左导航条 --%>
            <div class="left-subnav">
                <ul class="block-list">
                    <% for (int i = 0; i < block_list.size(); i++) { %>
                        <li class="<%= block_id==i+1?"cur":"" %>" ><a href="JavaScript:clickBlock(<%= i+1 %>)"> - <%= block_list.get(i).get("plate_name") %> </a></li>
                    <% } %>
                </ul>
            </div>
            <div class="main-content">
                <%-- 板块信息 --%>
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
                        <li class="<%= sort_type==1?"cur":"" %>"> <a href="JavaScript:clickSortType(1)"> 默认 </a> </li>
                        <li class="<%= sort_type==2?"cur":"" %>"> <a href="JavaScript:clickSortType(2)"> 最新 </a> </li>
                        <li class="<%= sort_type==3?"cur":"" %>"> <a href="JavaScript:clickSortType(3)"> 最热 </a> </li>
                        <li class="post"> <button onclick="clickPost()"> 发帖 </button></li>
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
                        <% for (int i = (page_id-1) * PageSize; i < post_list.size() && i < page_id*PageSize; i++) { %>
                            <tr>
                                <td class="title"> <a href="JavaScript:clickPost(<%=post_list.get(i).get("theme_id")%>)"> <%=post_list.get(i).get("theme_name")%> </a> </td>
                                <td class="author"> <a href="JavaScript:clickUser(<%=post_list.get(i).get("user_id")%>)"> <%=getUserName(post_list.get(i).get("user_id"))%> </a> </td>
                                <td class="click"> <%= post_list.get(i).get("click_num") %> </td>
                                <td class="reply"> <%= post_list.get(i).get("reply_cnt") %> </td>
                                <td class="time"> <%= post_list.get(i).get("theme_time") %> </td>
                            </tr>
                        <% } %>
                    </table>
                    <div class="page-btns">
                        <%= page_id %> / <%= page_cnt %>
                        <button onclick="clickPrePage()" <%= page_id==1?"disabled":"" %> > 上一页 </button>
                        <button onclick="clickNextPage()" <%= post_list.size() < page_id * PageSize ? "disabled":""%> > 下一页 </button>
                    </div>
                </div>
            </div>
        </div>
        
    </body>
</html>