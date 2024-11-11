package MyBeans;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class PartStockBean 
{
    private final Lock lock = new ReentrantLock();

    private long getNextStockId(Connection conn) throws SQLException 
	{
        long psid = 0;
        Statement stat = conn.createStatement();
        ResultSet rs = stat.executeQuery("SELECT P_STOCK.nextval FROM dual");
        if (rs.next()) {psid = rs.getLong(1);}
        
		if(rs!=null){rs.close();}
		if(stat!=null){stat.close();}
		
        return psid;
    }

    private long getRecentBalance(Connection conn, long branchId, long partId, long pModelId, String recrdno) throws SQLException 
	{
        long maxBalance = 0;
        String sql = "SELECT balance FROM PART_STOCK WHERE br_id = ? AND mat_id = ? AND pmodel_id = ? "
                   + "AND RECORD_ID = (SELECT MAX(RECORD_ID) FROM PART_STOCK WHERE br_id = ? AND mat_id = ? AND pmodel_id = ? AND RECORD_ID <= ?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setLong(1, branchId);
        pstmt.setLong(2, partId);
        pstmt.setLong(3, pModelId);
        pstmt.setLong(4, branchId);
        pstmt.setLong(5, partId);
        pstmt.setLong(6, pModelId);
        pstmt.setString(7, recrdno);

        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) 
		{
            String balanceStr = rs.getString(1);
            if (balanceStr != null) {maxBalance = Long.parseLong(balanceStr);}
        }

		if(rs!=null){rs.close();}
		if(pstmt!=null){pstmt.close();}
		
        return maxBalance;
    }

    public long insertStock(Connection conn, long branchId, long partId, long pModelId, String trDate, 
				long in_qty, long out_qty, long installId, String userId, long purID, long enggStkId, 
				long pRepId, long fltRetId, long pScrapeId, String tr_type, long src, long rate) 
	{
		lock.lock(); // Acquire lock
        PreparedStatement pstmt = null;
		long status=0;
		
        try 
		{
            //conn.setAutoCommit(false); // Disable auto-commit for transaction
			
            long psid = getNextStockId(conn);
            String recrdno = getRecordId(trDate, psid);
            long maxBalance = getRecentBalance(conn, branchId, partId, pModelId, recrdno);

			if(tr_type.equals("CREDIT"))
			{
				long newBalance = maxBalance + in_qty;

				String updateSql = "UPDATE PART_STOCK SET balance = balance + ? WHERE br_id = ? AND mat_id = ? AND pmodel_id = ? AND RECORD_ID > ?";
				pstmt = conn.prepareStatement(updateSql);
				pstmt.setLong(1, in_qty);
				pstmt.setLong(2, branchId);
				pstmt.setLong(3, partId);
				pstmt.setLong(4, pModelId);
				pstmt.setString(5, recrdno);
				pstmt.executeUpdate();

				String insertSql = "INSERT INTO PART_STOCK (ID, MAT_ID, TR_DATE, INWARD, OUTWARD, BALANCE, RECORD_ID, BR_ID, "
								 + "SRC, INSTALL_ID, PMODEL_ID, USER_ID, PURCHASE_ID, ENGG_STOCK_ID, PRINTER_REP_ID, "
								 + "FC_RETURN_ID, PRINTER_SCRAP_ID, RATE) "
								 + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
				pstmt = conn.prepareStatement(insertSql);
				pstmt.setLong(1, psid);
				pstmt.setLong(2, partId);
				pstmt.setString(3, trDate);
				pstmt.setLong(4, in_qty); // Inward quantity
				pstmt.setLong(5, out_qty); // Outward quantity
				pstmt.setLong(6, newBalance); // Updated balance
				pstmt.setString(7, recrdno); // Record number
				pstmt.setLong(8, branchId);
				pstmt.setLong(9, src); // Assuming SRC is 8
				pstmt.setLong(10, installId);
				pstmt.setLong(11, pModelId);
				pstmt.setString(12, userId);
				pstmt.setLong(13, purID);
				pstmt.setLong(14, enggStkId);
				pstmt.setLong(15, pRepId);
				pstmt.setLong(16, fltRetId);
				pstmt.setLong(17, pScrapeId);
				pstmt.setLong(18, rate);
				pstmt.executeUpdate();

				conn.commit();
				//conn.setAutoCommit(true);
				status=1;
				System.out.println("Stock inserted successfully with updated balance!");
			}
			else
			if(tr_type.equals("DEBIT"))
			{
				if (maxBalance >= out_qty) 
				{
					long newBalance = maxBalance - out_qty;

					String updateSql = "UPDATE PART_STOCK SET balance = balance - ? WHERE br_id = ? AND mat_id = ? AND pmodel_id = ? AND RECORD_ID > ?";
					pstmt = conn.prepareStatement(updateSql);
					pstmt.setLong(1, out_qty);
					pstmt.setLong(2, branchId);
					pstmt.setLong(3, partId);
					pstmt.setLong(4, pModelId);
					pstmt.setString(5, recrdno);
					pstmt.executeUpdate();

					String insertSql = "INSERT INTO PART_STOCK (ID, MAT_ID, TR_DATE, INWARD, OUTWARD, BALANCE, RECORD_ID, BR_ID, "
									 + "SRC, INSTALL_ID, PMODEL_ID, USER_ID, PURCHASE_ID, ENGG_STOCK_ID, PRINTER_REP_ID, "
									 + "FC_RETURN_ID, PRINTER_SCRAP_ID, RATE) "
									 + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
					pstmt = conn.prepareStatement(insertSql);
					pstmt.setLong(1, psid);
					pstmt.setLong(2, partId);
					pstmt.setString(3, trDate);
					pstmt.setLong(4, in_qty); // Inward quantity
					pstmt.setLong(5, out_qty); // Outward quantity
					pstmt.setLong(6, newBalance); // Updated balance
					pstmt.setString(7, recrdno); // Record number
					pstmt.setLong(8, branchId);
					pstmt.setLong(9, src); // Assuming SRC is 8
					pstmt.setLong(10, installId);
					pstmt.setLong(11, pModelId);
					pstmt.setString(12, userId);
					pstmt.setLong(13, purID);
					pstmt.setLong(14, enggStkId);
					pstmt.setLong(15, pRepId);
					pstmt.setLong(16, fltRetId);
					pstmt.setLong(17, pScrapeId);
					pstmt.setLong(18, rate);
					pstmt.executeUpdate();

					conn.commit();
					//conn.setAutoCommit(true);
					status=1;
				}
				else 
				{
					status=2;
				}
			}
			if(pstmt!=null){pstmt.close();}
        } 
		catch (SQLException e) 
		{
            e.printStackTrace();
            try 
			{
                if (conn != null) conn.rollback(); // Rollback on error
				//conn.setAutoCommit(true);
				if(pstmt!=null){pstmt.close();}
            } 
			catch (SQLException ex) 
			{
                ex.printStackTrace();
            }
        } 
		finally 
		{
            try 
			{
                if (pstmt != null) pstmt.close();
				//conn.setAutoCommit(true);
				if(pstmt!=null){pstmt.close();}
            } 
			catch (SQLException e) 
			{
                e.printStackTrace();
            }
            lock.unlock(); // Release lock
        }
		
		return status;
    }

    public long deleteStock(Connection conn, String userId, long src, String recrdno) 
	{
		lock.lock(); // Acquire lock
        PreparedStatement pstmt = null;
		long status=0, inward=0, outward=0, partid=0, pmodelid=0, brid=0;
		
        try 
		{
            //conn.setAutoCommit(false); // Disable auto-commit for transaction
			Statement st1 = conn.createStatement();
			ResultSet rs1 = null;
			
			if (recrdno != null && recrdno.length() > 0 ) 
			{
				String str1="select INWARD, OUTWARD, MAT_ID, PMODEL_ID, br_id from PART_STOCK where RECORD_ID='"+recrdno+"'";
				rs1=st1.executeQuery(str1);
				if(rs1.next())
				{
				    inward=rs1.getLong(1);
				    outward=rs1.getLong(2);
				    partid=rs1.getLong(3);
				    pmodelid=rs1.getLong(4);
				    brid=rs1.getLong(5);
					
					if(inward>0)
					{
						String updateSql = "UPDATE PART_STOCK SET balance = balance - ? WHERE br_id = ? AND mat_id = ? AND pmodel_id = ? AND RECORD_ID > ?";
						pstmt = conn.prepareStatement(updateSql);
						pstmt.setLong(1, inward);
						pstmt.setLong(2, brid);
						pstmt.setLong(3, partid);
						pstmt.setLong(4, pmodelid);
						pstmt.setString(5, recrdno);
						pstmt.executeUpdate();
					}
					else
					if(outward>0)
					{
						String updateSql = "UPDATE PART_STOCK SET balance = balance + ? WHERE br_id = ? AND mat_id = ? AND pmodel_id = ? AND RECORD_ID > ?";
						pstmt = conn.prepareStatement(updateSql);
						pstmt.setLong(1, outward);
						pstmt.setLong(2, brid);
						pstmt.setLong(3, partid);
						pstmt.setLong(4, pmodelid);
						pstmt.setString(5, recrdno);
						pstmt.executeUpdate();
					}
					
					String updateSql1 = "INSERT INTO PART_STOCK_RC(SELECT * FROM PART_STOCK WHERE RECORD_ID=?)";
					pstmt = conn.prepareStatement(updateSql1);
					pstmt.setLong(1, brid);
					pstmt.setLong(2, partid);
					pstmt.setLong(3, pmodelid);
					pstmt.setString(4, recrdno);
					pstmt.executeUpdate();
					
					updateSql1 = "UPDATE PART_STOCK_RC SET COMMENTS = CONCAT(COMMENTS, ?) WHERE RECORD_ID = ?";
					pstmt = conn.prepareStatement(updateSql1);
					pstmt.setString(1, " Deleted by "+userId+" .");
					pstmt.setString(2, recrdno);
					pstmt.executeUpdate();
					
					updateSql1 = "DELETE FROM PART_STOCK WHERE RECORD_ID=?";
					pstmt = conn.prepareStatement(updateSql1);
					pstmt.setString(1, recrdno);
					pstmt.executeUpdate();
				}

				conn.commit();
				//conn.setAutoCommit(true);
				status=1;
			}
			
			if(rs1!=null){rs1.close();}
			if(st1!=null){st1.close();}
			if(pstmt!=null){pstmt.close();}
        } 
		catch (SQLException e) 
		{
            e.printStackTrace();
            try 
			{
                if (conn != null) conn.rollback(); // Rollback on error
				//conn.setAutoCommit(true);
				if(pstmt!=null){pstmt.close();}
            } 
			catch (SQLException ex) 
			{
                ex.printStackTrace();
            }
        } 
		finally 
		{
            try 
			{
                if (pstmt != null) pstmt.close();
				//conn.setAutoCommit(true);
				if(pstmt!=null){pstmt.close();}
            } 
			catch (SQLException e) 
			{
                e.printStackTrace();
            }
            lock.unlock(); // Release lock
        }
		
		return status;
    }

    public long editStock(Connection conn, String userId, long src, String recrdno, long in_qty, long out_qty, long rate) 
	{
		lock.lock(); // Acquire lock
        PreparedStatement pstmt = null;
		long status=0, inward=0, outward=0, partid=0, pmodelid=0, brid=0, balance=0, diff=0;
		String str1="";
		
        try 
		{
            //conn.setAutoCommit(false); // Disable auto-commit for transaction
			
			Statement st1 = conn.createStatement();
			ResultSet rs1 = null;
			
			if (recrdno != null && recrdno.length() > 0 ) 
			{
				str1="select INWARD, OUTWARD, BALANCE, MAT_ID, PMODEL_ID, br_id from PART_STOCK where RECORD_ID='"+recrdno+"'";
				rs1=st1.executeQuery(str1);
				if(rs1.next())
				{
				    inward=rs1.getLong(1);
				    outward=rs1.getLong(2);
				    balance=rs1.getLong(3);
				    partid=rs1.getLong(4);
				    pmodelid=rs1.getLong(5);
				    brid=rs1.getLong(6);
					
					if( in_qty > 0 )
					{
						if( in_qty > inward )
						{
							// increase
							diff = in_qty - inward;
							
							str1 = "UPDATE PART_STOCK SET  balance = balance + ? WHERE br_id = ? AND mat_id = ? AND pmodel_id = ? AND RECORD_ID > ?";
							pstmt = conn.prepareStatement(str1);
							pstmt.setLong(1, diff);
							pstmt.setLong(2, brid);
							pstmt.setLong(3, partid);
							pstmt.setLong(4, pmodelid);
							pstmt.setString(5, recrdno);
							pstmt.executeUpdate();
							
							str1 = "UPDATE PART_STOCK SET inward=? and balance=balance+? and COMMENTS = CONCAT(COMMENTS, ?) WHERE RECORD_ID = ?";
							pstmt = conn.prepareStatement(str1);
							pstmt.setLong(1, in_qty);
							pstmt.setLong(2, diff);
							pstmt.setString(3, " Qty increase by "+userId+" .");
							pstmt.setString(4, recrdno);
							pstmt.executeUpdate();
						}
						else
						if( in_qty < inward )
						{
							// descrease 
							diff = inward - in_qty;
							
							str1 = "UPDATE PART_STOCK SET  balance = balance - ? WHERE br_id = ? AND mat_id = ? AND pmodel_id = ? AND RECORD_ID > ?";
							pstmt = conn.prepareStatement(str1);
							pstmt.setLong(1, diff);
							pstmt.setLong(2, brid);
							pstmt.setLong(3, partid);
							pstmt.setLong(4, pmodelid);
							pstmt.setString(5, recrdno);
							pstmt.executeUpdate();
							
							str1 = "UPDATE PART_STOCK SET inward=? and balance=balance-? and COMMENTS = CONCAT(COMMENTS, ?) WHERE RECORD_ID = ?";
							pstmt = conn.prepareStatement(str1);
							pstmt.setLong(1, in_qty);
							pstmt.setLong(2, diff);
							pstmt.setString(3, " Qty descrease by "+userId+" .");
							pstmt.setString(4, recrdno);
							pstmt.executeUpdate();
						}
					}
					else
					if( out_qty > 0 )
					{
						if( out_qty > outward )
						{
							// increase
							diff = out_qty - outward;
							
							str1 = "UPDATE PART_STOCK SET  balance = balance - ? WHERE br_id = ? AND mat_id = ? AND pmodel_id = ? AND RECORD_ID > ?";
							pstmt = conn.prepareStatement(str1);
							pstmt.setLong(1, diff);
							pstmt.setLong(2, brid);
							pstmt.setLong(3, partid);
							pstmt.setLong(4, pmodelid);
							pstmt.setString(5, recrdno);
							pstmt.executeUpdate();
							
							str1 = "UPDATE PART_STOCK SET outward=? and balance=balance-? and COMMENTS = CONCAT(COMMENTS, ?) WHERE RECORD_ID = ?";
							pstmt = conn.prepareStatement(str1);
							pstmt.setLong(1, out_qty);
							pstmt.setLong(2, diff);
							pstmt.setString(3, " Qty increase by "+userId+" .");
							pstmt.setString(4, recrdno);
							pstmt.executeUpdate();
						}
						else
						if( out_qty < outward )
						{
							// descrease 
							diff = outward - out_qty;
							
							str1 = "UPDATE PART_STOCK SET  balance = balance + ? WHERE br_id = ? AND mat_id = ? AND pmodel_id = ? AND RECORD_ID > ?";
							pstmt = conn.prepareStatement(str1);
							pstmt.setLong(1, diff);
							pstmt.setLong(2, brid);
							pstmt.setLong(3, partid);
							pstmt.setLong(4, pmodelid);
							pstmt.setString(5, recrdno);
							pstmt.executeUpdate();
							
							str1 = "UPDATE PART_STOCK SET outward=? and balance=balance+? and COMMENTS = CONCAT(COMMENTS, ?) WHERE RECORD_ID = ?";
							pstmt = conn.prepareStatement(str1);
							pstmt.setLong(1, out_qty);
							pstmt.setLong(2, diff);
							pstmt.setString(3, " Qty descrease by "+userId+" .");
							pstmt.setString(4, recrdno);
							pstmt.executeUpdate();
						}
						else
						{
//							pstmt=conn.prepareStatement("update PART_STOCK set TR_DATE=?, INWARD=?, RATE=? where record_id=?");
//							pstmt.setString(1, sdate);
//							pstmt.setLong(2, mqty);
//							pstmt.setString(3, mrate);
//							pstmt.setLong(4, stockid);
//							pstmt.executeUpdate();
						}
					}
				}

				conn.commit();
				//conn.setAutoCommit(true);
				status=1;
			}
			
			if(rs1!=null){rs1.close();}
			if(st1!=null){st1.close();}
			if(pstmt!=null){pstmt.close();}
        } 
		catch (SQLException e) 
		{
            e.printStackTrace();
            try 
			{
                if (conn != null) conn.rollback(); // Rollback on error
				//conn.setAutoCommit(true);
				if(pstmt!=null){pstmt.close();}
            } 
			catch (SQLException ex) 
			{
                ex.printStackTrace();
            }
        } 
		finally 
		{
            try 
			{
                if (pstmt != null) pstmt.close();
				//conn.setAutoCommit(true);
				if(pstmt!=null){pstmt.close();}
            } 
			catch (SQLException e) 
			{
                e.printStackTrace();
            }
            lock.unlock(); // Release lock
        }
		
		return status;
    }


    private String getRecordId(String trDate, long psid) 
	{
        String str1 = "000000000000000";
        String str2 = "0000000";
        String str3 = "00000000";
        try 
		{
            if (trDate != null && !trDate.isEmpty() && trDate.length() == 10) 
			{
                str3 = trDate.substring(0, 4) + trDate.substring(5, 7) + trDate.substring(8, 10);
            }
            str2 = String.valueOf(psid);

            switch (str2.length()) 
			{
                case 1:
                    str2 = "000000" + str2;
                    break;
                case 2:
                    str2 = "00000" + str2;
                    break;
                case 3:
                    str2 = "0000" + str2;
                    break;
                case 4:
                    str2 = "000" + str2;
                    break;
                case 5:
                    str2 = "00" + str2;
                    break;
                case 6:
                    str2 = "0" + str2;
                    break;
                default:
                    break;
            }

            str1 = str3 + str2;

        } catch (Exception e) 
		{
            // Handle exception if necessary
        }
        return str1;
    }

}
