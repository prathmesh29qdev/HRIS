import java.util.*;
import MyBeans.DBConnection;
import java.text.*;
import java.io.*; import MyBeans.*;
import java.lang.*;
import java.sql.*;
import java.net.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.*;
//import org.apache.commons.lang.ArrayUtils; 

public class PartStock extends HttpServlet 
{
    public void init(ServletConfig config) throws ServletException
    {
    	 super.init(config);  
    }
    public void destroy() { }

	class StockItem
	{
		String printerPartName;
		String pmodelName;
		int matId;
		int pmodelId;
		int totalInward;
		int totalOutward;
		int openingStock;
		int closingStock;
		int minStock;

		// Constructor
		public StockItem(String printerPartName, String pmodelName, int matId, int pmodelId) 
		{
			this.printerPartName = printerPartName;
			this.pmodelName = pmodelName;
			this.matId = matId;
			this.pmodelId = pmodelId;
			this.totalInward = 0;
			this.totalOutward = 0;
			this.openingStock = 0;
			this.closingStock = 0;
			this.minStock = 0;
		}
	}
	
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
		HttpSession ses=request.getSession(true);
		String u4brnlist=(String)ses.getAttribute("u4brnlist");

        MyBeans.convertDate dateformat=new MyBeans.convertDate();
        response.setContentType("application/vnd.ms-excel"); response.setHeader("Content-Disposition", "attachment; filename=PartStock.xls");
        HSSFWorkbook wb = new HSSFWorkbook();
        HSSFSheet sheet = wb.createSheet("Part Stock Details");
        OutputStream out = response.getOutputStream();
		
		HSSFFont f=wb.createFont();
		f.setFontHeightInPoints((short) 10);
        f.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
        
		HSSFCellStyle cs1=wb.createCellStyle();
		cs1.setFillForegroundColor(HSSFColor.LIGHT_YELLOW.index);
		cs1.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		cs1.setBorderTop(HSSFCellStyle.BORDER_THIN); 
		cs1.setBorderLeft(HSSFCellStyle.BORDER_THIN); 
		cs1.setBorderBottom(HSSFCellStyle.BORDER_THIN); 
		cs1.setBorderRight(HSSFCellStyle.BORDER_THIN); 
		cs1.setFont(f);
		
		HSSFCellStyle cs2=wb.createCellStyle();
		cs2.setFillForegroundColor(HSSFColor.LIGHT_GREEN.index);
		cs2.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		cs2.setBorderTop(HSSFCellStyle.BORDER_THIN); 
		cs2.setBorderLeft(HSSFCellStyle.BORDER_THIN); 
		cs2.setBorderBottom(HSSFCellStyle.BORDER_THIN); 
		cs2.setBorderRight(HSSFCellStyle.BORDER_THIN); 
		
		try
		{
			long cartid=Long.parseLong(request.getParameter("cid"));
			long pmodel=Long.parseLong(request.getParameter("pmodel"));
			long branchid=Long.parseLong(request.getParameter("branchid"));
			String dt1=request.getParameter("date1");
			String dt2=request.getParameter("date2");
			String pmodelname=request.getParameter("pmodelname");
			String cmodel=request.getParameter("cmodel");
			
			ArrayList<StockItem> stockList = new ArrayList<>();
			Map<String, StockItem> itemMap = new HashMap<>();

			Connection con=DBConnection.getNewInstance().getConnection();
			Statement st1 = con.createStatement();
			ResultSet rs1=null;
			long sr=1, count=1, norecord=0, colcount=0;
			long topen=0, tinward=0, toutward=0, tclose=0;
			String str1="", v1="";

			HSSFRow row    = sheet.createRow((short)0);
			row.createCell((short)colcount).setCellValue("SR");  row.getCell((short)colcount++).setCellStyle(cs1);
			row.createCell((short)colcount).setCellValue("PART");  row.getCell((short)colcount++).setCellStyle(cs1);
			row.createCell((short)colcount).setCellValue("PRINTER");  row.getCell((short)colcount++).setCellStyle(cs1);
			row.createCell((short)colcount).setCellValue("MIN. STOCK");  row.getCell((short)colcount++).setCellStyle(cs1);
			row.createCell((short)colcount).setCellValue("OPENING STOCK");  row.getCell((short)colcount++).setCellStyle(cs1);
			row.createCell((short)colcount).setCellValue("TOTAL INWARD");  row.getCell((short)colcount++).setCellStyle(cs1);
			row.createCell((short)colcount).setCellValue("TOTAL OUTWARD");  row.getCell((short)colcount++).setCellStyle(cs1);
			row.createCell((short)colcount).setCellValue("CLOSING BALANCE");  row.getCell((short)colcount++).setCellStyle(cs1);
						
			String condition = "src!=0 and br_id = " + branchid + " AND TR_DATE <= '"+dt2+"'";
			if (cartid != 0) { condition += " AND mat_id = " + cartid;}
			if (pmodel != 0) {condition += " AND pmodel_id = " + pmodel;}
			str1 = "SELECT t.MAT_ID, t.pmodel_id, t.balance, pp.name AS printer_part_name, "
					+ "pm.model_name AS pmodel_name, ppms.min_stock  "
					+ "FROM ("
					+ "SELECT MAT_ID, pmodel_id, balance, ROW_NUMBER() "
					+ "OVER (PARTITION BY MAT_ID, pmodel_id ORDER BY record_id DESC) as rn "
					+ "FROM part_stock WHERE " + condition + ") t "
					+ "JOIN printer_part pp ON t.mat_id = pp.id "
					+ "JOIN printer_part_min_stock ppms ON ppms.part_id = pp.id and ppms.br_id = "+branchid+" "
					+ "JOIN p_model pm ON t.pmodel_id = pm.id "
					+ "WHERE rn = 1 and pp.status=1"
					+ "ORDER BY t.balance DESC, pp.name, pm.model_name";
			rs1=st1.executeQuery(str1);
			while(rs1.next())
			{
				int matId = rs1.getInt("MAT_ID");
				int pmodelId = rs1.getInt("pmodel_id");
				int closingStock = rs1.getInt("balance");
				int minStock = rs1.getInt("min_stock");
				String printerPartName = rs1.getString("printer_part_name");
				String pmodelName = rs1.getString("pmodel_name");

				String key = matId + "-" + pmodelId;
				StockItem item;
				if (itemMap.containsKey(key)) {item = itemMap.get(key);}
				else
				{
					item = new StockItem(printerPartName, pmodelName, matId, pmodelId);
					stockList.add(item);
					itemMap.put(key, item);
				}
				item.closingStock = closingStock;
				item.minStock = minStock;
			}

			condition="ps.src!=0 and ps.br_id = " + branchid + " AND TR_DATE between '"+dt1+"' and '"+dt2+"' ";
			if (cartid != 0) { condition += " AND ps.mat_id = " + cartid;}
			if (pmodel != 0) {condition += " AND ps.pmodel_id = " + pmodel;}
			str1 = "SELECT ps.MAT_ID, ps.pmodel_id, pp.name AS printer_part_name, "
					+ "pm.model_name AS pmodel_name, "
					+ "SUM(ps.inward) AS total_inward, SUM(ps.outward) AS total_outward "
					+ "FROM part_stock ps "
					+ "JOIN printer_part pp ON ps.mat_id = pp.id "
					+ "JOIN p_model pm ON ps.pmodel_id = pm.id "
					+ "WHERE " + condition + " and pp.status=1 "
					+ "GROUP BY ps.MAT_ID, ps.pmodel_id, pp.name, pm.model_name "
					+ "ORDER BY pp.name, pm.model_name";
			rs1=st1.executeQuery(str1);
			while(rs1.next())
			{ 
				int matId = rs1.getInt("MAT_ID");
				int pmodelId = rs1.getInt("pmodel_id");
				int totalInward = rs1.getInt("total_inward");
				int totalOutward = rs1.getInt("total_outward");

				String key = matId + "-" + pmodelId;

				if (itemMap.containsKey(key)) 
				{
					StockItem item = itemMap.get(key);
					item.totalInward = totalInward;
					item.totalOutward = totalOutward;
				}	
			}

			condition = "src!=0 and br_id = " + branchid + " AND TR_DATE < '"+dt1+"'";
			if (cartid != 0) { condition += " AND mat_id = " + cartid;}
			if (pmodel != 0) {condition += " AND pmodel_id = " + pmodel;}
			str1 = "SELECT t.MAT_ID, t.pmodel_id, t.balance, pp.name AS printer_part_name, "
					+ "pm.model_name AS pmodel_name, pp.min_stock  "
					+ "FROM ("
					+ "SELECT MAT_ID, pmodel_id, balance, ROW_NUMBER() "
					+ "OVER (PARTITION BY MAT_ID, pmodel_id ORDER BY record_id DESC) as rn "
					+ "FROM part_stock WHERE " + condition + ") t "
					+ "JOIN printer_part pp ON t.mat_id = pp.id "
					+ "JOIN p_model pm ON t.pmodel_id = pm.id "
					+ "WHERE rn = 1  and pp.status=1"
					+ "ORDER BY t.balance DESC, pp.name, pm.model_name";
			rs1=st1.executeQuery(str1);
			while(rs1.next())
			{
				int matId = rs1.getInt("MAT_ID");
				int pmodelId = rs1.getInt("pmodel_id");
				int openingStock = rs1.getInt("balance");

				String key = matId + "-" + pmodelId;

				if (itemMap.containsKey(key)) 
				{
					StockItem item = itemMap.get(key);
					item.openingStock = openingStock; // Update opening stock
				}	
			}

			for (StockItem item : stockList) 
			{
				colcount=0;
				
				topen += item.openingStock;
				tinward += item.totalInward;
				toutward += item.totalOutward;
				tclose += item.closingStock;

				HSSFRow row1    = sheet.createRow((short)count++);
				row1.createCell((short)colcount++).setCellValue(sr++);
				row1.createCell((short)colcount++).setCellValue(item.printerPartName);
				row1.createCell((short)colcount++).setCellValue(item.pmodelName);
				row1.createCell((short)colcount++).setCellValue(item.minStock);
				row1.createCell((short)colcount++).setCellValue(item.openingStock);
				row1.createCell((short)colcount++).setCellValue(item.totalInward);
				row1.createCell((short)colcount++).setCellValue(item.totalOutward);
				row1.createCell((short)colcount++).setCellValue(item.closingStock);
			}


			HSSFRow row2    = sheet.createRow((short)count);
			row2.createCell((short)0).setCellValue("TOTAL");  row2.getCell((short)0).setCellStyle(cs2);
			row2.createCell((short)4).setCellValue(topen);  row2.getCell((short)4).setCellStyle(cs2);
			row2.createCell((short)5).setCellValue(tinward);  row2.getCell((short)5).setCellStyle(cs2);
			row2.createCell((short)6).setCellValue(toutward);  row2.getCell((short)6).setCellStyle(cs2);
			row2.createCell((short)7).setCellValue(tclose);  row2.getCell((short)7).setCellStyle(cs2);

			wb.write(out);out.close(); 
			
			if(rs1!=null){rs1.close();}
			if(st1!=null){st1.close();}
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
