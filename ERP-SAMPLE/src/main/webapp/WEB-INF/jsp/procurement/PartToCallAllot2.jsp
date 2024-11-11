
<%@ page language="java" import="java.sql.*, MyBeans.*" import="java.util.Date" import="java.io.*" import="java.text.DateFormat" import="java.text.SimpleDateFormat" import="java.lang.*"%>
<jsp:useBean id="dateformat" scope="request" class="MyBeans.convertDate" />
<%-- <jsp:useBean id="dateutil" scope="request" class="MyBeans.npd" /> --%>
<jsp:useBean id="stockBean" scope="request" class="MyBeans.PartStockBean" />
<HTML><HEAD><TITLE>PART ALLOCATION TO CALL</TITLE>
<link href="css/style1.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="js/rightclick.js"></script><%
String validate="NO", v1="";
HttpSession ses=request.getSession(true);
String usrid=(String)ses.getAttribute("usr_id");
String brnlist=(String)ses.getAttribute("brnlist");  
long utotalbrn=Long.parseLong((String)ses.getAttribute("utotalbrn"));
long UsrBrnList[]=(long[])ses.getAttribute("UsrBrnList");

%>
</HEAD><BODY><div id="hstyle">PART ALLOCATION TO CALL</div>
<form autocomplete="off" onkeypress="return DisableEnter()" action="" method="post">
<%
String action=request.getParameter("action");

if(action.equals("req"))
{
	long partid=Long.parseLong(request.getParameter("partid"));
	long qty=Long.parseLong(request.getParameter("qty"));
	long callid=Long.parseLong(request.getParameter("callid"));
	long cid=Long.parseLong(request.getParameter("cid"));
	long branchid=Long.parseLong(request.getParameter("branchid"));
	long hpart=Long.parseLong(request.getParameter("hpart"));
	long pmodel=Long.parseLong(request.getParameter("pmodel"));

	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd:HH:mm");
	Date dat = new Date();
	String dt = dateFormat.format(dat);
	String today = dt.substring(0, 10);
	String tm = dt.substring(11, 16);
	long hr = Long.parseLong(tm.substring(0, 2));
	String year = dt.substring(0, 4);
	String month =dt.substring(5, 7);
	String mrd = "AM";
	if(hr>12){hr=hr-12; mrd="PM";} else if(hr==12){mrd="PM";}
	String time = (Long.toString(hr) ) + (tm.substring(2, 5) )+ " "+mrd;

	long rw1=0, rw2=0, i=1, reqid=0;
	String para1="", para2="";

	Connection con=DBConnection.getNewInstance().getConnection();
	con.setAutoCommit(false);
	PreparedStatement pst1=null;
	Statement stat=con.createStatement();
	ResultSet rs=null;

	try
	{
		pst1=con.prepareStatement("insert into PART_REQ(ID, CALL_ID, REQ_BY, REQ_DATE, REQ_TIME, PART_ID, REQ_QTY, STATUS, CLIENT_ID, BR_ID, PMODEL_ID) "+
								  "values(PART_REQ_SEQ.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
		pst1.setLong(1, callid);
		pst1.setString(2, usrid);
		pst1.setString(3, today);
		pst1.setString(4, time);
		pst1.setLong(5, partid);
		pst1.setLong(6, qty);
		pst1.setLong(7, 1);
		pst1.setLong(8, cid);
		pst1.setLong(9, branchid);
		pst1.setLong(10, pmodel);
		rw1=pst1.executeUpdate();
		
		pst1=con.prepareStatement("update client_request set CALL_STATUS=?, CALL_STATUS_NAME=? where CALL_ID=?");
		pst1.setLong(1, 6);
		pst1.setString(2, "PART ALLOT PENDING");
		pst1.setLong(3, callid);
		rw2=pst1.executeUpdate();
		try
		{
			if(rw2>0)
			{
				// long satatusupdate = dateutil.setCallStatusTAT(con, pst1, stat, usrid, callid, 6, 0, "PART ALLOT PENDING", "-");
			}
		}
		catch(Exception e){}
		
		pst1=con.prepareStatement("insert into call_comments(id, call_id, cdate, ctime, comments, cuser, comment_type, attempt) "+
								  "values(CALL_COMMENT_SEQ.nextval, ?, ?, ?, ?, ?, ?, ?)");
		pst1.setLong(1, callid);
		pst1.setString(2, today);
		pst1.setString(3, time);
		pst1.setString(4, "Part requested");
		pst1.setString(5, usrid);
		pst1.setString(6, "SC");
		pst1.setLong(7, 9999);
		pst1.executeUpdate();
	}
	catch(Exception e){}
	
	i=2;
	while(i<=hpart)
	{
		para1=""; para2=""; partid=0; qty=0;
		para1="partid"+i;
		para2="qty"+i;
		
		try{partid=Long.parseLong(request.getParameter(para1));}catch(Exception e){}
		try{qty=Long.parseLong(request.getParameter(para2));}catch(Exception e){}
		
		try
		{
			pst1=con.prepareStatement("insert into PART_REQ(ID, CALL_ID, REQ_BY, REQ_DATE, REQ_TIME, PART_ID, REQ_QTY, STATUS, CLIENT_ID, BR_ID, PMODEL_ID) "+
									  "values(PART_REQ_SEQ.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
			pst1.setLong(1, callid);
			pst1.setString(2, usrid);
			pst1.setString(3, today);
			pst1.setString(4, time);
			pst1.setLong(5, partid);
			pst1.setLong(6, qty);
			pst1.setLong(7, 1);
			pst1.setLong(8, cid);
			pst1.setLong(9, branchid);
			pst1.setLong(10, pmodel);
			rw1=pst1.executeUpdate();
			
			pst1=con.prepareStatement("insert into call_comments(id, call_id, cdate, ctime, comments, cuser, comment_type, attempt) "+
									  "values(CALL_COMMENT_SEQ.nextval, ?, ?, ?, ?, ?, ?, ?)");
			pst1.setLong(1, callid);
			pst1.setString(2, today);
			pst1.setString(3, time);
			pst1.setString(4, "Part requested");
			pst1.setString(5, usrid);
			pst1.setString(6, "SC");
			pst1.setLong(7, 9999);
			pst1.executeUpdate();
		}
		catch(Exception e){}

		i++;
	}

	if(rw1>0 && rw2>0)
	{
		%><br><br><br><br><br><br><center><label>Requirement Sent!</label><br><br><%
	}
	else
	{
		%><br><br><br><br><br><br><center><label>Failed to send requirement!</label><br><br><%
	}
	con.setAutoCommit(true);
	if(rs!=null){rs.close();}
	if(stat!=null){stat.close();}
	if(pst1!=null){pst1.close();}
	con.close();
}
else
if(action.equals("allot"))
{
	long partid=Long.parseLong(request.getParameter("partid"));
	long branchid=Long.parseLong(request.getParameter("branchid"));
	long qty=Long.parseLong(request.getParameter("qty"));
	long usedpart=Long.parseLong(request.getParameter("usedpart"));
	long callid=Long.parseLong(request.getParameter("callid"));
	long cid=Long.parseLong(request.getParameter("cid"));
	long pmodel=Long.parseLong(request.getParameter("pmodel"));
	String pmodelname=request.getParameter("pmodelname");
	String partname=request.getParameter("partname");
	String returnableby="", enggid="0";
	long price=0, purchprice=0, reqid=0, addtoexistingdc=0;
	v1=""; if((v1=request.getParameter("purchprice"))!=null){purchprice=Long.parseLong(v1);}
	v1=""; if((v1=request.getParameter("price"))!=null){price=Long.parseLong(v1);}
	v1="";if((v1=request.getParameter("engg"))!=null){returnableby=v1;}
	v1="";if((v1=request.getParameter("eid"))!=null){enggid=v1;}
	v1=""; if((v1=request.getParameter("reqid"))!=null){reqid=Long.parseLong(v1);}
	v1=""; if((v1=request.getParameter("addtoexistingdc"))!=null){addtoexistingdc=Long.parseLong(v1);}

	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd:HH:mm");
	Date dat = new Date();
	String dt = dateFormat.format(dat);
	String dt1 = dt.substring(0, 10);
	String tm = dt.substring(11, 16);
	long hr = Long.parseLong(tm.substring(0, 2));
	String mrd = "AM";
	if(hr>12){hr=hr-12; mrd="PM";} else if(hr==12){mrd="PM";}
	String time = (Long.toString(hr) ) + (tm.substring(2, 5) )+ " "+mrd;
	
	//long cdate=Long.parseLong(dt1.substring(0,4)+dt1.substring(5,7)+dt1.substring(8,10));
	//long vdate=Long.parseLong(dt1.substring(0,4)+dt1.substring(5,7)+dt1.substring(8,10));

	String str="",recrdno="0";
	long rw1=0, rw2=0, rw3=0, i=1, balance=0, psid=0, installid=0, maxbal=0,psbal=0, status=0;

	Connection con=DBConnection.getNewInstance().getConnection();
	con.setAutoCommit(false);
	Statement stat=con.createStatement();
	ResultSet rs=null;
	PreparedStatement pst1=null;
	try
	{
		rs=stat.executeQuery("select PART_INSTALL_SEQ.nextval from dual");
		if(rs.next()){installid=rs.getLong(1);}
		
		pst1=con.prepareStatement("insert into PART_INSTALL(CALL_ID, PART_ID, QTY, INST_DATE, USER_ID, PRICE, ENGG_ID, CLIENT_ID, "+
								  "PURCHASE_PRICE, USED_PART, ID, RETURNABLE_BY, br_id, PMODEL_ID) "+
								  "values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
		pst1.setLong(1, callid);
		pst1.setLong(2, partid);
		pst1.setLong(3, qty);
		pst1.setString(4, dt1);
		pst1.setString(5, usrid);
		pst1.setDouble(6, price);
		pst1.setLong(7, 0);
		pst1.setLong(8, cid);
		pst1.setDouble(9, purchprice);
		pst1.setLong(10,usedpart);
		pst1.setLong(11,installid);
		pst1.setString(12, returnableby);
		pst1.setLong(13, branchid);
		pst1.setLong(14, pmodel);
		rw1=pst1.executeUpdate();
	}
	catch(Exception e){}

	status = stockBean.insertStock(con, branchid, partid, pmodel, dt1, 0, qty, installid, usrid, 0, 0, 0, 0, 0, "DEBIT", 8, 0);
/*
    public long insertStock(Connection conn, long branchId, long partId, long pModelId, String trDate, 
				long in_qty, long out_qty, long installId, String userId, long purID, long enggStkId, 
				long pRepId, long fltRetId, long pScrapeId, String tr_type, long src, long rate) 
*/				

	if(status == 1)
	{
		long charoffset=0, intoffset=0, dcid=0, dcfound=0;
		String cperson="",  contactno="", dcno="", str1="";
		char charcode; rw2=0; rw1=0;

		if(addtoexistingdc==1)
		{
			str1="select ID, DC_NO from general_dc where status=0 and call_id="+callid;
			rs=stat.executeQuery(str1);
			if(rs.next())
			{
				dcfound++;
				dcid=rs.getLong(1);
				v1=""; if((v1=rs.getString(2))!=null){dcno=v1;}
			}
		}
		
		if(dcfound==0)
		{
			str1="select DC_CHAR_CODE from code_offset";
			rs=stat.executeQuery(str1);
			if(rs.next()){charoffset=rs.getLong(1);}
			charcode = ((char)charoffset);

			str1="select dcnumber_sq.nextval from dual";
			rs=stat.executeQuery(str1);
			if(rs.next()){intoffset=rs.getLong(1);}
			if(intoffset==99999)
			{
				charoffset++;
				if(charoffset>90)
				{
					charoffset=65;
					pst1=con.prepareStatement("update code_offset set DC_CHAR_CODE=?");
					pst1.setLong(1, charoffset);
					pst1.executeUpdate();
				}
				else
				{
					pst1=con.prepareStatement("update code_offset set DC_CHAR_CODE=?");
					pst1.setLong(1, charoffset);
					pst1.executeUpdate();
				}
			}
			if(intoffset<10){dcno="0000"+Long.toString(intoffset);}
			else
			if(intoffset<100 && intoffset>=10){dcno="000"+Long.toString(intoffset);}
			else
			if(intoffset<1000 && intoffset>=100){dcno="00"+Long.toString(intoffset);}
			else
			if(intoffset<10000 && intoffset>=1000){dcno="0"+Long.toString(intoffset);}
			else
			{dcno=Long.toString(intoffset);}
			dcno=charcode+dcno;

			str1="select GENERAL_DC_SEQ.nextval from dual";
			rs=stat.executeQuery(str1);
			if(rs.next()){dcid=rs.getLong(1);}

			str1="select CALL_BY, CONTACT_NO from client_request where call_id="+callid;
			rs=stat.executeQuery(str1);
			if(rs.next())
			{
				v1=""; if((v1=rs.getString(1))!=null){cperson=v1;}
				v1=""; if((v1=rs.getString(2))!=null){contactno=v1;}
			}
			
			pst1=con.prepareStatement("insert into general_dc(ID, DC_NO, DC_DATE, DC_TIME, CLIENT_ID, REMARKS, STATUS, "+
				 "BR_ID, PUNCH_BY, CONSINE_NAME, dc_head, CALL_ID, CONTACT_NO) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
			pst1.setLong(1, dcid);
			pst1.setString(2, dcno);
			pst1.setString(3, dt1);
			pst1.setString(4, time);
			pst1.setLong(5, cid);
			pst1.setString(6, "Printer part dispatch");
			pst1.setLong(7, 0);
			pst1.setLong(8, branchid);
			pst1.setString(9, usrid);
			pst1.setString(10, cperson);
			pst1.setLong(11, 3);
			pst1.setLong(12, callid);
			pst1.setString(13, contactno);
			rw1=pst1.executeUpdate();
		}
		else {rw1=1;}
		 
		partname=partname+" - "+pmodelname;
		
		pst1=con.prepareStatement("insert into general_dc_goods(id, GDC_ID, PROD_NAME, QTY, RATE, part_id, PMODEL_ID) "+
								  "values(general_dc_goods_seq.nextval, ?, ?, ?, ?, ?, ?)");
		pst1.setLong(1, dcid);
		pst1.setString(2, partname);
		pst1.setLong(3, qty);
		pst1.setLong(4, price);
		pst1.setLong(5, partid);
		pst1.setLong(6, pmodel);
		rw2=pst1.executeUpdate();
		
		pst1=con.prepareStatement("update part_req set ALLOT_BY=?, ALLOT_DATE=?, ALLOT_TIME=?, GDC_NO=?, status=? where id=?");
		pst1.setString(1, usrid);
		pst1.setString(2, dt1);
		pst1.setString(3, time);
		pst1.setString(4, dcno);
		pst1.setLong(5, 2);
		pst1.setLong(6, reqid);
		rw3=pst1.executeUpdate();
			
		try
		{
			String oglclient="-";
			str1="select OGL_CLIENT from client where id="+cid;
			rs=stat.executeQuery(str1);
			if(rs.next()){ v1=""; if((v1=rs.getString(1))!=null){oglclient=v1;} }

			long chatid=0;
			String autocomment="New general DC for part allotted: "+dcno;
		}
		catch(Exception e){}
		
		
		if(rw1>0 && rw2>0 && rw3>0)
		{
			rw2=0;
			pst1=con.prepareStatement("update client_request set CALL_STATUS=?, CALL_STATUS_NAME=? where CALL_ID=?");
			pst1.setLong(1, 12);
			pst1.setString(2, "PART READY FOR DISPATCH");
			pst1.setLong(3, callid);
			rw2=pst1.executeUpdate();
			try
			{
				if(rw2>0)
				{
					//long satatusupdate = dateutil.setCallStatusTAT(con, pst1, stat, usrid, callid, 12, 0, "PART READY FOR DISPATCH", "-");
				}
			}
			catch(Exception e){}
			
			con.commit(); 
			%><br><br><br><br><br><br><center><label>Allocation Done Successfully!</label><br><br><%
		}
		else
		{
			con.rollback();
			%><br><br><br><br><br><br><center><label>Failed to allocate part!</label><br><br><%
		}
	}
	else
	if(status==2)
	{
		con.rollback();
		%><br><br><br><br><br><br><center><label>Insufficient part stock balance to allocate!</label><br><br><%
	}
	else
	if(status==2)
	{
		con.rollback();
		%><br><br><br><br><br><br><center><label>Failed to allocate part!</label><br><br><%
	}
	con.setAutoCommit(true);
	if(rs!=null){rs.close();}
	if(stat!=null){stat.close();}
	if(pst1!=null){pst1.close();}
	if(con!=null){con.close();}
}
%>
</form></BODY></HTML>