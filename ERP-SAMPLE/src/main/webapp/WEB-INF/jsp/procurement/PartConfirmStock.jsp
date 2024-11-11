
<%@ page language="java" import="java.sql.*, MyBeans.*" import="java.util.Date" import="java.io.*" import="java.text.DateFormat" import="java.text.SimpleDateFormat" import="java.lang.*"%>
<%-- <jsp:useBean id="npd" scope="request" class="MyBeans.npd" /> --%>
<HTML><HEAD><TITLE>PART CONFIRM STOCK</TITLE></HEAD>
<BODY><form autocomplete="off" onkeypress="return DisableEnter()" action="" method="post"><%
String validate="NO", v1="";
HttpSession ses=request.getSession(true);
String usrid=(String)ses.getAttribute("usr_id");
String brnlist=(String)ses.getAttribute("brnlist");  
long utotalbrn=Long.parseLong((String)ses.getAttribute("utotalbrn"));
long UsrBrnList[]=(long[])ses.getAttribute("UsrBrnList");

String ct=request.getParameter("loopcount1");
long count = Long.parseLong(ct);
DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
Date dat = new Date();
String date = dateFormat.format(dat);

Connection con=DBConnection.getNewInstance().getConnection();
PreparedStatement pst1 = null, pst2=null;
long psid=0, branchid=0, cartid=0, pmd=0;
v1="";if((v1=request.getParameter("brnid1"))!=null){branchid=Long.parseLong(v1);}
v1="";if((v1=request.getParameter("cid"))!=null){cartid=Long.parseLong(v1);}
v1="";if((v1=request.getParameter("pmodel"))!=null){pmd=Long.parseLong(v1);}

pst1=con.prepareStatement("update PART_STOCK set VERIFY_BY=?, VERIFY_DATE=?, VERIFY_DIFF_COUNT=?, VERIFY_MATCHED=? where BR_ID=? and RECORD_ID=?");
pst2=con.prepareStatement("update PRINTER_PART_MIN_STOCK set VERIFY_STATUS=?, LAST_VERIFY_DATE=?, LAST_VERIFY_BY=?, NEXT_VERIFY_DATE=? where BR_ID=? and PART_ID=?");
						  
long n=1, rw1=0, id=0, qty=0, qtbalance=0, pmodel=0, oldbalance=0, diff=0, matchedValue=0;
String str1="", recrdno="0", var1="mid", var2="ostock", var3="pmodel", var4="recid", var5="oldstock";
String incr="", v2="", v3="", v4="", v5="", v6="", recordid="";

//String nextdate=npd.getDateMMddYYYY(date, "30", "+");

//nextdate = nextdate.substring(6,10) +"-"+ nextdate.substring(3,5) +"-"+ nextdate.substring(0,2);

//while(n<count)
for (n = 1; n < count; n++) 
{
	incr = "";v1 = "";v2 = "";v3 = ""; v4=""; v5=""; 
	id=0; qty=0;pmodel=0;  recordid=""; oldbalance=0; diff=0; matchedValue=0;
	
	incr = Long.toString(n);
	v1 = var1+incr; 	v2 = var2+incr; 	v3 = var3+incr; 	v4 = var4+incr; 	v5 = var5+incr; 	
	
	v6=""; if((v6=request.getParameter(v1))!=null){id=Long.parseLong(v6);}
	v6=""; if((v6=request.getParameter(v2))!=null){if(v6.length()>0){qty=Long.parseLong(v6);}}
	v6=""; if((v6=request.getParameter(v3))!=null){pmodel=Long.parseLong(v6);}
	v6=""; if((v6=request.getParameter(v4))!=null){recordid=v6;}
	v6=""; if((v6=request.getParameter(v5))!=null){oldbalance=Long.parseLong(v6);}

	if(Long.parseLong(recordid)>0 && pmodel>0 && id>0)
	{
		matchedValue = (oldbalance == qty) ? 0 : (oldbalance < qty) ? 2 : 1;
        diff = qty - oldbalance;

		pst1.setString(1, usrid);
		pst1.setString(2, date);
		pst1.setLong(3, diff);
		pst1.setLong(4, matchedValue);
		pst1.setLong(5, branchid);
		pst1.setString(6, recordid);
		pst1.addBatch();
			
		pst2.setLong(1, 1);
		pst2.setString(2, date);
		pst2.setString(3, usrid);
		//pst2.setString(4, nextdate);
		pst2.setString(4, new Date().toString());
		pst2.setLong(5, branchid);
		pst2.setLong(6, id);
		pst2.addBatch();
	}
}

int[] partStockResults = pst1.executeBatch();
int[] printerPartMinStockResults = pst2.executeBatch();

//System.out.println("PART_STOCK batch updated rows: " + partStockResults.length);
//System.out.println("PRINTER_PART_MIN_STOCK batch updated rows: " + printerPartMinStockResults.length);

if(pst1!=null){pst1.close();}
if(pst2!=null){pst2.close();}
con.close();
response.sendRedirect("partstock.do?branchid="+branchid+"&cid="+cartid+"&pmodel="+pmd);
%>
</form></BODY></HTML>