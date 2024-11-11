
<%@ page language="java" import="java.sql.*, MyBeans.*, java.util.Date, java.io.*"%>
<%@ page import="java.text.DateFormat, java.text.SimpleDateFormat, java.lang.*"%>
<%@ page import="org.apache.commons.lang3.ArrayUtils, java.util.ArrayList, java.util.HashMap, java.util.Map"%>
<jsp:useBean id="cmpbrn" scope="request" class="MyBeans.BranchDetails" />
<HTML><HEAD><TITLE>PART READY STOCK</TITLE>
<script type="text/javascript">var GB_ROOT_DIR = "css/greybox/";</script>
<script type="text/javascript" src="css/greybox/AJS.js"></script>
<script type="text/javascript" src="css/greybox/AJS_fx.js"></script>
<script type="text/javascript" src="css/greybox/gb_scripts.js"></script>
<link href="css/greybox/gb_styles.css" rel="stylesheet" type="text/css" media="all" />
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
	if(document.form.branchid.value==""){alert("Please select a stock branch!"); document.form.branchid.focus();}
//	else
//	if(document.form.cid.value=="0" && document.form.pmodel.value=="0"){alert("Please select either one part name or printer name, both can't be ALL!"); document.form.cmodel.focus();}
	else
	if(target==1){document.form.method="POST";document.form.target="";document.form.action="partstock.do";	document.form.submit();}
	else
	if(target==2){document.form.method="POST";document.form.target="_blank";document.form.action="PartStock";	document.form.submit();}
	else
	if(target==3){document.form.method="POST";document.form.target="";document.form.action="PartAddStock.do";	document.form.submit();}
	else
	if(target==4){document.form.method="POST";document.form.target="";document.form.action="PartLessStock.do";	document.form.submit();}
	else
	if(target==5){document.form.method="POST";document.form.target="";document.form.action="PartConfirmStock.do";	document.form.submit();}
}
function setLastRecord()
{
	document.form.loopcount1.value=document.form.loopcount.value;
	document.form.brnid1.value=document.form.brnid.value;
}

var cartarray=new Array(); var cartidarray=new Array();
cartarray[0]="ALL"; cartidarray[0]="0";
var printerarray=new Array(); var printeridarray=new Array();
printerarray[0]="ALL"; printeridarray[0]="0";
<%
String validate="NO", v1="";
HttpSession ses=request.getSession(true);

String usrid=(String)ses.getAttribute("usr_id");
String brnlist=(String)ses.getAttribute("brnlist");  
long utotalbrn=Long.parseLong((String)ses.getAttribute("utotalbrn"));
long UsrBrnList[]=(long[])ses.getAttribute("UsrBrnList");

class StockItem
{
	String printerPartName;
	String pmodelName;
	int matId;
	int pmodelId;
	int totalInward;
	int totalOutward;
	int openingStock;
	int closingStock;
	int minStock;
	String recordId;

	// Constructor
	public StockItem(String printerPartName, String pmodelName, int matId, int pmodelId, String recordId) 
	{
		this.printerPartName = printerPartName;
		this.pmodelName = pmodelName;
		this.matId = matId;
		this.pmodelId = pmodelId;
		this.recordId = recordId;
		this.totalInward = 0;
		this.totalOutward = 0;
		this.openingStock = 0;
		this.closingStock = 0;
		this.minStock = 0;
	}
}
ArrayList<StockItem> stockList = new ArrayList<>();
Map<String, StockItem> itemMap = new HashMap<>();

DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
Date dat=new Date();
String dt1=dateFormat.format(dat);
String dt2=dt1;

Connection con=DBConnection.getNewInstance().getConnection();
Statement st1 = con.createStatement();
ResultSet rs1=null;
long sr=1, norecord=0, index=1, cartid=0, minstock=0, colorcode=0, tmpid=0, branchid=0, pmodel=0;
long topen=0, tinward=0, toutward=0, tclose=0;
//if(branchid==0){branchid=cbrnid;}
String str1="", str2="", cmodel="ALL", tmpmodel="", unit="", pmodelname="ALL";
String var1="mid", var2="ostock", var3="pmodel", var4="recid", var5="oldstock", incr="", v2="", v3="", v4="", v5="";
v1="";if((v1=request.getParameter("cid"))!=null){cartid=Long.parseLong(v1);}else{cartid=0;}
v1="";if((v1=request.getParameter("date1"))!=null){dt1=v1;}
v1="";if((v1=request.getParameter("date2"))!=null){dt2=v1;}
v1="";if((v1=request.getParameter("branchid"))!=null){branchid=Long.parseLong(v1);}
v1="";if((v1=request.getParameter("pmodel"))!=null){pmodel=Long.parseLong(v1);}
v1="";if((v1=request.getParameter("pmodelname"))!=null){pmodelname=v1;}
v1="";if((v1=request.getParameter("cmodel"))!=null){cmodel=v1;}

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
%></script></HEAD><BODY onLoad="setLastRecord()"><center>
<form autocomplete="off"  name="form" onkeypress="return DisableEnter()" action="" method="post"><center>
<div id="hstyle">PART READY STOCK</div><br><center>
<table border="0" align="center" cellpadding="5" cellspacing="5" width="90%">
<tr>
<td align=right><label>Branch:</label></td>
<td><select name="branchid" style="width:350px">
<option value=""></option>
<%
String branchLlist[][]=cmpbrn.getBranchListSelect(con, brnlist, utotalbrn);
int i=0, j=0;
for(i=0; i<branchLlist.length; i++)
{
	j=0;
	%><option value="<%=branchLlist[i][j++]%>" <%if(branchid==Long.parseLong(branchLlist[i][(j-1)])){%> selected <%}%> ><%=branchLlist[i][j++]%>, <%=branchLlist[i][j++]%>, <%=branchLlist[i][j++]%></option><%
}%></select>
</td>
<td align=right><label>PART:</label></td>
<td align=left>
<input type=text value="<%=cmodel%>", id=cmodel name="cmodel" style="width:350px" onBlur="javascript: if(validateElement(cartarray, 'cmodel')){listElementId(cartarray, cartidarray, 'cmodel', 'cid');}">
<input type=hidden id='cid' name="cid" value="<%=cartid%>">
</td>
</tr>
<tr>
<td align=right><label>From:</label></td>
<td>
<input type=text value="<%=dt1 %>" readonly name="date1" size=10><input type="button" value="...." onclick="displayCalendar(document.forms[0].date1,'yyyy-mm-dd',this)">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
<label>To:</label>
<input type=text value="<%=dt2 %>" readonly name="date2" size=10><input type="button" value="...." onclick="displayCalendar(document.forms[0].date2,'yyyy-mm-dd',this)">
</td>
<td align=right><label>PRINTER:</label></td>
<td align=left>
<input type=text value="<%=pmodelname%>", id=pmodelname name="pmodelname" style="width:350px" onBlur="javascript: if(validateElement(printerarray, 'pmodelname')){listElementId(printerarray, printeridarray, 'pmodelname', 'pmodel');}">
<input type=hidden id='pmodel' name="pmodel" value="<%=pmodel%>">
</td>
</tr>
<tr>
<td colspan=4 align=right>
<input type="button" name="" value=" Export " onClick="setTarget(2)" style="width:150px">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
<input type="button" name="" value="Confirm Stock" onClick="setTarget(5)" style="width:150px">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
<input type="button" name="" value="Add Stock" onClick="setTarget(3)" style="width:150px" <% if(usrid.equals("ADMIN") || usrid.equals("AMIN1") || usrid.equals("RAHUL")){}else{%>disabled<%}%>>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
<input type="button" name="" value="Reduce Stock" onClick="setTarget(4)" style="width:150px" <% if(usrid.equals("ADMIN") || usrid.equals("AMIN1") || usrid.equals("RAHUL")){}else{%>disabled<%}%>>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
<input type="button" name="" value="Refresh" onClick="setTarget(1)" style="width:150px">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
</td>
</tr>
</table>
<input type=hidden name="loopcount1" name="loopcount1"  value="<%=sr%>">
<input type=hidden name="brnid1" name="brnid1" value="<%=branchid%>">
<div style="width:97%; height:22px ; border-left: 2px gray solid; border-right: 2px gray solid; border-top: 2px gray solid; border-bottom: 2px gray solid; padding:0px; margin: 0px">
<table  cellspacing=0% cellpadding=5 width=100% height=100% border=0>
<tr bgcolor=#666666>
<th align=center width=5%><font size=2 color=white>SR.</th>
<th align=center width=25%><font size=2 color=white>PART NAME</th>
<th align=center width=25%><font size=2 color=white>PRINTER MODEL</th>
<th align=center width=5%><font size=2 color=white>MIN.</th>
<th align=center width=5%><font size=2 color=white>OPEN</th>
<th align=center width=5%><font size=2 color=white>IN</th>
<th align=center width=5%><font size=2 color=white>OUT</th>
<th align=center width=5%><font size=2 color=white>BAL</th>
<th align=center width=10%><font size=2 color=white>TRANSFER</th>
<th align=center width=10%><font size=2 color=white>QTY</th>
</tr>
</table></div>
<div style="overflow: auto; width:97%; height:400px ; border-left: 2px gray solid; border-right: 2px gray solid; border-top: 2px gray solid; border-bottom: 2px gray solid; padding:0px; margin: 0px">
<table  cellspacing=0 cellpadding=5 border=1 width=100%><%
String condition = "src!=0 and br_id = " + branchid + " AND TR_DATE <= '"+dt2+"'";
if (cartid != 0) { condition += " AND mat_id = " + cartid; }
if (pmodel != 0) { condition += " AND pmodel_id = " + pmodel; }

str1 = "SELECT t.MAT_ID, t.pmodel_id, t.balance, t.record_id, pp.name AS printer_part_name, "
        + "pm.model_name AS pmodel_name, ppms.min_stock "
        + "FROM ("
        + "SELECT MAT_ID, pmodel_id, balance, record_id, "
        + "ROW_NUMBER() OVER (PARTITION BY MAT_ID, pmodel_id ORDER BY record_id DESC) as rn "
        + "FROM part_stock WHERE " + condition + ") t "
        + "JOIN printer_part pp ON t.mat_id = pp.id "
        + "JOIN printer_part_min_stock ppms ON ppms.part_id = pp.id AND ppms.br_id = " + branchid + " "
        + "JOIN p_model pm ON t.pmodel_id = pm.id "
        + "WHERE t.rn = 1 AND pp.status = 1 "
        + "ORDER BY t.balance DESC, pp.name, pm.model_name";
		
rs1=st1.executeQuery(str1);
while(rs1.next())
{
	int matId = rs1.getInt("MAT_ID");
	int pmodelId = rs1.getInt("pmodel_id");
	String recordId = rs1.getString("record_id");
	int closingStock = rs1.getInt("balance");
	int minStock = rs1.getInt("min_stock");
	String printerPartName = rs1.getString("printer_part_name");
	String pmodelName = rs1.getString("pmodel_name");

	String key = matId + "-" + pmodelId;
	StockItem item;
	if (itemMap.containsKey(key)) {item = itemMap.get(key);}
	else
	{
		item = new StockItem(printerPartName, pmodelName, matId, pmodelId, recordId);
		stockList.add(item);
		itemMap.put(key, item);
	}
	item.closingStock = closingStock;
	item.minStock = minStock;
}

condition="ps.src!=0 and ps.br_id = " + branchid + " AND TR_DATE between '"+dt1+"' and '"+dt2+"' ";
if (cartid != 0) { condition += " AND ps.mat_id = " + cartid;}
if (pmodel != 0) {condition += " AND ps.pmodel_id = " + pmodel;}
str1 = "SELECT ps.MAT_ID, ps.pmodel_id, pp.name AS printer_part_name, "
        + "pm.model_name AS pmodel_name, "
        + "SUM(ps.inward) AS total_inward, SUM(ps.outward) AS total_outward "
        + "FROM part_stock ps "
        + "JOIN printer_part pp ON ps.mat_id = pp.id "
        + "JOIN p_model pm ON ps.pmodel_id = pm.id "
        + "WHERE " + condition + " and pp.status=1 "
        + "GROUP BY ps.MAT_ID, ps.pmodel_id, pp.name, pm.model_name "
        + "ORDER BY pp.name, pm.model_name";
rs1=st1.executeQuery(str1);
while(rs1.next())
{ 
	int matId = rs1.getInt("MAT_ID");
	int pmodelId = rs1.getInt("pmodel_id");
	int totalInward = rs1.getInt("total_inward");
	int totalOutward = rs1.getInt("total_outward");

	String key = matId + "-" + pmodelId;

	if (itemMap.containsKey(key)) 
	{
		StockItem item = itemMap.get(key);
		item.totalInward = totalInward;
		item.totalOutward = totalOutward;
	}	
}

condition = "src!=0 and br_id = " + branchid + " AND TR_DATE < '"+dt1+"'";
if (cartid != 0) { condition += " AND mat_id = " + cartid;}
if (pmodel != 0) {condition += " AND pmodel_id = " + pmodel;}
str1 = "SELECT t.MAT_ID, t.pmodel_id, t.balance, pp.name AS printer_part_name, "
		+ "pm.model_name AS pmodel_name, pp.min_stock  "
        + "FROM ("
        + "SELECT MAT_ID, pmodel_id, balance, ROW_NUMBER() "
        + "OVER (PARTITION BY MAT_ID, pmodel_id ORDER BY record_id DESC) as rn "
        + "FROM part_stock WHERE " + condition + ") t "
        + "JOIN printer_part pp ON t.mat_id = pp.id "
        + "JOIN p_model pm ON t.pmodel_id = pm.id "
        + "WHERE rn = 1  and pp.status=1"
        + "ORDER BY t.balance DESC, pp.name, pm.model_name";
rs1=st1.executeQuery(str1);
while(rs1.next())
{
	int matId = rs1.getInt("MAT_ID");
	int pmodelId = rs1.getInt("pmodel_id");
	int openingStock = rs1.getInt("balance");

	String key = matId + "-" + pmodelId;

	if (itemMap.containsKey(key)) 
	{
		StockItem item = itemMap.get(key);
		item.openingStock = openingStock; // Update opening stock
	}	
}

for (StockItem item : stockList) 
{
	topen += item.openingStock;
	tinward += item.totalInward;
	toutward += item.totalOutward;
	tclose += item.closingStock;
	
	v1=""; v2=""; v3=""; v4=""; v5=""; colorcode++;
	incr=Long.toString(sr);
	v1=var1+incr;
	v2=var2+incr;
	v3=var3+incr;
	v4=var4+incr;
	v5=var5+incr;

	%>
	<tr <% if(colorcode%2==0){%>bgcolor=Ghostwhite<%}else{%>bgcolor=#D5F5E3<%} %> >
	<td align=center width=5%><%=sr++%></td>
	<td align=left width=25%>
		<font size=2><%=item.printerPartName %>
		<input type=hidden name="<%=v1%>" value="<%=item.matId%>">
		<input type=hidden name="<%=v4%>" value="<%=item.recordId%>">
	</td>
	<td align=left width=25%><font size=2>
		<%=item.pmodelName %>
		<input type=hidden name="<%=v3%>" value="<%=item.pmodelId%>">
	</td>
	<td align=center width=5%><%=item.minStock%></td>
	<td align=center width=5%><%=item.openingStock%></td>
	<td align=center width=5%><%=item.totalInward%></td>
	<td align=center width=5%><%=item.totalOutward%></td>
	<td align=center width=5%>
		<%if(item.closingStock < item.minStock){%><font color=red><%} %><%=item.closingStock%>
		<input type=hidden name="<%=v5%>" value="<%=item.closingStock%>">
	</td>
    <td width=10%>
		<%
		if(usrid.equals("AMIN") || usrid.equals("ADMIN") || usrid.equals("VISHESH") || usrid.equals("ABHISHEK") || usrid.equals("SAVITA") || usrid.equals("TEJASH") || usrid.equals("PRADIP") || usrid.equals("RAHUL") || usrid.equals("DIVYA") || usrid.equals("HAYATH") || usrid.equals("GAUTAM") || usrid.equals("DELHISUPPORT") || usrid.equals("HAFEEZUNNISA"))
		{
			%><input type="button" onClick="GB_showCenter('Transfer part stock to other branch and printer','<%=request.getScheme()+"://"+request.getServerName()+request.getContextPath()%>/movecartstock?stockprod=part&cartid=<%=item.matId%>&stock=<%=item.closingStock%>&cmodel=<%=item.printerPartName%>&branchid=<%=branchid%>&pmodel=<%=item.pmodelId%>&pmodelname=<%=item.pmodelName%>',500,750);" name="mbtn" value="Transfer" id="mbtn" style="width:80px" /><%
		}
		%>
	</td>
	<td align=center width=10%><input type=text name="<%=v2%>" value="" maxlength=5 style="width:50px" onKeyPress="return numbersonly(this, event)" style="background-color:Ghostwhite"></td>
	</tr><%
}
if(rs1!=null){rs1.close();}
if(st1!=null){st1.close();}
con.close();%>
</table></div>
<div style=" width:97%; height:18px; border-left: 0px gray solid; border-bottom: 0px gray solid; border-right: 0px gray solid; padding:0px; margin: 0px; background-color:Linen;">	
<table width="100%" cellspacing=0 cellpadding=0 border=1 height=100%>
<tr bgcolor=#666666>
<td nowrap align=center colspan=4 colspan=45%><font size=3 color=white><b>TOTAL</font></td>
<td align=center width=5%><font size=3 color=white><b><%=topen%></td>
<td align=center width=5%><font size=3 color=white><b><%=tinward%></td>
<td align=center width=5%><font size=3 color=white><b><%=toutward%></td>
<td align=center width=5%><font size=3 color=white><b><%=tclose%></td>
<td align=left width=20% colspan=2><br></td>
</tr>
</table></div>
<input type=hidden name="loopcount" name="loopcount"  value="<%=sr%>">
<input type=hidden name="brnid" name="brnid" value="<%=branchid%>">
</form>
<script>var obj1 = new actb(document.getElementById('cmodel'),cartarray);</script>
<script>var obj2 = new actb(document.getElementById('pmodelname'),printerarray);</script>
</BODY></HTML>