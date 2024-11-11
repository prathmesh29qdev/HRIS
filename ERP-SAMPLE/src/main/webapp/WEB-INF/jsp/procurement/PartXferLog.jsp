
<%@ page language="java" import="java.sql.*, MyBeans.*,java.util.Calendar" import="java.util.Date" import="java.io.*" import="java.text.DateFormat" import="java.text.SimpleDateFormat" import="java.lang.*"%>
<jsp:useBean id="cmpbrn" scope="request" class="MyBeans.BranchDetails" />
<jsp:useBean id="dateformat" scope="request" class="MyBeans.convertDate" />
<HTML><HEAD><TITLE>PRINTER PART TRANSFER LOG</TITLE>
<link href="css/style1.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="css/dhtmlgoodies_calendar.css?random=20051112" media="screen"/>
<script type="text/javascript" src="js/dhtmlgoodies_calendar.js?random=20060118"></script>
<script language="javascript" type="text/javascript" src="js/rightclick.js"></script>
<script language="javascript" type="text/javascript" src="js/numeric.js"></script>
<script language="javascript" type="text/javascript" src="js/agree.js"></script>
<script language="javascript" type="text/javascript" src="js/ValidateElement.js"></script> 
<script language="javascript" type="text/javascript" src="js/ValidateDynamic.js"></script> 
<script language="javascript" type="text/javascript" src="js/ListElement.js"></script> 
<script language="javascript" type="text/javascript" src="js/actb.js"></script>
<script language="javascript" type="text/javascript" src="js/common.js"></script>
<script language="javascript">
function setTarget(target)
{
	if(target==1){document.form.method="POST";document.form.target="";document.form.action="partxferlog.do";	document.form.submit();}
	else
	if(target==2)
	{
		document.form.method="POST";document.form.target="_blank";document.form.action="PartXferLog";	document.form.submit();
	}
}

var partarray=new Array(); var partidarray=new Array(); partarray[0]="ALL"; partidarray[0]="0";<%
String validate="NO", v1="";
HttpSession ses=request.getSession(true);
String usrid=(String)ses.getAttribute("usr_id");
String brnlist=(String)ses.getAttribute("brnlist");  
long utotalbrn=Long.parseLong((String)ses.getAttribute("utotalbrn"));
long UsrBrnList[]=(long[])ses.getAttribute("UsrBrnList");

Connection con=DBConnection.getNewInstance().getConnection();
Statement st1 = con.createStatement();
ResultSet rs1=null;
long sr=1, norecord=0, index=1, enggid=0, colorcode=0, qty=0, id=0, partid=0;
long frombranchid=0, tobranchid=0, xfertype=1, frompmodel=0, topmodel=0;
String str1="", dt1="",dt2="", name="", enggname="ALL", partname="ALL";
String fromprintername="ALL", toprintername="ALL", frombranch="", tobranch="";
String tdate="", ttime="", transferby="";

v1="";if((v1=request.getParameter("frombranchid"))!=null){frombranchid=Long.parseLong(v1);}
v1="";if((v1=request.getParameter("tobranchid"))!=null){tobranchid=Long.parseLong(v1);}
v1="";if((v1=request.getParameter("frompmodel"))!=null){frompmodel=Long.parseLong(v1);}
v1="";if((v1=request.getParameter("topmodel"))!=null){topmodel=Long.parseLong(v1);}
v1="";if((v1=request.getParameter("xfertype"))!=null){xfertype=Long.parseLong(v1);}
v1="";if((v1=request.getParameter("partid"))!=null){partid=Long.parseLong(v1);}
v1="";if((v1=request.getParameter("enggid"))!=null){enggid=Long.parseLong(v1);}
v1=""; if((v1=request.getParameter("date1"))!=null){if(v1.length()>0){dt1=v1;}}
v1=""; if((v1=request.getParameter("date2"))!=null){if(v1.length()>0){dt2=v1;}}
try
{
	if((dt1.length()<10) || (dt2.length()<10))
	{
		DateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd");
		Calendar ca1 = Calendar.getInstance();
		ca1.add(Calendar.DATE, -1);

		Date dat=new Date();
		dt2=dateFormat.format(dat);
		dt1=dateFormat.format(ca1.getTime());
	}
}
catch(Exception e){}

str1="Select unique id, name from printer_part where status=1 order by name";
rs1=st1.executeQuery(str1);
while(rs1.next())
{
	id=0; name="";
	id=rs1.getLong(1);
	v1=""; if((v1=rs1.getString(2))!=null){name=v1;}
	%>partidarray[<%=index%>]='<%=id%>'; partarray[<%=index%>]='<%=name%>';<%
	if(id==partid){partname=name;}
	index++;
}
%>var engineerarray=new Array();var engineeridarray=new Array(); engineerarray[0]="ALL"; engineeridarray[0]="0";<%
index=1;
str1="Select unique exec_id, execode from field_executive where br_id in("+brnlist+") and left_job='NO' and exe_type=1 order by execode";
rs1=st1.executeQuery(str1);
while(rs1.next())
{
	id=0; name="";
	id=rs1.getLong(1);
	v1=""; if((v1=rs1.getString(2))!=null){name=v1;}
	%>engineeridarray[<%=index%>]='<%=id%>'; engineerarray[<%=index%>]='<%=name%>';<%
	if(id==enggid){enggname=name;}
	index++;
}
%>var printerarray=new Array();var printeridarray=new Array(); printerarray[0]="ALL"; printeridarray[0]="0";<%
index=1;
str1="Select unique ID, MODEL_NAME from p_model where status=0 order by MODEL_NAME";
rs1=st1.executeQuery(str1);
while(rs1.next())
{
	id=0; name="";
	id=rs1.getLong(1);
	v1=""; if((v1=rs1.getString(2))!=null){name=v1;}
	%>printeridarray[<%=index%>]='<%=id%>'; printerarray[<%=index%>]='<%=name%>';<%
	if(id==frompmodel){fromprintername=name;}
	if(id==topmodel){toprintername=name;}
	index++;
}
%></script></HEAD><BODY><center>
<form autocomplete="off"  name="form" onkeypress="return DisableEnter()" action="" method="post"><center>
<div id="hstyle">PRINTER PART TRANSFER LOG</div><center>
<input type="hidden" value="0" name="installtype" id="installtype">
<input type="hidden" value="used" name="baltype" id="baltype">
<table border="0" align="center" cellpadding="5" cellspacing="7" width="95%">
<tr>
<td align=right><label>From Branch:</label></td>
<td align=left><select name="frombranchid" style="width:300px">
<option value="0">ALL</option><%
String branchLlist[][]=cmpbrn.getBranchListSelect(con, brnlist, utotalbrn);
int i=0, j=0;
for(i=0; i<branchLlist.length; i++)
{
	j=0;
	%><option value="<%=branchLlist[i][j++]%>" <%if(frombranchid==Long.parseLong(branchLlist[i][(j-1)])){%> selected <%}%> ><%=branchLlist[i][j++]%>, <%=branchLlist[i][j++]%>, <%=branchLlist[i][j++]%></option><%
}%></select>
</td>
<td align=right><label>To Branch:</label></td>
<td align=left><select name="tobranchid" style="width:300px">
<option value="0">ALL</option><%
for(i=0; i<branchLlist.length; i++)
{
	j=0;
	%><option value="<%=branchLlist[i][j++]%>" <%if(tobranchid==Long.parseLong(branchLlist[i][(j-1)])){%> selected <%}%> ><%=branchLlist[i][j++]%>, <%=branchLlist[i][j++]%>, <%=branchLlist[i][j++]%></option><%
}%></select>
</td>
</tr>
<tr>
<td align=right><label>From Printer:</label></td>
<td align=left>
<input type=text value="<%=fromprintername%>", id=fromprintername name="fromprintername" style="width:300px" onBlur="javascript: if(validateElement(printerarray, 'fromprintername')){listElementId(printerarray, printeridarray, 'fromprintername', 'frompmodel');}">
<input type=hidden id='frompmodel' name="frompmodel" value="<%=frompmodel%>">
</td>
<td align=right><label>To Printer:</label></td>
<td align=left>
<input type=text value="<%=toprintername%>", id=toprintername name="toprintername" style="width:300px" onBlur="javascript: if(validateElement(printerarray, 'toprintername')){listElementId(printerarray, printeridarray, 'toprintername', 'topmodel');}">
<input type=hidden id='topmodel' name="topmodel" value="<%=topmodel%>">
</td>
</tr>
<tr>
<td align=right><label>ENGINEER:</label></td>
<td align=left>
<input type='text' id='enggname' name="enggname" value="<%=enggname%>" style="width:300px" onBlur="javascript: if(validateElement(engineerarray, 'enggname')){listElementId(engineerarray, engineeridarray, 'enggname', 'enggid');}">
<input type=hidden id='enggid' name="enggid" value="<%=enggid%>">
</td>
<td align=right><label>PART:</label></td>
<td align=left>
<input type=text value="<%=partname%>", id=partname name="partname" style="width:300px" onBlur="javascript: if(validateElement(partarray, 'partname')){listElementId(partarray, partidarray, 'partname', 'partid');}">
<input type=hidden id='partid' name="partid" value="<%=partid%>">
</td>
</tr>
<tr>
<td align=right><label>Tranfer Type:</label></td>
<td align=left>
	<select name="xfertype" style="width:300px">
	<option value="1" <% if(xfertype==1){%>selected<%}%> >Office Stock</option>
	<option value="2" <% if(xfertype==2){%>selected<%}%> >Engieer Stock</option>
	</select>
</td>
<td align=right><label>From:</label></td>
<td>
	<input type=text value="<%=dt1 %>" readonly name="date1" size=8><input type="button" value="Select" onclick="displayCalendar(document.forms[0].date1,'yyyy-mm-dd',this)">
	&nbsp; &nbsp; &nbsp;
	<label>To:</label>
	<input type=text value="<%=dt2 %>" readonly name="date2" size=8><input type="button" value="Select" onclick="displayCalendar(document.forms[0].date2,'yyyy-mm-dd',this)">
	&nbsp; &nbsp; &nbsp;
	<input type="button" name="" value="Export"  onClick="setTarget(2)" style="width:80px" disabled>
	&nbsp; &nbsp; &nbsp;
	<input type="button" name="" value="Refresh"  onClick="setTarget(1)" style="width:80px">
</td>
</tr>
</table>
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
if(xfertype==1)
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
<div style="overflow: auto; width:95%; height:450px; border-left: 0px gray solid; border-bottom: 0px gray solid; border-right: 0px gray solid; padding:0px; margin: 0px; ">
<table  cellspacing=0 cellpadding=5 border=1 width=100%><%
if(xfertype==1)
{
	str1 = "SELECT PSX.TRANSFER_DATE, PSX.TRANSFER_TIME, B1.CODE AS FROM_BRANCH, B2.CODE AS TO_BRANCH, "
	+ "P1.MODEL_NAME, P2.MODEL_NAME, PP.NAME AS PART_NAME, PSX.QTY, PSX.TRANSFER_BY "
	+ "FROM PART_STOCK_XFER PSX "
	+ "JOIN BRANCH B1 ON PSX.FROM_BR_ID = B1.ID "
	+ "JOIN BRANCH B2 ON PSX.TO_BR_ID = B2.ID "
	+ "JOIN P_MODEL P1 ON PSX.FROM_PRINTER_ID = P1.ID "
	+ "JOIN P_MODEL P2 ON PSX.TO_PRINTER_ID = P2.ID "
	+ "JOIN PRINTER_PART PP ON PSX.PART_ID = PP.ID "
	+ "WHERE PSX.TRANSFER_TYPE="+xfertype+" AND PSX.TRANSFER_DATE BETWEEN '"+dt1+"' AND '"+dt2+"' ";

	if (frombranchid>0) {str1 += " AND PSX.FROM_BR_ID = " + frombranchid;}
	if (tobranchid>0) {str1 += " AND PSX.TO_BR_ID = " + tobranchid;}
	if (frompmodel>0) {str1 += " AND PSX.FROM_PRINTER_ID = " + frompmodel;}
	if (topmodel>0) {str1 += " AND PSX.TO_PRINTER_ID = " + topmodel;}
	if (partid>0) {str1 += " AND PSX.PART_ID = " + partid;}

	str1 += " ORDER BY PSX.ID";
}
else
if(xfertype==2)
{
	str1 = "SELECT PSX.TRANSFER_DATE, PSX.TRANSFER_TIME, P1.MODEL_NAME, P2.MODEL_NAME, "
	+ "PP.NAME AS PART_NAME, PSX.QTY, FE.EXECODE AS ENGINEER_NAME, PSX.TRANSFER_BY "
	+ "FROM PART_STOCK_XFER PSX "
	+ "JOIN P_MODEL P1 ON PSX.FROM_PRINTER_ID = P1.ID "
	+ "JOIN P_MODEL P2 ON PSX.TO_PRINTER_ID = P2.ID "
	+ "JOIN PRINTER_PART PP ON PSX.PART_ID = PP.ID "
	+ "JOIN FIELD_EXECUTIVE FE ON PSX.EXE_ID = FE.EXEC_ID "
	+ "WHERE PSX.TRANSFER_DATE BETWEEN '"+dt1+"' AND '"+dt2+"' ";

	if (frompmodel>0) {str1 += " AND PSX.FROM_PRINTER_ID = " + frompmodel;}
	if (topmodel>0) {str1 += " AND PSX.TO_PRINTER_ID = " + topmodel;}
	if (partid>0) {str1 += " AND PSX.PART_ID = " + partid;}
	if (enggid>0) { str1 += " AND PSX.EXE_ID = " + enggid; }

	str1 += " ORDER BY PSX.ID";
}

rs1 = st1.executeQuery(str1);
while(rs1.next())
{
	qty=0; tdate=""; ttime=""; frombranch=""; tobranch=""; fromprintername=""; toprintername="";
	partname=""; enggname=""; transferby="";
	
	if(xfertype==1)
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
	if(xfertype==2)
	{
		v1=""; if((v1=rs1.getString(1))!=null){tdate=v1;}
		v1=""; if((v1=rs1.getString(2))!=null){ttime=v1;}
		v1=""; if((v1=rs1.getString(3))!=null){fromprintername=v1;}
		v1=""; if((v1=rs1.getString(4))!=null){toprintername=v1;}
		v1=""; if((v1=rs1.getString(5))!=null){partname=v1;}
		qty=rs1.getLong(6);
		v1=""; if((v1=rs1.getString(7))!=null){enggname=v1;}
		v1=""; if((v1=rs1.getString(8))!=null){transferby=v1;}
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

<script>var obj1 = new actb(document.getElementById('enggname'),engineerarray);</script>
<script>var obj2 = new actb(document.getElementById('partname'),partarray);</script>
<script>var obj3 = new actb(document.getElementById('fromprintername'),printerarray);</script>
<script>var obj4 = new actb(document.getElementById('toprintername'),printerarray);</script>

</form></BODY></HTML>