
<%@ page language="java" import="java.sql.*, MyBeans.*" import="java.util.Date" import="java.io.*" import="java.text.DateFormat" import="java.text.SimpleDateFormat" import="java.lang.*"%>
<jsp:useBean id="rec" scope="request" class="MyBeans.Recordid" />
<jsp:useBean id="stockBean" scope="request" class="MyBeans.PartStockBean" />
<HTML><HEAD><TITLE>PART ALLOTMENT TO ENGINEER</TITLE>
<link href="css/style1.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="js/rightclick.js"></script><%
String validate="NO", v1="";
HttpSession ses=request.getSession(true);
String usrid=(String)ses.getAttribute("usr_id");
String brnlist=(String)ses.getAttribute("brnlist");  
long utotalbrn=Long.parseLong((String)ses.getAttribute("utotalbrn"));
long UsrBrnList[]=(long[])ses.getAttribute("UsrBrnList");

%>
</HEAD><BODY><div id="hstyle">PART ALLOTMENT TO ENGINEER</div>
<form autocomplete="off" onkeypress="return DisableEnter()" action="AllotPartToEngg.do" method="post"><%
long hcart=Long.parseLong(request.getParameter("hcart"));
long branchid=Long.parseLong(request.getParameter("branchid"));

DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd:HH:mm");
Date dat = new Date();
String yrmn = dateFormat.format(dat);
String dt1 = yrmn.substring(0, 10);

String date = request.getParameter("date");
String time = request.getParameter("time");
long worker = Long.parseLong(request.getParameter("wid"));
long pid = Long.parseLong(request.getParameter("pid"));
long partid = Long.parseLong(request.getParameter("partid"));
String cqty = request.getParameter("cqty");
String cqtydisp = "",  para1 = "", para2 = "", para3="",v2 = "", str="",recrdno="0";
long rw1 = 0, i=1, balance=0;

long cdate=Long.parseLong(dt1.substring(0,4)+dt1.substring(5,7)+dt1.substring(8,10));
long vdate=Long.parseLong(date.substring(0,4)+date.substring(5,7)+date.substring(8,10));

long esid=0,psid=0, status=0, updatestatus=0;
double maxbal=0.0,esbal=0.0,psbal=0.0;

Connection con=DBConnection.getNewInstance().getConnection();
con.setAutoCommit(false);
Statement stat=con.createStatement();
ResultSet rs=null;
boolean rowfound=false;
PreparedStatement pst1=null,pst2=null, pst3=null, pst4=null;

rs=stat.executeQuery("select ENG_STOCK_DETAILS_SEQ.nextval from dual");
if(rs.next()){esid=rs.getLong(1);}

recrdno=rec.getRecordid(date,esid);

str="select balance from ENG_STOCK_DETAILS where p_id ="+partid+" and pmodel_id="+pid+" and eng_name="+worker+" and RECORD_ID in(select max(RECORD_ID) from ENG_STOCK_DETAILS where p_id ="+partid+" and eng_name="+worker+" and pmodel_id="+pid+" and RECORD_ID<="+Long.parseLong(recrdno)+")";
rs=stat.executeQuery(str);
if(rs.next()){v1=""; if((v1=rs.getString(1))!=null){maxbal=Double.parseDouble(v1);}}

pst1=con.prepareStatement("update ENG_STOCK_DETAILS set balance=balance-? where p_id=? and eng_name=? and pmodel_id=? and RECORD_ID>?");
pst1.setDouble(1, Double.parseDouble(cqty));
pst1.setLong(2, partid);
pst1.setLong(3, worker);
pst1.setLong(4, pid);
pst1.setLong(5, Long.parseLong(recrdno));
pst1.executeUpdate();

esbal=maxbal-Double.parseDouble(cqty);

pst2=con.prepareStatement("insert into ENG_STOCK_DETAILS(id, P_ID, ENG_NAME, OUTWARD, BALANCE, USED_DATE, RECORD_ID, br_id, STOCK_TIME, USER_ID, SRC, pmodel_id) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
pst2.setLong(1, esid);
pst2.setLong(2, partid);
pst2.setLong(3, worker);
pst2.setLong(4, Long.parseLong(cqty));
pst2.setDouble(5, esbal);
pst2.setString(6, date);
pst2.setLong(7, Long.parseLong(recrdno));
pst2.setLong(8, branchid);
pst2.setString(9, time);
pst2.setString(10, usrid);
pst2.setLong(11, 4);
pst2.setLong(12, pid);
pst2.executeUpdate();

maxbal=0.0;recrdno="0";

status = stockBean.insertStock(con, branchid, partid, pid, date, Long.parseLong(cqty), 0, 0, usrid, 0, 0, 0, 0, 0, "CREDIT", 4, 0);
/*
public long insertStock(Connection conn, long branchId, long partId, long pModelId, String trDate, 
			long in_qty, long out_qty, long installId, String userId, long purID, long enggStkId, 
			long pRepId, long fltRetId, long pScrapeId, String tr_type, long src, long rate) 
*/				

if(status == 0)
{
	i = hcart + 1;
	updatestatus=0;
}
else
if(status == 1)
{
	updatestatus=1;
}
else
if(status == 2)
{
	i = hcart + 1;
	updatestatus=2;
}

while(i<=hcart)
{
	para1=""; para2=""; para3=""; cqty="";maxbal=0.0;recrdno="0"; pid=0; partid=0; status=0;
	
    para1="partid"+i;	 partid=Long.parseLong(request.getParameter(para1));
    para2="cqty"+i; cqty=request.getParameter(para2);
    para3="pid"+i;	 pid=Long.parseLong(request.getParameter(para3));
	 
	rs=stat.executeQuery("select ENG_STOCK_DETAILS_SEQ.nextval from dual");
	if(rs.next()){esid=rs.getLong(1);}

	recrdno=rec.getRecordid(date,esid);
	 
	str="select balance from ENG_STOCK_DETAILS where p_id ="+partid+" and pmodel_id="+pid+" and eng_name="+worker+" and RECORD_ID in(select max(RECORD_ID) from ENG_STOCK_DETAILS where p_id ="+partid+" and pmodel_id="+pid+" and eng_name="+worker+" and RECORD_ID<='"+recrdno+"')";
	rs=stat.executeQuery(str);
	if(rs.next()){v1=""; if((v1=rs.getString(1))!=null){maxbal=Double.parseDouble(v1);}}
	
	pst1.setDouble(1, Double.parseDouble(cqty));
	pst1.setLong(2, partid);
	pst1.setLong(3, worker);
	pst1.setLong(4, pid);
	pst1.setLong(5, Long.parseLong(recrdno));
	pst1.executeUpdate();
	
	esbal=maxbal-Double.parseDouble(cqty);

	pst2.setLong(1, esid);
	pst2.setLong(2, partid);
	pst2.setLong(3, worker);
	pst2.setLong(4, Long.parseLong(cqty));
	pst2.setDouble(5, esbal);
	pst2.setString(6, date);
	pst2.setLong(7, Long.parseLong(recrdno));
	pst2.setLong(8, branchid);
	pst2.setString(9, time);
	pst2.setString(10, usrid);
	pst2.setLong(11, 4);
	pst2.setLong(12, pid);
	pst2.executeUpdate();
	
	maxbal=0.0;recrdno="0";
	
	status = stockBean.insertStock(con, branchid, partid, pid, date, Long.parseLong(cqty), 0, 0, usrid, 0, 0, 0, 0, 0, "CREDIT", 4, 0);
	/*
	public long insertStock(Connection conn, long branchId, long partId, long pModelId, String trDate, 
				long in_qty, long out_qty, long installId, String userId, long purID, long enggStkId, 
				long pRepId, long fltRetId, long pScrapeId, String tr_type, long src, long rate) 
	*/				

	if(status == 0)
	{
		i = hcart + 1;
		updatestatus=0;
	}
	else
	if(status == 1)
	{
		updatestatus=1;
	}
	else
	if(status == 2)
	{
		i = hcart + 1;
		updatestatus=2;
	}
	 
	i++;
}

if(updatestatus == 0)
{
	con.rollback();
	%>
	<br><br><br><br><br>
	<div id="done">Failed De-Allocation!</div>
	<br><br><br><center>
	<input type=button value="  Back  " onclick="window.history.go(-1)" style="width:200px"></center>
	<%
}
else
if(updatestatus == 1)
{
	con.commit();
	%>
	<br><br><br><br><br>
	<div id="done">De-Allocation Done!</div><br><br><br><center>
	<input type=submit value="Update Next" style="width:200px"></center>
	<%
}
else
if(updatestatus == 2)
{
	con.rollback();
	%>
	<br><br><br><br><br>
	<div id="done">Insufficient part stock for de-allocation!</div>
	<br><br><br><center>
	<input type=button value="  Back  " onclick="window.history.go(-1)" style="width:200px"></center>
	<%
}
con.setAutoCommit(true);

if(rs!=null){rs.close();}
if(stat!=null){stat.close();}
if(pst1!=null){pst1.close();}
if(pst2!=null){pst2.close();}
if(pst3!=null){pst3.close();}
if(pst4!=null){pst4.close();}
con.close();%>
</form></BODY></HTML>