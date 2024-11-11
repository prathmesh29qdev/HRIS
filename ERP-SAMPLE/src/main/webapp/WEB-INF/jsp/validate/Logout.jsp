
<%@ page language="java" import="java.sql.*, MyBeans.*" import="java.util.*" import="java.io.*" import="java.text.SimpleDateFormat" %>
<html><head><TITLE>LOGOUT</TITLE>
<link href="css/style1.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/rightclick.js"></script> 
<SCRIPT LANGUAGE="JavaScript">
function loadMenuHeader()
{
/*
	document.form.target="header_frm";
	document.form.action="/WEB-INF/ppc_jsp/Logins/blank.jsp";
	document.form.submit();

	document.form.target="menu_frm";
	document.form.action="/WEB-INF/ppc_jsp/Logins/blank.jsp";
	document.form.submit();
*/	
}
</script>
</head><body onload="loadMenuHeader()"><form autocomplete="off" name=form action=""><%
HttpSession ses = request.getSession(true);
ses.invalidate(); 
 
java.sql.Timestamp abc = new java.sql.Timestamp(new java.util.Date().getTime());
String outdate = new SimpleDateFormat("yyyy-MM-dd").format(abc);
String outtime = new SimpleDateFormat("HH:mm").format(abc);
%><br><br><br><br>
<center><p><font size="6" color=#FFFF99>You Are Signed Out Successfully!</font><br><br>
<font color=#FFCC99 size=4><b><u>"Please Close This Window For Security Reasons"</u></b></font></p></center><br><br>
</body></html>