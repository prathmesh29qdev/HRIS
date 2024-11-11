
<%@ page language="java" import="java.sql.*, MyBeans.*" import="java.util.Date" import="java.io.*" import="java.text.DateFormat" import="java.text.SimpleDateFormat" import="java.lang.*"%>
<jsp:useBean id="rec" scope="request" class="MyBeans.Recordid" />
<jsp:useBean id="dateformat" scope="request" class="MyBeans.convertDate" />
<%-- <jsp:useBean id="dateutil" scope="request" class="MyBeans.npd" /> --%>
<jsp:useBean id="stockBean" scope="request" class="MyBeans.PartStockBean" />
<HTML><HEAD><TITLE>PART DE-ALLOCATION FROM CALL</TITLE>
<script language="javascript">function printPage(){if (window.print) window.print();}</script>
<link href="css/style1.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="js/rightclick.js"></script>
</HEAD><center><br><br><br><br><%
String validate="NO", v1="";
HttpSession ses=request.getSession(true);
String usrid=(String)ses.getAttribute("usr_id");
String brnlist=(String)ses.getAttribute("brnlist");  
long utotalbrn=Long.parseLong((String)ses.getAttribute("utotalbrn"));
long UsrBrnList[]=(long[])ses.getAttribute("UsrBrnList");

String canceltype=request.getParameter("canceltype");
long callid=Long.parseLong(request.getParameter("callid"));
//System.out.println("canceltype :"+canceltype);

if(canceltype.equals("req"))
{
	long reqid=Long.parseLong(request.getParameter("reqid"));

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

	long rw1=0, rw2=0;

	Connection con=DBConnection.getNewInstance().getConnection();
	con.setAutoCommit(false);
	Statement stat=con.createStatement();
	ResultSet rs=null;
	PreparedStatement pst1=null;
	try
	{
		pst1=con.prepareStatement("insert into part_req_rc(select * from part_req where id=?)");
		pst1.setLong(1, reqid);
		rw1=pst1.executeUpdate();
		
		pst1=con.prepareStatement("update part_req_rc set ALLOT_DATE=?, ALLOT_TIME=?, ALLOT_BY=? where ID=?");
		pst1.setString(1, today);
		pst1.setString(2, time);
		pst1.setString(3, usrid);
		pst1.setLong(4, reqid);
		rw1=pst1.executeUpdate();
		
		if(rw1>0)
		{
			pst1=con.prepareStatement("delete from part_req where id=?");
			pst1.setLong(1, reqid);
			rw2=pst1.executeUpdate();
		}
		if(rw2>0)
		{
			pst1=con.prepareStatement("update client_request set CALL_STATUS=?, CALL_STATUS_NAME=? where CALL_ID=?");
			pst1.setLong(1, 10);
			pst1.setString(2, "SUPPORT TEAM PENDING");
			pst1.setLong(3, callid);
			rw2=pst1.executeUpdate();
			
			pst1=con.prepareStatement("insert into call_comments(id, call_id, cdate, ctime, comments, cuser, comment_type, attempt) "+
									  "values(CALL_COMMENT_SEQ.nextval, ?, ?, ?, ?, ?, ?, ?)");
			pst1.setLong(1, callid);
			pst1.setString(2, today);
			pst1.setString(3, time);
			pst1.setString(4, "Part request cancelled");
			pst1.setString(5, usrid);
			pst1.setString(6, "SC");
			pst1.setLong(7, 9999);
			pst1.executeUpdate();
			
						
			try
			{
				if(rw2>0)
				{
					try
					{
						//long satatusupdate = dateutil.setCallStatusTAT(con, pst1, stat, usrid, callid, 10, 0, "SUPPORT TEAM PENDING", "-");
					}
					catch(Exception e){}
				}
			}
			catch(Exception e){}
		}
	}
	catch(Exception e){}

	if(rw2>0)
	{
		con.commit(); 
		%><br><br><br><br><br><br><center><label>Part Request Cancelled Successfully!</label><br><br><input type="button" name="backbtn" value="Back" onClick="window.history.go(-1)" style="width:150px"><%
	}
	else
	{
		con.rollback();
		%><br><br><br><br><br><br><center><label>Failed Cancel Part Request!</label><br><br><input type="button" name="backbtn" value="Back" onClick="window.history.go(-1)" style="width:150px"><%
	}
	con.setAutoCommit(true);
	if(rs!=null){rs.close();}
	if(stat!=null){stat.close();}
	if(pst1!=null){pst1.close();}
	con.close();
}
else
if(canceltype.equals("allot"))
{
	String action="-";
	v1="";if((v1=request.getParameter("action"))!=null){action=v1;}

	if(action.equals("cancel"))
	{
		long branchid=Long.parseLong(request.getParameter("branchid"));
		long reqid=Long.parseLong(request.getParameter("reqid"));
		long partid=Long.parseLong(request.getParameter("partid"));
		long cid=Long.parseLong(request.getParameter("cid"));
		long installid=Long.parseLong(request.getParameter("installid"));
		String partname=request.getParameter("partname");
		String GDC_NO=request.getParameter("GDC_NO");
		long pmodel=Long.parseLong(request.getParameter("pmodel"));

		long row1=0, found=0;

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

		String dt1 = today;

		String str="",recrdno="0", dt2="", str1="";
		long rw1=0, rw2=0, rw3=0, i=1, balance=0, psid=0, maxbal=0,psbal=0, qty=0, dcpartcount=0, oldbrid=0;
		long status=0;

		Connection con=DBConnection.getNewInstance().getConnection();
		con.setAutoCommit(false);
		Statement stat=con.createStatement();
		ResultSet rs=null;
		PreparedStatement pst1=null;

		rs=stat.executeQuery("select br_id, OUTWARD, TR_DATE, RECORD_ID from part_stock where src=8 and INSTALL_ID="+installid+"");
		if(rs.next())
		{
			oldbrid=rs.getLong(1);
			qty=rs.getLong(2);
			v1=""; if((v1=rs.getString(3))!=null){dt2=v1;}
			v1=""; if((v1=rs.getString(4))!=null){recrdno=v1;}
		}

		try
		{
			status = stockBean.insertStock(con, branchid, partid, pmodel, dt1, qty, 0, installid, usrid, 0, 0, 0, 0, 0, "CREDIT", 4, 0);
			/*
			public long insertStock(Connection conn, long branchId, long partId, long pModelId, String trDate, 
						long in_qty, long out_qty, long installId, String userId, long purID, long enggStkId, 
						long pRepId, long fltRetId, long pScrapeId, String tr_type, long src, long rate) 
			*/				
		}
		catch(Exception e){}
		
		try
		{
			if(status == 1)
			{
				rw1=0;
				pst1=con.prepareStatement("insert into part_install_rc(select * from part_install where id=?)");
				pst1.setLong(1, installid);
				rw1=pst1.executeUpdate();
				
				String usrid1=". Cancelled by "+usrid+", dated "+dt1+".";
				pst1=con.prepareStatement("update part_install_rc set USER_ID=concat(USER_ID, ?) where id=?");
				pst1.setString(1, usrid1);
				pst1.setLong(2, installid);
				rw1=pst1.executeUpdate();
			}
		}
		catch(Exception e){}
		try
		{
			if(rw1>0 && !GDC_NO.equals("-") && GDC_NO!=null && GDC_NO.length()>3 )
			{
				str1="select count(*) from general_dc_goods where gdc_id in(select id from general_dc where dc_no='"+GDC_NO+"')";
				rs=stat.executeQuery(str1);
				if(rs.next()){ dcpartcount=rs.getLong(1); }
				
				pst1=con.prepareStatement("delete from part_install where id=?");
				pst1.setLong(1, installid);
				rw2=pst1.executeUpdate();
				
				if(dcpartcount==0)
				{
					pst1=con.prepareStatement("update part_req set ALLOT_BY='', ALLOT_DATE='', ALLOT_TIME='', GDC_NO='', status=1 where id=?");
					pst1.setLong(1, reqid);
					rw3=pst1.executeUpdate();
					if(rw3>0)
					{
						pst1=con.prepareStatement("delete from general_dc where dc_no=?");
						pst1.setString(1, GDC_NO);
						pst1.executeUpdate();
					}
					if(rw3>0)
					{
						rw3=0;
						pst1=con.prepareStatement("update client_request set CALL_STATUS=?, CALL_STATUS_NAME=? where CALL_ID=?");
						pst1.setLong(1, 6);
						pst1.setString(2, "PART ALLOT PENDING");
						pst1.setLong(3, callid);
						rw3=pst1.executeUpdate();
						
						try
						{
							if(rw3>0)
							{
								try
								{
									//long satatusupdate = dateutil.setCallStatusTAT(con, pst1, stat, usrid, callid, 6, 0, "PART ALLOT PENDING", "-");
								}
								catch(Exception e){}
							}
						}
						catch(Exception e){}
					}
				}
				else
				if(dcpartcount==1)
				{
					if(rw2>0)
					{
						pst1=con.prepareStatement("update part_req set ALLOT_BY='', ALLOT_DATE='', ALLOT_TIME='', GDC_NO='', status=1 where id=?");
						pst1.setLong(1, reqid);
						rw3=pst1.executeUpdate();
					}
					if(rw3>0)
					{
						rw3=0;
						pst1=con.prepareStatement("delete from general_dc_goods where gdc_id in(select id from general_dc where dc_no=?)");
						pst1.setString(1, GDC_NO);
						rw3=pst1.executeUpdate();
					}
					if(rw3>0)
					{
						rw3=0;
						pst1=con.prepareStatement("delete from general_dc where dc_no=?");
						pst1.setString(1, GDC_NO);
						rw3=pst1.executeUpdate();
					}
					if(rw3>0)
					{
						rw3=0;
						pst1=con.prepareStatement("update client_request set CALL_STATUS=?, CALL_STATUS_NAME=? where CALL_ID=?");
						pst1.setLong(1, 6);
						pst1.setString(2, "PART ALLOT PENDING");
						pst1.setLong(3, callid);
						rw3=pst1.executeUpdate();
						
						try
						{
							if(rw3>0)
							{
								try
								{
									//long satatusupdate = dateutil.setCallStatusTAT(con, pst1, stat, usrid, callid, 6, 0, "PART ALLOT PENDING", "-");
								}
								catch(Exception e){}
							}
						}
						catch(Exception e){}
					}
				}
				if(dcpartcount>1)
				{
					if(rw2>0)
					{
						pst1=con.prepareStatement("update part_req set status=1 where id=?");
						pst1.setLong(1, reqid);
						rw3=pst1.executeUpdate();
					}
					if(rw3>0)
					{
						rw3=0;
						pst1=con.prepareStatement("delete from general_dc_goods where part_id=? and gdc_id in(select id from general_dc where dc_no=?)");
						pst1.setLong(1, partid);
						pst1.setString(2, GDC_NO);
						rw3=pst1.executeUpdate();
					}
					if(rw3>0)
					{
						rw3=0;
						pst1=con.prepareStatement("update client_request set CALL_STATUS=?, CALL_STATUS_NAME=? where CALL_ID=?");
						pst1.setLong(1, 6);
						pst1.setString(2, "PART ALLOT PENDING");
						pst1.setLong(3, callid);
						rw3=pst1.executeUpdate();
						
						try
						{
							if(rw3>0)
							{
								try
								{
									//long satatusupdate = dateutil.setCallStatusTAT(con, pst1, stat, usrid, callid, 6, 0, "PART ALLOT PENDING", "-");
								}
								catch(Exception e){}
							}
						}
						catch(Exception e){}
						
						pst1=con.prepareStatement("insert into call_comments(id, call_id, cdate, ctime, comments, cuser, comment_type, attempt) "+
												  "values(CALL_COMMENT_SEQ.nextval, ?, ?, ?, ?, ?, ?, ?)");
						pst1.setLong(1, callid);
						pst1.setString(2, today);
						pst1.setString(3, time);
						pst1.setString(4, "Cancelled allotted part");
						pst1.setString(5, usrid);
						pst1.setString(6, "SC");
						pst1.setLong(7, 9999);
						pst1.executeUpdate();
					}
				}
				
			}
		}
		catch(Exception e){}

		if(rw2>0 && rw3>0)
		{
			con.commit(); 
			%><br><br><br><br><br><br><center><label>Part De-Allotted / Cancelled Successfully!</label><br><br><%
		}
		else
		{
			con.rollback();
			%><br><br><br><br><br><br><center><label>Failed to De-Allot / Cancel Part!</label><br><br><input type="button" name="backbtn" value="Back" onClick="window.history.go(-1)" style="width:150px"><%
		}
		con.setAutoCommit(true);
		if(rs!=null){rs.close();}
		if(stat!=null){stat.close();}
		if(pst1!=null){pst1.close();}
		con.close();
	}
}
%>
</form></BODY></HTML>