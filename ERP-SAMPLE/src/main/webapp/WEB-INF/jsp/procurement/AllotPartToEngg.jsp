
<%@ page language="java" import="java.sql.*, MyBeans.*" import="java.util.Date" import="java.io.*" import="java.text.DateFormat" import="java.text.SimpleDateFormat" import="java.lang.*, org.apache.commons.lang3.ArrayUtils"%>
<jsp:useBean id="cmpbrn" scope="request" class="MyBeans.BranchDetails" />
<HTML><HEAD><TITLE>PART ALLOTMENT TO ENGINEER</TITLE>
<link href="css/style1.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="css/dhtmlgoodies_calendar.css?random=20051112" media="screen"/>
<script type="text/javascript" src="js/dhtmlgoodies_calendar.js?random=20060118"></script>
<script language="javascript" type="text/javascript" src="js/rightclick.js"></script>
<script language="javascript" type="text/javascript" src="js/numeric.js"></script>
<script language="javascript" type="text/javascript" src="js/agree.js"></script>
<script language="javascript" type="text/javascript" src="js/ValidateElement.js"></script> 
<script language="javascript" type="text/javascript" src="js/ValidateDynamic.js"></script> 
<script language="javascript" type="text/javascript" src="js/ListElement.js"></script> 
<script language="javascript" type="text/javascript" src="js/compareThreeArrays.js"></script> 
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
	
    if(target==3)
    {
		if(document.form.ttype.value=="2" && document.form.worker.value==""){alert("Please Select An Engineer Name!");	form.worker.focus();	return false;}
		else
		{document.form.target=""; document.form.action="AllotPartToEngg.do"; document.form.submit();}
    }
	else
	if(document.form.branchid.value==""){alert("Please Select A Branch Name For balance Effect!");	form.branchid.focus();	return false;}
	else
	if(document.form.worker.value==""){alert("Please Select An Engineer Name!");	form.worker.focus();	return false;}
	else
	if(target==1)
	{
		var j=1; var qty=""; var model=""; var bal=""; var pmodel="";
		var k=parseInt(document.getElementById("hcart").value);
		for(j=1; j<=k; j++)
		{
			qty="";model="";bal="";
			qty="cqty"+j;
			bal="balance"+j;
			model="partname"+j;
			pmodel="pmodel"+j;
			
			if(document.getElementById(pmodel).value==""){alert("Please Select Printer Name!"); return false();}
			else
			if(document.getElementById(model).value==""){alert("Please Select Part Name!"); return false();}
			else
			if(document.getElementById(qty).value=="" || document.getElementById(qty).value=="0"){alert("Please Enter Proper Part Quntity!"); return false();}
			else
			if(parseInt(document.getElementById(qty).value) > parseInt(document.getElementById(bal).value)){alert("Quantity Can't Be Greater Than balance Value!"); return false();}
		}
		if(document.getElementById("pmodel").value==""){alert("Please Select Printer Name!"); return false();}
		else
		if(document.getElementById("partname").value==""){alert("Please Select Part Name!"); return false();}
		else
		if(document.getElementById("cqty").value=="" || document.getElementById("cqty").value=="0"){alert("Please Enter Proper Part Quntity!"); return false();}
		else
		if(parseInt(document.getElementById("cqty").value) > parseInt(document.getElementById("balance").value)){alert("Quantity Can't Be Greater Than balance Value!"); return false();}
		else
		{document.form.action="AllotPartToEngg1.do"; document.form.submit();}
	}
	else
	if(target==2)
	{
		var j=1; var qty=""; var model=""; var bal=""; var pmodel="";
		var k=parseInt(document.getElementById("hcart").value);
		for(j=1; j<=k; j++)
		{
			qty="";model="";bal="";
			qty="cqty"+j;
			bal="balance"+j;
			model="partname"+j;
			pmodel="pmodel"+j;
			
			if(document.getElementById(pmodel).value==""){alert("Please Select Printer Name!"); return false();}
			else
			if(document.getElementById(model).value==""){alert("Please Select Part Name!"); return false();}
			else
			if(document.getElementById(qty).value=="" || document.getElementById(qty).value=="0"){alert("Please Enter Proper Part Quntity!"); return false();}
			else
			if(parseInt(document.getElementById(qty).value) > parseInt(document.getElementById(bal).value)){alert("Quantity Can't Be Greater Than balance Value!"); return false();}
		}
		if(document.getElementById("pmodel").value==""){alert("Please Select Printer Name!"); return false();}
		else
		if(document.getElementById("partname").value==""){alert("Please Select Part Name!"); return false();}
		else
		if(document.getElementById("cqty").value=="" || document.getElementById("cqty").value=="0"){alert("Please Enter Proper Part Quntity!"); return false();}
		else
		if(parseInt(document.getElementById("cqty").value) > parseInt(document.getElementById("balance").value)){alert("Quantity Can't Be Greater Than balance Value!"); return false();}
		else
		{document.form.action="AllotPartToEngg2.do"; document.form.submit();}
	}
}
function delete1(type)
{
    document.getElementById(type).deleteRow(parseInt(document.getElementById("h"+type).value)+1);
	document.getElementById("h"+type).value=parseInt(document.getElementById("h"+type).value)-1;
}
function Add1(type)
{
	document.getElementById("h"+type).value=parseInt(document.getElementById("h"+type).value)+1;
	var row=document.getElementById(type).insertRow(parseInt(document.getElementById("h"+type).value)+1);
	var com1='partname'+document.getElementById("h"+type).value;
	var com2='cid'+document.getElementById("h"+type).value;
	var txt1='balance'+document.getElementById("h"+type).value;
	var txt2='cqty'+document.getElementById("h"+type).value;
	
	var com1='pmodel'+document.getElementById("h"+type).value;
	var com2='pid'+document.getElementById("h"+type).value;
	var com3='partname'+document.getElementById("h"+type).value;
	var com4='partid'+document.getElementById("h"+type).value;
	var txt1='balance'+document.getElementById("h"+type).value;
	var txt2='cqty'+document.getElementById("h"+type).value;
	
    var browsername="unknown";
	
    if((navigator.userAgent.indexOf("MSIE") != -1 ) || (!!document.documentMode == true )) //IF IE > 10
    {
      browsername="IE";   //alert('IE'); 
    }  
    else if(navigator.userAgent.indexOf("Firefox") != -1 ) 
    {
        browsername="Firefox";  //alert('Firefox');
    }
    else if(navigator.userAgent.indexOf("Chrome") != -1 )
    {
        browsername="Chrome";  //alert('Chrome');
    }
    else if(navigator.userAgent.indexOf("Safari") != -1)
    {
        browsername="Safari";  //alert('Safari');
    }
	else
	if((navigator.userAgent.indexOf("Opera") || navigator.userAgent.indexOf('OPR')) != -1 ) 
    {
        browsername="Opera";  //alert('Opera');
    }
    else 
    {
       browsername="unknown";  //alert('unknown');
    }

	if(browsername=="IE")
	{
		var first=row.insertCell(0);
		var el=document.createElement("<input type='text' name='"+com1+"' id='"+com1+"' size=50 onblur=\"if(validateElement(pmodelarray, '"+com1+"')){listElementId(pmodelarray, pidarray, '"+com1+"', '"+com2+"');}\">");
		var e2=document.createElement("<input type=hidden id='"+com2+"' name='"+com2+"'>");
		first.appendChild(el);
		first.appendChild(e2);
		new actb(document.getElementById(com1),pmodelarray);
		
		var second=row.insertCell(1);
		var e3=document.createElement("<input type='text' name='"+com3+"' id='"+com3+"' size=50 onblur=\"if(validateElement(partarray, '"+com3+"')){listElementId(partarray, partidarray, '"+com3+"', '"+com4+"'); getBalance(balanceArray, document.form.'"+com4+"'.value, document.form.'"+com2+"'.value, '"+txt1+"');}\">");
		var e4=document.createElement("<input type=hidden id='"+com4+"' name='"+com4+"'>");
		second.appendChild(e3);
		second.appendChild(e4);
		new actb(document.getElementById(com3),partarray);
		
		var third=row.insertCell(2);
		var txtfield=document.createElement("<input type='text' name='"+txt1+"' id='"+txt1+"' size=5 readonly style='background-color:silver'>");
		third.appendChild(txtfield);
		
		var forth=row.insertCell(3);
		var txtfield=document.createElement("<input type='text' name='"+txt2+"' id='"+txt2+"' size=5 onKeyPress='return numbersonly(this, event)'>");
		forth.appendChild(txtfield);
		
		var fifth=row.insertCell(4);
		var bname="del"+type+(parseInt(document.getElementById("h"+type).value)-1);
		var btn=document.createElement("<input type='button' name='"+bname+"' id='"+bname+"' value='DEL' onClick=\"delete1('"+type+"')\">");
		fifth.appendChild(btn);
	}
	else
	{
		var first=row.insertCell(0);
		var e1 = document.createElement('input');
		e1.setAttribute('type', 'text');
		e1.setAttribute('name', com1);
		e1.setAttribute('id', com1);
		e1.setAttribute('size', '50');
		e1.setAttribute('onblur', 'if(validateElement(pmodelarray, \''+com1+'\')){listElementId(pmodelarray, pidarray, \''+com1+'\', \''+com2+'\');}');
		
		var e11 = document.createElement('input');
		e11.setAttribute('type', 'hidden');
		e11.setAttribute('name', com2);
		e11.setAttribute('id', com2);
		
		first.appendChild(e1);
		first.appendChild(e11);
		new actb(document.getElementById(com1),pmodelarray);

		var second=row.insertCell(1);
		var e3 = document.createElement('input');
		e3.setAttribute('type', 'text');
		e3.setAttribute('name', com3);
		e3.setAttribute('id', com3);
		e3.setAttribute('size', '50');
		e3.setAttribute('onblur', 'if(validateElement(partarray, \''+com3+'\')){listElementId(partarray, partidarray, \''+com3+'\', \''+com4+'\'); getBalance(balanceArray, document.form.'+com4+'.value, document.form.'+com2+'.value, \''+txt1+'\');}');
		
		var e31 = document.createElement('input');
		e31.setAttribute('type', 'hidden');
		e31.setAttribute('name', com4);
		e31.setAttribute('id', com4);
		
		second.appendChild(e3);
		second.appendChild(e31);
		new actb(document.getElementById(com3),partarray);
		
		var third=row.insertCell(2);
		var e2 = document.createElement('input');
		e2.setAttribute('type', 'text');
		e2.setAttribute('readOnly', true); 
		e2.setAttribute('style', 'background-color:silver'); 
		e2.setAttribute('name', txt1);
		e2.setAttribute('id', txt1);
		e2.setAttribute('size', '5');
		third.appendChild(e2);
		
		var fourth=row.insertCell(3);
		var e4 = document.createElement('input');
		e4.setAttribute('type', 'text');
		e4.setAttribute('name', txt2);
		e4.setAttribute('id', txt2);
		e4.setAttribute('size', '5');
		e4.setAttribute('onKeyPress', 'return numbersonly(this, event);');
		fourth.appendChild(e4);

		var fifth=row.insertCell(4);
		var bname="del"+type+(parseInt(document.getElementById("h"+type).value)-1);
		var e5 = document.createElement('input');
		e5.setAttribute('type', 'button');
		e5.setAttribute('name', bname);
		e5.setAttribute('id', bname);
		e5.setAttribute('value', 'DEL');
		e5.setAttribute('onClick', 'delete1(\''+type+'\');');
		fifth.appendChild(e5);
	}
}
</script>
<script LANGUAGE="JavaScript">
var workerarray=new Array();var workeridarray=new Array();<%
Connection con=DBConnection.getNewInstance().getConnection();
Statement stat1=con.createStatement();
Statement stat2=con.createStatement();
ResultSet rs1=null, rs2=null;
long index=0, balance=0, branchid=0, ttype=1, wid=0,  partid=0, pmodel=0;
//if(branchid==0){branchid=cbrnid;}
String nmelement="", idelement="", str1="", str2="", worker="", partname="";
v1="";if((v1=request.getParameter("branchid"))!=null){branchid=Long.parseLong(v1);}
v1="";if((v1=request.getParameter("ttype"))!=null){ttype=Long.parseLong(v1);}
v1="";if((v1=request.getParameter("wid"))!=null){wid=Long.parseLong(v1);}
v1="";if((v1=request.getParameter("worker"))!=null){worker=v1;}
/*
if(branchid==0)
{
	str1="Select unique exec_id, execode, sname from field_executive where br_id in("+brnlist+") and exe_type=1 and LEFT_JOB='NO' order by execode";
}
else
{
	str1="Select unique exec_id, execode, sname from field_executive where br_id="+branchid+" and exe_type=1 and LEFT_JOB='NO' order by execode";
}
*/
str1="Select unique exec_id, execode, sname from field_executive where exe_type=1 and LEFT_JOB='NO' order by execode";
rs1 = stat1.executeQuery(str1);
while(rs1.next())
{
	nmelement="";idelement="";
	v1=""; if((v1=rs1.getString(1))!=null){idelement=v1;}
	v1=""; if((v1=rs1.getString(2))!=null){nmelement=v1;}
	v1=""; if((v1=rs1.getString(3))!=null){nmelement=nmelement+" "+v1;}
	%>workeridarray[<%=index%>]='<%=idelement%>'; workerarray[<%=index%>]='<%=nmelement%>';<%
	index++;
}
%>var pmodelarray=new Array();var pidarray=new Array();<%
index=0;
str1="Select unique id, MODEL_NAME from P_MODEL where status=0 order by MODEL_NAME";
rs1 = stat1.executeQuery(str1);
while(rs1.next())
{
	nmelement="";idelement="";
	v1=""; if((v1=rs1.getString(1))!=null){idelement=v1;}
	v1=""; if((v1=rs1.getString(2))!=null){nmelement=v1;}
	
	%>pidarray[<%=index%>]='<%=idelement%>';  	pmodelarray[<%=index%>]='<%=nmelement%>';<%
	index++;
}

%>
var partarray=new Array(); var partidarray=new Array();

var balanceArray = [];
<%
index=0;
long index1=0;
if(ttype==1)
{
	String[][] partrarray = new String[5000][2];
	long[] partindexrarray = new long[5000];
	long partcount=0;
	try
	{
		str1="select distinct id, name from printer_part where status=1 order by name";
		rs1=stat1.executeQuery(str1);
		while(rs1.next())
		{
			partrarray[(int)partcount][0]=rs1.getString(1);
			partindexrarray[(int)partcount]=rs1.getLong(1);
			partrarray[(int)partcount][1]=rs1.getString(2);

			%>partidarray[<%=index1%>]='<%=rs1.getString(1)%>'; partarray[<%=index1%>]='<%=rs1.getString(2)%>';<%
			
			index1++; partcount++;
		}
	}
	catch(Exception e){}
	
	index1=0;
	if(branchid==0)
	{
		str1="SELECT MAT_ID, pmodel_id, balance FROM (SELECT MAT_ID,pmodel_id,balance,ROW_NUMBER() "+
			 "OVER (PARTITION BY MAT_ID, pmodel_id ORDER BY record_id DESC) as rn FROM part_stock "+
			 "WHERE br_id="+branchid+" and src!=0) t WHERE rn = 1 ORDER BY balance DESC";
	}
	else
	{
		str1="SELECT MAT_ID, pmodel_id, balance FROM (SELECT MAT_ID,pmodel_id,balance,ROW_NUMBER() "+
			 "OVER (PARTITION BY MAT_ID, pmodel_id ORDER BY record_id DESC) as rn FROM part_stock "+
			 "WHERE br_id="+branchid+" and src!=0) t WHERE rn = 1 ORDER BY balance DESC";
	}
	rs1=stat1.executeQuery(str1);
	while(rs1.next())
	{
		balance=0; partid=0; partname=""; pmodel=0;
		
		partid=rs1.getLong(1);
		pmodel=rs1.getLong(2);
		balance=rs1.getLong(3);

		try
		{
			if(balance>0)
			{
				%>balanceArray.push([<%=partid%>, <%=pmodel%>, <%=balance%>]);<%
				index1++;
			}
		}
		catch(Exception e){}
	}
}
else
if(ttype==2)
{
	String[][] partrarray = new String[4000][2];
	long[] partindexrarray = new long[4000];
	long partcount=0;
	try
	{
		str1="select distinct id, name from printer_part where status=1 order by name";
		rs1=stat1.executeQuery(str1);
		while(rs1.next())
		{
			partrarray[(int)partcount][0]=rs1.getString(1);
			partindexrarray[(int)partcount]=rs1.getLong(1);
			partrarray[(int)partcount][1]=rs1.getString(2);

			%>partidarray[<%=index1%>]='<%=rs1.getString(1)%>'; partarray[<%=index1%>]='<%=rs1.getString(2)%>';<%
			
			index1++; partcount++;
		}
	}
	catch(Exception e){}
	
	index1=0;
/*	
	if(branchid==0)
	{
		str1="select es.p_id, es.pmodel_id, es.balance from ENG_STOCK_DETAILS es "+
			"inner join (select p_id, pmodel_id, max(record_id) as maxid from "+
			"ENG_STOCK_DETAILS where eng_name="+wid+" group by p_id, pmodel_id) filter "+
			"on es.p_id=filter.p_id and es.pmodel_id=filter.pmodel_id and es.record_id=filter.maxid order by es.p_id";
	}
	else
	{
		str1="select es.p_id, es.pmodel_id, es.balance from ENG_STOCK_DETAILS es "+
			"inner join (select p_id, pmodel_id, max(record_id) as maxid from "+
			"ENG_STOCK_DETAILS where br_id="+branchid+" and eng_name="+wid+" group by p_id, pmodel_id) filter "+
			"on es.p_id=filter.p_id and es.pmodel_id=filter.pmodel_id and es.record_id=filter.maxid order by es.p_id";
	}
*/	
	str1="select es.p_id, es.pmodel_id, es.balance from ENG_STOCK_DETAILS es "+
		"inner join (select p_id, pmodel_id, max(record_id) as maxid from "+
		"ENG_STOCK_DETAILS where eng_name="+wid+" group by p_id, pmodel_id) filter "+
		"on es.p_id=filter.p_id and es.pmodel_id=filter.pmodel_id and es.record_id=filter.maxid order by es.p_id";
	rs1=stat1.executeQuery(str1);
	while(rs1.next())
	{
		balance=0; partid=0; partname=""; pmodel=0;
		
		partid=rs1.getLong(1);
		pmodel=rs1.getLong(2);
		balance=rs1.getLong(3);

		try
		{
			if(balance>0)
			{
				%>balanceArray.push([<%=partid%>, <%=pmodel%>, <%=balance%>]);<%
				index1++;
			}
		}
		catch(Exception e){}
	}
}

if(rs1!=null){rs1.close();}
if(stat1!=null){stat1.close();}
%>
</script></HEAD><BODY onload="document.form.branchid.focus()"><center>
<div id="hstyle">PART ALLOTMENT TO ENGINEER</div>
<form autocomplete="off" method="post" name="form"><br><center><%
DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd:HH:mm");
Date dat = new Date();
String dt = dateFormat.format(dat);
String date = dt.substring(0, 10);
String tm = dt.substring(11, 16);
long hr = Long.parseLong(tm.substring(0, 2));
String mrd = "AM";
if(hr>12){hr=hr-12; mrd="PM";} else if(hr==12){mrd="PM";}
String time = (Long.toString(hr) ) + (tm.substring(2, 5) )+ " "+mrd;%>
<input type="hidden" name="hcart" id="hcart" value="0">
<input type=hidden value="<%=date%>" name="date">
<input type=hidden value="<%=time%>" name="time" size=10>
<table border=0 align=center cellspacing=2 cellpadding=5% width=95%>
<tr>
<td align=left><label>Branch of balance:</label></td>
<td align=left><select name="branchid" style="width:350px" onChange="setTarget(3)">
<option value="0"></option><%
String branchLlist[][]=cmpbrn.getBranchListSelect(con, brnlist, utotalbrn);
int i=0, j=0;
for(i=0; i<branchLlist.length; i++)
{
	j=0;
	%><option value="<%=branchLlist[i][j++]%>" <%if(branchid==Long.parseLong(branchLlist[i][(j-1)])){%> selected <%}%> ><%=branchLlist[i][j++]%>, <%=branchLlist[i][j++]%>, <%=branchLlist[i][j++]%></option><%
}
con.close();
%></select>
</td>
<td align=left><label>Engineer:</label></td>
<td align=left>
	<input type='text' id='worker' name="worker" value="<%=worker%>" size="40" onBlur="javascript: if(validateElement(workerarray, 'worker')){listElementId(workerarray, workeridarray, 'worker', 'wid');}">
	<input type=hidden id='wid' name="wid" value="<%=wid%>">
</td>
<td align=left><label>Transaction Type:</label></td>
<td align=left><select name="ttype" onChange="setTarget(3)"><option value="1" <% if(ttype==1){%>selected<%}%>>Allocation</option><option value="2" <% if(ttype==2){%>selected<%}%>>De-Allocation</option></select>
</td>
</tr>
</table><br>
<table border=0 cellpadding=5 cellspacing=0 name="cart" id="cart" width=95% align="center">
<tr bgcolor=#D5F5E3>
<td align=left><b><font size=2>Printer Name</font></b></td>
<td align=left><b><font size=2>Part Name</font></b></td>
<td align=left><b><font size=2>Balance</font></b></td>
<td align=left><b><font size=2>Qty.</font></b></td>
<td align=left></td>
</tr>
<tr>
	<td align=left>
		<input type=text id=pmodel name="pmodel" value="" size=50 onBlur="javascript: if(validateElement(pmodelarray, 'pmodel')){listElementId(pmodelarray, pidarray, 'pmodel', 'pid');}">
		<input type=hidden id='pid' name="pid" value="">
	</td>
	<td align=left>
		<input type=text, value="", id=partname name="partname" size=50  onBlur="javascript: if(validateElement(partarray, 'partname')){listElementId(partarray, partidarray, 'partname', 'partid'); getBalance(balanceArray, document.form.partid.value, document.form.pid.value, 'balance');}">
		<input type=hidden id='partid' name="partid" value="">
	</td>
	<td align=left><input type=text id='balance' name="balance" value="" size=5 readonly style="background-color:silver"></td>
	<td align=left><input type=text, value="", name="cqty" id="cqty" size=5 onKeyPress="return numbersonly(this, event)"></td>
<td align=left>	<input type="button" name="addcart" id="addcart" value="ADD" onClick="javascript:Add1('cart')"></td>
</tr>
</table>
<br><br>
<input type="button" name="" value="Allocate" onClick="setTarget(1)" style="width:150px" <% if(ttype==2){%>disabled<%}%>>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
<input type="button" name="" value="De-Allocate" onClick="setTarget(2)" style="width:150px" <% if(ttype==1){%>disabled<%}%>>
</center>
<script>var obj1 = new actb(document.getElementById('worker'),workerarray);</script>
<script>var obj2 = new actb(document.getElementById('partname'),partarray);</script>
<script>var obj3 = new actb(document.getElementById('pmodel'),pmodelarray);</script>
</form></center></BODY></HTML>