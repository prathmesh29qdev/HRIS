
<%@ page language="java" import="java.sql.*, MyBeans.*" import="java.util.*" import="java.io.*"%>
<%
HttpSession ses = request.getSession(true);
String user=(String)ses.getAttribute("user_id");

long msgcount=0;
if(msgcount>0)
{
	%>
<!--
	<a href="chat.do" target="body_frm" style="background-color:yellow">
	<font color=red>You have a new message!</font>
	</a>
-->
	<marquee style="scrollamount=500;" scrolldelay="500;">
	<a onclick="showChat()" href="#">
	<img src="Images/comment_alert.png" width="12%" height="12%"><div class="centered"><%=msgcount%></div>
	</a>
	</marquee>
	<input type="hidden" name="msgcount" value="<%=msgcount%>"><%
}
else
{
	%><input type="hidden" name="msgcount" value="0"><%
}
%>