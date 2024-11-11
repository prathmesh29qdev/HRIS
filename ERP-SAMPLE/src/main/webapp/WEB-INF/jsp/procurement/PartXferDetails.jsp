
<%@ page language="java" import="java.sql.*, MyBeans.*" import="java.io.*, java.lang.*, java.util.StringTokenizer"%>
<jsp:useBean id="dateformat" scope="request" class="MyBeans.convertDate" />
<HTML><HEAD><TITLE>VIEW PART TRANSFER DETAILS</TITLE>
<link href="css/style1.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="js/rightclick.js"></script>
<script language="javascript" type="text/javascript" src="js/common.js"></script>
<%
String validate="NO", v1="";
HttpSession ses=request.getSession(true);
String usrid=(String)ses.getAttribute("usr_id");
String brnlist=(String)ses.getAttribute("brnlist");  
long utotalbrn=Long.parseLong((String)ses.getAttribute("utotalbrn"));
long UsrBrnList[]=(long[])ses.getAttribute("UsrBrnList");

long stockid=0, inward=0, outward=0, stocktype=0;
v1="";if((v1=request.getParameter("stockid"))!=null){stockid=Long.parseLong(v1);}
v1="";if((v1=request.getParameter("inward"))!=null){inward=Long.parseLong(v1);}
v1="";if((v1=request.getParameter("outward"))!=null){outward=Long.parseLong(v1);}
v1="";if((v1=request.getParameter("stocktype"))!=null){stocktype=Long.parseLong(v1);}

%>
</HEAD><BODY style="background-color:white"><center>
<form autocomplete="off" onkeypress="return DisableEnter()" action="" method="post" name="form">
<center>
<div style="width:95%; height:40px ; border-left: 0px gray solid; border-right: 0px gray solid; border-top: 0px gray solid; border-bottom: 0px gray solid; padding:0px; margin: 0px">
<table  cellspacing=0 cellpadding=5 border=1 width=100% height="100%">
<tr bgcolor=#666666>
<th align=center width=5%><font size=2 color=white>SR.</th>
<th align=center width=15%><font size=2 color=white>TRANSFER DATE</th>
<th align=center width=20%><font size=2 color=white>PART</th>
<th align=center width=5%><font size=2 color=white>QTY</th>
<th align=center width=20%><font size=2 color=white>FROM PRINTER</th>
<th align=center width=20%><font size=2 color=white>TO PRINTER</th>
<%
if(stocktype==1)
{
	%>
	<th align=center width=7%><font size=2 color=white>FROM BRANCH</th>
	<th align=center width=8%><font size=2 color=white>TO BRANCH</th>
	<%
}
else
{
	%>
	<th align=center width=15%><font size=2 color=white>ENGINEER</th>
	<%
}
%>
</tr>
</table>
</div>
<div style="overflow: auto; width:95%; height:200px; border-left: 0px gray solid; border-bottom: 0px gray solid; border-right: 0px gray solid; padding:0px; margin: 0px; ">
<table  cellspacing=0 cellpadding=5 border=1 width=100%><%
long sr=1, norecord=0, index=1, enggid=0, colorcode=0, qty=0, id=0, partid=0;
long frombranchid=0, tobranchid=0, xfertype=1, frompmodel=0, topmodel=0;
String str1="", dt1="",dt2="", name="", enggname="ALL", partname="ALL";
String fromprintername="ALL", toprintername="ALL", frombranch="", tobranch="";
String tdate="", ttime="", transferby="";

Connection con=DBConnection.getNewInstance().getConnection();
Statement st1=con.createStatement();
ResultSet rs1=null;

str1 = "SELECT PSX.TRANSFER_DATE, PSX.TRANSFER_TIME, B1.CODE AS FROM_BRANCH, B2.CODE AS TO_BRANCH, "
+ "P1.MODEL_NAME, P2.MODEL_NAME, PP.NAME AS PART_NAME, PSX.QTY, PSX.TRANSFER_BY "
+ "FROM PART_STOCK_XFER PSX "
+ "JOIN BRANCH B1 ON PSX.FROM_BR_ID = B1.ID "
+ "JOIN BRANCH B2 ON PSX.TO_BR_ID = B2.ID "
+ "JOIN P_MODEL P1 ON PSX.FROM_PRINTER_ID = P1.ID "
+ "JOIN P_MODEL P2 ON PSX.TO_PRINTER_ID = P2.ID "
+ "JOIN PRINTER_PART PP ON PSX.PART_ID = PP.ID "
+ "WHERE PSX.TRANSFER_TYPE="+stocktype+" ";
if (inward>0) {str1 += " AND PSX.TO_STOCK_ID = " + stockid;}
else
if (outward>0) {str1 += " AND PSX.FROM_STOCK_ID = " + stockid;}

str1 += " ORDER BY PSX.ID";

try{rs1=st1.executeQuery(str1);}catch(Exception e){}
if(rs1.next())
{
	if(stocktype==1)
	{
		v1=""; if((v1=rs1.getString(1))!=null){tdate=v1;}
		v1=""; if((v1=rs1.getString(2))!=null){ttime=v1;}
		v1=""; if((v1=rs1.getString(3))!=null){frombranch=v1;}
		v1=""; if((v1=rs1.getString(4))!=null){tobranch=v1;}
		v1=""; if((v1=rs1.getString(5))!=null){fromprintername=v1;}
		v1=""; if((v1=rs1.getString(6))!=null){toprintername=v1;}
		v1=""; if((v1=rs1.getString(7))!=null){partname=v1;}
		qty=rs1.getLong(8);
		v1=""; if((v1=rs1.getString(9))!=null){transferby=v1;}
	}
	else
	if(stocktype==2)
	{
	}
	
	%>
	<tr <%if(sr%2==0){%>bgcolor=Ghostwhite<%}else{%>bgcolor=#D5F5E3<%}%> valign="top">
	<td nowrap align=center width=5%><%=sr++%></td>
	<td align=left width=15%><font size=2><%=dateformat.formatDate(tdate)%> <%=ttime%><br><br>By: <%=transferby%></td>
	<td align=left width=20%><font size=2><%=partname %></td>
	<td align=center width=5%><font size=2><%=qty %></td>
	<td align=left width=20%><font size=2><%=fromprintername %></td>
	<td align=left width=20%><font size=2><%=toprintername %></td>
	<%
	if(xfertype==1)
	{
		%>
		<td align=left width=7%><font size=2><%=frombranch %></td>
		<td align=left width=8%><font size=2><%=tobranch %></td>
		<%
	}
	else
	if(xfertype==2)
	{
		%>
		<td align=left width=15%><font size=2><%=enggname %></td>
		<%
	}
	%>
	</tr>
	<%
}
if(rs1!=null){rs1.close();}
if(st1!=null){st1.close();}
con.close();%>
</table></div>
</center></form></BODY></HTML>