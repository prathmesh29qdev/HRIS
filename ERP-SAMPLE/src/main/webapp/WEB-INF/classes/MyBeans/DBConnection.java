package MyBeans;

import java.io.PrintStream;
import java.sql.*;

public class DBConnection
{

    Connection con;
    static DBConnection dbcon = null;

    private DBConnection()
        throws Exception
    {
        con = null;
        Class.forName("oracle.jdbc.driver.OracleDriver");
        if(con == null || con.isClosed())
        {
        	con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/xePDB1", "printer", "ppc");
        }
        System.out.println("Log : " + (con != null ? "FOUND !!!!!!!!!!!" : "Not FOUND !!!!!!!!!!"));
    }

    public static DBConnection getInstance()
        throws Exception
    {
        if(dbcon == null)
        {
            dbcon = new DBConnection();
        }
        return dbcon;
    }

    public Connection getConnection()
    {
        try
        {
            if(con == null || con.isClosed())
            {
            	con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/xePDB1", "printer", "ppc");
            }
        }
        catch(SQLException sqlexception)
        {
            System.out.println((new StringBuilder("Error Occured getting Conection ")).append(sqlexception).toString());
        }
        return con;
    }

    public static void close(Connection connection, Statement statement, PreparedStatement preparedstatement, ResultSet resultset)
    {
        try
        {
            if(connection != null)
            {
                connection.close();
                connection = null;
            }
            if(statement != null)
            {
                statement.close();
                statement = null;
            }
            if(preparedstatement != null)
            {
                preparedstatement.close();
                preparedstatement = null;
            }
            if(resultset != null)
            {
                resultset.close();
                resultset = null;
            }
        }
        catch(Exception exception)
        {
            System.out.println((new StringBuilder("Exception In close Method Of DBConnection Class ")).append(exception.getMessage()).toString());
        }
    }

    public static DBConnection getNewInstance()
        throws Exception
    {
        return new DBConnection();
    }

}
