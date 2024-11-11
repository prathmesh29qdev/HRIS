
<%@ page language="java" import="java.sql.*, MyBeans.*, java.util.Calendar" import="java.util.Date" import="java.io.*" import="java.text.DateFormat" import="java.text.SimpleDateFormat" import="java.lang.*, org.apache.commons.lang3.ArrayUtils"%>
<jsp:useBean id="dateformat" scope="request" class="MyBeans.convertDate" />
<jsp:useBean id="cmpbrn" scope="request" class="MyBeans.BranchDetails" />
<HTML><HEAD><TITLE>PART USAGE SUMMARY BY ENGINEER</TITLE>
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
<script language="javascript" type="text/javascript" src="js/common.js"></script><%
String validate="NO", v1="";
HttpSession ses=request.getSession(true);
String usrid=(String)ses.getAttribute("usr_id");
String brnlist=(String)ses.getAttribute("brnlist");  
long utotalbrn=Long.parseLong((String)ses.getAttribute("utotalbrn"));
long UsrBrnList[]=(long[])ses.getAttribute("UsrBrnList");

%>
<script LANGUAGE="JavaScript">
function setTarget(target)
{
    if(target==1)
    {
        document.form.target=""; document.form.action="eng_stock.do"; document.form.submit();
    }
}
function exportData(partid, branchid, enggid, dt1, dt2, baltype, pmodelid)
{
	document.form.target=""; 
	document.form.action='PartUsage?cid='+partid+'&branchid='+branchid+'&wid='+enggid+'&date1='+dt1+'&date2='+dt2+'&baltype='+baltype+'&installtype=0'+'&pmodelid='+pmodelid;
	document.form.submit();
}
var workerarray=new Array();var workeridarray=new Array();
workerarray[0]="ALL"; workeridarray[0]="0";
<%
Connection con=DBConnection.getNewInstance().getConnection();
Statement stat1 = con.createStatement();
Statement stat2 = con.createStatement();
ResultSet rs1=null, rs2=null;
long sr=1, colorcode=0, balance=0, tbalance=0, openbal=0, topenbal=0, pid=0,tid=0;
long enggid=541, oldenggid=0, index=1, branchid=0, reporttype=1;
long eopenbal=0, einward=0, eoutward=0, ebalance=0;
v1="";if((v1=request.getParameter("branchid"))!=null){branchid=Long.parseLong(v1);}
String ename="ALL",str1="", str2="", part_name="", date="-", unit="", nmelement="", idelement="";
String[][] enggrarray = new String[500][2];
long[] enggindexrarray = new long[500];
long enggcount=0;
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

v1=""; if((v1=request.getParameter("wid"))!=null) {enggid=Long.parseLong(v1);}
v1=""; if((v1=request.getParameter("reporttype"))!=null) {reporttype=Long.parseLong(v1);}

if(branchid==0)
{
	str1="Select unique exec_id, execode, sname from field_executive where br_id in("+brnlist+") and left_job='NO' and exe_type=1 order by execode";
}
else
{
	str1="Select unique exec_id, execode, sname from field_executive where br_id="+branchid+" and left_job='NO' and exe_type=1 order by execode";
}
System.out.println(str1);

rs1=stat1.executeQuery(str1);
while(rs1.next())
{
	nmelement="";idelement="";
	v1=""; if((v1=rs1.getString(1))!=null){idelement=v1;}
	v1=""; if((v1=rs1.getString(2))!=null){nmelement=v1;}
//	v1=""; if((v1=rs1.getString(3))!=null){nmelement=nmelement+" "+v1;}

	enggrarray[(int)enggcount][0]=idelement;
	enggindexrarray[(int)enggcount]=Long.parseLong(idelement);
	enggrarray[(int)enggcount][1]=nmelement;
	
	%>workeridarray[<%=index%>]='<%=idelement%>'; workerarray[<%=index%>]='<%=nmelement%>';<%
	if(enggid==Long.parseLong(idelement)){ename=nmelement;}
	index++; enggcount++;
}%>
</script></HEAD><BODY><div id="hstyle">PART USAGE SUMMARY BY ENGINEER</div>
<form autocomplete="off" action="" method="post" name="form"><center>
<table border="0" align="center" cellpadding="5" cellspacing="5" width="100%">
<tr>
<td align=right><label>Report Type:</label></td>
<td align=left>
	<select name="reporttype" id="reporttype" style="width:150px">
	<option value="1" <% if(reporttype==1){%>selected<%} %> >Consolidated Count</option>
	<option value="2" <% if(reporttype==2){%>selected<%} %> >Part Wise Count</option>
	</select>
</td>
<td align=right><label>Engineer:</label></td>
<td align=left>
	<input type='text' id='worker' name="worker" value="<%=ename%>" style="width:250px" onBlur="javascript: if(validateElement(workerarray, 'worker')){listElementId(workerarray, workeridarray, 'worker', 'wid');}">
	<input type=hidden id='wid' name="wid" value="<%=enggid%>">
</td>
<td align=center><label>From:</label>
<input type=text value="<%=dt1 %>" readonly name="date1" size=8><input type="button" value="...." onclick="displayCalendar(document.forms[0].date1,'yyyy-mm-dd',this)">
</td>
<td align=center><label>To:</label>
<input type=text value="<%=dt2 %>" readonly name="date2" size=8><input type="button" value="...." onclick="displayCalendar(document.forms[0].date2,'yyyy-mm-dd',this)">
</td>
<td><input type="button" name="rbtn" value="Refresh"  onClick="setTarget(1)" style="width:100px"></td>
</tr>
</table>
<%
if(reporttype==1)
{
	%>
	<div style="width:97%; height:25px ; border-left: 0px gray solid; border-right: 0px gray solid; border-top: 0px gray solid; border-bottom: 0px gray solid; padding:0px; margin: 0px">
	<table  cellspacing=0 cellpadding=4 width=100% border=1  height="100%">
	<tr bgcolor=#666666 valign=top>
	<th align="center" width="5%"><font size=2/><label>Sr.</label></th>
	<th align="left" width="35%"><font size=2/><label>Engineer</label></th>
	<th align="center" width="15%"><font size=2/><label>Open Balance</label></th>
	<th align="center" width="15%"><font size=2/><label>Allotted</label></th>
	<th align="center" width="15%"><font size=2/><label>Used</label></th>
	<th align="center" width="15%"><font size=2/><label>Close Balance</label></th>
	</tr>
	</table></div>
	<div style="overflow: auto; width:97%; height:450; border-left: 0px gray solid; border-bottom: 0px gray solid; border-right: 0px gray solid; padding:0px; margin: 0px;">
	<table  cellspacing="0" cellpadding="4" border="1" width=100%><%
	long[] openbalarray = new long[4000];
	String[] openbalindexarray = new String[4000];

	String[][] partrarray = new String[4000][3];
	long[] partindexrarray = new long[4000];
	long partcount=0;
	try
	{
		str1="select distinct id, name, unit from printer_part where status=1 order by name";
		rs1=stat1.executeQuery(str1);
		while(rs1.next())
		{
			partrarray[(int)partcount][0]=rs1.getString(1);
			partindexrarray[(int)partcount]=rs1.getLong(1);
			partrarray[(int)partcount][1]=rs1.getString(2);
			partrarray[(int)partcount][2]=rs1.getString(3);
			partcount++;
		}
	}
	catch(Exception e){}

	partcount=0;
	long eid=0, pmodel=0;
	
//new
	if(enggid==0)
	{
		str1="select es.p_id, es.balance, es.eng_name, es.pmodel_id from ENG_STOCK_DETAILS es "+
			"inner join (select p_id, pmodel_id, max(record_id) as maxid from "+
			"ENG_STOCK_DETAILS where eng_name>0 and used_date<'"+dt1+"' group by p_id, pmodel_id) filter "+
			"on es.p_id=filter.p_id and es.pmodel_id=filter.pmodel_id and es.record_id=filter.maxid order by es.eng_name, es.p_id";
	}
	else
	{
		str1="select es.p_id, es.balance, es.eng_name, es.pmodel_id from ENG_STOCK_DETAILS es "+
			"inner join (select p_id, pmodel_id, max(record_id) as maxid from "+
			"ENG_STOCK_DETAILS where eng_name="+enggid+" and used_date<'"+dt1+"' group by p_id, pmodel_id) filter "+
			"on es.p_id=filter.p_id and es.pmodel_id=filter.pmodel_id and es.record_id=filter.maxid order by es.eng_name, es.p_id";
	}
	rs1=stat1.executeQuery(str1);
	while(rs1.next())
	{
		balance=0; pid=0; eid=0; ename=""; pmodel=0;
		
		pid=rs1.getLong(1);
		balance=rs1.getLong(2);
		eid=rs1.getLong(3);
		pmodel=rs1.getLong(4);
		
		ename=eid+"_"+pid+"_"+pmodel;
		
		openbalarray[(int)partcount]=balance;
		openbalindexarray[(int)partcount]=ename;
		partcount++;
	}

	long inward=0, outward=0, tinward=0, toutward=0;
	long[][] inoutarray = new long[4000][2];
	String[] inoutindexarray = new String[4000];
	partcount=0; eid=0;
	if(enggid==0)
	{
		str1="select p_id, eng_name, sum(INWARD), sum(OUTWARD), pmodel_id from ENG_STOCK_DETAILS where "+
			 "used_date between '"+dt1+"' and '"+dt2+"' group by p_id, eng_name, pmodel_id order by eng_name";
	}
	else
	{
		str1="select p_id, eng_name, sum(INWARD), sum(OUTWARD), pmodel_id from ENG_STOCK_DETAILS where "+
			 "eng_name="+enggid+" and used_date between '"+dt1+"' and '"+dt2+"' group by p_id, eng_name, pmodel_id order by eng_name";
	}
	rs1=stat1.executeQuery(str1);
	while(rs1.next())
	{
		pid=0; eid=0; inward=0; outward=0; ename=""; pmodel=0;
		
		pid=rs1.getLong(1);
		eid=rs1.getLong(2);
		inward=rs1.getLong(3);
		outward=rs1.getLong(4);
		pmodel=rs1.getLong(5);
		
		ename=eid+"_"+pid+"_"+pmodel;
		
		inoutarray[(int)partcount][0]=inward;
		inoutarray[(int)partcount][1]=outward;
		inoutindexarray[(int)partcount]=ename;
		partcount++;
	}
	long loopcount=0;

	if(enggid==0)
	{
		str1="select unique p_id, eng_name, pmodel_id from ENG_STOCK_DETAILS where eng_name>0 and "+
			 "used_date<='"+dt2+"' order by eng_name, p_id";
	}
	else
	{
		str1="select unique p_id, eng_name, pmodel_id from ENG_STOCK_DETAILS where eng_name="+enggid+" and "+
			 "used_date<='"+dt2+"' order by eng_name, p_id";
	}
	rs1=stat1.executeQuery(str1);
	while(rs1.next())
	{
		balance=0; pid=0; eid=0; openbal=0; inward=0; outward=0; pmodel=0;
		
		pid=rs1.getLong(1);
		eid=rs1.getLong(2);
		pmodel=rs1.getLong(3);
		
		if(loopcount==0	){oldenggid=eid; loopcount++;}
		
		if(eid!=oldenggid)
		{
			if( !ename.equals("-") && (eopenbal>0 || einward>0 || eoutward>0 || ebalance>0) )
			{
				%>
				<tr <% if(sr%2==0){%>bgcolor=Ghostwhite<%}else{%>bgcolor=#D5F5E3<%} %> >
				<td align=center width="5%"><font size=2><%=sr++%></td>
				<td align=left width="35%"><font size=2><%=ename%></td>
				<td align=center width="15%"><font size=2><b><%=eopenbal%></b></td>
				<td align=center width="15%"><font size=2><b>
					<a href="#" onClick="exportData('0','0','<%=oldenggid%>','<%=dt1%>','<%=dt2%>', 'allot', '0')" >
					<%=einward%>
					</a>
				</b></td>
				<td align=center width="15%"><font size=2><b>
					<a href="#" onClick="exportData('0','0','<%=oldenggid%>','<%=dt1%>','<%=dt2%>', 'used', '0')" >
					<%=eoutward%>
					</a>
				</b></td>
				<td align=center width="15%"><font size=2><b><%=ebalance%></b></td>
				</tr><%
			}
			oldenggid=eid;
			eopenbal=0; einward=0; eoutward=0; ebalance=0;
		}
		
		try
		{
			str2="select es.balance, es.p_id, es.pmodel_id from ENG_STOCK_DETAILS es "+
				"inner join (select p_id, pmodel_id, max(record_id) as maxid from ENG_STOCK_DETAILS where "+
				"eng_name="+eid+" and p_id="+pid+" and pmodel_id="+pmodel+" and used_date<='"+dt2+"' group by p_id, pmodel_id) filter "+
				"on es.p_id=filter.p_id and es.pmodel_id=filter.pmodel_id and es.record_id=filter.maxid";
			rs2=stat2.executeQuery(str2);
			if(rs2.next()){}
			{
				balance=rs2.getLong(1);
				ebalance+=balance;
			}
		}
		catch(Exception e){}
		
		ename=eid+"_"+pid+"_"+pmodel;
		try
		{
			index=0;
			index=ArrayUtils.indexOf(openbalindexarray, ename);
			if(index>=0)
			{
				openbal=openbalarray[(int)index];
				eopenbal+=openbal;
			}
		}
		catch(Exception e){}
		try
		{
			index=0;
			index=ArrayUtils.indexOf(inoutindexarray, ename);
			if(index>=0)
			{
				inward=inoutarray[(int)index][0];
				outward=inoutarray[(int)index][1];
				einward+=inward;
				eoutward+=outward;
			}
		}
		catch(Exception e){}
		
		ename="-";
		try
		{
			index=0;
			index=ArrayUtils.indexOf(enggindexrarray, eid);
			if(index>=0){ename=enggrarray[(int)index][1];}
		}
		catch(Exception e){}
	}
	if( !ename.equals("-") && (eopenbal>0 || einward>0 || eoutward>0 || ebalance>0) )
	{
		tinward+=inward;
		toutward+=outward;
		topenbal+=openbal;
		tbalance+=balance;
		%>
		<tr <% if(sr%2==0){%>bgcolor=Ghostwhite<%}else{%>bgcolor=#D5F5E3<%} %> >
		<td align=center width="5%"><font size=2><%=sr++%></td>
		<td align=left width="35%"><font size=2><%=ename%></td>
		<td align=center width="15%"><font size=2><b><%=eopenbal%></b></td>
		<td align=center width="15%"><font size=2><b>
			<a href="#" onClick="exportData('0','0','<%=oldenggid%>','<%=dt1%>','<%=dt2%>', 'allot', '0')" >
			<%=einward%>
			</a>
		</b></td>
		<td align=center width="15%"><font size=2><b>
			<a href="#" onClick="exportData('0','0','<%=oldenggid%>','<%=dt1%>','<%=dt2%>', 'used', '0')" >
			<%=eoutward%>
			</a>
		</b></td>
		<td align=center width="15%"><font size=2><b><%=ebalance%></b></td>
		</tr><%
	}
	%>
	</table>
	</div>
	<div style="width:97%; height:25px ; border-left: 0px gray solid; border-right: 0px gray solid; border-top: 0px gray solid; border-bottom: 0px gray solid; padding:0px; margin: 0px">
	<table  cellspacing=0 cellpadding=4 width=100% border="1"  height="100%">
	<tr bgcolor=#666666>
	<th align="center" width="40%" colspan=3><font size=2><label>Total</label></th>
	<th align="center" width="15%"><font size=2><label><%=topenbal%></label></th>
	<th align="center" width="15%"><font size=2><label><%=tinward%></label></th>
	<th align="center" width="15%"><font size=2><label><%=toutward%></label></th>
<!--	<th align="left" width="15%"><font size=2><label>
		<a href="#" onClick="exportData('0','0','<%=enggid%>','<%=dt1%>','<%=dt2%>', 'used')" ><%=toutward%></a>
	</label></th>
-->
	<th align="center" width="15%"><font size=2><label><%=tbalance%></label></th>
	</tr>
	</table></div>
	<%
}
else
{
	%>
	<div style="width:97%; height:45px ; border-left: 0px gray solid; border-right: 0px gray solid; border-top: 0px gray solid; border-bottom: 0px gray solid; padding:0px; margin: 0px">
	<table  cellspacing=0 cellpadding=4 width=100% border=1  height="100%">
	<tr bgcolor=#666666 valign=top>
	<th align="center" width="5%"><font size=2/><label>Sr.</label></th>
	<th align="left" width="15%"><font size=2/><label>Engineer</label></th>
	<th align="left" width="25%"><font size=2/><label>Part Name</label></th>
	<th align="left" width="25%"><font size=2/><label>Printer Name</label></th>
	<th align="center" width="5%"><font size=2/><label>Open<br>Bal.</label></th>
	<th align="center" width="5%"><font size=2/><label>Allot</label></th>
	<th align="center" width="5%"><font size=2/><label>Used</label></th>
	<th align="center" width="5%"><font size=2/><label>Close<br>Bal.</label></th>
	<th align="center" width="10%"><font size=2/><label>Last<br>Use</label></th>  
	</tr>
	</table></div>
	<div style="overflow: auto; width:97%; height:450; border-left: 0px gray solid; border-bottom: 0px gray solid; border-right: 0px gray solid; padding:0px; margin: 0px;">
	<table  cellspacing="0" cellpadding="4" border="1" width=100%><%
	long[] openbalarray = new long[5000];
	String[] openbalindexarray = new String[5000];

	String[][] partrarray = new String[5000][3];
	long[] partindexrarray = new long[5000];
	long partcount=0;
	try
	{
		str1="select distinct id, name, unit from printer_part where status=1 order by name";
		rs1=stat1.executeQuery(str1);
		while(rs1.next())
		{
			partrarray[(int)partcount][0]=rs1.getString(1);
			partindexrarray[(int)partcount]=rs1.getLong(1);
			partrarray[(int)partcount][1]=rs1.getString(2);
			partrarray[(int)partcount][2]=rs1.getString(3);
			partcount++;
		}
	}
	catch(Exception e){}

	String[][] pmodelrarray = new String[1000][2];
	long[] pmodelindexrarray = new long[1000];
	long pmodelcount=0;
	try
	{
		str1="select distinct id, model_name from p_model where status=0 order by model_name";
		rs1=stat1.executeQuery(str1);
		while(rs1.next())
		{
			pmodelrarray[(int)pmodelcount][0]=rs1.getString(1);
			pmodelindexrarray[(int)pmodelcount]=rs1.getLong(1);
			pmodelrarray[(int)pmodelcount][1]=rs1.getString(2);
			pmodelcount++;
		}
	}
	catch(Exception e){}

	partcount=0;
	long eid=0, pmodel=0;
	String pmodelname="";
	
	if(enggid==0)
	{
		str1="select es.p_id, es.balance, es.eng_name, es.pmodel_id from ENG_STOCK_DETAILS es "+
			"inner join (select p_id, pmodel_id, max(record_id) as maxid from "+
			"ENG_STOCK_DETAILS where eng_name>0 and used_date<'"+dt1+"' group by p_id, pmodel_id) filter "+
			"on es.p_id=filter.p_id and es.pmodel_id=filter.pmodel_id and es.record_id=filter.maxid order by es.eng_name, es.p_id";
	}
	else
	{
		str1="select es.p_id, es.balance, es.eng_name, es.pmodel_id from ENG_STOCK_DETAILS es "+
			"inner join (select p_id, pmodel_id, max(record_id) as maxid from "+
			"ENG_STOCK_DETAILS where eng_name="+enggid+" and used_date<'"+dt1+"' group by p_id, pmodel_id) filter "+
			"on es.p_id=filter.p_id and es.pmodel_id=filter.pmodel_id and es.record_id=filter.maxid order by es.eng_name, es.p_id";
	}
	rs1=stat1.executeQuery(str1);
	while(rs1.next())
	{
		balance=0; pid=0; eid=0; ename=""; pmodel=0; pmodelname="";
		
		pid=rs1.getLong(1);
		balance=rs1.getLong(2);
		eid=rs1.getLong(3);
		pmodel=rs1.getLong(4);
		
		ename=eid+"_"+pid+"_"+pmodel;
		
		openbalarray[(int)partcount]=balance;
		openbalindexarray[(int)partcount]=ename;
		partcount++;
	}

	long inward=0, outward=0, tinward=0, toutward=0;
	long[][] inoutarray = new long[4000][2];
	String[] inoutindexarray = new String[4000];
	partcount=0; eid=0;
	if(enggid==0)
	{
		str1="select p_id, eng_name, sum(INWARD), sum(OUTWARD), pmodel_id from ENG_STOCK_DETAILS where "+
			 "used_date between '"+dt1+"' and '"+dt2+"' group by p_id, eng_name, pmodel_id order by eng_name";
	}
	else
	{
		str1="select p_id, eng_name, sum(INWARD), sum(OUTWARD), pmodel_id from ENG_STOCK_DETAILS where "+
			 "eng_name="+enggid+" and used_date between '"+dt1+"' and '"+dt2+"' group by p_id, eng_name, pmodel_id order by eng_name";
	}
	rs1=stat1.executeQuery(str1);
	while(rs1.next())
	{
		pid=0; eid=0; inward=0; outward=0; ename=""; pmodel=0; 
		
		pid=rs1.getLong(1);
		eid=rs1.getLong(2);
		inward=rs1.getLong(3);
		outward=rs1.getLong(4);
		pmodel=rs1.getLong(5);
		
		ename=eid+"_"+pid+"_"+pmodel;
		
		inoutarray[(int)partcount][0]=inward;
		inoutarray[(int)partcount][1]=outward;
		inoutindexarray[(int)partcount]=ename;
		partcount++;
	}
	if(enggid==0)
	{
		str1="select unique p_id, eng_name, pmodel_id from ENG_STOCK_DETAILS where eng_name>0 and "+
			 "used_date<='"+dt2+"' order by eng_name, p_id";
	}
	else
	{
		str1="select unique p_id, eng_name, pmodel_id from ENG_STOCK_DETAILS where eng_name="+enggid+" and "+
			 "used_date<='"+dt2+"' order by eng_name, p_id";
	}
	rs1=stat1.executeQuery(str1);
	while(rs1.next())
	{
		balance=0;part_name="";date="-"; pid=0; unit=""; eid=0; ename="";
		openbal=0; inward=0; outward=0; pmodel=0; pmodelname="";
		
		pid=rs1.getLong(1);
		eid=rs1.getLong(2);
		pmodel=rs1.getLong(3);
		
		try
		{
			str2="select es.balance, es.used_date, es.p_id, es.pmodel_id from ENG_STOCK_DETAILS es "+
				"inner join (select p_id, pmodel_id, max(record_id) as maxid from ENG_STOCK_DETAILS where "+
				"eng_name="+eid+" and p_id="+pid+" and pmodel_id="+pmodel+" and used_date<='"+dt2+"' group by p_id, pmodel_id) filter "+
				"on es.p_id=filter.p_id and es.pmodel_id=filter.pmodel_id and es.record_id=filter.maxid";
			rs2=stat2.executeQuery(str2);
			if(rs2.next()){}
			{
				balance=rs2.getLong(1);
				v1="";if((v1=rs2.getString(2))!=null){date=v1;}
			}
		}
		catch(Exception e){}
		
		try
		{
			index=0;
			index=ArrayUtils.indexOf(partindexrarray, pid);
			if(index>=0)
			{
				part_name=partrarray[(int)index][1];
				unit=partrarray[(int)index][2];
			}
		}
		catch(Exception e){}

		try
		{
			index=0;
			index=ArrayUtils.indexOf(pmodelindexrarray, pmodel);
			if(index>=0){ pmodelname=pmodelrarray[(int)index][1]; }
		}
		catch(Exception e){}

		ename=eid+"_"+pid+"_"+pmodel;
		try
		{
			index=0;
			index=ArrayUtils.indexOf(openbalindexarray, ename);
			if(index>=0)
			{
				openbal=openbalarray[(int)index];
			}
		}
		catch(Exception e){}
		
		try
		{
			index=0;
			index=ArrayUtils.indexOf(inoutindexarray, ename);
			if(index>=0)
			{
				inward=inoutarray[(int)index][0];
				outward=inoutarray[(int)index][1];
			}
		}
		catch(Exception e){}
		
		ename="-";
		try
		{
			index=0;
			index=ArrayUtils.indexOf(enggindexrarray, eid);
			if(index>=0)
			{
				ename=enggrarray[(int)index][1];
			}
		}
		catch(Exception e){}
		
		if( !ename.equals("-") && (openbal>0 || inward>0 || outward>0 || balance>0))
		{
			tinward+=inward;
			toutward+=outward;
			topenbal+=openbal;
			tbalance+=balance;

			%>
			<tr  <% if(sr%2==0){%>bgcolor=Ghostwhite<%}else{%>bgcolor=#D5F5E3<%} %> >
			<td align=center width="5%"><font size=2><%=sr++%></td>
			<td align=left width="15%"><font size=2><%=ename%></td>
			<td align=left width="25%"><font size=2><%=part_name%></td>
			<td align=left width="25%">
				<font size=2><%=pmodelname%><br>
				<input type="button" onClick="GB_showCenter('Transfer stock to other model','<%=request.getScheme()+"://"+request.getServerName()+request.getContextPath()%>/movecartstock?stockprod=enggpart&pid=<%=pid%>&part_name=<%=part_name%>&stock=<%=balance%>&pmodel=<%=pmodel%>&pmodelname=<%=pmodelname%>&eid=<%=eid%>',400,700);" name="mbtn" value="Transfer" id="mbtn" style="width:80px" />
			</td>
			<td align=center width="5%"><font size=2><b><%=openbal%></b></td>
			<td align=center width="5%"><font size=2><b>
				<a href="#" onClick="exportData('<%=pid%>','0','<%=eid%>','<%=dt1%>','<%=dt2%>', 'allot', '<%=pmodel%>')" >
				<%=inward%>
				</a>
			</b></td>
			<td align=center width="5%"><font size=2><b>
				<a href="#" onClick="exportData('<%=pid%>','0','<%=eid%>','<%=dt1%>','<%=dt2%>', 'used', '<%=pmodel%>')" >
				<%=outward%>
				</a>
			</b></td>
			<td align=center width="5%"><font size=2><b><%=balance%></b></td>
			<td align=center width="10%">
			<font size=2><%=dateformat.formatDate(date)%>
			</td>
			</tr><%
		}
	}
	%>
	</table>
	</div>
	<div style="width:97%; height:25px ; border-left: 0px gray solid; border-right: 0px gray solid; border-top: 0px gray solid; border-bottom: 0px gray solid; padding:0px; margin: 0px">
	<table  cellspacing=0 cellpadding=4 width=100% border="1"  height="100%">
	<tr bgcolor=#666666>
	<th align="center" width="70%" colspan=4><font size=2><label>Total</label></th>
	<th align="center" width="5%"><font size=2><label><%=topenbal%></label></th>
	<th align="center" width="5%"><font size=2><label><%=tinward%></label></th>
	<th align="center" width="5%"><font size=2><label><%=toutward%></label></th>
	<th align="center" width="5%"><font size=2><label><%=tbalance%></label></th>
	<th align="left" width="10%"><font size=2><label> </label></th>
	</tr>
	</table></div>
	<%
}
if(rs1!=null){rs1.close();}
if(rs2!=null){rs2.close();}
if(stat1!=null){stat1.close();}
if(stat2!=null){stat2.close();}
con.close();
%>
<script>var obj1 = new actb(document.getElementById('worker'),workerarray);</script>
</center></form></BODY></HTML>