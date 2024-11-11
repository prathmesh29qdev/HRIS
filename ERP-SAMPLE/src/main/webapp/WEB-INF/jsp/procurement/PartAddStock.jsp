
<%@ page language="java" import="java.sql.*, MyBeans.*" import="java.util.Date" import="java.io.*" import="java.text.DateFormat" import="java.text.SimpleDateFormat" import="java.lang.*"%>
<jsp:useBean id="stockBean" scope="request" class="MyBeans.PartStockBean" />
<HTML><HEAD><TITLE>PART OPENING STOCK</TITLE></HEAD>
<BODY><form autocomplete="off" onkeypress="return DisableEnter()" action="" method="post"><%
String validate="NO", v1="";
HttpSession ses=request.getSession(true);
String usrid=(String)ses.getAttribute("usr_id");
String brnlist=(String)ses.getAttribute("brnlist");  
long utotalbrn=Long.parseLong((String)ses.getAttribute("utotalbrn"));
long UsrBrnList[]=(long[])ses.getAttribute("UsrBrnList");

String ct=request.getParameter("loopcount1");
long count = Long.parseLong(ct);
//System.out.println(ct);
//System.out.println(count);
DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
Date dat = new Date();
String date = dateFormat.format(dat);

Connection con=DBConnection.getNewInstance().getConnection();
String v2="", v3="", v4="", incr="", var1="mid", var2="ostock", var3="pmodel", str1="",recrdno="0";
long psid=0, branchid=0, cartid=0, pmd=0;
v1="";if((v1=request.getParameter("brnid1"))!=null){branchid=Long.parseLong(v1);}
v1="";if((v1=request.getParameter("cid"))!=null){cartid=Long.parseLong(v1);}
v1="";if((v1=request.getParameter("pmodel"))!=null){pmd=Long.parseLong(v1);}
double maxbal=0.0,psbal=0.0;

long n=1, rw1=0, id=0, qty=0, qtbalance=0, pmodel=0, status=0;
while(n<count)
{
	incr = "";v1 = "";v2 = "";v3 = ""; v4=""; id=0; qty=0;qtbalance=0;maxbal=0.0;recrdno="0"; pmodel=0;status=0;
	incr = Long.toString(n);
	v1 = var1+incr;
	v2 = var2+incr;
	v3 = var3+incr;
	
	v4=""; if((v4=request.getParameter(v1))!=null){id=Long.parseLong(v4);}
	v4=""; if((v4=request.getParameter(v2))!=null){if(v4.length()>0){qty=Long.parseLong(v4);}}
	v4=""; if((v4=request.getParameter(v3))!=null){pmodel=Long.parseLong(v4);}
	
	if(qty>0 && pmodel>0 && id>0)
	{
		status = stockBean.insertStock(con, branchid, id, pmodel, date, qty, 0, 0, usrid, 0, 0, 0, 0, 0, "CREDIT", 11, 0);
		/*
			public long insertStock(Connection conn, long branchId, long partId, long pModelId, String trDate, 
						long in_qty, long out_qty, long installId, String userId, long purID, long enggStkId, 
						long pRepId, long fltRetId, long pScrapeId, String tr_type, long src, long rate) 
		*/				
	}
	n++;
}
con.close();
response.sendRedirect("partstock.do?branchid="+branchid+"&cid="+cartid+"&pmodel="+pmd);%>
</form></BODY></HTML>