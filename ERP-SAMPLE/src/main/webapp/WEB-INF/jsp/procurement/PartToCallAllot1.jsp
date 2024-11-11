<%@ page language="java" import="java.sql.*, MyBeans.*" import="java.util.Date" import="java.io.*" import="java.text.DateFormat" import="java.text.SimpleDateFormat" import="java.lang.*"%>
<jsp:useBean id="dateformat" scope="request" class="MyBeans.convertDate" />
<jsp:useBean id="cmpbrn" scope="request" class="MyBeans.BranchDetails" />
<HTML><HEAD><TITLE>PART ALLOCATION TO CALL</TITLE>
<link href="css/style1.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="js/rightclick.js"></script>
<script language="javascript" type="text/javascript" src="js/numeric.js"></script>
<script language="javascript" type="text/javascript" src="js/agree.js"></script>
<script language="javascript" type="text/javascript" src="js/ValidateElement.js"></script> 
<script language="javascript" type="text/javascript" src="js/ValidateDynamic.js"></script> 
<script language="javascript" type="text/javascript" src="js/ListElement.js"></script> 
<script language="javascript" type="text/javascript" src="js/actb.js"></script>
<script language="javascript" type="text/javascript" src="js/common.js"></script>
<%
String validate="NO", v1="";
HttpSession ses=request.getSession(true);
String usrid=(String)ses.getAttribute("usr_id");
String brnlist=(String)ses.getAttribute("brnlist");  
long utotalbrn=Long.parseLong((String)ses.getAttribute("utotalbrn"));
long UsrBrnList[]=(long[])ses.getAttribute("UsrBrnList");

String action="-";
v1="";if((v1=request.getParameter("action"))!=null){action=v1;}

if(action.equals("allot") || action.equals("req"))
{
	long callid=Long.parseLong(request.getParameter("callid"));
	long cid=Long.parseLong(request.getParameter("cid"));
	long execode=Long.parseLong(request.getParameter("execode"));
	String cname=request.getParameter("cname");
	String clocation=request.getParameter("clocation");
	%>
	<script language="javascript">
	var partarray=new Array(); var partidarray=new Array();
	var enggarray=new Array(); var enggidarray=new Array(); 
	<%
	Connection con=DBConnection.getNewInstance().getConnection();
	Statement st1 = con.createStatement();
	ResultSet rs1=null;
	long pid=0, index=0, branchid=0, partid=0, reqid=0, pmodel=0;
	String pname="", partname="", pmodelname="";
	try{ v1="";if((v1=request.getParameter("branchid"))!=null){branchid=Long.parseLong(v1);} }catch(Exception e){}
	try{ v1="";if((v1=request.getParameter("partid"))!=null){partid=Long.parseLong(v1);} }catch(Exception e){}
	try{ v1="";if((v1=request.getParameter("reqid"))!=null){reqid=Long.parseLong(v1);} }catch(Exception e){}
	try{ v1="";if((v1=request.getParameter("pmodel"))!=null){pmodel=Long.parseLong(v1);} }catch(Exception e){}
	try{ v1="";if((v1=request.getParameter("pmodelname"))!=null){pmodelname=v1;} }catch(Exception e){}

	String str1="Select unique id, name from printer_part where status=1 order by name";
	rs1=st1.executeQuery(str1);
	while(rs1.next())
	{
		pname="";pid=0;
		pid=rs1.getLong(1);
		v1=""; if((v1=rs1.getString(2))!=null){pname=v1;}
		
		if(partid==pid){partname=pname;}
		
		%>partidarray[<%=index%>]='<%=pid%>'; partarray[<%=index%>]='<%=pname%>';<%
		index++;
	}
	index=0;
	str1="select unique exec_id, execode from field_executive where exe_type=1 and left_job='NO' order by execode";
	rs1=st1.executeQuery(str1);
	while(rs1.next())
	{
		pname="";pid=0;
		pid=rs1.getLong(1);
		v1=""; if((v1=rs1.getString(2))!=null){pname=v1;}
		%>enggidarray[<%=index%>]='<%=pid%>'; enggarray[<%=index%>]='<%=pname%>';<%
		index++;
	}
	%>
	</script>
	<script LANGUAGE="JavaScript">
	function setTarget(target)
	{
		if(target == 1)  // for allocation of part
		{
			if(document.form.action.value=="allot")
			{
				if (document.form.partid.value=="0"){alert("Please select part name!");document.form.partid.focus();return false;}
				else
				if (document.form.branchid.value==""){alert("Please select a stock branch!");document.form.branchid.focus();return false;}
				else
				if (document.form.qty.value==""){alert("Please enter quantity!");document.form.qty.focus();return false;}
				else
				if (document.form.usedpart.value==""){alert("Please select if part used or new!");document.form.usedpart.focus();return false;}
				else
				if (document.form.purchprice.value==""){alert("Please enter purchase price!");document.form.purchprice.focus();return false;}
				else
				if (document.form.price.value==""){alert("Please enter sale price!");document.form.price.focus();return false;}
				else
				if(document.form.partbal.value < document.form.qty.value){alert("Not enough balance in branch stock!");document.form.qty.focus(); return false;}
				else
				if (document.form.addtoexistingdc.value==""){alert("Please select if need to add into existing DC or separate DC!");document.form.addtoexistingdc.focus();return false;}
				else
				{
//					alert("ready to submit");
					document.form.action="PartToCallAllot2.do"; document.form.submit();
				}
			}
			else
			if(document.form.action.value=="req")
			{
				if (document.form.partname.value==""){alert("Please select part name!");document.form.partname.focus();return false;}
				else
				if (document.form.qty.value==""){alert("Please enter quantity!");document.form.qty.focus();return false;}
				else
				{
					var count=document.getElementById("hpart").value;
					var varname1="", varname2="";

					for(var k=2; k<=count; k++)
					{
						varname1='partname'+k;
						varname2='qty'+k;
						if(document.getElementById(varname1).value==""){alert("Please select part name!");document.form.varname1.focus();return false;}
						else
						if(document.getElementById(varname2).value==""){alert("Please enter quantity!");document.form.varname2.focus();return false;}
					}
					
					document.form.action="PartToCallAllot2.do"; document.form.submit();
				}
			}
		}
	}
	function getPartBal()
	{
		var partid=document.form.partid.value;
		var branchid=document.form.branchid.value;
		var pmodel=document.form.pmodel.value;
		var eid='0';
		if(typeof XMLHttpRequest!="undefined"){req=new XMLHttpRequest();}
		else
		if (window.ActiveXObject){req=new ActiveXObject("Microsoft.XMLHTTP");}
		req.open("POST", "getPartBal.do", true);
		req.onreadystatechange = callbackRelevantPB;
		req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		req.send("stocksrc=branch&partid="+encodeURIComponent(partid)+"&eid="+encodeURIComponent(eid)+"&branchid="+encodeURIComponent(branchid)+"&pmodel="+encodeURIComponent(pmodel));
	}
	function callbackRelevantPB()
	{
		if (req.readyState==4)
		{
			if (req.status==200 || req.status==500)
			{
				var htmlelement=document.getElementById("pbal");
				htmlelement.innerHTML=req.responseText;
			}
		}
	}

	function getPartPrice()
	{
		var partid=document.form.partid.value;
		var branchid=document.form.branchid.value;
		var usedpart=document.form.usedpart.value;
		if(typeof XMLHttpRequest!="undefined"){req=new XMLHttpRequest();}
		else
		if (window.ActiveXObject){req=new ActiveXObject("Microsoft.XMLHTTP");}
		req.open("POST", "getPartPrice.do", true);
		req.onreadystatechange = callbackRelevantPP;
		req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		req.send("fieldtitle=NO&partid="+encodeURIComponent(partid)+"&usedpart="+encodeURIComponent(usedpart)+"&branchid="+encodeURIComponent(branchid));
	}
	function callbackRelevantPP()
	{
		if (req.readyState==4)
		{
			if (req.status==200 || req.status==500)
			{
				var htmlelement=document.getElementById("pprice");
				htmlelement.innerHTML=req.responseText;
			}
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
		var com2='partid'+document.getElementById("h"+type).value;
		var txt1='qty'+document.getElementById("h"+type).value;

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
			var el=document.createElement("<input type='text' name='"+com1+"' id='"+com1+"' style='width:400px' onblur=\"if(validateElement(partarray, '"+com1+"')){listElementId(partarray, partidarray, '"+com1+"', '"+com2+"');}\">");
			var e2=document.createElement("<input type=hidden id='"+com2+"' name='"+com2+"'>");
			
			var second=row.insertCell(1);
			var txtfield=document.createElement("<input type='text' name='"+txt1+"' id='"+txt1+"' style='width:50px' maxlength=10 onKeyPress='return numbersonly(this, event)'>");
			txtfield.setAttribute('value', '');
			second.appendChild(txtfield);
			
			var third=row.insertCell(2);
			var bname="del"+type+(parseInt(document.getElementById("h"+type).value)-1);
			var btn=document.createElement("<input type='button' name='"+bname+"' id='"+bname+"' style='width:50px'  value='DEL' onClick=\"delete1('"+type+"')\">");
			third.appendChild(btn);
		}
		else
		{
			var first=row.insertCell(0);
			var e1 = document.createElement('input');
			e1.setAttribute('type', 'text');
			e1.setAttribute('name', com1);
			e1.setAttribute('id', com1);
			e1.setAttribute('style', 'width:400px');
			e1.setAttribute('onblur', 'if(validateElement(partarray, \''+com1+'\')){listElementId(partarray, partidarray, \''+com1+'\', \''+com2+'\');}');
			
			var e11 = document.createElement('input');
			e11.setAttribute('type', 'hidden');
			e11.setAttribute('name', com2);
			e11.setAttribute('id', com2);

			first.appendChild(e1);
			first.appendChild(e11);
			new actb(document.getElementById(com1),partarray);
			
			var second=row.insertCell(1);
			var e1 = document.createElement('input');
			e1.setAttribute('type', 'text');
			e1.setAttribute('name', txt1);
			e1.setAttribute('id', txt1);
			e1.setAttribute('style', 'width:50px');
			e1.setAttribute('maxlength', '10');
			e1.setAttribute('onKeyPress', 'return numbersonly(this, event);');
			second.appendChild(e1);
			
			var third=row.insertCell(2);
			var bname="del"+type+(parseInt(document.getElementById("h"+type).value)-1);
			var e2 = document.createElement('input');
			e2.setAttribute('type', 'button');
			e2.setAttribute('name', bname);
			e2.setAttribute('id', bname);
			e1.setAttribute('style', 'width:50px');
			e2.setAttribute('value', 'DEL');
			e2.setAttribute('onClick', 'delete1(\''+type+'\');');
			third.appendChild(e2);
		}
	}

	</script>
	</HEAD><BODY><center>
	<form autocomplete="off" onkeypress="return DisableEnter()" action="" method="post" name="form">
	<input type="hidden" name="callid" value="<%=callid%>">
	<input type="hidden" name="cid" value="<%=cid%>">
	<input type="hidden" name="execode" value="<%=execode%>">
	<input type="hidden" name="action" value="<%=action%>">
	<input type="hidden" name="reqid" value="<%=reqid%>">
	<input type="hidden" name="pmodel" id="pmodel" value="<%=pmodel%>">
	<input type="hidden" name="pmodelname" id="pmodelname" value="<%=pmodelname%>">
	<%
	if(action.equals("req"))
	{
		%>
		<input type="hidden" name="branchid" id="branchid" value="<%=branchid%>">
		<input type="hidden" name="hpart" id="hpart" value="1">
		
		<table border=0 align=center cellspacing=5 cellpadding=0 name="part" id="part">
		<tr valign=top>
		<td align=left colspan=3><label>Client: </label> <font size=2><%=cname%> - <%=clocation%></font></td>
		</tr>
		<tr valign=top>
		<td align=left colspan=3><label>Printer: </label> <font size=2><%=pmodelname%></font></td>
		</tr>
		<tr bgcolor=#D5F5E3>
			<td align=left><B>Part Name</B></td>
			<td align=left><B>Quantity</B></td>
			<td align=left></td>
		</tr>
		<tr>
			<td align=left>
			<input type=text value="", id="partname" name="partname" style="width:400px" onBlur="javascript: if(validateElement(partarray, 'partname')){listElementId(partarray, partidarray, 'partname', 'partid');}">
			<input type="hidden" id='partid' name="partid" value="0">
			</td>
			<td align=left><input type='text' name="qty" id="qty" style="width:50px" value="" maxlength=10 onKeyPress="return numbersonly(this, event)"></td>
			<td align=left>	<input type="button" name="addpart" id="addpart" value="ADD" onClick="javascript:Add1('part')"></td>
		</tr>
		<tr>
		<td colspan=3 align=center><br>
		<%
		String partpermission="";
		if(usrid.equals("ADMIN") || usrid.equals("NITIN") || usrid.equals("PRADIP") || usrid.equals("MAHENDRA") || usrid.equals("VIJAY") || usrid.equals("GAUTAM") || usrid.equals("VISHESH") || usrid.equals("SAVITA") || usrid.equals("ABHISHEK") || usrid.equals("AMIN") || usrid.equals("RITIK") || usrid.equals("RAJ") || usrid.equals("JHA") || usrid.equals("SHANKAR"))
		{
			partpermission="";
		}
		else
		{
			partpermission="disabled";
		}
		%>
		<input <% if(pmodel<=0){%>disabled<%}%> type="button" name="sbtn" <%=partpermission%> value="Submit Part Request" onClick="setTarget(1)" style="width:200px">
		<%if(pmodel<=0){%><Br><font color=red>Without printer model, part request not allowed!</font><%}%>
		</td>
		</tr>
		</table>
		<BR>
		<div id="hstyle"><font size=2>PREVIOUS PART REQUIREMENT FOR THIS CALL</font></div>
		<table border=1 align=center cellspacing=0 cellpadding=4 WIDTH=100%>
		<tr valign=top bgcolor=#666666>
		<td align=left width=10%><label>DATE</label></td>
		<td align=left width=40%><label>PRINTER</label></td>
		<td align=left width=35%><label>PART</label></td>
		<td align=left width=5%><label>QTY</label></td>
		<td align=left width=10%><label>REQ. BY:</label></td>
		</tr>
		<%
		Statement st2 = con.createStatement();
		ResultSet rs2=null;
		String REQ_BY="", REQ_DATE="", REQ_TIME="", PARTNAME="", str2="";
		long PART_ID=0, REQ_QTY=0, sr=0, STATUS=0;
		
		str1="select REQ_BY, REQ_DATE, REQ_TIME, PART_ID, REQ_QTY, ID, PMODEL_ID, STATUS from PART_REQ where CALL_ID="+callid+" order by ID DESC";
		rs1=st1.executeQuery(str1);
		while(rs1.next())
		{
			REQ_BY=""; REQ_DATE=""; REQ_TIME=""; PARTNAME=""; PART_ID=0; REQ_QTY=0; sr++; reqid=0;
			pmodel=0; pname=""; STATUS=0;
			
			v1=""; if((v1=rs1.getString(1))!=null){REQ_BY=v1;}
			v1=""; if((v1=rs1.getString(2))!=null){REQ_DATE=v1;}
			v1=""; if((v1=rs1.getString(3))!=null){REQ_TIME=v1;}
			PART_ID=rs1.getLong(4);
			REQ_QTY=rs1.getLong(5);
			reqid=rs1.getLong(6);
			pmodel=rs1.getLong(7);
			STATUS=rs1.getLong(8);
			
			try
			{
				str2="Select name from printer_part where id="+PART_ID;
				rs2=st2.executeQuery(str2);
				if(rs2.next()){ v1=""; if((v1=rs2.getString(1))!=null){PARTNAME=v1;} }
			}
			catch(Exception e){}
			
			try
			{
				str2="Select model_name from p_model where id="+pmodel;
				rs2=st2.executeQuery(str2);
				if(rs2.next()){ v1=""; if((v1=rs2.getString(1))!=null){pname=v1;} }
			}
			catch(Exception e){}
			
			%>
			<tr valign=top <% if(sr%2==0){%>bgcolor=#D5F5E3<%}else{%>bgcolor=ghostwhite<%} %> >
			<td align=left width=10%><font size=2><%=dateformat.formatDate(REQ_DATE)%><br><%=REQ_TIME%></font></td>
			<td align=left width=40%><font size=2><%=pname%></font></td>
			<td align=left width=35%>
				<font size=2><%=PARTNAME%>
				<%
				if(STATUS==1)
				{
					%><BR>Not Allotted : <a href="PartToCallAllot3.do?canceltype=req&callid=<%=callid%>&reqid=<%=reqid%>" rel="gb_page_center[700, 450]">CANCEL REQ.</a><%
				}
				else
				if(STATUS==2)
				{
					%><BR>Alloted<%
				}
				else
				if(STATUS==3)
				{
					%><BR>Dispatched<%
				}
				else
				if(STATUS==4)
				{
					%><BR>Delivered<%
				}
				%>
				</font>
			</td>
			<td align=left width=5%><font size=2><%=REQ_QTY%></font></td>
			<td align=left width=10%><font size=2><%=REQ_BY%><Br></font></td>
			</tr>
			<%
		}
		if(rs2!=null){rs2.close();}
		if(st2!=null){st2.close();}
		%>
		</table>
		
		<%
	}
	else
	if(action.equals("allot"))
	{
		%>
		<div id="hstyle">PART ALLOCATION TO CALL</div>
		<table border=0 align=center cellspacing=5 cellpadding=4>
		<tr valign=top>
		<td align=left width=30%><label>CLIENT NAME:</label></td>
		<td align=left width=70%><font size=2><%=cname%> - <%=clocation%></font></td>
		</tr>
		<tr valign=top>
		<td align=left width=30%><label>PRINTER MODEL:</label></td>
		<td align=left width=70%><font size=2><%=pmodelname%></font></td>
		</tr>
		<tr>
		<td align=left><label>Part Name:</label></td>
		<td align=left>
		<input type=text value="<%=partname%>", id="partname" name="partname" style="width:350px" onBlur="javascript: if(validateElement(partarray, 'partname')){listElementId(partarray, partidarray, 'partname', 'partid');}">
		<input type=hidden id='partid' name="partid" value="<%=partid%>">
		</td>
		</tr>
		<tr>
		<td align=left><label>Stock Branch:</label></td>
		<td align=left><select name="branchid" style="width:350px"  onChange="getPartBal();">
		<option value="0"></option><%
		String branchLlist[][]=cmpbrn.getBranchListSelect(con, brnlist, utotalbrn);
		int i=0, j=0;
		for(i=0; i<branchLlist.length; i++)
		{
			j=0;
			%><option value="<%=branchLlist[i][j++]%>" <%if(branchid==Long.parseLong(branchLlist[i][(j-1)])){%> selected <%}%> ><%=branchLlist[i][j++]%>, <%=branchLlist[i][j++]%>, <%=branchLlist[i][j++]%></option><%
		}
		%></select>
		</td>
		</tr>
		<tr>
		<td align=left><label>Quantity:</label></td>
		<td align=left>
		<input type='text' name="qty" id="qty" style="width:350px" value="" maxlength=10 onKeyPress="return numbersonly(this, event)">
		&nbsp; &nbsp; &nbsp; 
		<div id="pbal"><input type="hidden" name="partbal" id="partbal" value="0"></div>
		</td>
		</tr>
		<tr>
		<td align=left><label>Used Part?</label></td>
		<td align=left>
			<select name="usedpart" id="usedpart" style="width:350px" onchange="getPartPrice()">
			<option value=""></option><option value="1">YES</option><option value="0">NO</option>
			</select>
		</td>
		<tr>
		<td align=left><label>Purchase Price:</label></td>
		<td align=left>
			<div id="pprice">
			<input type='text' name="purchprice" id="purchprice" style="width:350px" value="" maxlength=10 onKeyPress="return numbersonly(this, event)">
			</div>
		</td>
		</tr>
		<tr>
		<td align=left><label>Sale Price:</label></td>
		<td align=left><input type='text' name="price" id="price" style="width:350px" value="" maxlength=10 onKeyPress="return numbersonly(this, event)"></td>
		</tr>
		<tr>
		<td align=left><label>Faulty Returnable By:</label></td>
		<td align=left>
		<input type='text' id='engg' name="engg" value="" style="width:350px" onBlur="javascript: listElementId(enggarray, enggidarray, 'engg', 'eid');">
		<input type="hidden" id='eid' name="eid" value="0">
		</td>
		</tr>
		<tr>
		<td align=left><label>Add in existing DC?</label></td>
		<td align=left>
			<select name="addtoexistingdc" id="addtoexistingdc" style="width:350px">
			<option value=""></option><option value="1">YES</option><option value="0">NO</option>
			</select>
		</td>
		<tr>
		<tr><td colspan=2><br></td></tr>
		<tr><td colspan=2 align="center">
			<input <% if(pmodel<=0){%>disabled<%}%> type="button" name="sbtn" value="Allotcate Part" onClick="setTarget(1)" style="width:250px">
			<%if(pmodel<=0){%><Br><font color=red>Without printer model, part allotment not allowed!</font><%}%>
		</td></tr>
		</table>
		<%
	}
	if(rs1!=null){rs1.close();}
	if(st1!=null){st1.close();}
	con.close();
	%>
	</center>
	</form>
	<script>var obj1 = new actb(document.getElementById('partname'),partarray);</script>
	<script>var obj2 = new actb(document.getElementById('engg'),enggarray);</script>
	<%
}
else
if(action.equals("cancel"))
{
	Connection con=DBConnection.getNewInstance().getConnection();
	long partid=0, reqid=0, pmodel=0, callid=0, cid=0, installid=0;
	String pmodelname="", partname="", GDC_NO="-", canceltype="", cname="", clocation="";
	try{ v1="";if((v1=request.getParameter("partid"))!=null){partid=Long.parseLong(v1);} }catch(Exception e){}
	try{ v1="";if((v1=request.getParameter("reqid"))!=null){reqid=Long.parseLong(v1);} }catch(Exception e){}
	try{ v1="";if((v1=request.getParameter("pmodel"))!=null){pmodel=Long.parseLong(v1);} }catch(Exception e){}
	try{ v1="";if((v1=request.getParameter("callid"))!=null){callid=Long.parseLong(v1);} }catch(Exception e){}
	try{ v1="";if((v1=request.getParameter("cid"))!=null){cid=Long.parseLong(v1);} }catch(Exception e){}
	try{ v1="";if((v1=request.getParameter("installid"))!=null){installid=Long.parseLong(v1);} }catch(Exception e){}
	try{ v1="";if((v1=request.getParameter("pmodelname"))!=null){pmodelname=v1;} }catch(Exception e){}
	try{ v1="";if((v1=request.getParameter("partname"))!=null){partname=v1;} }catch(Exception e){}
	try{ v1="";if((v1=request.getParameter("GDC_NO"))!=null){GDC_NO=v1;} }catch(Exception e){}
	try{ v1="";if((v1=request.getParameter("canceltype"))!=null){canceltype=v1;} }catch(Exception e){}
	try{ v1="";if((v1=request.getParameter("cname"))!=null){cname=v1;} }catch(Exception e){}
	try{ v1="";if((v1=request.getParameter("clocation"))!=null){clocation=v1;} }catch(Exception e){}
	%>
	<script LANGUAGE="JavaScript">
	function setTarget(target)
	{
		if (document.form.branchid.value=="0"){alert("Please select a stock branch!");document.form.branchid.focus();return false;}
		else
		{ document.form.action="PartToCallAllot3.do"; document.form.submit(); }
	}
	</script>
	</HEAD><BODY><center>
	<form autocomplete="off" onkeypress="return DisableEnter()" action="PartToCallAllot3.do" method="post" name="form">
	<input type="hidden" name="callid" value="<%=callid%>">
	<input type="hidden" name="cid" value="<%=cid%>">
	<input type="hidden" name="installid" value="<%=installid%>">
	<input type="hidden" name="partname" value="<%=partname%>">
	<input type="hidden" name="GDC_NO" value="<%=GDC_NO%>">
	<input type="hidden" name="canceltype" value="<%=canceltype%>">
	<input type="hidden" name="partid" value="<%=partid%>">
	<input type="hidden" name="action" value="<%=action%>">
	<input type="hidden" name="reqid" value="<%=reqid%>">
	<input type="hidden" name="pmodel" id="pmodel" value="<%=pmodel%>">
	<input type="hidden" name="pmodelname" id="pmodelname" value="<%=pmodelname%>">
	<input type="hidden" name="cname" id="cname" value="<%=cname%>">
	<input type="hidden" name="clocation" id="clocation" value="<%=clocation%>">

	<div id="hstyle">PART DE-ALLOT FROM CALL</div>
	<br><br>
	<table border=0 align=center cellspacing=5 cellpadding=4>
	<tr>
	<td align=left><label>Client Name:</label></td>
	<td align=left><%=cname%> - [ <%=clocation%> ]</td>
	</tr>
	<tr>
	<td align=left><label>Part Name:</label></td>
	<td align=left><%=partname%></td>
	</tr>
	<tr>
	<td align=left><label>Move Stock To Branch:</label></td>
	<td align=left><select name="branchid" style="width:350px"  onChange="getPartBal();">
	<option value="0"></option><%
	String branchLlist[][]=cmpbrn.getBranchListSelect(con, brnlist, utotalbrn);
	int i=0, j=0;
	for(i=0; i<branchLlist.length; i++)
	{
		j=0;
		%><option value="<%=branchLlist[i][j++]%>" ><%=branchLlist[i][j++]%>, <%=branchLlist[i][j++]%>, <%=branchLlist[i][j++]%></option><%
	}
	%></select>
	</td>
	</tr>
	<tr><td colspan=2><br></td></tr>
	<tr><td colspan=2 align="center">
		<input type="button" name="sbtn" value="De-Allot Part" onClick="setTarget(1)" style="width:250px">
	</td></tr>
	<tr><td colspan=2><br></td></tr>
	</table>
	<%
	con.close();
	%>
	</center>
	</form>
	<%
}
%>
</BODY></HTML>