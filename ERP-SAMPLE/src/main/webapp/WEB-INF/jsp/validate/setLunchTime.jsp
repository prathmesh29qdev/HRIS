<%-- <jsp:useBean id="dateutil" scope="request" class="MyBeans.npd" /> --%>
<%@ page language="java" import="MyBeans.*, java.sql.*, java.net.*, java.util.Date, java.io.*, java.text.DateFormat, java.text.SimpleDateFormat"%>
<%-- <%@ page import="java.util.*, jakarta.mail.*, jakarta.mail.internet.*, jakarta.activation.*, com.Util.PasswordGenerator, java.util.Random" %> --%>
<%@ page import="java.util.*, jakarta.mail.*, jakarta.mail.internet.*, jakarta.activation.*, java.util.Random" %>
<%
String validate="NO", v1="", loginid = "";

DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd:HH:mm:ss");
Date dat = new Date();
String dt = dateFormat.format(dat);
String date = dt.substring(0, 10);
String time = dt.substring(11, 19);

String BR_DATE="", START_TIME="", END_TIME="", BRTIME="", str="", dt1="", dt2="";
long ID=0, status=0, min=0;

try
{
	Connection con=DBConnection.getNewInstance().getConnection();
	Statement stat=con.createStatement();
	PreparedStatement pst1=null;
	ResultSet rs=null;
	
	str="select BR_DATE, START_TIME, END_TIME, ID from BREAK_TIME where BR_DATE='"+date+"' AND USERNAME='"+loginid.toUpperCase()+"'";
	rs=stat.executeQuery(str);
	if(!rs.next())
	{
		pst1=con.prepareStatement("insert into BREAK_TIME(ID, BR_TYPE, BR_DATE, START_TIME, USERNAME, STATUS) values(BREAK_TIME_SEQ.nextval, ?, ?, ?, ?, ?)");
		pst1.setLong(1, 0);
		pst1.setString(2, date);
		pst1.setString(3, time);
		pst1.setString(4, loginid.toUpperCase());
		pst1.setLong(5, 1);
		pst1.executeUpdate();
		status=1;
	}
	else
	{
		str="select BR_DATE, START_TIME, END_TIME, ID from BREAK_TIME where STATUS=1 AND BR_DATE='"+date+"' AND USERNAME='"+loginid.toUpperCase()+"'";
		rs=stat.executeQuery(str);
		if(rs.next())
		{
			v1=""; if((v1=rs.getString(1))!=null){BR_DATE=v1;}
			v1=""; if((v1=rs.getString(2))!=null){START_TIME=v1;}
			v1=""; if((v1=rs.getString(3))!=null){END_TIME=v1;}
			ID=rs.getLong(4);
			
			BR_DATE=BR_DATE.replace("-", ":");
			
			dt1=BR_DATE+" "+START_TIME;
			dt2=BR_DATE+" "+time;
			
// 			BRTIME=dateutil.timeDiffBetweenDate(dt1, dt2);
			
			try{ min=Long.parseLong(BRTIME.substring(3,5)); }catch(Exception e){}
			
			if(min>7)
			{
				try
				{
					pst1=con.prepareStatement("update BREAK_TIME set END_TIME=?, BR_TIME=?, STATUS=? WHERE ID=?");
					pst1.setString(1, time);
					pst1.setString(2, BRTIME);
					pst1.setLong(3, 2);
					pst1.setLong(4, ID);
					pst1.executeUpdate();
					status=2;
				}
				catch(Exception e){}
			}
			else
			{
				status=1;
			}
		}
	}
	
	if(pst1!=null){pst1.close();}
	if(rs!=null){rs.close();}
	if(stat!=null){stat.close();}
	con.close();
}
catch(Exception e){}

if(status==1)
{
	%><input type="button" name="brkbtn" id="brkbtn" value="End Lunch Break" onClick="updateLunchTime(2)" style="background-color: white;color: black;border: 2px solid red;"><%
}
else
if(status==2)
{
	%><input type="button" name="brkbtn" id="brkbtn" value="Lunch Break: <%=BRTIME%>" onClick="" style="background-color: white;color: black;border: 2px solid #4CAF50;"><%
}
else
{
	%><input type="button" name="brkbtn" id="brkbtn" value="Start Lunch Break" onClick="updateLunchTime(1)" style="background-color: white;color: black;border: 2px solid #4CAF50;"><%
}
%>
