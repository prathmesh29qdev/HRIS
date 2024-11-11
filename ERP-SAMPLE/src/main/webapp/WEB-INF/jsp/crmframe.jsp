<%@ page errorPage="Error.do"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page language="java" import="java.io.*" import="java.lang.*, java.sql.*, MyBeans.*"%>
<html><head><title>ERP / CRM APS</title>
<link href="css/style1.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/rightclick.js"></script> 
</head>
<%
String company="Power Point Cartridges Pvt. Ltd.";

long[] UsrBrnList = {1, 2, 3, 4, 5, 6, 7, 8, 11, 12, 13};
String brnlist ="1, 2, 3, 4, 5, 6, 7, 8, 11, 12, 13";

HttpSession ses=request.getSession(true);
ses.setAttribute("UsrBrnList",UsrBrnList);
ses.setAttribute("brnlist",brnlist);
ses.setAttribute("utotalbrn","11");
ses.setAttribute("usr_id","ADMIN");
ses.setAttribute("usr_br_id","1");

%>
<frameset ROWS="4%,*" frameborder="NO" FRAMESPACING="0">
	<frame name="header_frm" src="title.do?cnm=<%=company%>" scrolling="no" noresize MARGINWIDTH="0" MARGINHEIGHT="0">
	<frameset COLS="14%,*" frameborder="NO" FRAMESPACING="0">
		<frame name="menu_frm" src="menu.do" scrolling="no" noresize MARGINWIDTH="0" MARGINHEIGHT="0">
		<frame name="body_frm" src="homepg.do" scrolling="auto" noresize MARGINWIDTH="0" MARGINHEIGHT="0">
	</frameset>
</frameset></html>