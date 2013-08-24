package dbConn;
import java.sql.*;
import oracle.jdbc.driver.*;
import oracle.sql.*;

public class Dbconn{
		Connection conn;
		String dbDriver = "oracle.jdbc.driver.OracleDriver";
			
		public Dbconn() throws Exception{
			Class.forName(dbDriver);
			String strUrl = "jdbc:oracle:thin:@210.42.24.100:1521:dbeleven";
			conn = DriverManager.getConnection(strUrl, "nicwf", "nicwf");				
		}
		
		public OracleCallableStatement prepareCall(String sql) throws Exception{
			return (OracleCallableStatement) conn.prepareCall(sql);
		}
				
	
		
	
		public Dbconn(String server,String name,String user,String password) throws Exception{
			Class.forName(dbDriver);
			String strUrl = "jdbc:oracle:thin:@"+server+":1521:"+name;
			conn = DriverManager.getConnection(strUrl,user,password);
		}
			
		public Statement createStatement() throws Exception{
   			return conn.createStatement();
  		}
  		
  		public String info(){
  			String information;
  			information = "Java connect to oracle9i testing";
  			return information;
  		}	
  		
  		public void close(){
  			try{
  				conn.close();	
  			}catch (Exception e){
  				System.out.println(e);
  			}
  		}
}