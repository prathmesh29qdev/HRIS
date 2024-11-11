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

public class PartStatement extends HttpServlet 
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
			Connection con=DBConnection.getNewInstance().getConnection();
			Statement st1 = con.createStatement();
			Statement st2 = con.createStatement();
			ResultSet rs1=null, rs2=null;

			String username="", partname="", pmodelname="", branch="", trdate="", exptype="", srcname="", brcode=""; 
			long inward=0, outward=0, balance=0, src=0, purchaseid=0, estockid=0, prepairid=0, callid=0, pmodel=0; 
			long fcreturnid=0, installid=0, recid=0, openstock=0, pmodelid=0, partid=0, tinward=0, toutward=0;
			long topenbal=0, tclosebal=0, stockid=0, colorcode=0, cartid=0, branchid=2, datatype=1, stocktype=1, enggid=0, sr=1;
			int colcount=0, count=1;
			String v1="", str1="", str2="", cmodel="ALL", ename="ALL", tmpmodel="", unit="", dt1="",dt2="";
			
			v1="";if((v1=request.getParameter("branchid"))!=null){branchid=Long.parseLong(v1);}
			v1="";if((v1=request.getParameter("cid"))!=null){cartid=Long.parseLong(v1);}
			v1="";if((v1=request.getParameter("wid"))!=null){enggid=Long.parseLong(v1);}
			v1="";if((v1=request.getParameter("stocktype"))!=null){stocktype=Long.parseLong(v1);}
			v1="";if((v1=request.getParameter("pmodel"))!=null){pmodel=Long.parseLong(v1);}
			v1=""; if((v1=request.getParameter("date1"))!=null){if(v1.length()>0){dt1=v1;}}
			v1=""; if((v1=request.getParameter("date2"))!=null){if(v1.length()>0){dt2=v1;}}
			
			response.setContentType("application/vnd.ms-excel");
			HSSFWorkbook wb = new HSSFWorkbook();
			HSSFSheet sheet=null;
			if(stocktype==1)
			{
				response.setHeader("Content-Disposition", "attachment; filename=Office Part Stock Statement.xls");
				sheet = wb.createSheet("Office Part Statement");
			}
			else
			if(stocktype==2)
			{
				response.setHeader("Content-Disposition", "attachment; filename=Engineer Part Stock Statement.xls");
				sheet = wb.createSheet("Engineer Part Statement");
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

			if(stocktype ==  1)
			{
				HSSFRow row=sheet.createRow((short)0);
				row.createCell((short)colcount).setCellValue("SR.");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("DATE");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("PART");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("PRINTER");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("OPENING BALANCE");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("INWARD");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("OUTWARD");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("CLOSING BALANCE");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("REMARK");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("BRANCH");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("ENGINEER");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("CALL ID");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("DONE BY");  row.getCell((short)colcount++).setCellStyle(cs1);
			}
			else
			if(stocktype ==  2)
			{
				HSSFRow row=sheet.createRow((short)0);
				row.createCell((short)colcount).setCellValue("SR.");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("DATE");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("PART");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("PRINTER");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("OPENING BALANCE");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("INWARD");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("OUTWARD");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("CLOSING BALANCE");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("REMARK");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("BRANCH");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("ENGINEER");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("CALL ID");  row.getCell((short)colcount++).setCellStyle(cs1);
				row.createCell((short)colcount).setCellValue("DONE BY");  row.getCell((short)colcount++).setCellStyle(cs1);
			}

			if(stocktype ==  1)
			{
				str1 = "SELECT ps.USER_ID, pp.name, pm.model_name, br.name AS branch_code, " +
					   "ps.TR_DATE, ps.INWARD, ps.OUTWARD, ps.BALANCE, ps.SRC, ps.PURCHASE_ID, " +
					   "ps.ENGG_STOCK_ID, ps.PRINTER_REP_ID, ps.FC_RETURN_ID, ps.INSTALL_ID, " +
					   "ps.record_id, ps.mat_id, ps.pmodel_id, ps.br_id, ps.id, (SELECT balance FROM "+
					   "part_stock ps2 WHERE ps2.br_id = ps.br_id AND ps2.mat_id = ps.mat_id " +
					   "AND ps2.pmodel_id = ps.pmodel_id AND ps2.record_id < ps.record_id "+
					   "ORDER BY ps2.record_id DESC FETCH FIRST 1 ROWS ONLY) AS openstock "+
					   "FROM part_stock ps " +
					   "LEFT JOIN printer_part pp ON ps.mat_id = pp.id " +
					   "LEFT JOIN p_model pm ON ps.PMODEL_ID = pm.id " +
					   "LEFT JOIN branch br ON ps.br_id = br.id " +
					   "WHERE (ps.inward>0 or ps.outward>0) and ps.tr_date BETWEEN '" + dt1 + "' AND '" + dt2 + "'";
				if (branchid != 0) {str1 += " AND ps.br_id = " + branchid;}
				if (cartid != 0) {str1 += " AND ps.mat_id = " + cartid;}
				if (pmodel != 0) {str1 += " AND ps.pmodel_id = " + pmodel;}
				str1 += " ORDER BY ps.br_id, ps.mat_id, ps.pmodel_id, ps.record_id";
				
				try
				{
					str2="SELECT SUM(BALANCE) FROM PART_STOCK PS "+
						  "WHERE RECORD_ID = ( "+
						  "SELECT MAX(RECORD_ID) FROM PART_STOCK PS2 "+
						  "WHERE PS2.MAT_ID=PS.MAT_ID AND PS2.PMODEL_ID=PS.PMODEL_ID AND PS2.TR_DATE < '"+dt1+"' ";
						if (branchid != 0) {str2 += " AND ps2.br_id = " + branchid;}
						if (cartid != 0) {str2 += " AND ps2.mat_id = " + cartid;}
						if (pmodel != 0) {str2 += " AND ps2.pmodel_id = " + pmodel;}
					str2 += ")";
					rs2 = st2.executeQuery(str2);
					if(rs2.next()){ topenbal=rs2.getLong(1); }
				}
				catch(Exception e){}
				
				try
				{
					str2="SELECT SUM(BALANCE) FROM PART_STOCK PS "+
						  "WHERE RECORD_ID = ( "+
						  "SELECT MAX(RECORD_ID) FROM PART_STOCK PS2 "+
						  "WHERE PS2.MAT_ID=PS.MAT_ID AND PS2.PMODEL_ID=PS.PMODEL_ID AND PS2.TR_DATE <= '"+dt2+"' ";
						if (branchid != 0) {str2 += " AND ps2.br_id = " + branchid;}
						if (cartid != 0) {str2 += " AND ps2.mat_id = " + cartid;}
						if (pmodel != 0) {str2 += " AND ps2.pmodel_id = " + pmodel;}
					str2 += ")";
					rs2 = st2.executeQuery(str2);
					if(rs2.next()){ tclosebal=rs2.getLong(1); }
				}
				catch(Exception e){}
			}
			else
			if(stocktype ==  2)
			{
				str1 = "SELECT esd.USER_ID, pp.name, pm.model_name, fe.execode AS engineer_name, " +
					  "esd.USED_DATE, esd.INWARD, esd.OUTWARD, esd.BALANCE, esd.SRC, esd.CALL_ID, " +
					  "esd.P_ID, esd.PMODEL_ID, esd.ENG_NAME, br.code AS branch_code, (SELECT balance FROM " +
					  "ENG_STOCK_DETAILS esd2 WHERE esd2.ENG_NAME = esd.ENG_NAME AND esd2.P_ID = esd.P_ID " +
					  "AND esd2.PMODEL_ID = esd.PMODEL_ID AND esd2.RECORD_ID < esd.RECORD_ID " +
					  "ORDER BY esd2.RECORD_ID DESC FETCH FIRST 1 ROWS ONLY) AS openstock " +
					  "FROM ENG_STOCK_DETAILS esd " +
					  "LEFT JOIN printer_part pp ON esd.p_id = pp.id " +
					  "LEFT JOIN p_model pm ON esd.PMODEL_ID = pm.id " +
					  "LEFT JOIN branch br ON esd.br_id = br.id " +
					  "LEFT JOIN field_executive fe on esd.eng_name = fe.exec_id "+
					  "WHERE (esd.INWARD > 0 OR esd.OUTWARD > 0) AND esd.USED_DATE BETWEEN '"+dt1+"' AND '"+dt2+"'";
				if (enggid != 0) {str1 += " AND esd.ENG_NAME = " + enggid;}
				if (cartid != 0) {str1 += " AND esd.P_ID = " + cartid;}
				if (pmodel != 0) {str1 += " AND esd.pmodel_id = " + pmodel;}
				str1 += " ORDER BY esd.eng_name, esd.P_ID, esd.PMODEL_ID, esd.RECORD_ID";
				
				try
				{
					str2="SELECT SUM(BALANCE) FROM ENG_STOCK_DETAILS esd "+
						  "WHERE RECORD_ID = ( "+
						  "SELECT MAX(RECORD_ID) FROM ENG_STOCK_DETAILS esd2 "+
						  "WHERE esd2.P_ID=esd.P_ID AND esd2.PMODEL_ID=esd.PMODEL_ID AND esd2.USED_DATE < '"+dt1+"' ";
						if (enggid != 0) {str2 += " AND esd2.ENG_NAME = " + enggid;}
						if (cartid != 0) {str2 += " AND esd2.P_ID = " + cartid;}
						if (pmodel != 0) {str2 += " AND esd2.pmodel_id = " + pmodel;}
					str2 += ")";
					rs2 = st2.executeQuery(str2);
					if(rs2.next()){ topenbal=rs2.getLong(1); }
				}
				catch(Exception e){}
				
				try
				{
					str2="SELECT SUM(BALANCE) FROM ENG_STOCK_DETAILS esd "+
						  "WHERE RECORD_ID = ( "+
						  "SELECT MAX(RECORD_ID) FROM ENG_STOCK_DETAILS esd2 "+
						  "WHERE esd2.P_ID=esd.P_ID AND esd2.PMODEL_ID=esd.PMODEL_ID AND esd2.USED_DATE <= '"+dt2+"' ";
						if (enggid != 0) {str2 += " AND esd2.ENG_NAME = " + enggid;}
						if (cartid != 0) {str2 += " AND esd2.P_ID = " + cartid;}
						if (pmodel != 0) {str2 += " AND esd2.pmodel_id = " + pmodel;}
					str2 += ")";
					rs2 = st2.executeQuery(str2);
					if(rs2.next()){ tclosebal=rs2.getLong(1); }
				}
				catch(Exception e){}
			}
			rs1 = st1.executeQuery(str1);
			while(rs1.next())
			{
				username=""; partname=""; pmodelname=""; branch=""; trdate=""; srcname=""; brcode=""; colcount=0;
				inward=0; outward=0; balance=0; src=0; purchaseid=0; estockid=0; prepairid=0; callid=0;
				fcreturnid=0; installid=0; recid=0; openstock=0; pmodelid=0; partid=0; branchid=0; stockid=0;
				
				if(stocktype==1)
				{
					v1=""; if((v1=rs1.getString(1))!=null){username=v1;}
					v1=""; if((v1=rs1.getString(2))!=null){partname=v1;}
					v1=""; if((v1=rs1.getString(3))!=null){pmodelname=v1;}
					v1=""; if((v1=rs1.getString(4))!=null){branch=v1;}
					v1=""; if((v1=rs1.getString(5))!=null){trdate=v1;}
					inward=rs1.getLong(6);
					outward=rs1.getLong(7);
					balance=rs1.getLong(8);
					src=rs1.getLong(9);
					purchaseid=rs1.getLong(10);
					estockid=rs1.getLong(11);
					prepairid=rs1.getLong(12);
					fcreturnid=rs1.getLong(13);
					installid=rs1.getLong(14);
					recid=rs1.getLong(15);
					partid=rs1.getLong(16);
					pmodelid=rs1.getLong(17);
					branchid=rs1.getLong(18);
					stockid=rs1.getLong(19);
					openstock=rs1.getLong(20);

					if (src == 0) {srcname = "Initial stock record"; } 
					else 
					if (src == 1) {srcname = "Purchase or opening"; } 
					else 
					if (src == 2) {srcname = "Allot to engg.";} 
					else 
					if (src == 3) { srcname = "In-house printer repair"; }
					else 
					if (src == 4) {srcname = "De-allot from engg.";} 
					else 
					if (src == 5) {srcname = "Transfer between printer";}
					else 
					if (src == 7) {srcname = "Faulty return in ok condition"; callid=fcreturnid;}
					else 
					if (src == 8) {srcname = "Allot to call"; callid=installid;}
					else 
					if (src == 9) {srcname = "Transfer between branches";}
					else 
					if (src == 10) {srcname = "Purchase return or cancel";}
					else 
					if (src == 11) {srcname = "Balance adjustment";}
				}
				else
				if(stocktype==2)
				{
					v1=""; if((v1=rs1.getString(1))!=null){username=v1;}
					v1=""; if((v1=rs1.getString(2))!=null){partname=v1;}
					v1=""; if((v1=rs1.getString(3))!=null){pmodelname=v1;}
					v1=""; if((v1=rs1.getString(4))!=null){branch=v1;}
					v1=""; if((v1=rs1.getString(5))!=null){trdate=v1;}
					inward=rs1.getLong(6);
					outward=rs1.getLong(7);
					balance=rs1.getLong(8);
					src=rs1.getLong(9);
					callid=rs1.getLong(10);
					partid=rs1.getLong(11);
					pmodelid=rs1.getLong(12);
					enggid=rs1.getLong(13);
					v1=""; if((v1=rs1.getString(14))!=null){brcode=v1;}
					openstock=rs1.getLong(15);
			 
					if (src == 1) {srcname = "Allocation"; } 
					else 
					if (src == 2) {srcname = "Installation";} 
					else 
					if (src == 3) { srcname = "Uninstalled Part Return"; }
					else 
					if (src == 4) {srcname = "De-allocation";} 
					else 
					if (src == 5) {srcname = "Transfer between printer";}
				}

				tinward += inward;
				toutward += outward;
				
				HSSFRow row1=sheet.createRow((short)count++);
				row1.createCell((short)colcount++).setCellValue(sr++);
				row1.createCell((short)colcount++).setCellValue(dateformat.formatDate(trdate));
				row1.createCell((short)colcount++).setCellValue(partname);
				row1.createCell((short)colcount++).setCellValue(pmodelname);
				row1.createCell((short)colcount++).setCellValue(openstock);
				row1.createCell((short)colcount++).setCellValue(inward);
				row1.createCell((short)colcount++).setCellValue(outward);
				row1.createCell((short)colcount++).setCellValue(balance);
				row1.createCell((short)colcount++).setCellValue(srcname);
				row1.createCell((short)colcount++).setCellValue(brcode);
				row1.createCell((short)colcount++).setCellValue(branch);
				row1.createCell((short)colcount++).setCellValue(callid);
				row1.createCell((short)colcount++).setCellValue(username);
			}
			
			colcount=0;
			HSSFRow row2=sheet.createRow((short)count++);
			row2.createCell((short)colcount).setCellValue("Total"); row2.getCell((short)colcount++).setCellStyle(cs1);
			row2.createCell((short)colcount).setCellValue(""); row2.getCell((short)colcount++).setCellStyle(cs1);
			row2.createCell((short)colcount).setCellValue(""); row2.getCell((short)colcount++).setCellStyle(cs1);
			row2.createCell((short)colcount).setCellValue(""); row2.getCell((short)colcount++).setCellStyle(cs1);
			row2.createCell((short)colcount).setCellValue(topenbal); row2.getCell((short)colcount++).setCellStyle(cs1);
			row2.createCell((short)colcount).setCellValue(tinward); row2.getCell((short)colcount++).setCellStyle(cs1);
			row2.createCell((short)colcount).setCellValue(toutward); row2.getCell((short)colcount++).setCellStyle(cs1);
			row2.createCell((short)colcount).setCellValue(tclosebal); row2.getCell((short)colcount++).setCellStyle(cs1);
			row2.createCell((short)colcount).setCellValue(""); row2.getCell((short)colcount++).setCellStyle(cs1);
			row2.createCell((short)colcount).setCellValue(""); row2.getCell((short)colcount++).setCellStyle(cs1);
			row2.createCell((short)colcount).setCellValue(""); row2.getCell((short)colcount++).setCellStyle(cs1);
			row2.createCell((short)colcount).setCellValue(""); row2.getCell((short)colcount++).setCellStyle(cs1);
			row2.createCell((short)colcount).setCellValue(""); row2.getCell((short)colcount++).setCellStyle(cs1);
				
			wb.write(out); out.close(); 

			if(rs1!=null){rs1.close();}
			if(rs2!=null){rs2.close();}
			if(st1!=null){st1.close();}
			if(st2!=null){st2.close();}
			con.close();
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