
<%@ page language="java" import="java.sql.*, MyBeans.*" import="java.util.Date" import="java.io.*" import="java.text.DateFormat" import="java.text.SimpleDateFormat" import="java.lang.*"%>
<HTML><HEAD><TITLE>PART FAULTY RETURN ENTRY</TITLE>
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
	if(target==1){document.form.method="POST";document.form.target="";document.form.action="PartFaultyReturn.do";	document.form.submit();}
	else
	if(target==2){document.form.method="POST";document.form.target="_blank";document.form.action="PartFaultyReturn";	document.form.submit();}
}
var cartarray=new Array(); var cartidarray=new Array(); cartarray[0]="ALL"; cartidarray[0]="0";<%
String validate="NO", v1="";
HttpSession ses=request.getSession(true);
String usrid=(String)ses.getAttribute("usr_id");
String brnlist=(String)ses.getAttribute("brnlist");  
long utotalbrn=Long.parseLong((String)ses.getAttribute("utotalbrn"));
long UsrBrnList[]=(long[])ses.getAttribute("UsrBrnList");

Connection con=DBConnection.getNewInstance().getConnection();
Statement st1 = con.createStatement();
Statement st2 = con.createStatement();
ResultSet rs1=null, rs2=null;
boolean rowfound1 = false, rowfound2=false;
long sr=1, norecord=0, stock=0, tstock=0, index=1, cartid=0, enggid=0, minstock=0, colorcode=0, tmpid=0;
String str1="", str2="", cmodel="ALL", ename="ALL", tmpmodel="", unit="";

DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
Date dat=new Date();
String dt1=dateFormat.format(dat);
String dt2=dt1;
v1="";if((v1=request.getParameter("cid"))!=null){cartid=Long.parseLong(v1);}else{cartid=0;}
v1="";if((v1=request.getParameter("wid"))!=null){enggid=Long.parseLong(v1);}else{cartid=0;}
v1="";if((v1=request.getParameter("date1"))!=null){dt1=v1;}
v1="";if((v1=request.getParameter("date2"))!=null){dt2=v1;}

str1="Select unique id, name from printer_part where status=1 order by name";
rs1=st1.executeQuery(str1);
rowfound1=rs1.next();
while(rowfound1==true)
{
	tmpmodel="";tmpid=0;
	tmpid=rs1.getLong(1);
	v1=""; if((v1=rs1.getString(2))!=null){tmpmodel=v1;}
	%>cartidarray[<%=index%>]='<%=tmpid%>'; cartarray[<%=index%>]='<%=tmpmodel%>';<%
	if(tmpid==cartid){cmodel=tmpmodel;}
	index++;
	rowfound1=rs1.next();
}
%>var workerarray=new Array();var workeridarray=new Array(); workerarray[0]="ALL"; workeridarray[0]="0";<%
String nmelement="";
index=1;
str1="Select unique exec_id, execode, sname from field_executive where LEFT_JOB='NO' and left_job='NO' and exe_type=1 order by execode";
rs1=st1.executeQuery(str1);
rowfound1=rs1.next();
while(rowfound1==true)
{
	tmpmodel="";tmpid=0;
	tmpid=rs1.getLong(1);
	v1=""; if((v1=rs1.getString(2))!=null){tmpmodel=v1;}
	v1=""; if((v1=rs1.getString(3))!=null){nmelement=nmelement+" "+v1;}
	%>workeridarray[<%=index%>]='<%=tmpid%>'; workerarray[<%=index%>]='<%=tmpmodel%>';<%
	if(tmpid==enggid){ename=tmpmodel;}
	index++;
	rowfound1=rs1.next();
}
%></script></HEAD><BODY><center>
<form autocomplete="off"  name="form" onkeypress="return DisableEnter()" action="" method="post"><center>
<div id="hstyle">PART FAULTY RETURN ENTRY</div><br><center>
<label>FROM:</label>
<input type=text, value="<%=dt1%>", name="date1" SIZE=10>
<input type="button" value="....." onclick="displayCalendar(document.forms[0].date1,'yyyy-mm-dd',this)">
&nbsp; &nbsp; &nbsp; 
<label>TO:</label>
<input type=text, value="<%=dt2%>", name="date2" SIZE=10>
<input type="button" value="....." onclick="displayCalendar(document.forms[0].date2,'yyyy-mm-dd',this)">
&nbsp; &nbsp; &nbsp; 
<input type="button" name="" value="Re-Load" onClick="setTarget(1)" style="width:150px">
&nbsp; &nbsp; &nbsp; 
<input type="button" name="" value="Export" onClick="setTarget(2)" style="width:150px">
<BR><BR>
<label>ACCESSORY:</label>
<input type=text value="<%=cmodel%>", id=cmodel name="cmodel" size=35 onBlur="javascript: if(validateElement(cartarray, 'cmodel')){listElementId(cartarray, cartidarray, 'cmodel', 'cid');}">
<input type=hidden id='cid' name="cid" value="<%=cartid%>">
&nbsp; &nbsp; &nbsp; 
<label>ENGINEER:</label>
<input type='text' id='worker' name="worker" value="<%=ename%>" size="40"  size=35 onBlur="javascript: if(validateElement(workerarray, 'worker')){listElementId(workerarray, workeridarray, 'worker', 'wid');}">
<input type=hidden id='wid' name="wid" value="<%=enggid%>">
<div style="width:90%; height:18px; border-left: 2px gray solid; border-right: 2px gray solid; border-top: 2px gray solid; border-bottom: 2px gray solid; padding:0px; margin: 0px background-color:#666666;">
<table  cellspacing=0% cellpadding=0% width=100%>
<tr bgcolor=#666666>
<th align=center width=5%><font size=2 color=white>SR.</th>
<th align=center width=10%><font size=2 color=white>DATE</th>
<th align=center width=25%><font size=2 color=white>ENGINEER</th>
<th align=center width=25%><font size=2 color=white>ACCESSORY</th>
<th align=center width=10%><font size=2 color=white>QUANTITY</th>
<th align=center width=10%><font size=2 color=white>UNIT</th>
<th align=center width=15%><font size=2 color=white>FAULTY RETURN</th>
</tr>
</table></div>
<div style="overflow: auto; width:90%; height:400px; border-left: 0px gray solid; border-bottom: 0px gray solid; border-right: 0px gray solid; padding:0px; margin: 0px; ">
<table  cellspacing=0 cellpadding=0 border=1 width=100%><%
String usedate="", callid="", returnstatus="", outward="";

str1="select ID, P_ID, ENG_NAME, OUTWARD, USED_DATE, CALL_ID, FAULTY_RETURN from ENG_STOCK_DETAILS where call_id>0 ";
//if(rstatus!=0){str1=str1+"and faulty_return="+rstatus+" ";}
if(enggid==0){str1=str1+"and eng_name="+enggid+" ";}
if(cartid==0){str1=str1+"and p_id="+cartid+" ";}
str1=str1+"and USED_DATE between '"+dt1+"' and '"+dt2+"' order by used_date, eng_name, p_id";

rs1 = st1.executeQuery(str1);
rowfound1 = rs1.next();
while(rowfound1 == true)
{
	norecord = 1;stock=0; cartid=0;minstock=0;cmodel="";enggid=0;
	unit="";outward="";usedate=""; callid=""; returnstatus="";
	
	cartid=rs1.getLong(1);
	v1="";if((v1=rs1.getString(2))!=null){cmodel=v1;}
	enggid=rs1.getLong(3);
	v1="";if((v1=rs1.getString(4))!=null){outward=v1;}
	v1="";if((v1=rs1.getString(5))!=null){usedate=v1;}
	v1="";if((v1=rs1.getString(6))!=null){callid=v1;}
	v1="";if((v1=rs1.getString(7))!=null){returnstatus=v1;}

	if(enggid==0)
	{
		str2="select sum(outward) from ENG_STOCK_DETAILS where p_id="+cartid+" and USED_DATE between '"+dt1+"' and '"+dt2+"'";
	}
	else
	{
		str2="select sum(outward) from ENG_STOCK_DETAILS where eng_name="+enggid+" and p_id="+cartid+" and USED_DATE between '"+dt1+"' and '"+dt2+"'";
	}
	rs2=st2.executeQuery(str2);
	rowfound2=rs2.next();
	if(rowfound2==true){rowfound2=false;v1="";if((v1=rs2.getString(1))!=null){stock=Long.parseLong(v1);}}
	
	if(colorcode==0)
	{
		colorcode=1;%>
		<tr bgcolor=Ghostwhite>
		<td nowrap align=center width=10%><%=sr++%></td>
		<td align=left width=50%><font size=2><%=cmodel %></td><%
		if(stock==0){%><td align=center width=20%><br></td><%}else{%><td align=center width=20%><%=stock %></td><%}%>
		<td align=left width=20%><font size=2><%=unit%></td>
		</tr><%
	}
	else
	{
		colorcode=0;%>
		<tr bgcolor=#D5F5E3>
		<td nowrap align=center width=10%><%=sr++%></td>
		<td align=left width=50%><font size=2><%=cmodel %></td><%
		if(stock==0){%><td align=center width=20%><br></td><%}else{%><td align=center width=20%><%=stock %></td><%}%>
		<td align=left width=20%><font size=2><%=unit%></td>
		</tr><%
	}
	rowfound1=rs1.next();
}
if(rs2!=null){rs2.close();}
if(st2!=null){st2.close();}
rs1.close();st1.close();con.close();%>
</table></div>
<div style=" width:80%; height:18px; border-left: 0px gray solid; border-bottom: 0px gray solid; border-right: 0px gray solid; padding:0px; margin: 0px; background-color:Linen;">	
<table width="100%" cellspacing=0 cellpadding=0 border=0>
	<tr bgcolor=#666666>
	<td nowrap align=center colspan=3><font size=3 color=white><b>TOTAL</font></td>
	<td align=center width=15%><font size=3 color=white><b><%=tstock%></td>
	<td align=left width=15%><br></td>
	</tr>
</table></div>
</form>
<script>var obj1 = new actb(document.getElementById('cmodel'),cartarray);</script>
<script>var obj1 = new actb(document.getElementById('worker'),workerarray);</script>
</BODY></HTML>