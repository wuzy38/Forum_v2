<%@ page language="java" import="java.util.*,java.sql.*, com.*"
contentType="text/html; charset=utf-8"%>

<%!

ArrayList<HashMap<String, String>> getPostList()
{
    MysqlConnector conn = new MysqlConnector();
    return conn.getThemeInOrder(-1, 3);
}
String getUserName(String user_id)
{
    MysqlConnector conn = new MysqlConnector();
    return conn.getRowByID("user", Integer.parseInt(user_id) ).get("user_name");
}
%>

<%
    ArrayList<HashMap<String, String>> post_list = getPostList();
    System.out.println(post_list.size());
%>

<html>
    <head>
        <title>
            Forum rank
        </title>
        <link rel="stylesheet" type="text/css" href="css/font-awesome.css" />
        <%-- 导航条css模板 --%>
        <link rel="stylesheet" type="text/css" href="css/nav.css" />
        <link rel="stylesheet" type="text/css" href="css/post_list.css" />
        <style>
            /* 导航条 当前界面为第3个 */
            .nav-content .nav-main ul li:nth-of-type(2) a
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
            .rank-nav
            {
                margin-bottom: 20px;
                border-bottom: 1px solid #e5e5e5;
            }
            .rank-nav ul 
            {
                margin: 0;
                padding:0;
            }
            .rank-nav ul li
            {
                display: inline-block;
                font-size: 16px;
                line-height: 40px;
                margin-right: 42px;
                list-style: none;
            }
            .right-container
            {
                float: right;
                width: 250px;
            }

            .right-container .item
            {
                margin: 20px 0;
                background: #f2f2f2;
            }
        </style>
        <script>
            function clickPost(block_id, post_id)
            {
                window.location.href="post.jsp?block_id="+block_id+"&post_id="+post_id;
            }
            function clickUser(user_id)
            {
                
            }
        </script>
    </head>
    <body>
        <%-- 导航条html模板 高度50 --%>
        <%@ include file="jsp/nav.jsp"%>
        <%-- 主体 --%>
        <div class="container">

            <div class="main-content">
                <div class="post-list">
                    <table>
                        <tr class="header">
                            <th class="title">  标题 </th>
                            <th class="author"> 作者 </th>
                            <th class="click"> 点击 </th>
                            <th class="reply"> 回复 </th>
                            <th class="time"> 发表时间 </th>
                        </tr>
                        <% for (int i = 0; i < post_list.size(); i++) { %>
                            <tr class="item">
                                <td class="title"> <a href="JavaScript:clickPost(<%=post_list.get(i).get("plate_id")%>, <%=post_list.get(i).get("theme_id")%>)"> <%=post_list.get(i).get("theme_name")%> </a> </td>
                                <td class="author"> <a href="JavaScript:clickUser(<%=post_list.get(i).get("user_id")%>)"> <%=getUserName(post_list.get(i).get("user_id"))%> </a> </td>
                                <td class="click"> <%= post_list.get(i).get("click_num") %> </td>
                                <td class="reply"> <%= Integer.parseInt(post_list.get(i).get("reply_cnt"))-1 %> </td>
                                <td class="time"> <%= post_list.get(i).get("theme_time") %> </td>
                            </tr>
                        <% } %>
                    </table>
                </div>
            </div>
        
        </div>
        
    </body>
</html>

