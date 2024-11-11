
<%@ page language="java" import="java.sql.*, MyBeans.*,java.util.Calendar" import="java.util.Date" import="java.io.*" import="java.text.DateFormat" import="java.text.SimpleDateFormat" import="java.lang.*"%>
<jsp:useBean id="dateformat" scope="request" class="MyBeans.convertDate" />
<jsp:useBean id="cmpbrn" scope="request" class="MyBeans.BranchDetails" />
<HTML><HEAD><TITLE>PART ALLOCATION TO CALL</TITLE>
<link rel="stylesheet" type="text/css" href="DataTables/datatables.css">
<link rel="stylesheet" type="text/css" href="DataTables/jquery.dataTables.min.css">
<script type="text/javascript" charset="utf8" src="DataTables/datatables.js"></script>
<script type="text/javascript" charset="utf8" src="DataTables/jquery-3.3.1.js"></script>
<script type="text/javascript" charset="utf8" src="DataTables/jquery.dataTables.min.js"></script>
<link href="css/style1.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="css/dhtmlgoodies_calendar.css?random=20051112" media="screen"/>
<script type="text/javascript" src="js/dhtmlgoodies_calendar.js?random=20060118"></script>
<script type="text/javascript">var GB_ROOT_DIR = "css/greybox/";</script>
<script type="text/javascript" src="css/greybox/AJS.js"></script>
<script type="text/javascript" src="css/greybox/AJS_fx.js"></script>
<script type="text/javascript" src="css/greybox/gb_scripts.js"></script>
<link href="css/greybox/gb_styles.css" rel="stylesheet" type="text/css" media="all" />
<script language="javascript" type="text/javascript" src="js/rightclick.js"></script>
<script language="javascript" type="text/javascript" src="js/ListElement.js"></script> 
<script language="javascript" type="text/javascript" src="js/ValidateElement.js"></script>   
<script language="javascript" type="text/javascript" src="js/actb.js"></script>
<script language="javascript" type="text/javascript" src="js/common.js"></script>
<script language="javascript">
$(document).ready(function() {
    $('#userTable').DataTable( {
        columnDefs: [ {
            targets: [ 0 ],
            orderData: [ 0, 1 ]
        }, {
            targets: [ 1 ],
            orderData: [ 1, 0 ]
        }, {
            targets: [ 4 ],
            orderData: [ 4, 0 ]
        } ]
    } );
} );

function getDetails(compid)
{
	document.form.method="post";
	var url='DoneComplainDetail.do?complainid='+compid;
	window.open(url, '_blank', 'height=650, width=950, left=100, top=0, taskbar=no, status=no, titlebar=no, toolbar=no, addressbar=no, menubar=no, location=no, resizable=yes, Fullscreen=yes, scrollbars=yes');
}
</script><%
String validate="NO", v1="",v2="",vloc="";
HttpSession ses=request.getSession(true);
String usrid=(String)ses.getAttribute("usr_id");
String brnlist=(String)ses.getAttribute("brnlist");  
long utotalbrn=Long.parseLong((String)ses.getAttribute("utotalbrn"));
long UsrBrnList[]=(long[])ses.getAttribute("UsrBrnList");

String update="Y";
String delete="Y";
%>
<script LANGUAGE="JavaScript">
var enggarray=new Array(); var enggidarray=new Array(); 
enggarray[0]="ALL"; enggidarray[0]="0"; <%
String location="ALL" ,engineer="ALL", clientname="ALL", clientid="0", enggid="0", locid="0";
long status=1;
v1="";if((v1=request.getParameter("status"))!=null){status=Long.parseLong(v1);}
v1="";if((v1=request.getParameter("cname"))!=null){clientname=v1;}
v1="";if((v1=request.getParameter("cid"))!=null){clientid=v1;}
v1="";if((v1=request.getParameter("engg"))!=null){engineer=v1;}
v1="";if((v1=request.getParameter("eid"))!=null){enggid=v1;}
v1="";if((v1=request.getParameter("loc"))!=null){location=v1;}
v1="";if((v1=request.getParameter("locid"))!=null){locid=v1;}
if(clientname.length()==0){clientname="ALL";}
if(clientid.length()==0){clientid="0";}
if(engineer.length()==0){engineer="ALL";}
if(enggid.length()==0){enggid="0";}
if(location.length()==0){location="ALL";}
if(locid.length()==0){locid="0";}
String dt1="",dt2="";
v1=""; if((v1=request.getParameter("date1"))!=null){if(v1.length()>0){dt1=v1;}}
v1=""; if((v1=request.getParameter("date2"))!=null){if(v1.length()>0){dt2=v1;}}
try
{
	if((dt1.length()<10) || (dt2.length()<10))
	{
		DateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd");
		Calendar ca1 = Calendar.getInstance();
		ca1.add(Calendar.DATE, -15);

		Date dat=new Date();
		dt2=dateFormat.format(dat);
		dt1=dateFormat.format(ca1.getTime());
		
//		dt1=dt2; // temp for same day as default period
	}
}
catch(Exception e){}

Connection con=DBConnection.getNewInstance().getConnection();
String nmelement="",mob="", idelement="", str="";
Statement stat=con.createStatement();
ResultSet rs=null; boolean nextrow=false;
long index =1, branchid=0;

v1="";if((v1=request.getParameter("branchid"))!=null){branchid=Long.parseLong(v1);}
//if(branchid==0){branchid=cbrnid;}

if(branchid==0)
{
	str="select unique exec_id, execode, mobile from field_executive where br_id in("+brnlist+") and exe_type=1 and left_job='NO' order by execode";
}
else
{
	str="select unique exec_id, execode, mobile from field_executive where br_id="+branchid+" and exe_type=1 and left_job='NO' order by execode";
}
rs=stat.executeQuery(str);
nextrow=rs.next();
while(nextrow==true)
{
	nextrow=false; nmelement="";mob=""; idelement="";
	v1=""; if((v1=rs.getString(1))!=null){idelement=v1;}
	v1=""; if((v1=rs.getString(2))!=null){nmelement=v1;}
	v1=""; if((v1=rs.getString(3))!=null){mob=v1;}
	%>enggidarray[<%=index%>]='<%=idelement%>';  enggarray[<%=index%>]='<%=nmelement+"-"+mob%>';<%
	if(enggid.equals(idelement)){engineer=nmelement;}
	index++;
	nextrow=rs.next();
}
%>var namearray=new Array();var idarray=new Array(); namearray[0]="ALL"; idarray[0]="0";<%
index=1; 
if(branchid==0)
{
	str="select unique client_id, name from client where br_id in("+brnlist+") and terminate='NO' group by (client_id, name) order by name";
}
else
{
	str="select unique client_id, name from client WHERE terminate='NO' and br_id="+branchid+" group by (client_id, name) order by name";
}
rs=stat.executeQuery(str);
nextrow=rs.next();
while(nextrow==true)
{
	nextrow=false; nmelement="";mob=""; idelement="";
	v1=""; if((v1=rs.getString(1))!=null){idelement=v1;}
	v1=""; if((v1=rs.getString(2))!=null){nmelement=v1;}
	%>idarray[<%=index%>]='<%=idelement%>';  namearray[<%=index%>]='<%=nmelement%>';<%
	if(clientid.equals(idelement)){clientname=nmelement;}
	index++;
	nextrow=rs.next();
}
%>var locarray=new Array(); var locidarray=new Array(); locarray[0]="ALL"; locidarray[0]="0";<%
index=1; 
if(clientid.equals("0"))
{
	str="Select unique id, branch from client where br_id in("+brnlist+") and terminate='NO' and client_id='0000' and TERMINATE='NO' order by branch";
}
else
{
	str="Select unique id, branch from client where br_id in("+brnlist+") and terminate='NO' and client_id='"+clientid+"' and TERMINATE='NO' order by branch";
}
rs=stat.executeQuery(str);
nextrow=rs.next();
while(nextrow==true)
{
	nmelement=""; idelement="";
	v1=""; if((v1=rs.getString(1))!=null){idelement=v1;}
	v1=""; if((v1=rs.getString(2))!=null){nmelement=v1;}
	%>locidarray[<%=index%>]='<%=idelement%>'; locarray[<%=index%>]='<%=nmelement%>';<%
	if(locid.equals(idelement)){location=nmelement;}
	index++;
	nextrow=rs.next();
}
%>
</script><HEAD><BODY>
<form autocomplete="off" action="PartToCallAllot.do"  name="form" onkeypress="return DisableEnter()" method="post">
<div id="hstyle">PART REQUEST / ALLOCATION FOR CALLS</div><center>
<table cellspacing=0% cellpadding=4 width=95%>
<tr>
<td><label>Branch:</label></td>
<td><select name="branchid" style="width:300px">
<option value="0">ALL</option><%
String branchLlist[][]=cmpbrn.getBranchListSelect(con, brnlist, utotalbrn);
int i=0, j=0;
for(i=0; i<branchLlist.length; i++)
{
	j=0;
	%><option value="<%=branchLlist[i][j++]%>" <%if(branchid==Long.parseLong(branchLlist[i][(j-1)])){%> selected <%}%> ><%=branchLlist[i][j++]%>, <%=branchLlist[i][j++]%>, <%=branchLlist[i][j++]%></option><%
}%></select>
</td>
<td><label>Client:</label></td>
<td>
<input type='text' id='cname' name="cname" value="<%=clientname%>" style="width:300px" onBlur="javascript: if(validateElement(namearray, 'cname')){listElementId(namearray, idarray, 'cname', 'cid'); document.form.submit()}">
<input type=hidden id='cid' name="cid" value="<%=clientid%>">
</td>
</tr>
<tr>
<td><label>Location:</label></td>
<td>
<input type='text' id='loc' name="loc" value="<%=location%>" style="width:300px" onBlur="javascript: if(validateElement(locarray, 'loc')){listElementId(locarray, locidarray, 'loc', 'locid'); }">
<input type=hidden id='locid' name="locid" value="<%=locid%>">
</td>
<td><label>Status:</label></td>
<td><select name="status" style="width:300px">
<option value="0" <% if(status==0){%>selected<%} %> >ALL</option>
<option value="1" <% if(status==1){%>selected<%} %> >Requested</option>
<option value="2" <% if(status==2){%>selected<%} %> >Alloted</option>
<option value="3" <% if(status==3){%>selected<%} %> >Dispatched</option>
<option value="4" <% if(status==4){%>selected<%} %> >Delivered</option>
</select>
</td>
</tr>
<tr>
<td><label>From:</label></td>
<td>
<input type=text value="<%=dt1 %>" readonly name="date1" size=8><input type="button" value="...." onclick="displayCalendar(document.forms[0].date1,'yyyy-mm-dd',this)">
&nbsp; &nbsp; &nbsp; 
<label>To:</label>
<input type=text value="<%=dt2 %>" readonly name="date2" size=8><input type="button" value="...." onclick="displayCalendar(document.forms[0].date2,'yyyy-mm-dd',this)">
&nbsp; &nbsp; &nbsp; 
<input type=submit value="Re-Load"  style="width:150px">
</td>
</tr>
</table>
<table  cellspacing=0% cellpadding=0% width=100% border=0 id="userTable" name="userTable" class="display"> 
<thead>
<tr bgcolor=#666666 valign="top">
<th align=left width=5%><font size=2 color=white>SR</th>
<th align=left width=10%><font size=2 color=white>CALL ID<BR>ENGINEER</th>
<th align=left width=10%><font size=2 color=white>CALL DATE</th>
<th align=left width=10%><font size=2 color=white>REQ. DATE</th>
<th align=left width=25%><font size=2 color=white>CLIENT</th>
<th align=left width=30%><font size=2 color=white>PART NAME</th>
<th align=left width=10%><font size=2 color=white>QTY</th>
</tr>
</thead>
<tbody>
<%
DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
Date dat = new Date();
String cdt = dateFormat.format(dat);

String updatelink="PartToCallAllot1.do?callid=", ulink="";
String str1="", str2="", partname="", enggname="", calldate="", userid="", cname="", clocation="", onlineenggname="";
long count=1, cid=0, callid=0, partid=0, execode=0, psr=0, installid=0, execodeonline=0;
String REQ_BY="", REQ_DATE="", REQ_TIME="", PARTNAME="", GDC_NO="", ALLOT_TIME="", ALLOT_DATE="", ALLOT_BY="", pmodelname="";
long PART_ID=0, REQ_QTY=0, sr=0, allotid=0, reqid=0, reqstatus=0, pmodel=0;

Statement stat1=con.createStatement();
ResultSet rs1=null;
/*
str = "SELECT pr.REQ_BY, pr.REQ_DATE, pr.REQ_TIME, pr.PART_ID, pr.REQ_QTY, pr.ID, pr.GDC_NO, pr.CALL_ID, pr.client_id, " +
      "pr.ALLOT_BY, pr.ALLOT_DATE, pr.ALLOT_TIME, pr.status, pr.PMODEL_ID, " +
      "cr.call_date, cr.EXECODE, cr.EXECODE_ONLINE, c.name AS client_name, c.branch AS client_location, " +
      "fe.execode AS enggname, feo.execode AS onlineenggname, pp.name AS partname, pm.model_name, " +
      "pi.id AS allotid " +
      "FROM PART_REQ pr " +
      "LEFT JOIN client_request cr ON pr.CALL_ID = cr.call_id " +
      "LEFT JOIN CLIENT c ON pr.client_id = c.id " +
      "LEFT JOIN field_executive fe ON cr.EXECODE = fe.exec_id " +
      "LEFT JOIN field_executive feo ON cr.EXECODE_ONLINE = feo.exec_id " +
      "LEFT JOIN printer_part pp ON pr.PART_ID = pp.id " +
      "LEFT JOIN p_model pm ON pr.PMODEL_ID = pm.id " +
      "LEFT JOIN part_install pi ON pr.CALL_ID = pi.call_id AND pr.PART_ID = pi.part_id " +
      "WHERE pr.REQ_DATE BETWEEN '" + dt1 + "' AND '" + dt2 + "' ";
if(status != 0) {str += " AND pr.status = " + status;}
if(branchid != 0) {str += " AND pr.br_id = " + branchid;} else {str += " AND pr.br_id IN (" + u4brnlist + ") ";}
if(!locid.equals("0")) {str += " AND pr.client_id = " + Long.parseLong(locid);}
if(!clientid.equals("0")) {str += " AND pr.client_id IN (SELECT DISTINCT id FROM client WHERE client_id = '" + clientid + "') ";}
str += " ORDER BY pr.ID DESC";

rs = stat.executeQuery(str);
while(rs.next()) 
{
	callid=0; psr=1; execode=0; execodeonline=0; calldate=""; enggname=""; onlineenggname=""; 
	cname=""; clocation=""; partname=""; ulink=""; allotid=0; reqid=0; reqstatus=0; pmodel=0;
	REQ_BY=""; REQ_DATE=""; REQ_TIME=""; PARTNAME=""; PART_ID=0; REQ_QTY=0; sr++;
	allotid=0; reqid=0; GDC_NO="-"; cid=0;  ALLOT_TIME=""; ALLOT_DATE=""; ALLOT_BY=""; pmodelname="";
	
    REQ_BY = rs.getString("REQ_BY");
    REQ_DATE = rs.getString("REQ_DATE");
    REQ_TIME = rs.getString("REQ_TIME");
    PART_ID = rs.getLong("PART_ID");
    REQ_QTY = rs.getLong("REQ_QTY");
    reqid = rs.getLong("ID");
    GDC_NO = rs.getString("GDC_NO");
    callid = rs.getLong("CALL_ID");
    cid = rs.getLong("client_id");
    ALLOT_BY = rs.getString("ALLOT_BY");
    ALLOT_DATE = rs.getString("ALLOT_DATE");
    ALLOT_TIME = rs.getString("ALLOT_TIME");
    reqstatus = rs.getLong("status");
    pmodel = rs.getLong("PMODEL_ID");
    calldate = rs.getString("call_date");
    execode = rs.getLong("EXECODE");
    execodeonline = rs.getLong("EXECODE_ONLINE");
    cname = rs.getString("client_name");
    clocation = rs.getString("client_location");
    enggname = rs.getString("enggname");
    onlineenggname = rs.getString("onlineenggname");
    PARTNAME = rs.getString("partname");
    pmodelname = rs.getString("model_name");
    allotid = rs.getLong("allotid");

	updatelink="PartToCallAllot1.do?action=allot&callid="+callid+"&partid="+PART_ID+"&reqid="+reqid+"&cname="+cname+"&clocation="+clocation+"&execode="+execode+"&cid="+cid+"&pmodel="+pmodel+"&pmodelname="+pmodelname;
	%>
	<tr valign="top">
	<td nowrap align=left width=5%><%=count++ %></td>
	<td align=left width=10%><font size=2 color=brown><u><a href="#" onclick="getDetails('<%=callid%>')"><%=callid %></a></u><BR><%=enggname%></td>
	<td align=left width=10%><font size=2><%=dateformat.formatDate(calldate)%><BR></font></td>
	<td align=left width=10%><font size=2><%=dateformat.formatDate(REQ_DATE)%><BR><%=REQ_TIME%><BR></font></td>
	<td align=left width=25%><font size=2><%=cname%><br>[<%=clocation%>]<Br><br>
		Requirement By: <%=REQ_BY%> - </font>
		<b>
		<%
		if(reqstatus>1){%><font size=2><a href="PartToCallAllot1.do?action=cancel&canceltype=allot&callid=<%=callid%>&installid=<%=allotid%>&partid=<%=PART_ID%>&cid=<%=cid%>&partname=<%=PARTNAME%>&reqid=<%=reqid%>&GDC_NO=<%=GDC_NO%>&pmodel=<%=pmodel%>&pmodelname=<%=pmodelname%>&cname=<%=cname%>&clocation=<%=clocation%>" rel="gb_page_center[800, 600]">CANCEL</a></font><%}
		else
		if(reqstatus==1)
		{%><a href="<%=updatelink%>" rel="gb_page_center[700, 450]"><font color="red" size=2>Allot<font></a><%}
		%>
		</b>
	</td>
	<td align=left width=30%>
		<font size=2><%=PARTNAME%><br><%=pmodelname%><BR><br>
		<font size=2>Allotted By: <%=ALLOT_BY%> on <%=dateformat.formatDate(ALLOT_DATE)%> at <%=ALLOT_TIME%><BR></font>
	</td>
	<td align=left width=10%><font size=2><%=REQ_QTY%><BR></font></td>
	</tr>
	<%
}

*/
str="select REQ_BY, REQ_DATE, REQ_TIME, PART_ID, REQ_QTY, ID, GDC_NO, CALL_ID, client_id, ALLOT_BY, ALLOT_DATE, "+
	"ALLOT_TIME, status, PMODEL_ID from PART_REQ where REQ_DATE between '"+dt1+"' and '"+dt2+"' ";
if(status!=0){str+=" and status="+status;}

if(branchid!=0){str+=" and br_id="+branchid;}else{str+=" and br_id in("+brnlist+")";}
if(!clientid.equals("0")){str+=" and client_id in(select unique id from client where client_id='"+clientid+"')";}
if(!locid.equals("0")){str+=" and client_id="+Long.parseLong(locid);}

str+=" order by id desc";

rs=stat.executeQuery(str);
while(rs.next())
{
	callid=0; psr=1; execode=0; execodeonline=0; calldate=""; enggname=""; onlineenggname=""; 
	cname=""; clocation=""; partname=""; ulink=""; allotid=0; reqid=0; reqstatus=0; pmodel=0;
	REQ_BY=""; REQ_DATE=""; REQ_TIME=""; PARTNAME=""; PART_ID=0; REQ_QTY=0; sr++;
	allotid=0; reqid=0; GDC_NO="-"; cid=0;  ALLOT_TIME=""; ALLOT_DATE=""; ALLOT_BY=""; pmodelname="";
	
	v1=""; if((v1=rs.getString(1))!=null){REQ_BY=v1;}
	v1=""; if((v1=rs.getString(2))!=null){REQ_DATE=v1;}
	v1=""; if((v1=rs.getString(3))!=null){REQ_TIME=v1;}
	PART_ID=rs.getLong(4);
	REQ_QTY=rs.getLong(5);
	reqid=rs.getLong(6);
	v1=""; if((v1=rs.getString(7))!=null){GDC_NO=v1;}
	callid=rs.getLong(8);
	cid=rs.getLong(9);
	v1=""; if((v1=rs.getString(10))!=null){ALLOT_BY=v1;}
	v1=""; if((v1=rs.getString(11))!=null){ALLOT_DATE=v1;}
	v1=""; if((v1=rs.getString(12))!=null){ALLOT_TIME=v1;}
	reqstatus=rs.getLong(13);
	pmodel=rs.getLong(14);
	
	try
	{
		str1="select call_date, EXECODE, EXECODE_ONLINE from client_request where call_id="+callid;
		rs1=stat1.executeQuery(str1);
		if(rs1.next())
		{
			v1=""; if((v1=rs1.getString(1))!=null){calldate=v1;}
			execode=rs1.getLong(2);
			execodeonline=rs1.getLong(3);
		}
	}
	catch(Exception e){}
	try
	{
		str1="select name, branch from CLIENT where id="+cid;
		rs1=stat1.executeQuery(str1);
		if(rs1.next())
		{
			v1=""; if((v1=rs1.getString(1))!=null){cname=v1;}
			v1=""; if((v1=rs1.getString(2))!=null){clocation=v1;}
		}
	}
	catch(Exception e){}
	
	try
	{
		str1="select execode from field_executive where exec_id="+execode;
		rs1=stat1.executeQuery(str1);
		if(rs1.next()){v1=""; if((v1=rs1.getString(1))!=null){enggname=v1;}}
	}
	catch(Exception e){}
	
	try
	{
		str1="select execode from field_executive where exec_id="+execodeonline;
		rs1=stat1.executeQuery(str1);
		if(rs1.next()){v1=""; if((v1=rs1.getString(1))!=null){onlineenggname=v1;}}
	}
	catch(Exception e){}
	try
	{
		str1="Select name from printer_part where id="+PART_ID;
		rs1=stat1.executeQuery(str1);
		if(rs1.next()){ v1=""; if((v1=rs1.getString(1))!=null){PARTNAME=v1;} }
	}
	catch(Exception e){}
	try
	{
		str1="Select model_name from p_model where id="+pmodel;
		rs1=stat1.executeQuery(str1);
		if(rs1.next()){ v1=""; if((v1=rs1.getString(1))!=null){pmodelname=v1;} }
	}
	catch(Exception e){}
	
	try
	{
		str1="Select id from part_install where call_id="+callid+" and part_id="+PART_ID;
		rs1=stat1.executeQuery(str1);
		if(rs1.next()){ allotid=rs1.getLong(1);  }
	}
	catch(Exception e){}
	
	updatelink="PartToCallAllot1.do?action=allot&callid="+callid+"&partid="+PART_ID+"&reqid="+reqid+"&cname="+cname+"&clocation="+clocation+"&execode="+execode+"&cid="+cid+"&pmodel="+pmodel+"&pmodelname="+pmodelname;
	%>
	<tr valign="top">
	<td nowrap align=left width=5%><%=count %></td>
	<td align=left width=10%><font size=2 color=brown><u><a href="#" onclick="getDetails('<%=callid%>')"><%=callid %></a></u><BR><%=enggname%></td>
	<td align=left width=10%><font size=2><%=dateformat.formatDate(calldate)%><BR></font></td>
	<td align=left width=10%><font size=2><%=dateformat.formatDate(REQ_DATE)%><BR><%=REQ_TIME%><BR></font></td>
	<td align=left width=25%><font size=2><%=cname%><br>[<%=clocation%>]<Br><br>
		Requirement By: <%=REQ_BY%> - </font>
		<b>
		<%
		if(reqstatus>1){%><font size=2><a href="PartToCallAllot1.do?action=cancel&canceltype=allot&callid=<%=callid%>&installid=<%=allotid%>&partid=<%=PART_ID%>&cid=<%=cid%>&partname=<%=PARTNAME%>&reqid=<%=reqid%>&GDC_NO=<%=GDC_NO%>&pmodel=<%=pmodel%>&pmodelname=<%=pmodelname%>&cname=<%=cname%>&clocation=<%=clocation%>" rel="gb_page_center[800, 600]">CANCEL</a></font><%}
		else
		if(reqstatus==1)
		{%><a href="<%=updatelink%>" rel="gb_page_center[700, 450]"><font color="red" size=2>Allot<font></a><%}
		%>
		</b>
	</td>
	<td align=left width=30%>
		<font size=2><%=PARTNAME%><br><%=pmodelname%><BR><br>
		<font size=2>Allotted By: <%=ALLOT_BY%> on <%=dateformat.formatDate(ALLOT_DATE)%> at <%=ALLOT_TIME%><BR></font>
	</td>
	<td align=left width=10%><font size=2><%=REQ_QTY%><BR></font></td>
	</tr>
	<%
	count++;
}
if(rs!=null){rs.close();}
if(rs1!=null){rs1.close();}
if(stat!=null){stat.close();}
if(stat1!=null){stat1.close();}
con.close();%>
</tbody>
</table>
<br>
<script>var obj1 = new actb(document.getElementById('engg'),enggarray);</script>
<script>var obj2 = new actb(document.getElementById('cname'),namearray);</script>
<script>var obj3 = new actb(document.getElementById('loc'),locarray);</script>
</form></BODY></HTML>