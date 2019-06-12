<%-- jsp传递block_id和post_id reply_content --%>
<%@ page language="java" import="java.util.*,java.sql.*, com.*"
contentType="text/html; charset=utf-8"%>
<%-- 根据帖子id获取当前帖子的信息 --%>
<%-- 根据帖子id获取所有回复 --%>

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
MysqlConnector conn = new MysqlConnector();
ArrayList<HashMap<String, String>> getBlockList()
{
    
    return conn.getTableData("plate");
}

ArrayList<HashMap<String, String>> getPostList()
{
    return conn.getTableData("theme");
}

ArrayList<HashMap<String, String>> getReplyList(int post_id)
{
    return conn.getReplyByThemeID(post_id);
}

String getUserName(String user_id)
{
    return conn.getRowByID("user", Integer.parseInt(user_id) ).get("user_name");
}

int getUserIdByName(String user_name)
{
    return conn.getIDbyUsername(user_name);
}

%>

<%
ArrayList<HashMap<String, String>> block_list = getBlockList();
ArrayList<HashMap<String, String>> post_list = getPostList();
int block_id = getIntVal("block_id", request.getParameter("block_id"), 1, block_list.size());
String block_name = block_list.get(block_id-1).get("plate_name");
int post_id = getIntVal("post_id", request.getParameter("post_id"), 1, post_list.size());
if (session.getAttribute("userName") != null && request.getParameter("reply_editor") != null)
{
    System.out.println(request.getParameter("reply_editor"));
    conn.addReply(getUserIdByName((String)session.getAttribute("userName")), request.getParameter("reply_editor"), post_id);
    post_list = getPostList();
}
HashMap<String, String> cur_post = post_list.get(post_id-1);
String post_title = cur_post.get("theme_name");
String post_author = getUserName(cur_post.get("user_id"));
String post_time = cur_post.get("theme_time");
int click_cnt = Integer.parseInt(cur_post.get("click_num"));
int reply_cnt = Integer.parseInt(cur_post.get("reply_cnt"));
ArrayList<HashMap<String, String>> reply_list = getReplyList(post_id);
String post_content = reply_list.get(0).get("content");

// int block_id = 1;
// String block_name = "体育";
// String post_title = "自由泳长一点的标题";
// String post_author = "bibi";
// String post_time = "2019/06/06 0:25";
// int click_cnt = 15;
// int reply_cnt = 12;
// String post_content = "这哇塞了的供sdgsdghf阿反驳日本d货商的合格率是的会更好来干哈省略号市工会哦哦核苷酸读后感的搜狐给的搜";
// for (int i = 0; i < 10; i++) post_content += "  sagsdoinshds \n";

%>
<html>
    <head>
        <title>
            Forum Post
        </title>
        <link rel="stylesheet" type="text/css" href="css/font-awesome.css" />
        <%-- 导航条css模板 --%>
        <link rel="stylesheet" type="text/css" href="css/nav.css" />
        <style>
            /* 主体 */
            .container
            {
                margin: 50px auto;
                width: 800px;
            }
            .container .header
            {
                /* padding-top: 30px; */
            }
            .container .header a
            {
                text-decoration: none;
                font-size: 20px;
            }
            /* 帖子信息 */
            .container .post-head
            {
                margin-top: 30px;
            }
            .container .post-head h1
            {
                margin: auto;
                text-align: center;
            }
            .container .post-head h1 .post-title
            {
                padding: 10px;
                background: #4178B0;
                color: white;
                font-family: "宋体";
                font-size: 20px;
            }
            .container .post-head .post-inf
            {
                margin: 30px auto;
                text-align: center;
                text-decoration: none;
            }
            .container .post-head .post-inf span
            {
                padding: 0 10px;
            }
            /* 帖子正文 */
            .container .post-body
            {
                background: #eee;
                border-radius: 5px;
                padding: 10px 20px;
                text-decoration: none;
            }
            .container .post-body .post-text
            {
                
            }
            .container .post-body .post-text>p
            {
                white-space: pre-wrap;
                padding-bottom: 20px;
            }
            .container .post-body .action
            {
                padding: 5px 0;
                border-top: 1px dotted #ccc;
            }
            .container .post-body .action p
            {
                text-align: right;
                margin: 0;
                padding: 5px;
            }
            .container .reply-container
            {
                margin-top: 50px;
            }
            .container .reply-container .reply-item
            {
                margin: 10px 0;
            }
            .container .reply-container .reply-item .reply-head
            {
                text-align: center;
            }
            .container .reply-container .reply-item .reply-body
            {
                background: #eee;
                border-radius: 5px;
                padding: 10px 20px;
                white-space: pre-wrap;
            }
            .container .reply-box
            {
                width: 800px;
                margin: 50px auto;
            }
            .container .reply-box .editor-bar
            {
                width: 798;
                height: 20px;
                border: 1px solid #d5dadf;
                border-bottom: none;
                background: #f7f7f7;
                padding: 8px 0;
            }
            .container .reply-box .editor-box
            {
                width: 100%;
                height: 200px;
                
            }
            .container .reply-box .editor-box .editor-text
            {
                width: 100%;
                height: 200px;
                border: 1px solid #d5dadf;
            }
            .container .reply-box .editor-submit
            {
                margin-top: 5px;
                text-align: right;
            }
            .container .reply-box .editor-submit .editor-btn
            {
                color: #fff;
                background: #308ee3;
                border: 0 none;
                border-radius: 5px;
                padding: 0 20px;
                height: 30px;
            }
        </style>

        <script>
            block_id = "<%= block_id %>";
            post_id = "<%= post_id %>";
            function clickBlock()
            {
                window.location.href="block.jsp?block_id="+block_id;
            }
            // 点赞
            function clickLove()
            {

            }
            // 点击回复
            function onReply()
            {
                <% if (session.getAttribute("userName") == null){ %>
                    alert("请登录后再回复");
                    return false;
                <% } %>
                var reply_content = document.querySelector(".reply-box .editor-box .editor-text").value;
                if (reply_content == "")
                {
                    alert("回复内容不能为空");
                    return false;
                }
                return true;
            }
        </script>
    </head>
    <body>
        <%-- 导航条html模板 高度50 --%>
        <%@ include file="jsp/nav.jsp"%>
        <div class="container">
            <div class="header">
                <a href="index.jsp"> 简单论坛 </a>
                >>
                <a href="JavaScript:clickBlock()"> <%= block_name %> </a>
            </div>
            <div class="post-head">
                <h1 >
                    <span class="post-title"> <%= post_title %> </span>
                </h1>
                <div class="post-inf">
                    <span> 楼主: <a href=""> <%= post_author %> </a></span> 
                    <span> 时间: <%= post_time %> </span>
                    <span> 点击: <%= click_cnt %> </span>
                    <span> 回复: <%= reply_cnt %> </span>
                </div>
            </div>
            <div class="post-body">
                <div class="post-text">
                    <p><%= post_content %></p>
                </div>
                <div class="action">
                    <p>
                        <a href="JavaScript:clickLove()"> 点赞 </a> 
                        | 
                        <a href="#reply_editor"> 回复 </a>
                    </p>
                </div>
            </div>
            <div class="reply-container">
                <% for (int i = 1; i < reply_list.size(); i++) { %>
                <div class="reply-item">
                    <div class="reply-head">
                        <span> <%= i %>楼: <a> <%=getUserName(reply_list.get(i).get("user_id")) %> </a></span>
                        <span> 时间: <a> <%= reply_list.get(i).get("reply_time") %> </a> </span>
                    </div>
                    <div class="reply-body">
                        <%= reply_list.get(i).get("content") %>
                    </div>
                </div>
                <% } %>
            </div>
            <div class="reply-box">
                <div class="editor-bar">
                </div>
                <form method="post" action="post.jsp">
                    <input type="hidden" name="block_id" value="<%= block_id %>">
                    <input type="hidden" name="post_id" value="<%= post_id %>">
                    <div class="editor-box">
                        <textarea class="editor-text" name="reply_editor"></textarea>
                    </div>
                    <div class="editor-submit">
                        <button class="editor-btn" type="submit" onclick="return onReply()">
                            回复
                        </button>
                    </div>
                </form>
            </div>
        </div>
        
    </body>
</html>

