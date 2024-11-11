<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page language="java" import="MyBeans.*, java.sql.*, java.net.*, java.util.Date, java.io.*, java.text.DateFormat, java.text.SimpleDateFormat"%>
<%@ page import="java.util.*, jakarta.mail.*, jakarta.mail.internet.*, jakarta.activation.*, java.util.Random" %>
<jsp:useBean id="dateformat" scope="request" class="MyBeans.convertDate" />
<HTML><TITLE>ERP / CRM APS</TITLE>
<head>
<style>
/* Container holding the image and the text */
.container {
  position: relative;
  text-align: center;
  color: red;
  font-size: 12px;
  font-weight:bold
}

/* Centered text */
.centered {
  position: relative;
  top: 45%;
  left: 50%;
  transform: translate(-45%, -150%);
}
</style>

<script type="text/javascript">var GB_ROOT_DIR = "cssnew/greybox/";</script>
<script type="text/javascript" src="cssnew/greybox/AJS.js"></script>
<script type="text/javascript" src="cssnew/greybox/AJS_fx.js"></script>
<script type="text/javascript" src="cssnew/greybox/gb_scripts.js"></script>
<link href="cssnew/greybox/gb_styles.css" rel="stylesheet" type="text/css" media="all"/>

<script type="text/javascript" src="js/rightclick.js"></script>

<script type="text/javascript">
function updateLunchTime()
{
	var agree=confirm("Are you sure to update lunch break time?");
	if (agree)
	{
		var url="setLunchTime";
		
		if (window.XMLHttpRequest)
		{// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp = new XMLHttpRequest();
			xmlhttp.onreadystatechange = function()
			{
				document.getElementById('lunchbrk').innerHTML = xmlhttp.responseText;
			}
			xmlhttp.open("POST", url, true);
			xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
			xmlhttp.send(null);
		}
		else
		{// code for IE6, IE5
			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
			xmlhttp.onreadystatechange = function()
			{
				document.getElementById('lunchbrk').innerHTML = xmlhttp.responseText;
			}
			xmlhttp.open("POST", url, true);
			xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
			xmlhttp.send(null);
		}
	}
	else
	{return false ;}
}
</script>
</head><%
String validate="NO", v1="";
String coname="", loginid="ADMIN";

DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd:HH:mm");
Date dat = new Date();
String dt = dateFormat.format(dat);
String date = dt.substring(0, 10);
String tm = dt.substring(11, 16);
long hr = Long.parseLong(tm.substring(0, 2));
long min = Long.parseLong(tm.substring(3, 5));
String mrd = "AM";
if(hr>12){hr=hr-12; mrd="PM";} else if(hr==12){mrd="PM";}
String time = (Long.toString(hr) ) + (tm.substring(2, 5) )+ " "+mrd;

String tablename="tmptble", INTIME="", HODID="", estr="", EMPLOYEENAME="";
long mn=0, yr=0, EMPLOYEECODE=0;
try
{
	mn=Long.parseLong(date.substring(5,7));
	yr=Long.parseLong(date.substring(0,4));
	tablename="devicelogs_"+Long.toString(mn)+"_"+Long.toString(yr);
}
catch(Exception e){}


long breakstatus=0;
String BR_TIME="";

%>
<BODY background="Images/bg2.gif" height=10>
<form autocomplete="off" name="form">
<input type="hidden" name="cnm" value="<%=coname%>">
<TABLE cellSpacing=0 cellPadding=0 width=100% border=0 valign=top align=middle>
<TR valign=top>
<td align=left width="30%"><font size=4 color=RED><b><%=coname%></b></font></td>

<td align=center width="20%" valign="top">
<!--	<div id="chatmsg"><input type="hidden" name="msgcount" value="0"></div>  -->
	<div class="container" id="chatmsg">
	<input type="hidden" name="msgcount" value="0">
	</div>
</td>

<td align=right width="20%">
<!-- [<font color=#990099 size=2><%=loginid.toUpperCase()%></font><font color="red"> - PunchIn@<%=INTIME%></font>]</B>  -->
[<font color=#990099 size=2><%=loginid.toUpperCase()%></font>]

</TD>
<td align=right width="15%">
<div id="lunchbrk">
</div>
</td>
<td align=center width="15%">
<a href="logout.do" target="body_frm"><FONT size=4>Logout</FONT></a>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</TD>
</TR>
<TR valign=top><TD align=right><br></TD></TR>
</TABLE>
</form></BODY></HTML>
		