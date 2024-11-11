
<%@ page language="java" import="java.sql.*, MyBeans.*,java.util.Calendar" import="java.util.Date" import="java.io.*" import="java.text.DateFormat" import="java.text.SimpleDateFormat" import="java.lang.*"%>
<jsp:useBean id="cmpbrn" scope="request" class="MyBeans.BranchDetails" />
<jsp:useBean id="dateformat" scope="request" class="MyBeans.convertDate" />
<HTML><HEAD><TITLE>PRINTER PART STATEMENT</TITLE>
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
	if(target==1){document.form.method="POST";document.form.target="";document.form.action="partstatement.do";	document.form.submit();}
	else
	if(target==2)
	{
		document.form.method="POST";document.form.target="_blank";document.form.action="PartStatement";	document.form.submit();
	}
}
function exportData(partid, branchid, enggid, dt1, dt2, baltype, pmodelid, stocktype)
{
	document.form.target=""; 
	document.form.action='PartStatement?cid='+partid+'&branchid='+branchid+'&wid='+enggid+'&date1='+dt1+'&date2='+dt2+'&baltype='+baltype+'&installtype=0'+'&pmodelid='+pmodelid+'&stocktype='+stocktype;
	document.form.submit();
}
function getDetails(compid)
{
	document.form.method="post";
	var url='ComplainDetail.do?complainid='+compid;
	window.open(url, '_blank', 'height=650, width=950, left=100, top=0, taskbar=no, status=no, titlebar=no, toolbar=no, addressbar=no, menubar=no, location=no, resizable=yes, Fullscreen=yes, scrollbars=yes');
}
function viewTransfer(stockid, inward, outward, stocktype)
{
	document.form.method="post";
	var url='partxferdetails.do?stockid='+stockid+'&inward='+inward+'&outward='+outward+'&stocktype='+stocktype;
	window.open(url, '_blank', 'height=300, width=950, left=100, top=100, taskbar=no, status=no, titlebar=no, toolbar=no, addressbar=no, menubar=no, location=no, resizable=yes, Fullscreen=yes, scrollbars=yes');
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
Statement st2 = con.createStatement();
ResultSet rs1=null, rs2=null;
long sr=1, norecord=0, stock=0, tstock=0, index=1, cartid=0, enggid=0, minstock=0;
long colorcode=0, tmpid=0, branchid=1, datatype=1, stocktype=1, pmodel=0;
String str1="", str2="", cmodel="ALL", ename="ALL", tmpmodel="", unit="", pmodelname="ALL";
String dt1="",dt2="";
v1="";if((v1=request.getParameter("branchid"))!=null){branchid=Long.parseLong(v1);}
v1="";if((v1=request.getParameter("cid"))!=null){cartid=Long.parseLong(v1);}
v1="";if((v1=request.getParameter("wid"))!=null){enggid=Long.parseLong(v1);}
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
		ca1.add(Calendar.DATE, -0);

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
str1="Select unique exec_id, execode, sname from field_executive where left_job='NO' and exe_type=1 order by execode";
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
<div id="hstyle">PRINTER PART STATEMENT</div><center>
<input type="hidden" value="0" name="installtype" id="installtype">
<input type="hidden" value="used" name="baltype" id="baltype">
<table border="0" align="center" cellpadding="5" cellspacing="7" width="95%">
<tr>
<td align=right><label>Stock Type:</label></td>
<td align=left>
	<select name="stocktype" style="width:300px">
	<option value="1" <% if(stocktype==1){%>selected<%}%> >Office Stock</option>
	<option value="2" <% if(stocktype==2){%>selected<%}%> >Engieer Stock</option>
	</select>
</td>
<td align=right><label>Printer:</label></td>
<td align=left>
<input type=text value="<%=pmodelname%>", id=pmodelname name="pmodelname" style="width:300px" onBlur="javascript: if(validateElement(printerarray, 'pmodelname')){listElementId(printerarray, printeridarray, 'pmodelname', 'pmodel');}">
<input type=hidden id='pmodel' name="pmodel" value="<%=pmodel%>">
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
<td align=right><label>Engieer:</label></td>
<td align=left>
<input type='text' id='worker' name="worker" value="<%=ename%>" style="width:300px" onBlur="javascript: if(validateElement(workerarray, 'worker')){listElementId(workerarray, workeridarray, 'worker', 'wid');}">
<input type=hidden id='wid' name="wid" value="<%=enggid%>">
</td>
<td align=right><label>From:</label></td>
<td>
	<input type=text value="<%=dt1 %>" readonly name="date1" size=8><input type="button" value="Select" onclick="displayCalendar(document.forms[0].date1,'yyyy-mm-dd',this)">
	&nbsp; &nbsp; &nbsp;
	<label>To:</label>
	<input type=text value="<%=dt2 %>" readonly name="date2" size=8><input type="button" value="Select" onclick="displayCalendar(document.forms[0].date2,'yyyy-mm-dd',this)">
	&nbsp; &nbsp; &nbsp;
	<input type="button" name="" value="Export"  onClick="setTarget(2)" style="width:80px">
	&nbsp; &nbsp; &nbsp;
	<input type="button" name="" value="Refresh"  onClick="setTarget(1)" style="width:80px">
</td>
</tr>
</table>
<div style="width:95%; height:25px ; border-left: 0px gray solid; border-right: 0px gray solid; border-top: 0px gray solid; border-bottom: 0px gray solid; padding:0px; margin: 0px">
<table  cellspacing=0 cellpadding=4 border=1 width=100% height="100%">
<tr bgcolor=#666666>
<%
if(stocktype ==  1)
{
	%>
	<th align=center width=5%><font size=2 color=white>SR.</th>
	<th align=center width=10%><font size=2 color=white>DATE</th>
	<th align=center width=10%><font size=2 color=white>BRANCH</th>
	<th align=center width=20%><font size=2 color=white>PART</th>
	<th align=center width=20%><font size=2 color=white>PRINTER</th>
	<th align=center width=5%><font size=2 color=white>OPEN</th>
	<th align=center width=5%><font size=2 color=white>IN</th>
	<th align=center width=5%><font size=2 color=white>OUT</th>
	<th align=center width=5%><font size=2 color=white>CLOSE</th>
	<th align=center width=15%><font size=2 color=white>REMARK</th>
	<%
}
else
if(stocktype ==  2)
{
	%>
	<th align=center width=5%><font size=2 color=white>SR.</th>
	<th align=center width=10%><font size=2 color=white>DT. / BRANCH</th>
	<th align=center width=10%><font size=2 color=white>ENGG / CALL#</th>
	<th align=center width=20%><font size=2 color=white>PART</th>
	<th align=center width=20%><font size=2 color=white>PRINTER</th>
	<th align=center width=5%><font size=2 color=white>OPEN</th>
	<th align=center width=5%><font size=2 color=white>IN</th>
	<th align=center width=5%><font size=2 color=white>OUT</th>
	<th align=center width=5%><font size=2 color=white>CLOSE</th>
	<th align=center width=15%><font size=2 color=white>REMARK</th>
	<%
}
%>
</tr>
</table></div>
<div style="overflow: auto; width:95%; height:450px; border-left: 0px gray solid; border-bottom: 0px gray solid; border-right: 0px gray solid; padding:0px; margin: 0px; ">
<table  cellspacing=0 cellpadding=4 border=1 width=100%><%
String username="", partname="", branch="", trdate="", exptype="", srcname="", brcode=""; 
long inward=0, outward=0, balance=0, src=0, purchaseid=0, estockid=0, prepairid=0, callid=0; 
long fcreturnid=0, installid=0, recid=0, openstock=0, pmodelid=0, partid=0, tinward=0, toutward=0;
long topenbal=0, tclosebal=0, stockid=0;

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
	str1 = "SELECT ps.USER_ID, pp.name, pm.model_name, br.name AS branch_code, " +
		   "ps.TR_DATE, ps.INWARD, ps.OUTWARD, ps.BALANCE, ps.SRC, ps.PURCHASE_ID, " +
		   "ps.ENGG_STOCK_ID, ps.PRINTER_REP_ID, ps.FC_RETURN_ID, pi.call_id, " +
		   "ps.record_id, ps.mat_id, ps.pmodel_id, ps.br_id, ps.id, (SELECT balance FROM "+
		   "part_stock ps2 WHERE ps2.br_id = ps.br_id AND ps2.mat_id = ps.mat_id " +
		   "AND ps2.pmodel_id = ps.pmodel_id AND ps2.record_id < ps.record_id "+
		   "ORDER BY ps2.record_id DESC FETCH FIRST 1 ROWS ONLY) AS openstock "+
		   "FROM part_stock ps " +
		   "LEFT JOIN printer_part pp ON ps.mat_id = pp.id " +
		   "LEFT JOIN p_model pm ON ps.PMODEL_ID = pm.id " +
		   "LEFT JOIN branch br ON ps.br_id = br.id " +
		   "LEFT JOIN part_install pi ON ps.install_id = pi.id " +
		   "WHERE src>0 and ps.tr_date BETWEEN '" + dt1 + "' AND '" + dt2 + "'";
	if (branchid != 0) {str1 += " AND ps.br_id = " + branchid;}
	if (cartid != 0) {str1 += " AND ps.mat_id = " + cartid;}
	if (pmodel != 0) {str1 += " AND ps.pmodel_id = " + pmodel;}
	str1 += " ORDER BY ps.br_id, ps.mat_id, ps.pmodel_id, ps.record_id";
	
	try
	{
		str2="SELECT SUM(BALANCE) FROM PART_STOCK PS "+
			  "WHERE RECORD_ID = ( "+
			  "SELECT MAX(RECORD_ID) FROM PART_STOCK PS2 "+
			  "WHERE PS2.MAT_ID=PS.MAT_ID AND PS2.PMODEL_ID=PS.PMODEL_ID AND PS2.TR_DATE < '"+dt1+"' ";
			if (branchid != 0) {str2 += " AND ps2.br_id = " + branchid;}
			if (cartid != 0) {str2 += " AND ps2.mat_id = " + cartid;}
			if (pmodel != 0) {str2 += " AND ps2.pmodel_id = " + pmodel;}
		str2 += ")";
		rs2 = st2.executeQuery(str2);
		if(rs2.next()){ topenbal=rs2.getLong(1); }
	}
	catch(Exception e){}
	
	try
	{
		/*	
		str2="SELECT MAT_ID, PMODEL_ID, SUM(BALANCE) AS TOTAL_LATEST_BALANCE FROM PART_STOCK PS "+
			  "WHERE RECORD_ID = ( "+
			  "SELECT MAX(RECORD_ID) FROM PART_STOCK PS2 "+
			  "WHERE PS2.MAT_ID=PS.MAT_ID AND PS2.PMODEL_ID=PS.PMODEL_ID AND PS2.TR_DATE <= '"+dt2+"' ";
			if (branchid != 0) {str2 += " AND ps2.br_id = " + branchid;}
			if (cartid != 0) {str2 += " AND ps2.mat_id = " + cartid;}
			if (pmodel != 0) {str2 += " AND ps2.pmodel_id = " + pmodel;}
		str2 += ") GROUP BY MAT_ID, PMODEL_ID";
		*/	
		str2="SELECT SUM(BALANCE) FROM PART_STOCK PS "+
			  "WHERE RECORD_ID = ( "+
			  "SELECT MAX(RECORD_ID) FROM PART_STOCK PS2 "+
			  "WHERE PS2.MAT_ID=PS.MAT_ID AND PS2.PMODEL_ID=PS.PMODEL_ID AND PS2.TR_DATE <= '"+dt2+"' ";
			if (branchid != 0) {str2 += " AND ps2.br_id = " + branchid;}
			if (cartid != 0) {str2 += " AND ps2.mat_id = " + cartid;}
			if (pmodel != 0) {str2 += " AND ps2.pmodel_id = " + pmodel;}
		str2 += ")";
		rs2 = st2.executeQuery(str2);
		if(rs2.next()){ tclosebal=rs2.getLong(1); }
	}
	catch(Exception e){}
}
else
if(stocktype ==  2)
{
	str1 = "SELECT esd.USER_ID, pp.name, pm.model_name, fe.execode AS engineer_name, " +
		  "esd.USED_DATE, esd.INWARD, esd.OUTWARD, esd.BALANCE, esd.SRC, esd.CALL_ID, " +
		  "esd.P_ID, esd.PMODEL_ID, esd.ENG_NAME, br.code AS branch_code, (SELECT balance FROM " +
		  "ENG_STOCK_DETAILS esd2 WHERE esd2.ENG_NAME = esd.ENG_NAME AND esd2.P_ID = esd.P_ID " +
		  "AND esd2.PMODEL_ID = esd.PMODEL_ID AND esd2.RECORD_ID < esd.RECORD_ID " +
		  "ORDER BY esd2.RECORD_ID DESC FETCH FIRST 1 ROWS ONLY) AS openstock " +
		  "FROM ENG_STOCK_DETAILS esd " +
		  "LEFT JOIN printer_part pp ON esd.p_id = pp.id " +
		  "LEFT JOIN p_model pm ON esd.PMODEL_ID = pm.id " +
		  "LEFT JOIN branch br ON esd.br_id = br.id " +
		  "LEFT JOIN field_executive fe on esd.eng_name = fe.exec_id "+
		  "WHERE src>0 and esd.USED_DATE BETWEEN '"+dt1+"' AND '"+dt2+"'";
	if (enggid != 0) {str1 += " AND esd.ENG_NAME = " + enggid;}
	if (cartid != 0) {str1 += " AND esd.P_ID = " + cartid;}
	if (pmodel != 0) {str1 += " AND esd.pmodel_id = " + pmodel;}
	str1 += " ORDER BY esd.eng_name, esd.P_ID, esd.PMODEL_ID, esd.RECORD_ID";
	
	try
	{
		str2="SELECT SUM(BALANCE) FROM ENG_STOCK_DETAILS esd "+
			  "WHERE RECORD_ID = ( "+
			  "SELECT MAX(RECORD_ID) FROM ENG_STOCK_DETAILS esd2 "+
			  "WHERE esd2.P_ID=esd.P_ID AND esd2.PMODEL_ID=esd.PMODEL_ID AND esd2.USED_DATE < '"+dt1+"' ";
			if (enggid != 0) {str2 += " AND esd2.ENG_NAME = " + enggid;}
			if (cartid != 0) {str2 += " AND esd2.P_ID = " + cartid;}
			if (pmodel != 0) {str2 += " AND esd2.pmodel_id = " + pmodel;}
		str2 += ")";
		rs2 = st2.executeQuery(str2);
		if(rs2.next()){ topenbal=rs2.getLong(1); }
	}
	catch(Exception e){}
	
	try
	{
		str2="SELECT SUM(BALANCE) FROM ENG_STOCK_DETAILS esd "+
			  "WHERE RECORD_ID = ( "+
			  "SELECT MAX(RECORD_ID) FROM ENG_STOCK_DETAILS esd2 "+
			  "WHERE esd2.P_ID=esd.P_ID AND esd2.PMODEL_ID=esd.PMODEL_ID AND esd2.USED_DATE <= '"+dt2+"' ";
			if (enggid != 0) {str2 += " AND esd2.ENG_NAME = " + enggid;}
			if (cartid != 0) {str2 += " AND esd2.P_ID = " + cartid;}
			if (pmodel != 0) {str2 += " AND esd2.pmodel_id = " + pmodel;}
		str2 += ")";
		rs2 = st2.executeQuery(str2);
		if(rs2.next()){ tclosebal=rs2.getLong(1); }
	}
	catch(Exception e){}
}

rs1 = st1.executeQuery(str1);
while(rs1.next())
{
	username=""; partname=""; pmodelname=""; branch=""; trdate=""; srcname=""; brcode=""; 
	inward=0; outward=0; balance=0; src=0; purchaseid=0; estockid=0; prepairid=0; callid=0;
	fcreturnid=0; installid=0; recid=0; openstock=0; pmodelid=0; partid=0; branchid=0; stockid=0;

	if(stocktype==1)
	{
		v1=""; if((v1=rs1.getString(1))!=null){username=v1;}
		v1=""; if((v1=rs1.getString(2))!=null){partname=v1;}
		v1=""; if((v1=rs1.getString(3))!=null){pmodelname=v1;}
		v1=""; if((v1=rs1.getString(4))!=null){branch=v1;}
		v1=""; if((v1=rs1.getString(5))!=null){trdate=v1;}
		inward=rs1.getLong(6);
		outward=rs1.getLong(7);
		balance=rs1.getLong(8);
		src=rs1.getLong(9);
		purchaseid=rs1.getLong(10);
		estockid=rs1.getLong(11);
		prepairid=rs1.getLong(12);
		fcreturnid=rs1.getLong(13);
		installid=rs1.getLong(14);
		recid=rs1.getLong(15);
		partid=rs1.getLong(16);
		pmodelid=rs1.getLong(17);
		branchid=rs1.getLong(18);
		stockid=rs1.getLong(19);
		openstock=rs1.getLong(20);

		/*
		0-initial zero balance record for each item, 1-purchase or allocation, 2-allot to engg allot, 
		3-inhouse printer repair use, 4-de-allot from engg, 5-transfer between printer, 
		7-faulty return found working, 8-allot to call, 9 - transfer between branches and printers, 
		10-purchase return or delete purchase entry, 11-balance adjustment
		*/

		if (src == 0) {srcname = "Initial stock record"; } 
		else 
		if (src == 1) {srcname = "Purchase or opening"; } 
		else 
		if (src == 2) {srcname = "Allot to engg.";} 
		else 
		if (src == 3) { srcname = "In-house printer repair"; }
		else 
		if (src == 4) {srcname = "De-allot from engg.";} 
		else 
		if (src == 5) {srcname = "Transfer between printer";}
		else 
		if (src == 7) {srcname = "Faulty return in ok condition"; callid=fcreturnid;}
		else 
		if (src == 8) {srcname = "Allot to call"; callid=installid;}
		else 
		if (src == 9) {srcname = "Transfer between branches";}
		else 
		if (src == 10) {srcname = "Purchase return or cancel";}
		else 
		if (src == 11) {srcname = "Balance adjustment";}
	}
	else
	if(stocktype==2)
	{
		v1=""; if((v1=rs1.getString(1))!=null){username=v1;}
		v1=""; if((v1=rs1.getString(2))!=null){partname=v1;}
		v1=""; if((v1=rs1.getString(3))!=null){pmodelname=v1;}
		v1=""; if((v1=rs1.getString(4))!=null){branch=v1;}
		v1=""; if((v1=rs1.getString(5))!=null){trdate=v1;}
		inward=rs1.getLong(6);
		outward=rs1.getLong(7);
		balance=rs1.getLong(8);
		src=rs1.getLong(9);
		callid=rs1.getLong(10);
		partid=rs1.getLong(11);
		pmodelid=rs1.getLong(12);
		enggid=rs1.getLong(13);
		v1=""; if((v1=rs1.getString(14))!=null){brcode=v1;}
		openstock=rs1.getLong(15);
 
		if (src == 1) {srcname = "Allocation"; } 
		else 
		if (src == 2) {srcname = "Installation";} 
		else 
		if (src == 3) { srcname = "Uninstalled Part Return"; }
		else 
		if (src == 4) {srcname = "De-allocation";} 
		else 
		if (src == 5) {srcname = "Transfer between printer";}
	}

	tinward += inward;
	toutward += outward;
	
	%>
	<tr <%if(sr%2==0){%>bgcolor=Ghostwhite<%}else{%>bgcolor=#D5F5E3<%}%> valign="top">
	<td nowrap align=center width=5%><%=sr++%></td>
	<td align=left width=10%><font size=2><%=dateformat.formatDate(trdate) %><br><br><b><%=brcode%></b></td>
	<td align=left width=10%><font size=2><%=branch%><% if(callid>0){%><br><br>Call# <b><a href="#" onclick="getDetails('<%=callid%>')"><%=callid%></a></b><%} %></td>
	<td align=left width=20%><font size=2><%=partname %></td>
	<td align=left width=20%><font size=2><%=pmodelname %></td>
	<%
	if(openstock==0){%><td align=center width=5%><br></td><%} else {%><td align=center width=5%><%=openstock %></td><%}
	if(inward==0){%><td align=center width=5%><br></td><%} else {%><td align=center width=5%><%=inward %></td><%}
	if(outward==0){%><td align=center width=5%><br></td><%} else {%><td align=center width=5%><%=outward %></td><%}
	if(balance==0){%><td align=center width=5%><br></td><%} else {%><td align=center width=5%><%=balance %></td><%}
	%>
	<td align=left width=15%><font size=2>
		<%=srcname %>
		<%
		if(stocktype==1 && src==9){ %> - <a href="#" onclick="viewTransfer('<%=stockid%>', '<%=inward%>', '<%=outward%>', '<%=stocktype%>')"><b>View Transfer</b></a><% }
		%>
		<BR><BR>By: <%=username.toLowerCase() %>
	</font>
	</td>
	</tr>
	<%
}
if(rs1!=null){rs1.close();}
if(rs2!=null){rs2.close();}
if(st1!=null){st1.close();}
if(st2!=null){st2.close();}
con.close();%>
</table></div>
<div style="width:95%; height:25px ; border-left: 0px gray solid; border-right: 0px gray solid; border-top: 0px gray solid; border-bottom: 0px gray solid; padding:0px; margin: 0px">
<table  cellspacing=0 cellpadding=4 border=1 width=100% height="100%">
<tr bgcolor=#666666>
<th align=center width=63% colspan=5><font size=2 color=white>TOTAL</th>
<th align=center width=5%><font size=3 color=white><%=topenbal%></font></th>
<th align=center width=5%><font size=3 color=white><%=tinward%></font></th>
<th align=center width=5%><font size=3 color=white><%=toutward%></font></th>
<th align=center width=5%><font size=3 color=white><%=tclosebal%></font></th>
<th align=center width=15%><font size=3 color=white><br></font></th>
</tr>
</table></div>
<script>var obj1 = new actb(document.getElementById('cmodel'),cartarray);</script>
<script>var obj2 = new actb(document.getElementById('worker'),workerarray);</script>
<script>var obj3 = new actb(document.getElementById('pmodelname'),printerarray);</script>
</form></BODY></HTML>