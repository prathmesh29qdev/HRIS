import java.util.*;
import MyBeans.DBConnection;
import java.text.*;
import java.io.*; 
import MyBeans.*;
import java.lang.*;
import java.sql.*;
import java.net.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.*;

public class PartUsage extends HttpServlet 
{
    public void init(ServletConfig config) throws ServletException
    {
    	 super.init(config);  
    }
    public void destroy() { }
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
		HttpSession ses=request.getSession(true);
		String u4brnlist=(String)ses.getAttribute("u4brnlist");

        MyBeans.convertDate dateformat=new MyBeans.convertDate();
		try
		{
			String baltype="used", v1="";
			long pmodelid=0, installtype=0, partid=0, branchid=0, enggid=0, datatype=0, stocktype=0;
			String dt1=request.getParameter("date1");
			String dt2=request.getParameter("date2");
			try{v1="";if((v1=request.getParameter("installtype"))!=null){installtype=Long.parseLong(v1);}}catch(Exception e){}
			try{v1="";if((v1=request.getParameter("cid"))!=null){partid=Long.parseLong(v1);}}catch(Exception e){}
			try{v1="";if((v1=request.getParameter("branchid"))!=null){branchid=Long.parseLong(v1);}}catch(Exception e){}
			try{v1="";if((v1=request.getParameter("wid"))!=null){enggid=Long.parseLong(v1);}}catch(Exception e){}
			try{v1="";if((v1=request.getParameter("baltype"))!=null){baltype=v1;}}catch(Exception e){}
			try{v1="";if((v1=request.getParameter("pmodelid"))!=null){pmodelid=Long.parseLong(v1);}}catch(Exception e){}
			try{v1="";if((v1=request.getParameter("datatype"))!=null){datatype=Long.parseLong(v1);}}catch(Exception e){}
			try{v1="";if((v1=request.getParameter("stocktype"))!=null){stocktype=Long.parseLong(v1);}}catch(Exception e){}
			long partid1=partid;
			int colcount=0;
			if(datatype==1){baltype="used";}
			else
			if(datatype==2){baltype="allot";}
			else
			if(datatype==3){baltype="deallot";}
			
			response.setContentType("application/vnd.ms-excel");
			HSSFWorkbook wb = new HSSFWorkbook();
			HSSFSheet sheet=null;
			if(baltype.equals("used"))
			{
				response.setHeader("Content-Disposition", "attachment; filename=Part Consumption Report.xls");
				sheet = wb.createSheet("Part Usage");
			}
			else
			if(baltype.equals("allot"))
			{
				response.setHeader("Content-Disposition", "attachment; filename=Part Allocation Report.xls");
				sheet = wb.createSheet("Part Allocation");
			}
			else
			if(baltype.equals("deallot"))
			{
				response.setHeader("Content-Disposition", "attachment; filename=Part De-Allocation Report.xls");
				sheet = wb.createSheet("Part Allocation");
			}
			
			OutputStream out = response.getOutputStream();
			
			HSSFFont f=wb.createFont();
			f.setFontHeightInPoints((short) 8);
			f.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
			
			HSSFCellStyle cs1=wb.createCellStyle();
			cs1.setFillForegroundColor(HSSFColor.LIGHT_YELLOW.index);
			cs1.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
			cs1.setBorderTop(HSSFCellStyle.BORDER_THIN); 
			cs1.setBorderLeft(HSSFCellStyle.BORDER_THIN); 
			cs1.setBorderBottom(HSSFCellStyle.BORDER_THIN); 
			cs1.setBorderRight(HSSFCellStyle.BORDER_THIN); 
			cs1.setFont(f);
			
			if(baltype.equals("used"))
			{
				// part install by engg or directly alloted to call
				HSSFRow row=sheet.createRow((short)0);
				row.createCell((short)colcount).setCellValue("SR.");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("TARGET USE");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("BRANCH");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("PART NAME");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("USED/NEW");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("QTY");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("CLIENT NAME");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("CLIENT LOCATION");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("CALL ID");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("PRINTER MODEL");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("PRINTER SERIAL");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("PART FROM ENGINEER STOCK");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("PART DEBIT FROM");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("PART TO CALL ALLOT BY");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("INSTALL DATE");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("INSTALLED BY / RETURNABLE BY");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("FAULTY RETURN");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("BRANCH RETURN DATE");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("BRANCH RETURN TIME");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("BRANCH RETURN BY");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("HO RETURN DATE");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("HO RETURN TIME");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("HO RETURN BY");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("CHECK STATUS");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("CHECK DATE");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("CHECK UPDATE BY");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("CHECK COMMENTS");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("CURRENT STATUS");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("RETURN STATUS");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("PURCHASE PRICE");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("SALE PRICE");  row.getCell((short)colcount++).setCellStyle(cs1);
				
				Connection con=DBConnection.getNewInstance().getConnection();
				Statement st1 = con.createStatement();
				ResultSet rs1=null;

				long sr=1, count=1, norecord=0, stock=0, tstock=0, index=1, minstock=0, colorcode=0, tmpid=0;
				long installid=0, callid=0, qty=0, returnstatus=0, saleprice=0, purchaseprice=0, pmodel=0;
				long cid=0, usedpart=0, frstatus=0, currentstatus=0, checkstatus=0, bid=0, eid=0;
				long tqty=0, tpurchaseprice=0, tsaleprice=0, repairprod=0, repairpartid=0;
				String str1="", str2="", str3="", partname="";
				String installdate="", installbyuser="", returnableby="", brnreturnatdate=""; 
				String horeturnatdate="", horeturntime="", checkdate="", checkupdateby="", brreturnedby=""; 
				String horeturnby="", brnreturntime="", brnreturnby="", comments="", cname="", cbranch="";
				String enggname="", partallottype="", pserial="", pmodelname="", branchname="";
				
				if(stocktype==1) // office stock
				{
					str1="SELECT pi.ID, pi.CALL_ID, pi.QTY, pi.INST_DATE, pi.FR_STATUS, pi.USER_ID, pi.PRICE, "+
						"pi.PURCHASE_PRICE, pi.USED_PART, pi.RETURNABLE_BY, c.name AS client_name, c.branch AS client_branch, "+
						"cr.P_SERIAL, pm.MODEL_NAME, pp.name AS part_name, b.CODE AS branch_code, "+
						"fe.execode AS engg_name, pr.FR_DATE, pr.FR_TIME, pr.FR_BY, pr.FR_STATUS, "+
						"pr.COMMENTS, pr.CHECK_DATE, pr.CURRENT_STATUS, pr.USER_ID, pr.CHECKED, "+
						"pr.HO_RECEIPT_DT, pr.HO_RECEIPT_TIME, pr.HO_RECEIPT_BY "+
						"FROM part_install pi "+
						"LEFT JOIN client c ON pi.CLIENT_ID = c.ID "+
						"LEFT JOIN CLIENT_REQUEST cr ON pi.CALL_ID = cr.CALL_ID "+
						"LEFT JOIN P_MODEL pm ON pi.PMODEL_ID = pm.ID "+
						"LEFT JOIN printer_part pp ON pi.PART_ID = pp.ID "+
						"LEFT JOIN BRANCH b ON pi.BR_ID = b.ID "+
						"LEFT JOIN field_executive fe ON pi.ENGG_ID = fe.exec_id AND fe.exe_type = 1 "+
						"LEFT JOIN part_return pr ON pi.ID = pr.install_id "+
						"WHERE pi.engg_id = 0 and pi.INST_DATE between '"+dt1+"' and '"+dt2+"' ";
					if(branchid!=0){str1+=" and pi.br_id="+branchid+"";}
					if(enggid!=0){str1+=" and pi.ENGG_ID="+enggid+"";}
					if(partid!=0){str1+=" and pi.PART_ID="+partid+"";}
					str1+=" order by inst_date";
				}
				else
				if(stocktype==2) // engineer stock
				{
					str1="SELECT pi.ID, pi.CALL_ID, pi.QTY, pi.INST_DATE, pi.FR_STATUS, pi.USER_ID, pi.PRICE, "+
						"pi.PURCHASE_PRICE, pi.USED_PART, pi.RETURNABLE_BY, c.name AS client_name, c.branch AS client_branch, "+
						"cr.P_SERIAL, pm.MODEL_NAME, pp.name AS part_name, b.CODE AS branch_code, "+
						"fe.execode AS engg_name, pr.FR_DATE, pr.FR_TIME, pr.FR_BY, pr.FR_STATUS, "+
						"pr.COMMENTS, pr.CHECK_DATE, pr.CURRENT_STATUS, pr.USER_ID, pr.CHECKED, "+
						"pr.HO_RECEIPT_DT, pr.HO_RECEIPT_TIME, pr.HO_RECEIPT_BY "+
						"FROM part_install pi "+
						"LEFT JOIN client c ON pi.CLIENT_ID = c.ID "+
						"LEFT JOIN CLIENT_REQUEST cr ON pi.CALL_ID = cr.CALL_ID "+
						"LEFT JOIN P_MODEL pm ON pi.PMODEL_ID = pm.ID "+
						"LEFT JOIN printer_part pp ON pi.PART_ID = pp.ID "+
						"LEFT JOIN BRANCH b ON pi.BR_ID = b.ID "+
						"LEFT JOIN BRANCH b ON pi.BR_ID = b.ID "+
						"LEFT JOIN field_executive fe ON pi.ENGG_ID = fe.exec_id AND fe.exe_type = 1 "+
						"LEFT JOIN part_return pr ON pi.ID = pr.install_id "+
						"WHERE pi.engg_id > 0 and pi.INST_DATE between '"+dt1+"' and '"+dt2+"' ";
					if(branchid!=0){str1+=" and pi.br_id="+branchid+"";}
					if(enggid!=0){str1+=" and pi.ENGG_ID="+enggid+"";}
					if(partid!=0){str1+=" and pi.PART_ID="+partid+"";}
					str1+=" order by inst_date";
				}
				
//System.out.println("used: "+str1);
				rs1=st1.executeQuery(str1);
				while(rs1.next())
				{
					norecord=1; partid=0; partname=""; pmodel=0;
					colcount=0; installid=0; callid=0; qty=0; returnstatus=0; saleprice=0; purchaseprice=0;
					cid=0; usedpart=0; frstatus=0; currentstatus=0; checkstatus=0; pmodel=0; bid=0; eid=0;
					installdate=""; installbyuser=""; returnableby=""; brnreturnatdate=""; 
					horeturnatdate=""; horeturntime=""; checkdate=""; checkupdateby=""; brreturnedby=""; 
					horeturnby=""; brnreturntime=""; brnreturnby=""; comments=""; cname=""; cbranch="";
					enggname=""; partallottype=""; pserial=""; pmodelname=""; branchname="";
					
					installid=rs1.getLong(1);
					callid=rs1.getLong(2);
					qty=rs1.getLong(3);
					v1="";if((v1=rs1.getString(4))!=null){installdate=v1;}
					returnstatus=rs1.getLong(5);
					v1="";if((v1=rs1.getString(6))!=null){installbyuser=v1;}
					saleprice=rs1.getLong(7);
					purchaseprice=rs1.getLong(8);
					usedpart=rs1.getLong(9);
					v1="";if((v1=rs1.getString(10))!=null){returnableby=v1;}
					v1="";if((v1=rs1.getString(11))!=null){cname=v1;}
					v1="";if((v1=rs1.getString(12))!=null){cbranch=v1;}
					v1="";if((v1=rs1.getString(13))!=null){pserial=v1;}
					v1="";if((v1=rs1.getString(14))!=null){pmodelname=v1;}
					v1="";if((v1=rs1.getString(15))!=null){partname=v1;}
					v1="";if((v1=rs1.getString(16))!=null){branchname=v1;}
					v1="";if((v1=rs1.getString(17))!=null){enggname=v1; partallottype="Engg. to service call installation"; } else {partallottype="Office to service call installation";}
					v1="";if((v1=rs1.getString(18))!=null){brnreturnatdate=v1;}
					v1="";if((v1=rs1.getString(19))!=null){brnreturntime=v1;}
					v1="";if((v1=rs1.getString(20))!=null){brnreturnby=v1;}
					frstatus=rs1.getLong(21);
					v1="";if((v1=rs1.getString(22))!=null){comments=v1;}
					v1="";if((v1=rs1.getString(23))!=null){checkdate=v1;}
					currentstatus=rs1.getLong(24);
					v1="";if((v1=rs1.getString(25))!=null){checkupdateby=v1;}
					checkstatus=rs1.getLong(26);
					v1="";if((v1=rs1.getString(27))!=null){horeturnatdate=v1;}
					v1="";if((v1=rs1.getString(28))!=null){horeturntime=v1;}
					v1="";if((v1=rs1.getString(29))!=null){horeturnby=v1;}
					
					try
					{
						tqty += qty;
						tsaleprice += saleprice;
						tpurchaseprice += purchaseprice;
					}
					catch(Exception e){}

					HSSFRow row1=sheet.createRow((short)count++);
					row1.createCell((short)colcount++).setCellValue(sr++);
					row1.createCell((short)colcount++).setCellValue(partallottype);
					row1.createCell((short)colcount++).setCellValue(branchname);
					row1.createCell((short)colcount++).setCellValue(partname);
					
					if(usedpart==1){row1.createCell((short)colcount++).setCellValue("Used");}
					else
					{row1.createCell((short)colcount++).setCellValue("New");}
					
					row1.createCell((short)colcount++).setCellValue(qty);
					row1.createCell((short)colcount++).setCellValue(cname);
					row1.createCell((short)colcount++).setCellValue(cbranch);
					row1.createCell((short)colcount++).setCellValue(callid);
					row1.createCell((short)colcount++).setCellValue(pmodelname);
					row1.createCell((short)colcount++).setCellValue(pserial);
					row1.createCell((short)colcount++).setCellValue(enggname);
					row1.createCell((short)colcount++).setCellValue(partallottype);
					row1.createCell((short)colcount++).setCellValue(installbyuser);
					row1.createCell((short)colcount++).setCellValue(dateformat.formatDate(installdate));
					row1.createCell((short)colcount++).setCellValue(returnableby);

					if(returnstatus==0){row1.createCell((short)colcount++).setCellValue("Pending");}
					else
					if(returnstatus==1){row1.createCell((short)colcount++).setCellValue("Branch Received");}
					else
					if(returnstatus==2){row1.createCell((short)colcount++).setCellValue("H.O. Received");}

					row1.createCell((short)colcount++).setCellValue(dateformat.formatDate(brnreturnatdate));
					row1.createCell((short)colcount++).setCellValue(brnreturntime);
					row1.createCell((short)colcount++).setCellValue(brreturnedby);
					row1.createCell((short)colcount++).setCellValue(dateformat.formatDate(horeturnatdate));
					row1.createCell((short)colcount++).setCellValue(horeturntime);
					row1.createCell((short)colcount++).setCellValue(horeturnby);
					
					if(checkstatus==1){row1.createCell((short)colcount++).setCellValue("Y");}
					else
					{row1.createCell((short)colcount++).setCellValue("N");}
					
					row1.createCell((short)colcount++).setCellValue(dateformat.formatDate(checkdate));
					row1.createCell((short)colcount++).setCellValue(checkupdateby);
					row1.createCell((short)colcount++).setCellValue(comments);

					if(currentstatus==0){row1.createCell((short)colcount++).setCellValue("");}
					else
					if(currentstatus==1){row1.createCell((short)colcount++).setCellValue("Usable");}
					else
					if(currentstatus==2){row1.createCell((short)colcount++).setCellValue("Repairable");}
					else
					if(currentstatus==3){row1.createCell((short)colcount++).setCellValue("Scrape");}
					else
					if(currentstatus==4){row1.createCell((short)colcount++).setCellValue("Scrapped");}

					if(frstatus==0){row1.createCell((short)colcount++).setCellValue("");}
					else
					if(frstatus==1){row1.createCell((short)colcount++).setCellValue("Usable");}
					else
					if(frstatus==2){row1.createCell((short)colcount++).setCellValue("Repairable");}
					else
					if(frstatus==3){row1.createCell((short)colcount++).setCellValue("Scrape");}

					row1.createCell((short)colcount++).setCellValue(purchaseprice);
					row1.createCell((short)colcount++).setCellValue(saleprice);
				}

				if(stocktype==1) // office stock
				{
					// printer & part repair  part consumption
					str1="SELECT pr.serial, pr.rep_date, pr.user_id, pr.REPAIR_PROD, pr.CALL_ID, "+
					   "prp.qty, pm.MODEL_NAME, pp1.name AS part_name, pp2.name AS repair_part_name, "+
					   "b.CODE AS branch_name, fe.execode AS engg_name "+
					   "FROM printer_repair pr "+
					   "INNER JOIN printer_repair_part prp ON pr.id = prp.prep_id "+
					   "LEFT JOIN P_MODEL pm ON prp.pmodel_id = pm.ID "+
					   "LEFT JOIN printer_part pp1 ON prp.PART_ID = pp1.ID "+
					   "LEFT JOIN printer_part pp2 ON prp.PART_ID = pp2.ID "+
					   "LEFT JOIN BRANCH b ON pr.br_id = b.ID "+
					   "LEFT JOIN field_executive fe ON pr.engg = fe.exec_id AND fe.exe_type = 1 "+
					   "WHERE pr.rep_date BETWEEN '"+dt1+"' AND '"+dt2+"' ";
					if (branchid != 0) { str1 += " AND pr.br_id = " + branchid; }
					if (enggid != 0) { str1 += " AND pr.engg = " + enggid; }
					if (partid1 != 0) { str1 += " AND prp.PART_ID = " + partid1; }
					
					str1 += " ORDER BY pr.rep_date";
	//System.out.println(str1);
					rs1=st1.executeQuery(str1);
					while(rs1.next())
					{
						norecord=1; partid=0; partname=""; pmodel=0;
						colcount=0; installid=0; callid=0; qty=0; returnstatus=0; saleprice=0; purchaseprice=0;
						cid=0; usedpart=0; frstatus=0; currentstatus=0; checkstatus=0; pmodel=0; bid=0; eid=0;
						installdate=""; installbyuser=""; returnableby=""; brnreturnatdate=""; 
						horeturnatdate=""; horeturntime=""; checkdate=""; checkupdateby=""; brreturnedby=""; 
						horeturnby=""; brnreturntime=""; brnreturnby=""; comments=""; cname=""; cbranch="";
						enggname=""; partallottype=""; pserial=""; pmodelname=""; branchname="";
						repairprod=0; repairpartid=0;
					
						v1="";if((v1=rs1.getString(1))!=null){pserial=v1;}
						v1="";if((v1=rs1.getString(2))!=null){installdate=v1;}
						v1="";if((v1=rs1.getString(3))!=null){installbyuser=v1;}
						repairprod=rs1.getLong(4);
						callid=rs1.getLong(5);
						qty=rs1.getLong(6);
						v1="";if((v1=rs1.getString(7))!=null){pmodelname=v1;}
						v1="";if((v1=rs1.getString(8))!=null){partname=v1;}
						v1="";if((v1=rs1.getString(9))!=null){pmodelname=v1+" - "+pmodelname;}
						v1="";if((v1=rs1.getString(10))!=null){branchname=v1;}
						v1="";if((v1=rs1.getString(11))!=null){enggname=v1;}
						
						try{tqty += qty;}catch(Exception e){}
						partallottype="In-house repair";
						
						HSSFRow row1=sheet.createRow((short)count++);
						row1.createCell((short)colcount++).setCellValue(sr++);
						if(repairprod==1)
						{
							row1.createCell((short)colcount++).setCellValue("Printer Repair In-house");
						}
						else
						if(repairprod==2)
						{
							row1.createCell((short)colcount++).setCellValue("Part Repair In-house");
						}
						else
						{
							row1.createCell((short)colcount++).setCellValue("");
						}
						row1.createCell((short)colcount++).setCellValue(branchname);
						row1.createCell((short)colcount++).setCellValue(partname);
						
						if(usedpart==1){row1.createCell((short)colcount++).setCellValue("Used");}
						else
						{row1.createCell((short)colcount++).setCellValue("New");}
						
						row1.createCell((short)colcount++).setCellValue(qty);
						row1.createCell((short)colcount++).setCellValue(cname);
						row1.createCell((short)colcount++).setCellValue(cbranch);
						row1.createCell((short)colcount++).setCellValue(callid);
						row1.createCell((short)colcount++).setCellValue(pmodelname);
						row1.createCell((short)colcount++).setCellValue(pserial);
						row1.createCell((short)colcount++).setCellValue(enggname);
						row1.createCell((short)colcount++).setCellValue(partallottype);
						row1.createCell((short)colcount++).setCellValue(installbyuser);
						row1.createCell((short)colcount++).setCellValue(dateformat.formatDate(installdate));
						row1.createCell((short)colcount++).setCellValue(returnableby);
						row1.createCell((short)colcount++).setCellValue("N/A");
						row1.createCell((short)colcount++).setCellValue("");
						row1.createCell((short)colcount++).setCellValue("");
						row1.createCell((short)colcount++).setCellValue("");
						row1.createCell((short)colcount++).setCellValue("");
						row1.createCell((short)colcount++).setCellValue("");
						row1.createCell((short)colcount++).setCellValue("");
						row1.createCell((short)colcount++).setCellValue("");
						row1.createCell((short)colcount++).setCellValue("");
						row1.createCell((short)colcount++).setCellValue("");
						row1.createCell((short)colcount++).setCellValue("");
						row1.createCell((short)colcount++).setCellValue("");
						row1.createCell((short)colcount++).setCellValue("");
						row1.createCell((short)colcount++).setCellValue("");
						row1.createCell((short)colcount++).setCellValue("");
					}
				}
				else
				if(stocktype==2){} // engineer stock (not applicable for inhouse repair
				
				colcount=0;
				HSSFRow row2=sheet.createRow((short)count++);
				row2.createCell((short)colcount).setCellValue("Total"); row2.getCell((short)colcount++).setCellStyle(cs1);
				row2.createCell((short)colcount).setCellValue(""); row2.getCell((short)colcount++).setCellStyle(cs1);
				row2.createCell((short)colcount).setCellValue(""); row2.getCell((short)colcount++).setCellStyle(cs1);
				row2.createCell((short)colcount).setCellValue(""); row2.getCell((short)colcount++).setCellStyle(cs1);
				row2.createCell((short)colcount).setCellValue(""); row2.getCell((short)colcount++).setCellStyle(cs1);
				row2.createCell((short)colcount).setCellValue(tqty); row2.getCell((short)colcount++).setCellStyle(cs1);
				row2.createCell((short)colcount).setCellValue(""); row2.getCell((short)colcount++).setCellStyle(cs1);
				row2.createCell((short)colcount).setCellValue(""); row2.getCell((short)colcount++).setCellStyle(cs1);
				row2.createCell((short)colcount).setCellValue(""); row2.getCell((short)colcount++).setCellStyle(cs1);
				row2.createCell((short)colcount).setCellValue(""); row2.getCell((short)colcount++).setCellStyle(cs1);
				row2.createCell((short)colcount).setCellValue(""); row2.getCell((short)colcount++).setCellStyle(cs1);
				row2.createCell((short)colcount).setCellValue(""); row2.getCell((short)colcount++).setCellStyle(cs1);
				row2.createCell((short)colcount).setCellValue(""); row2.getCell((short)colcount++).setCellStyle(cs1);
				row2.createCell((short)colcount).setCellValue(""); row2.getCell((short)colcount++).setCellStyle(cs1);
				row2.createCell((short)colcount).setCellValue(""); row2.getCell((short)colcount++).setCellStyle(cs1);
				row2.createCell((short)colcount).setCellValue(""); row2.getCell((short)colcount++).setCellStyle(cs1);
				row2.createCell((short)colcount).setCellValue(""); row2.getCell((short)colcount++).setCellStyle(cs1);
				row2.createCell((short)colcount).setCellValue(""); row2.getCell((short)colcount++).setCellStyle(cs1);
				row2.createCell((short)colcount).setCellValue(""); row2.getCell((short)colcount++).setCellStyle(cs1);
				row2.createCell((short)colcount).setCellValue(""); row2.getCell((short)colcount++).setCellStyle(cs1);
				row2.createCell((short)colcount).setCellValue(""); row2.getCell((short)colcount++).setCellStyle(cs1);
				row2.createCell((short)colcount).setCellValue(""); row2.getCell((short)colcount++).setCellStyle(cs1);
				row2.createCell((short)colcount).setCellValue(""); row2.getCell((short)colcount++).setCellStyle(cs1);
				row2.createCell((short)colcount).setCellValue(""); row2.getCell((short)colcount++).setCellStyle(cs1);
				row2.createCell((short)colcount).setCellValue(""); row2.getCell((short)colcount++).setCellStyle(cs1);
				row2.createCell((short)colcount).setCellValue(""); row2.getCell((short)colcount++).setCellStyle(cs1);
				row2.createCell((short)colcount).setCellValue(""); row2.getCell((short)colcount++).setCellStyle(cs1);
				row2.createCell((short)colcount).setCellValue(""); row2.getCell((short)colcount++).setCellStyle(cs1);
				row2.createCell((short)colcount).setCellValue(""); row2.getCell((short)colcount++).setCellStyle(cs1);
				row2.createCell((short)colcount).setCellValue(tpurchaseprice); row2.getCell((short)colcount++).setCellStyle(cs1);
				row2.createCell((short)colcount).setCellValue(tsaleprice); row2.getCell((short)colcount++).setCellStyle(cs1);
			
				wb.write(out); out.close(); 
				
				if(rs1!=null){rs1.close();}
				if(st1!=null){st1.close();}
				con.close();
			}
			else
			if(baltype.equals("allot"))
			{
				// part allotment to engg or directly to call
				HSSFRow row=sheet.createRow((short)0);
				row.createCell((short)colcount).setCellValue("SR.");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("DATE");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("TIME");  row.getCell((short)colcount++).setCellStyle(cs1);
				if(stocktype==1)
				{
					row.createCell((short)colcount).setCellValue("BRANCH");  row.getCell((short)colcount++).setCellStyle(cs1);
				}
				else
				if(stocktype==2)
				{
					row.createCell((short)colcount).setCellValue("ENGINEER");  row.getCell((short)colcount++).setCellStyle(cs1);
				}
				row.createCell((short)colcount).setCellValue("SOURCE");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("PART");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("PRINTER");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("QTY");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("ALLOTED BY");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("CALL ID");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("TRANSFER DATE");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("TRANSFER TIME");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("TRANSFER_BY");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("TRASFER QTY");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("FROM PRINTER");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("TO PRINTER");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("FROM BRANCH");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("TO BRANCH");  row.getCell((short)colcount++).setCellStyle(cs1);
				
				Connection con=DBConnection.getNewInstance().getConnection();
				Statement st1 = con.createStatement();
				ResultSet rs1=null;

				long sr=1, count=1, norecord=0, P_ID=0, ENG_NAME=0, PMODEL_ID=0, colorcode=0, INWARD=0, CALL_ID=0, SRC=0;
				String str1="", str2="", str3="", partname="", pmodelname="", enggname="", srcname="";
				String USED_DATE="", STOCK_TIME="", USER_ID="", xferfrombranch="", xfertobranch="",  branchname="";;
				String xferdate="", xfertime="", xferby="", xferqty="", xferfrommodel="", xfertomodel="";
				
				if(stocktype==1)
				{
					str1 = "SELECT ps.INWARD, ps.TR_DATE as USED_DATE, pi.CALL_ID, '00:00 AM' as STOCK_TIME, " +
						   "ps.SRC, ps.USER_ID, pm.MODEL_NAME, pp.name as PART_NAME, fe.execode, " +
						   "psx.transfer_date, psx.transfer_time, psx.transfer_by, psx.qty as xfer_qty, " +
						   "pm1.model_name as from_printer_model, pm2.model_name as to_printer_model, " +
						   "br.name as branch_name, br1.name as from_branch, br2.name as to_branch FROM PART_STOCK ps " +
						   "LEFT JOIN P_MODEL pm ON ps.PMODEL_ID = pm.ID " +
						   "LEFT JOIN printer_part pp ON ps.mat_id = pp.ID " +
						   "LEFT JOIN part_install pi ON ps.install_id = pi.ID " +
						   "LEFT JOIN ENG_STOCK_DETAILS esd ON ps.engg_stock_id = esd.id " +
						   "LEFT JOIN field_executive fe ON esd.ENG_NAME = fe.exec_id AND fe.exe_type = 1 " +
						   "LEFT JOIN PART_STOCK_XFER psx ON ps.id = psx.to_stock_id and psx.transfer_type = 1 " +
						   "LEFT JOIN P_MODEL pm1 ON psx.FROM_PRINTER_ID = pm1.ID " +
						   "LEFT JOIN P_MODEL pm2 ON psx.TO_PRINTER_ID = pm2.ID " +
						   "LEFT JOIN BRANCH br ON ps.BR_ID = br.ID " +
						   "LEFT JOIN BRANCH br1 ON psx.FROM_BR_ID = br1.ID " +
						   "LEFT JOIN BRANCH br2 ON psx.TO_BR_ID = br2.ID " +
						   "WHERE ps.INWARD > 0 AND ps.SRC in(1, 4, 5, 7, 9) AND ps.TR_DATE BETWEEN '" + dt1 + "' AND '" + dt2 + "'";
					if (enggid != 0) { str1 += " AND esd.ENG_NAME = " + enggid; } 
					if (partid != 0) { str1 += " AND ps.mat_id = " + partid; } 
					if (pmodelid != 0) { str1 += " AND ps.PMODEL_ID = " + pmodelid; } 
					str1 += " ORDER BY ps.TR_DATE";
				}
				else
				if(stocktype==2)
				{
					str1 = "SELECT esd.INWARD, esd.USED_DATE, esd.CALL_ID, esd.STOCK_TIME, " +
						   "esd.SRC, esd.USER_ID, pm.MODEL_NAME, pp.name as PART_NAME, fe.execode, " +
						   "psx.transfer_date, psx.transfer_time, psx.transfer_by, psx.qty as xfer_qty, " +
						   "pm1.model_name as from_printer_model, pm2.model_name as to_printer_model, " +
						   "'-' as branch_name, br1.name as from_branch, br2.name as to_branch FROM ENG_STOCK_DETAILS esd " +
						   "LEFT JOIN P_MODEL pm ON esd.PMODEL_ID = pm.ID " +
						   "LEFT JOIN printer_part pp ON esd.P_ID = pp.ID " +
						   "LEFT JOIN field_executive fe ON esd.ENG_NAME = fe.exec_id AND fe.exe_type = 1 " +
						   "LEFT JOIN PART_STOCK_XFER psx ON esd.id = psx.to_stock_id and psx.transfer_type = 2 " +
						   "LEFT JOIN P_MODEL pm1 ON psx.FROM_PRINTER_ID = pm1.ID " +
						   "LEFT JOIN P_MODEL pm2 ON psx.TO_PRINTER_ID = pm2.ID " +
						   "LEFT JOIN BRANCH br1 ON psx.FROM_BR_ID = br1.ID " +
						   "LEFT JOIN BRANCH br2 ON psx.TO_BR_ID = br2.ID " +
						   "WHERE esd.INWARD > 0 AND esd.SRC in(1,3,5) AND esd.USED_DATE BETWEEN '" + dt1 + "' AND '" + dt2 + "'";
					if (enggid != 0) { str1 += " AND esd.ENG_NAME = " + enggid; } 
					if (partid != 0) { str1 += " AND esd.P_ID = " + partid; } 
					if (pmodelid != 0) { str1 += " AND esd.PMODEL_ID = " + pmodelid; } 
					str1 += " ORDER BY esd.USED_DATE";
				}
//System.out.println("allot: "+str1);
				rs1 = st1.executeQuery(str1);
				while (rs1.next()) 
				{
					norecord=1; colcount=0; P_ID=0; ENG_NAME=0; PMODEL_ID=0; INWARD=0; CALL_ID=0; SRC=0;
					USED_DATE=""; STOCK_TIME=""; USER_ID=""; partname=""; pmodelname=""; enggname=""; srcname="";
					xferdate=""; xfertime=""; xferby=""; xferqty=""; xferfrommodel=""; xfertomodel=""; branchname="";
					xferfrombranch=""; xfertobranch="";
					
					INWARD = rs1.getLong("INWARD");
					USED_DATE = rs1.getString("USED_DATE");
					CALL_ID = rs1.getLong("CALL_ID");
					STOCK_TIME = rs1.getString("STOCK_TIME");
					SRC = rs1.getLong("SRC");
					USER_ID = rs1.getString("USER_ID");
					pmodelname = rs1.getString("MODEL_NAME");
					partname = rs1.getString("PART_NAME");
					enggname = rs1.getString("execode");
					v1="";if((v1=rs1.getString("TRANSFER_DATE"))!=null){xferdate=v1;}
					v1="";if((v1=rs1.getString("TRANSFER_TIME"))!=null){xfertime=v1;}
					v1="";if((v1=rs1.getString("TRANSFER_BY"))!=null){xferby=v1;}
					v1="";if((v1=rs1.getString("XFER_QTY"))!=null){xferqty=v1;}
					v1="";if((v1=rs1.getString("FROM_PRINTER_MODEL"))!=null){xferfrommodel=v1;}
					v1="";if((v1=rs1.getString("TO_PRINTER_MODEL"))!=null){xfertomodel=v1;}
					v1="";if((v1=rs1.getString("BRANCH_NAME"))!=null){branchname=v1;}
					v1="";if((v1=rs1.getString("FROM_BRANCH"))!=null){xferfrombranch=v1;}
					v1="";if((v1=rs1.getString("TO_BRANCH"))!=null){xfertobranch=v1;}

					if(stocktype==1)
					{
						if (SRC == 1) {srcname = "Purchase or Allocation"; } 
						else 
						if (SRC == 4) {srcname = "Reversed from engineer de-allocation";} 
						else 
						if (SRC == 5) { srcname = "Transfer between printer"; }
						else 
						if (SRC == 7) {srcname = "Faulty part returned entered to stock as found working";} 
						else 
						if (SRC == 9) {srcname = "Transfer between branches";}
					}
					else
					if(stocktype==2)
					{
						if (SRC == 1) {srcname = "Allocation"; } 
						else 
						if (SRC == 2) {srcname = "Installation";} 
						else 
						if (SRC == 3) { srcname = "Un-installed Part returned from call"; }
						else 
						if (SRC == 4) {srcname = "De-allocation";} 
						else 
						if (SRC == 5) {srcname = "Transfer between printer";}
					}

					HSSFRow row1 = sheet.createRow((short) count++);
					row1.createCell((short) colcount++).setCellValue(sr++);
					row1.createCell((short) colcount++).setCellValue(dateformat.formatDate(USED_DATE));
					row1.createCell((short) colcount++).setCellValue(STOCK_TIME);
					if(stocktype==1)
					{
						row1.createCell((short) colcount++).setCellValue(branchname);
					}
					else
					if(stocktype==2)
					{
						row1.createCell((short) colcount++).setCellValue(enggname);
					}
					row1.createCell((short) colcount++).setCellValue(srcname);
					row1.createCell((short) colcount++).setCellValue(partname);
					row1.createCell((short) colcount++).setCellValue(pmodelname);
					row1.createCell((short) colcount++).setCellValue(INWARD);
					row1.createCell((short) colcount++).setCellValue(USER_ID);
					row1.createCell((short) colcount++).setCellValue(CALL_ID);
					row1.createCell((short) colcount++).setCellValue(dateformat.formatDate(xferdate));
					row1.createCell((short) colcount++).setCellValue(xfertime);
					row1.createCell((short) colcount++).setCellValue(xferby);
					row1.createCell((short) colcount++).setCellValue(xferqty);
					row1.createCell((short) colcount++).setCellValue(xferfrommodel);
					row1.createCell((short) colcount++).setCellValue(xfertomodel);
					row1.createCell((short) colcount++).setCellValue(xferfrombranch);
					row1.createCell((short) colcount++).setCellValue(xfertobranch);
				}
				
				wb.write(out); out.close(); 
				
				if(rs1!=null){rs1.close();}
				if(st1!=null){st1.close();}
				con.close();
			}
			else
			if(baltype.equals("deallot"))
			{
				// part de-allotment from engg or reverted from call
				HSSFRow row=sheet.createRow((short)0);
				row.createCell((short)colcount).setCellValue("SR.");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("DATE");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("TIME");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("ENGINEER");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("SOURCE");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("PART");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("PRINTER");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("QTY");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("ALLOTED BY");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("CALL ID");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("TRANSFER DATE");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("TRANSFER TIME");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("TRANSFER_BY");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("TRASFER QTY");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("FROM PRINTER");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("TO PRINTER");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("FROM BRANCH");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("TO BRANCH");  row.getCell((short)colcount++).setCellStyle(cs1);
				
				Connection con=DBConnection.getNewInstance().getConnection();
				Statement st1 = con.createStatement();
				ResultSet rs1=null;

				long sr=1, count=1, norecord=0, P_ID=0, ENG_NAME=0, PMODEL_ID=0, colorcode=0, INWARD=0, CALL_ID=0, SRC=0;
				String str1="", str2="", str3="", partname="", pmodelname="", enggname="", srcname="";
				String USED_DATE="", STOCK_TIME="", USER_ID="", xferfrombranch="", xfertobranch="", branchname="";; 
				String xferdate="", xfertime="", xferby="", xferqty="", xferfrommodel="", xfertomodel="";
					
				if(stocktype==1)
				{
					str1 = "SELECT ps.OUTWARD, ps.TR_DATE as USED_DATE, pi.CALL_ID, '00:00 AM' as STOCK_TIME, " +
						   "ps.SRC, ps.USER_ID, PP.name AS partname, PM.MODEL_NAME AS pmodelname, " +
						   "fe.execode AS enggname, psx.transfer_date, psx.transfer_time, psx.transfer_by, " +
						   "psx.qty as xfer_qty, pm1.model_name as from_printer_model, pm2.model_name as to_printer_model, " +
						   "br.name as branch_name, br1.name as from_branch, br2.name as to_branch FROM PART_STOCK ps " +
						   "LEFT JOIN P_MODEL pm ON ps.PMODEL_ID = pm.ID " +
						   "LEFT JOIN printer_part pp ON ps.mat_id = pp.ID " +
						   "LEFT JOIN part_install pi ON ps.install_id = pi.ID " +
						   "LEFT JOIN ENG_STOCK_DETAILS esd ON ps.engg_stock_id = esd.id " +
						   "LEFT JOIN field_executive fe ON esd.ENG_NAME = fe.exec_id AND fe.exe_type = 1 " +
						   "LEFT JOIN PART_STOCK_XFER psx ON ps.id = psx.from_stock_id and psx.transfer_type = 1 " +
						   "LEFT JOIN P_MODEL pm1 ON psx.FROM_PRINTER_ID = pm1.ID " +
						   "LEFT JOIN P_MODEL pm2 ON psx.TO_PRINTER_ID = pm2.ID " +
						   "LEFT JOIN BRANCH br ON ps.BR_ID = br.ID " +
						   "LEFT JOIN BRANCH br1 ON psx.FROM_BR_ID = br1.ID " +
						   "LEFT JOIN BRANCH br2 ON psx.TO_BR_ID = br2.ID " +
						   "WHERE ps.OUTWARD > 0 AND ps.SRC in(2, 5, 9) AND ps.TR_DATE BETWEEN '" + dt1 + "' AND '" + dt2 + "'";
					if (enggid != 0) { str1 += " AND esd.ENG_NAME = " + enggid; } 
					if (partid != 0) { str1 += " AND ps.mat_id = " + partid; } 
					if (pmodelid != 0) { str1 += " AND ps.PMODEL_ID = " + pmodelid; } 
					str1 += " ORDER BY ps.TR_DATE";
				}
				else
				if(stocktype==2)
				{
					str1 = "SELECT ESD.OUTWARD, ESD.USED_DATE, ESD.CALL_ID, ESD.STOCK_TIME, "+
						   "ESD.SRC, ESD.USER_ID, PP.name AS partname, PM.MODEL_NAME AS pmodelname, "+
						   "FE.execode AS enggname, psx.transfer_date, psx.transfer_time, psx.transfer_by, " +
						   "psx.qty as xfer_qty, pm1.model_name as from_printer_model, pm2.model_name as TO_PRINTER_MODEL, " +
						   "'-' as branch_name, br1.name as from_branch, br2.name as to_branch FROM ENG_STOCK_DETAILS ESD " +
						   "LEFT JOIN printer_part PP ON ESD.P_ID = PP.ID " +
						   "LEFT JOIN P_MODEL PM ON ESD.PMODEL_ID = PM.ID " +
						   "LEFT JOIN field_executive FE ON ESD.ENG_NAME = FE.exec_id AND FE.exe_type = 1 " +
						   "LEFT JOIN PART_STOCK_XFER psx ON esd.id = psx.from_stock_id and psx.transfer_type = 2 " +
						   "LEFT JOIN P_MODEL pm1 ON psx.FROM_PRINTER_ID = pm1.ID " +
						   "LEFT JOIN P_MODEL pm2 ON psx.TO_PRINTER_ID = pm2.ID " +
						   "LEFT JOIN BRANCH br1 ON psx.FROM_BR_ID = br1.ID " +
						   "LEFT JOIN BRANCH br2 ON psx.TO_BR_ID = br2.ID " +
						   "WHERE ESD.OUTWARD > 0 AND ESD.SRC IN (4, 5) AND ESD.USED_DATE BETWEEN '" + dt1 + "' AND '" + dt2 + "'";
					if (enggid != 0) { str1 += " AND ESD.ENG_NAME = " + enggid; } 
					if (partid != 0) { str1 += " AND ESD.P_ID = " + partid; } 
					if (pmodelid != 0) { str1 += " AND ESD.PMODEL_ID = " + pmodelid; } 
					str1 += " ORDER BY ESD.USED_DATE";
				}
//System.out.println("de-allot: "+str1);
				rs1=st1.executeQuery(str1);
				while(rs1.next())
				{
					norecord=1; colcount=0; P_ID=0; ENG_NAME=0; PMODEL_ID=0; INWARD=0; CALL_ID=0; SRC=0;
					USED_DATE=""; STOCK_TIME=""; USER_ID=""; partname=""; pmodelname=""; enggname=""; srcname="";
					xferdate=""; xfertime=""; xferby=""; xferqty=""; xferfrommodel=""; xfertomodel=""; branchname="";
					xferfrombranch=""; xfertobranch="";
					
					INWARD = rs1.getLong("OUTWARD");
					USED_DATE = rs1.getString("USED_DATE");
					CALL_ID = rs1.getLong("CALL_ID");
					STOCK_TIME = rs1.getString("STOCK_TIME");
					SRC = rs1.getLong("SRC");
					USER_ID = rs1.getString("USER_ID");
					pmodelname = rs1.getString("pmodelname");
					partname = rs1.getString("partname");
					enggname = rs1.getString("enggname");
					v1="";if((v1=rs1.getString("TRANSFER_DATE"))!=null){xferdate=v1;}
					v1="";if((v1=rs1.getString("TRANSFER_TIME"))!=null){xfertime=v1;}
					v1="";if((v1=rs1.getString("TRANSFER_BY"))!=null){xferby=v1;}
					v1="";if((v1=rs1.getString("XFER_QTY"))!=null){xferqty=v1;}
					v1="";if((v1=rs1.getString("FROM_PRINTER_MODEL"))!=null){xferfrommodel=v1;}
					v1="";if((v1=rs1.getString("TO_PRINTER_MODEL"))!=null){xfertomodel=v1;}
					v1="";if((v1=rs1.getString("BRANCH_NAME"))!=null){branchname=v1;}
					v1="";if((v1=rs1.getString("FROM_BRANCH"))!=null){xferfrombranch=v1;}
					v1="";if((v1=rs1.getString("TO_BRANCH"))!=null){xfertobranch=v1;}

					if(stocktype==1)
					{
						if (SRC == 2) {srcname = "Allocation to engineer"; } 
						else 
						if (SRC == 5) { srcname = "Transfer between printer"; }
						else 
						if (SRC == 9) {srcname = "Transfer between branches";}
					}
					else
					if(stocktype==2)
					{
						if(SRC==1){srcname="Allocation";}
						else
						if(SRC==2){srcname="Installation";}
						else
						if(SRC==3){srcname="Part returned";}
						else
						if(SRC==4){srcname="De-allocation";}
						else
						if(SRC==5){srcname="Stock transfer between printer model";}
					}
					
					HSSFRow row1=sheet.createRow((short)count++);
					row1.createCell((short)colcount++).setCellValue(sr++);
					row1.createCell((short)colcount++).setCellValue(dateformat.formatDate(USED_DATE));
					row1.createCell((short)colcount++).setCellValue(STOCK_TIME);
					if(stocktype==1)
					{
						row1.createCell((short) colcount++).setCellValue(branchname);
					}
					else
					if(stocktype==2)
					{
						row1.createCell((short) colcount++).setCellValue(enggname);
					}
					row1.createCell((short)colcount++).setCellValue(srcname);
					row1.createCell((short)colcount++).setCellValue(partname);
					row1.createCell((short)colcount++).setCellValue(pmodelname);
					row1.createCell((short)colcount++).setCellValue(INWARD);
					row1.createCell((short)colcount++).setCellValue(USER_ID);
					row1.createCell((short)colcount++).setCellValue(CALL_ID);
					row1.createCell((short) colcount++).setCellValue(dateformat.formatDate(xferdate));
					row1.createCell((short) colcount++).setCellValue(xfertime);
					row1.createCell((short) colcount++).setCellValue(xferby);
					row1.createCell((short) colcount++).setCellValue(xferqty);
					row1.createCell((short) colcount++).setCellValue(xferfrommodel);
					row1.createCell((short) colcount++).setCellValue(xfertomodel);
					row1.createCell((short) colcount++).setCellValue(xferfrombranch);
					row1.createCell((short) colcount++).setCellValue(xfertobranch);
				}
				
				wb.write(out); out.close(); 
				
				if(rs1!=null){rs1.close();}
				if(st1!=null){st1.close();}
				con.close();
			}
			
		}//end of try
		catch(Exception e)
		{
			e.getMessage();
			e.printStackTrace();
		}
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
		processRequest(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
		processRequest(request, response);
    }
    public String getServletInfo() 
    {
       return "Example to create a workbook in a servlet using HSSF";
    }
}