<%@ page contentType="text/html; charset=utf-8" %>
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
    </head>
    <body>
        <%-- 导航条html模板 高度50 --%>
        <%@ include file="jsp/nav.jsp"%>
        <%-- 主体 --%>
        <div class="container">

            <div class="main-content">
                <div class="rank-nav">
                    <ul>
                        <li> 24小时 </li>
                        <li> 日榜 </li>
                        <li> 周榜 </li>
                        <li> 月榜 </li>
                        <li> </li>
                    </ul>
                </div>
                <div class="post-list">
                    <table>
                        <tr class="header">
                            <th class="title">  标题 </th>
                            <th class="author"> 作者 </th>
                            <th class="click"> 点击 </th>
                            <th class="reply"> 回复 </th>
                            <th class="time"> 发表时间 </th>
                        </tr>
                        <% for (int i = 0; i < 200; i++) { %>
                            <tr class="item">
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

