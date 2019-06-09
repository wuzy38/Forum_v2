<%@ page contentType="text/html; charset=UTF-8" %>
<script>
    function addPostItem(title, author, click_cnt, reply_cnt, post_time)
    {
        var table = document.querySelector(".post-list table");
        var item = document.createElement("tr");
        item.setAttribute("class", "item");
        table.appendChild(item);
    }
</script>
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