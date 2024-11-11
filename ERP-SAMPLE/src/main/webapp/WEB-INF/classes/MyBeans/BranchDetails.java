package MyBeans;
import java.io.*;
import java.sql.*;
public class BranchDetails 
{
	public BranchDetails(){super();}
	
	public String[] getBranch(Connection con,  String brnid)
	{
		String CODE="", NAME="", CITY="", ADDRESS="", BOARD_LINE="", MOBILE="", EMAIL="", MANAGER="";
		String CMP_ID="", VAT_NO="", STAX_NO="", CST_NO="", PAN_NO="", REG_NO="", v1="";
		long compid=0;
		
		String[] brnAttrib=new String[15];
		brnAttrib[0]="";
		brnAttrib[1]="";
		brnAttrib[2]="";
		brnAttrib[3]="";
		brnAttrib[4]="";
		brnAttrib[5]="";
		brnAttrib[6]="";
		brnAttrib[7]="";
		brnAttrib[8]="";
		brnAttrib[9]="";
		brnAttrib[10]="";
		brnAttrib[11]="";
		brnAttrib[12]="";
		brnAttrib[13]="";
		brnAttrib[14]="";
		try
		{
			Statement stat=con.createStatement();
			String str="select ID, CODE, NAME, CITY, ADDRESS, BOARD_LINE, MOBILE, EMAIL, MANAGER, CMP_ID, VAT_NO, STAX_NO, "+
						"CST_NO, PAN_NO, REG_NO from BRANCH where ID="+brnid;
			ResultSet rs=stat.executeQuery(str);
			if(rs.next())
			{
				v1=""; if((v1=rs.getString(2))!=null){CODE=v1;}
				v1=""; if((v1=rs.getString(3))!=null){NAME=v1;}
				v1=""; if((v1=rs.getString(4))!=null){CITY=v1;}
				v1=""; if((v1=rs.getString(5))!=null){ADDRESS=v1;}
				v1=""; if((v1=rs.getString(6))!=null){BOARD_LINE=v1;}
				v1=""; if((v1=rs.getString(7))!=null){MOBILE=v1;}
				v1=""; if((v1=rs.getString(8))!=null){EMAIL=v1;}
				v1=""; if((v1=rs.getString(9))!=null){MANAGER=v1;}
				compid=rs.getLong(10);
				v1=""; if((v1=rs.getString(11))!=null){VAT_NO=v1;}
				v1=""; if((v1=rs.getString(12))!=null){STAX_NO=v1;}
				v1=""; if((v1=rs.getString(13))!=null){CST_NO=v1;}
				v1=""; if((v1=rs.getString(14))!=null){PAN_NO=v1;}
				v1=""; if((v1=rs.getString(15))!=null){REG_NO=v1;}
			}
			str="select NAME from company where ID="+compid;
			rs=stat.executeQuery(str);
			if(rs.next()){v1=""; if((v1=rs.getString(1))!=null){CMP_ID=v1;} }
			
			rs.close();stat.close();
			
			brnAttrib[0]=brnid;
			brnAttrib[1]=CODE;
			brnAttrib[2]=NAME;
			brnAttrib[3]=CITY;
			brnAttrib[4]=ADDRESS;
			brnAttrib[5]=BOARD_LINE;
			brnAttrib[6]=MOBILE;
			brnAttrib[7]=EMAIL;
			brnAttrib[8]=MANAGER;
			brnAttrib[9]=CMP_ID;
			brnAttrib[10]=VAT_NO;
			brnAttrib[11]=STAX_NO;
			brnAttrib[12]=CST_NO;
			brnAttrib[13]=PAN_NO;
			brnAttrib[14]=REG_NO;
		}
		catch(Exception e){System.out.println("BranchDetails.java.getBranch: "+e);}
		return brnAttrib;
	}
	
	public String[] getCompany(Connection con,  String cmpid)
	{
		String CODE="", NAME="", CITY="", ADDRESS="", BOARD_LINE="", MOBILE="", EMAIL="", MANAGER="";
		String CMP_ID="", VAT_NO="", STAX_NO="", CST_NO="", PAN_NO="", REG_NO="", v1="";
		
		String[] cmpAttrib=new String[15];
		cmpAttrib[0]="";
		cmpAttrib[1]="";
		cmpAttrib[2]="";
		cmpAttrib[3]="";
		cmpAttrib[4]="";
		cmpAttrib[5]="";
		cmpAttrib[6]="";
		cmpAttrib[7]="";
		cmpAttrib[8]="";
		cmpAttrib[9]="";
		cmpAttrib[10]="";
		cmpAttrib[11]="";
		cmpAttrib[12]="";
		cmpAttrib[13]="";
		try
		{
			Statement stat=con.createStatement();
			String str="select ID, CODE, NAME, CITY, ADDRESS, BOARD_LINE, MOBILE, EMAIL, MANAGER, VAT_NO, STAX_NO, "+
						"CST_NO, PAN_NO, REG_NO from BRANCH where ID="+cmpid;
			ResultSet rs=stat.executeQuery(str);
			if(rs.next())
			{
				v1=""; if((v1=rs.getString(2))!=null){CODE=v1;}
				v1=""; if((v1=rs.getString(3))!=null){NAME=v1;}
				v1=""; if((v1=rs.getString(4))!=null){CITY=v1;}
				v1=""; if((v1=rs.getString(5))!=null){ADDRESS=v1;}
				v1=""; if((v1=rs.getString(6))!=null){BOARD_LINE=v1;}
				v1=""; if((v1=rs.getString(7))!=null){MOBILE=v1;}
				v1=""; if((v1=rs.getString(8))!=null){EMAIL=v1;}
				v1=""; if((v1=rs.getString(9))!=null){MANAGER=v1;}
				v1=""; if((v1=rs.getString(10))!=null){VAT_NO=v1;}
				v1=""; if((v1=rs.getString(11))!=null){STAX_NO=v1;}
				v1=""; if((v1=rs.getString(12))!=null){CST_NO=v1;}
				v1=""; if((v1=rs.getString(13))!=null){PAN_NO=v1;}
				v1=""; if((v1=rs.getString(14))!=null){REG_NO=v1;}
			}
			rs.close();stat.close();
			
			cmpAttrib[0]=cmpid;
			cmpAttrib[1]=CODE;
			cmpAttrib[2]=NAME;
			cmpAttrib[3]=CITY;
			cmpAttrib[4]=ADDRESS;
			cmpAttrib[5]=BOARD_LINE;
			cmpAttrib[6]=MOBILE;
			cmpAttrib[7]=EMAIL;
			cmpAttrib[8]=MANAGER;
			cmpAttrib[11]=VAT_NO;
			cmpAttrib[12]=STAX_NO;
			cmpAttrib[13]=CST_NO;
			cmpAttrib[14]=PAN_NO;
			cmpAttrib[15]=REG_NO;
		}
		catch(Exception e){System.out.println("BranchDetails.java.getCompany: "+e);}
		return cmpAttrib;
	}
	
	public String[][] getBranchList(Connection con,  String cmpid)
	{
		String CODE="", NAME="", CITY="", v1="", str="";
		long brnid=0, brncount=0;
		Statement stat=null;
		ResultSet rs=null;
		
		try
		{
			stat=con.createStatement();
			str="select count(*) from branch where cmp_id="+Long.parseLong(cmpid);
			rs=stat.executeQuery(str);
			if(rs.next()){brncount=rs.getLong(1);}
//			brncount++;
		}
		catch(Exception e){}

		String[][] brnAttrib=new String[(int)brncount][15];
		try
		{
			brncount=0;
			str="select ID, CODE, NAME, CITY from BRANCH where CMP_ID="+Long.parseLong(cmpid)+" order by name";
			rs=stat.executeQuery(str);
			while(rs.next())
			{
				CODE=""; NAME=""; CITY=""; brnid=0;
				
				brnid=rs.getLong(1);
				v1=""; if((v1=rs.getString(2))!=null){CODE=v1;}
				v1=""; if((v1=rs.getString(3))!=null){NAME=v1;}
				v1=""; if((v1=rs.getString(4))!=null){CITY=v1;}
				
				brnAttrib[(int)brncount][0]=Long.toString(brnid);
				brnAttrib[(int)brncount][1]=NAME;
				brnAttrib[(int)brncount][2]=CITY;
				brnAttrib[(int)brncount][3]=CODE;
				
				brncount++;
			}
			rs.close();stat.close();
		}
		catch(Exception e){System.out.println("BranchDetails.java.getBranchList: "+e);}
		return brnAttrib;
	}
	
	public String[][] getBranchListSelect(Connection con,  String brlist, long brncount)
	{
		String CODE="", NAME="", CITY="", v1="", str="";
		long brnid=0;
		Statement stat=null;
		ResultSet rs=null;
		
		String[][] brnAttrib=new String[(int)brncount][15];
		try
		{
			stat=con.createStatement();
			brncount=0;
			str="select ID, CODE, NAME, CITY from BRANCH where ID IN("+brlist+") order by NAME";
			rs=stat.executeQuery(str);
			while(rs.next())
			{
				CODE=""; NAME=""; CITY=""; brnid=0;
				
				brnid=rs.getLong(1);
				v1=""; if((v1=rs.getString(2))!=null){CODE=v1;}
				v1=""; if((v1=rs.getString(3))!=null){NAME=v1;}
				v1=""; if((v1=rs.getString(4))!=null){CITY=v1;}
				
				brnAttrib[(int)brncount][0]=Long.toString(brnid);
				brnAttrib[(int)brncount][1]=NAME;
				brnAttrib[(int)brncount][2]=CITY;
				brnAttrib[(int)brncount][3]=CODE;
				
				brncount++;
			}
			rs.close();stat.close();
		}
		catch(Exception e){System.out.println("BranchDetails.java.getBranchListSelect: "+e);}
		return brnAttrib;
	}
	
	public String[][] getCompanyList(Connection con)
	{
		String CODE="", NAME="", CITY="", v1="", str="";
		long cmpid=0, cmpcount=0;
		Statement stat=null;
		ResultSet rs=null;
		
		try
		{
			stat=con.createStatement();
			str="select count(*) from company";
			rs=stat.executeQuery(str);
			if(rs.next()){cmpcount=rs.getLong(1);}
			cmpcount++;
		}
		catch(Exception e){}

		String[][] cmpAttrib=new String[(int)cmpcount][5];
		try
		{
			cmpcount=0;
			str="select ID, CODE, NAME, CITY from company order by name";
			rs=stat.executeQuery(str);
			while(rs.next())
			{
				CODE=""; NAME=""; CITY=""; cmpid=0;
				
				cmpid=rs.getLong(1);
				v1=""; if((v1=rs.getString(2))!=null){CODE=v1;}
				v1=""; if((v1=rs.getString(3))!=null){NAME=v1;}
				v1=""; if((v1=rs.getString(4))!=null){CITY=v1;}
				
				cmpAttrib[(int)cmpcount][0]=Long.toString(cmpid);
				cmpAttrib[(int)cmpcount][1]=NAME;
				cmpAttrib[(int)cmpcount][2]=CITY;
				cmpAttrib[(int)cmpcount][3]=CODE;
				
				cmpcount++;
			}
			rs.close();stat.close();
		}
		catch(Exception e){System.out.println("BranchDetails.java.getCompanyList: "+e);}
		return cmpAttrib;
	}
}