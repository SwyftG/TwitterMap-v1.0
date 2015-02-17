package edu.nyu.cloud;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;




public class DB {
	private Connection con;
	private PreparedStatement pstm;
	public static String dbName = ""; 
	public static String userName = "";
	public static String password = "";
	public static String hostname = "..u";
	public static String port = "";
	static String jdbcUrl = ;
	static String connectionString = "::" + port + "/" + dbName;
	public static Connection connection ;
	public static Statement command;
	



	public static void main(String[] args) throws SQLException, ClassNotFoundException {
		
		Class.forName("com.mysql.jdbc.Driver");
		
		
		connection =DriverManager.getConnection(jdbcUrl);
		command = connection.createStatement();
		
		//command.execute("CREATE TABLE Test (Name VARCHAR(20), Content VARCHAR(10000), Latitude VARCHAR(30), Longtitude VARCHAR(30), Time VARCHAR(50), Keyword VARCHAR(30))");
		//command.execute("INSERT INTO Test (Name, Content, Latitude, Longtitude, Time, Keyword) VALUES ('Rome', 'asdfasdfs', 'adsfaswdf', 'asdfasfwaFDA', '12.30','love')");
		//command.execute("DROP TABLE Test");
		System.out.print("OK");
		
	      ResultSet result = command.executeQuery("Select * FROM Test");
	      
	      while(result.next()){
				
				
				System.out.print(result.getString(1));
				System.out.print(result.getString(2));
				System.out.print(result.getString(3));
				System.out.print(result.getString(4));
				System.out.println(result.getString(5));
				System.out.println(result.getString(6));
					
	      }  
	      
	      //System.out.println(getNameArray());
	      //System.out.println(getNameArray()); 
	        connection.close();  
	}
	
	public static ArrayList<String> getNameArray() throws SQLException, ClassNotFoundException{
		Class.forName("com.mysql.jdbc.Driver");
		ArrayList<String> resultArray = new ArrayList<String>();
		connection =DriverManager.getConnection(jdbcUrl);
		command = connection.createStatement();

	      ResultSet result = command.executeQuery("Select * FROM Test");	      
	      while(result.next()){
				String s = result.getString(1);			
				resultArray.add(s);
				}
	      return resultArray;
		
		
	}
	
	public static ArrayList<String> getLongtitude () throws ClassNotFoundException, SQLException{
		Class.forName("com.mysql.jdbc.Driver");
		ArrayList<String> resultArray = new ArrayList<String>();
		connection =DriverManager.getConnection(jdbcUrl);
		command = connection.createStatement();

	      ResultSet result = command.executeQuery("Select * FROM Test");	      
	      while(result.next()){
				String s = result.getString(4);			
				resultArray.add(s);
				}
	      return resultArray;						
	}
	
	
	public static ArrayList<String> getLatitude() throws ClassNotFoundException, SQLException{
		Class.forName("com.mysql.jdbc.Driver");
		ArrayList<String> resultArray = new ArrayList<String>();
		connection =DriverManager.getConnection(jdbcUrl);
		command = connection.createStatement();

	      ResultSet result = command.executeQuery("Select * FROM Test");	      
	      while(result.next()){
				String s = result.getString(3);			
				resultArray.add(s);
				}
	      return resultArray;						
	}

	public static ArrayList<String> getContent() throws ClassNotFoundException, SQLException{
		Class.forName("com.mysql.jdbc.Driver");
		ArrayList<String> resultArray = new ArrayList<String>();
		connection =DriverManager.getConnection(jdbcUrl);
		command = connection.createStatement();

	      ResultSet result = command.executeQuery("Select * FROM Test");	      
	      while(result.next()){
				String s = result.getString(2);			
				resultArray.add(s);
				}
	      return resultArray;						
	}
	
	public static ArrayList<String> getTimeArray() throws SQLException, ClassNotFoundException{
		Class.forName("com.mysql.jdbc.Driver");
		ArrayList<String> resultArray = new ArrayList<String>();
		connection =DriverManager.getConnection(jdbcUrl);
		command = connection.createStatement();

	      ResultSet result = command.executeQuery("Select * FROM Test");	      
	      while(result.next()){
				String s = result.getString(5);			
				resultArray.add(s);
				}
	      return resultArray;
		
		
	}
	public static ArrayList<String> getKeywordArray() throws SQLException, ClassNotFoundException{
		Class.forName("com.mysql.jdbc.Driver");
		ArrayList<String> resultArray = new ArrayList<String>();
		connection =DriverManager.getConnection(jdbcUrl);
		command = connection.createStatement();

	      ResultSet result = command.executeQuery("Select * FROM Test");	      
	      while(result.next()){
				String s = result.getString(6);			
				resultArray.add(s);
				}
	      return resultArray;	
	}
}
