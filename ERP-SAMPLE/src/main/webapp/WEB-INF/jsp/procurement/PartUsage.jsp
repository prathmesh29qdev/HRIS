
<%@ page language="java" import="java.sql.*, MyBeans.*,java.util.Calendar" import="java.util.Date" import="java.io.*" import="java.text.DateFormat" import="java.text.SimpleDateFormat" import="java.lang.*"%>
<jsp:useBean id="cmpbrn" scope="request" class="MyBeans.BranchDetails" />
<HTML><HEAD><TITLE>PRINTER PART USAGE SUMMARY</TITLE>
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
	if(document.form.datatype.value==""){alert("Please select data type!"); document.form.datatype.focus(); return false;}
	else
	{
		if(document.form.datatype.value=="1"){document.form.baltype.value="used";}
		else
		if(document.form.datatype.value=="2"){document.form.baltype.value="allot";}
	}
	
	if(target==1){document.form.method="POST";document.form.target="";document.form.action="partusage.do";	document.form.submit();}
	else
	if(target==2)
	{
		document.form.method="POST";document.form.target="_blank";document.form.action="PartUsage";	document.form.submit();
	}
}
function exportData(partid, branchid, enggid, dt1, dt2, baltype, pmodelid, stocktype)
{
	document.form.target=""; 
	document.form.action='PartUsage?cid='+partid+'&branchid='+branchid+'&wid='+enggid+'&date1='+dt1+'&date2='+dt2+'&baltype='+baltype+'&installtype=0'+'&pmodelid='+pmodelid+'&stocktype='+stocktype;
	document.form.submit();
}

var cartarray=new Array(); var cartidarray=new Array(); cartarray[0]="ALL"; cartidarray[0]="0";
var printerarray=new Array(); var printeridarray=new Array();printerarray[0]="ALL"; printeridarray[0]="0";
<%
String validate="NO", v1="";
HttpSession ses=request.getSession(true);
String usrid=(String)ses.getAttribute("usr_id");
String brnlist=(String)ses.getAttribute("brnlist");  
long utotalbrn=Long.parseLong((String)ses.getAttribute("utotalbrn"));
long UsrBrnList[]=(long[])ses.getAttribute("UsrBrnList");

Connection con=DBConnection.getNewInstance().getConnection();
Statement st1 = con.createStatement();
ResultSet rs1=null;
boolean rowfound1 = false, rowfound2=false;
long sr=1, norecord=0, stock=0, tstock=0, index=1, cartid=0, enggid=0, minstock=0;
long colorcode=0, tmpid=0, branchid=0, datatype=1, stocktype=2, pmodel=0;
String str1="", str2="", cmodel="ALL", ename="ALL", tmpmodel="", unit="", pmodelname="ALL";
String dt1="",dt2="";
v1="";if((v1=request.getParameter("branchid"))!=null){branchid=Long.parseLong(v1);}
v1="";if((v1=request.getParameter("cid"))!=null){cartid=Long.parseLong(v1);}
v1="";if((v1=request.getParameter("wid"))!=null){enggid=Long.parseLong(v1);}
v1="";if((v1=request.getParameter("datatype"))!=null){datatype=Long.parseLong(v1);}
v1="";if((v1=request.getParameter("stocktype"))!=null){stocktype=Long.parseLong(v1);}
v1="";if((v1=request.getParameter("pmodel"))!=null){pmodel=Long.parseLong(v1);}
v1="";if((v1=request.getParameter("pmodelname"))!=null){pmodelname=v1;}
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
	tmpmodel="";tmpid=0;
	tmpid=rs1.getLong(1);
	v1=""; if((v1=rs1.getString(2))!=null){tmpmodel=v1;}
	%>cartidarray[<%=index%>]='<%=tmpid%>'; cartarray[<%=index%>]='<%=tmpmodel%>';<%
	if(tmpid==cartid){cmodel=tmpmodel;}
	index++;
}

index=1;
str1="Select unique id, model_name from p_model where status=0 order by model_name";
rs1=st1.executeQuery(str1);
while(rs1.next())
{
	tmpmodel="";tmpid=0;
	tmpid=rs1.getLong(1);
	v1=""; if((v1=rs1.getString(2))!=null){tmpmodel=v1;}
	%>printeridarray[<%=index%>]='<%=tmpid%>'; printerarray[<%=index%>]='<%=tmpmodel%>';<%
	if(tmpid==pmodel){pmodelname=tmpmodel;}
	index++;
}

%>var workerarray=new Array();var workeridarray=new Array(); workerarray[0]="ALL"; workeridarray[0]="0";<%
String nmelement="";
index=1;
if(branchid==0)
{
	str1="Select unique exec_id, execode, sname from field_executive where br_id in("+brnlist+") and left_job='NO' and exe_type=1 order by execode";
}
else
{
	str1="Select unique exec_id, execode, sname from field_executive where br_id="+branchid+" and left_job='NO' and exe_type=1 order by execode";
}
rs1=st1.executeQuery(str1);
while(rs1.next())
{
	tmpmodel="";tmpid=0;
	tmpid=rs1.getLong(1);
	v1=""; if((v1=rs1.getString(2))!=null){tmpmodel=v1;}
	v1=""; if((v1=rs1.getString(3))!=null){nmelement=nmelement+" "+v1;}
	%>workeridarray[<%=index%>]='<%=tmpid%>'; workerarray[<%=index%>]='<%=tmpmodel%>';<%
	if(tmpid==enggid){ename=tmpmodel;}
	index++;
}
%></script></HEAD><BODY><center>
<form autocomplete="off"  name="form" onkeypress="return DisableEnter()" action="" method="post"><center>
<div id="hstyle">PRINTER PART USAGE SUMMARY</div><center>
<input type="hidden" value="0" name="installtype" id="installtype">
<input type="hidden" value="used" name="baltype" id="baltype">
<table border="0" align="center" cellpadding="5" cellspacing="7" width="95%">
<tr>
<td align=right><label>Transaction Type:</label></td>
<td align=left>
	<select name="stocktype" style="width:300px">
	<option value="1" <% if(stocktype==1){%>selected<%}%> >Office Stock</option>
	<option value="2" <% if(stocktype==2){%>selected<%}%> >Engieer Stock</option>
	</select>
</td>
<td align=right><label>Engieer:</label></td>
<td align=left>
<input type='text' id='worker' name="worker" value="<%=ename%>" style="width:300px" onBlur="javascript: if(validateElement(workerarray, 'worker')){listElementId(workerarray, workeridarray, 'worker', 'wid');}">
<input type=hidden id='wid' name="wid" value="<%=enggid%>">
</td>
</tr>
<tr>
<td align=right><label>Branch:</label></td>
<td align=left><select name="branchid" style="width:300px">
<option value="0">ALL</option><%
String branchLlist[][]=cmpbrn.getBranchListSelect(con, brnlist, utotalbrn);
int i=0, j=0;
for(i=0; i<branchLlist.length; i++)
{
	j=0;
	%><option value="<%=branchLlist[i][j++]%>" <%if(branchid==Long.parseLong(branchLlist[i][(j-1)])){%> selected <%}%> ><%=branchLlist[i][j++]%>, <%=branchLlist[i][j++]%>, <%=branchLlist[i][j++]%></option><%
}%></select>
</td>
<td align=right><label>Part:</label></td>
<td align=left>
<input type=text value="<%=cmodel%>", id=cmodel name="cmodel" style="width:300px" onBlur="javascript: if(validateElement(cartarray, 'cmodel')){listElementId(cartarray, cartidarray, 'cmodel', 'cid');}">
<input type=hidden id='cid' name="cid" value="<%=cartid%>">
</td>
</tr>
<tr>
<td align=right><label>Data Type:</label></td>
<td align=left>
<select name="datatype" id="datatype" style="width:300px">
<option value="1" <% if(datatype==1){%>selected<%} %> >Installation</option>
<option value="2" <% if(datatype==2){%>selected<%} %> >Allocation</option>
<option value="3" <% if(datatype==3){%>selected<%} %> >De-Allocation</option>
</select>
</td>
<td align=right><label>Printer:</label></td>
<td align=left>
<input type=text value="<%=pmodelname%>", id=pmodelname name="pmodelname" style="width:300px" onBlur="javascript: if(validateElement(printerarray, 'pmodelname')){listElementId(printerarray, printeridarray, 'pmodelname', 'pmodel');}">
<input type=hidden id='pmodel' name="pmodel" value="<%=pmodel%>">
</td>
</tr>
<tr>
<td align=right><label>From:</label></td>
<td>
	<input type=text value="<%=dt1 %>" readonly name="date1" size=8><input type="button" value="Select" onclick="displayCalendar(document.forms[0].date1,'yyyy-mm-dd',this)">
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	<label>To:</label>
	<input type=text value="<%=dt2 %>" readonly name="date2" size=8><input type="button" value="Select" onclick="displayCalendar(document.forms[0].date2,'yyyy-mm-dd',this)">
</td>
<td colspan=2 align=center>
	<input type="button" name="" value="Export"  onClick="setTarget(2)" style="width:100px">
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	<input type="button" name="" value="Refresh"  onClick="setTarget(1)" style="width:100px">
</td>
</tr>
</table>
<div style="width:95%; height:25px ; border-left: 0px gray solid; border-right: 0px gray solid; border-top: 0px gray solid; border-bottom: 0px gray solid; padding:0px; margin: 0px">
<table  cellspacing=0 cellpadding=4 border=1 width=100% height="100%">
<tr bgcolor=#666666>
<th align=center width=10%><font size=2 color=white>SR.</th>
<%
if(stocktype ==  1){%><th align=center width=20%><font size=2 color=white>BRANCH</th><%}
else
if(stocktype ==  2){%><th align=center width=20%><font size=2 color=white>ENGINEER</th><%}
%>
<th align=center width=30%><font size=2 color=white>PART</th>
<th align=center width=30%><font size=2 color=white>PRINTER</th>
<th align=center width=10%><font size=2 color=white>QTY</th>
</tr>
</table></div>
<div style="overflow: auto; width:95%; height:450px; border-left: 0px gray solid; border-bottom: 0px gray solid; border-right: 0px gray solid; padding:0px; margin: 0px; ">
<table  cellspacing=0 cellpadding=4 border=1 width=100%><%
long pid=0, eid=0;
String partname="", enggname="", exptype="allot";

/* 
0-initial record of each item  having zero transaction values
1-allocation or purchase, (inward)  - allocate
2-allot to engg allot,  (outward)  - de-allot
3-in-house repairing, (outward) - installation
4-de-allot from engg, (inward + outward ) - to be re-verify  - allocate
5-transfer between printer, ( inward + outward between printers of same branch, total will be intact) - allocate & de-allot between printer & same branch
6-opening balance less directly (outward)
7-faulty return working took into inventory (inward) - allocate
8-allot to call, (outward) - installation
9 - transfer between branches and printers   (inward + outward from once branch to another branch) - allocate & de-allot between branches

*/

if(stocktype ==  1)
{
	if(datatype==1)
	{
		exptype="used";
		
		str1 = "SELECT SUM(ps.outward), pp.name, pm.model_name, br.name AS branch_name, " +
			  "ps.mat_id, ps.br_id, ps.pmodel_id FROM part_stock ps " +
			  "LEFT JOIN printer_part pp ON ps.mat_id = pp.id " +
			  "LEFT JOIN p_model pm ON ps.PMODEL_ID = pm.id " +
			  "LEFT JOIN branch br ON ps.br_id = br.id " +
			  "WHERE ps.outward > 0 and ps.src IN (3, 8) AND ps.tr_date BETWEEN '" + dt1 + "' AND '" + dt2 + "'";
		if (branchid != 0) {str1 += " AND ps.br_id = " + branchid;}
		if (cartid != 0) {str1 += " AND ps.mat_id = " + cartid;}
		if (pmodel != 0) {str1 += " AND ps.pmodel_id = " + pmodel;}
		str1 += " GROUP BY br.name, pp.name, pm.model_name, ps.mat_id, ps.pmodel_id, ps.br_id " +
				"ORDER BY br.name, pm.model_name, pp.name";
	}
	else
	if(datatype==2)
	{
		exptype="allot";
		
		str1 = "SELECT SUM(ps.inward), pp.name, pm.model_name, br.name AS branch_name, " +
			  "ps.mat_id, ps.br_id, ps.pmodel_id FROM part_stock ps " +
			  "LEFT JOIN printer_part pp ON ps.mat_id = pp.id " +
			  "LEFT JOIN p_model pm ON ps.PMODEL_ID = pm.id " +
			  "LEFT JOIN branch br ON ps.br_id = br.id " +
			  "WHERE ps.inward > 0 and ps.src IN (1, 4, 5, 7, 9) AND ps.tr_date BETWEEN '" + dt1 + "' AND '" + dt2 + "'";
		if (branchid != 0) {str1 += " AND ps.br_id = " + branchid;}
		if (cartid != 0) {str1 += " AND ps.mat_id = " + cartid;}
		if (pmodel != 0) {str1 += " AND ps.pmodel_id = " + pmodel;}
		str1 += " GROUP BY br.name, pp.name, pm.model_name, ps.mat_id, ps.pmodel_id, ps.br_id " +
				"ORDER BY br.name, pm.model_name, pp.name";
	}
	else
	if(datatype==3)
	{
		exptype="deallot";
		
		str1 = "SELECT SUM(ps.outward), pp.name, pm.model_name, br.name AS branch_name, " +
			  "ps.mat_id, ps.br_id, ps.pmodel_id FROM part_stock ps " +
			  "LEFT JOIN printer_part pp ON ps.mat_id = pp.id " +
			  "LEFT JOIN p_model pm ON ps.PMODEL_ID = pm.id " +
			  "LEFT JOIN branch br ON ps.br_id = br.id " +
			  "WHERE ps.outward > 0 and ps.src IN (2, 5, 9) AND ps.tr_date BETWEEN '" + dt1 + "' AND '" + dt2 + "'";
		if (branchid != 0) {str1 += " AND ps.br_id = " + branchid;}
		if (cartid != 0) {str1 += " AND ps.mat_id = " + cartid;}
		if (pmodel != 0) {str1 += " AND ps.pmodel_id = " + pmodel;}
		str1 += " GROUP BY br.name, pp.name, pm.model_name, ps.mat_id, ps.pmodel_id, ps.br_id " +
				"ORDER BY br.name, pm.model_name, pp.name";
	}
}
else
if(stocktype ==  2)
{
	if(datatype == 2)
	{
		str1 = "SELECT SUM(esd.INWARD) AS QTY, pp.name AS PART_NAME, pm.model_name AS PMODEL_NAME, fe.execode AS ENG_NAME, esd.p_id, esd.ENG_NAME, esd.PMODEL_ID ";
	}
	else
	{
		str1 = "SELECT SUM(esd.OUTWARD) AS QTY, pp.name AS PART_NAME, pm.model_name AS PMODEL_NAME, fe.execode AS ENG_NAME, esd.p_id, esd.ENG_NAME, esd.PMODEL_ID ";
	}

	str1 += "FROM ENG_STOCK_DETAILS esd " +
		   "LEFT JOIN printer_part pp ON esd.P_ID = pp.id " +
		   "LEFT JOIN p_model pm ON esd.PMODEL_ID = pm.id " +
		   "LEFT JOIN field_executive fe ON esd.ENG_NAME = fe.exec_id " +
		   "WHERE esd.USED_DATE between '"+dt1+"' and '"+dt2+"' ";
	if(datatype == 1) {str1 += "AND esd.OUTWARD > 0 AND esd.SRC = 2 "; 		exptype="used";} 
	else
	if(datatype == 2) {str1 += "AND esd.INWARD > 0 AND esd.SRC IN (1, 3, 5) ";		 exptype="allot";} 
	else 
	if (datatype == 3) {str1 += "AND esd.OUTWARD > 0 AND esd.SRC IN (4, 5) ";		 exptype="deallot";} 

	if (cartid != 0) { str1 += "AND esd.P_ID = "+cartid+" "; } 
	if (enggid != 0) { str1 += "AND esd.ENG_NAME = "+enggid+" "; }
	 
	str1 += "GROUP BY pp.name, pm.model_name, fe.execode, esd.p_id, esd.ENG_NAME, esd.PMODEL_ID ORDER BY fe.execode, pm.model_name, pp.name";
}

rs1 = st1.executeQuery(str1);
while(rs1.next())
{
	partname=""; pmodelname=""; stock=0; enggname=""; pid=0; eid=0; pmodel=0;
	
	stock=rs1.getLong(1);
	v1=""; if((v1=rs1.getString(2))!=null){partname=v1;}
	v1=""; if((v1=rs1.getString(3))!=null){pmodelname=v1;}
	v1=""; if((v1=rs1.getString(4))!=null){enggname=v1;}
	pid=rs1.getLong(5);
	eid=rs1.getLong(6);
	pmodel=rs1.getLong(7);
	
	tstock+=stock;
	
	%>
	<tr <%if(sr%2==0){%>bgcolor=Ghostwhite<%}else{%>bgcolor=#D5F5E3<%}%> valign="top">
	<td nowrap align=center width=10%><%=sr++%></td>
	<td align=left width=20%><font size=2><%=enggname %></td>
	<td align=left width=30%><font size=2><%=partname %></td>
	<td align=left width=30%><font size=2><%=pmodelname %></td>
	<%
	if(stock==0){%><td align=center width=10%><br></td><%}
	else
	{
		if(stocktype==1)
		{
			%><td align=center width=10%><a href="#" onClick="exportData('<%=pid%>','<%=eid%>','0','<%=dt1%>','<%=dt2%>', '<%=exptype%>', '<%=pmodel%>', '<%=stocktype%>')" ><%=stock %></a></td><%
		}
		else
		if(stocktype==2)
		{
			%><td align=center width=10%><a href="#" onClick="exportData('<%=pid%>','0','<%=eid%>','<%=dt1%>','<%=dt2%>', '<%=exptype%>', '<%=pmodel%>', '<%=stocktype%>')" ><%=stock %></a></td><%
		}
	}
	%>
	</tr>
	<%
}
if(rs1!=null){rs1.close();}
if(st1!=null){st1.close();}
con.close();%>
</table></div>
<div style="width:95%; height:25px ; border-left: 0px gray solid; border-right: 0px gray solid; border-top: 0px gray solid; border-bottom: 0px gray solid; padding:0px; margin: 0px">
<table  cellspacing=0 cellpadding=4 border=1 width=100% height="100%">
<tr bgcolor=#666666>
<th align=center width=90% colspan=3><font size=2 color=white>TOTAL</th>
<th align=center width=10%><a href="#" onClick="exportData('0','0','0','<%=dt1%>','<%=dt2%>', '<%=exptype%>', '0', '<%=stocktype%>')" ><font size=3 color=white><%=tstock%></font></a></th>
</tr>
</table></div>
<script>var obj1 = new actb(document.getElementById('cmodel'),cartarray);</script>
<script>var obj2 = new actb(document.getElementById('worker'),workerarray);</script>
<script>var obj3 = new actb(document.getElementById('pmodelname'),printerarray);</script>
</form></BODY></HTML>