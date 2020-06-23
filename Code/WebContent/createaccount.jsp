<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
	try {

		//Get the database connection - Replacing with... you know
			//ApplicationDB db = new ApplicationDB();	
			//Connection con = db.getConnection();
			
			ApplicationDB db = new ApplicationDB();	
			//Create a connection string
			//String url = "jdbc:mysql://database-4-joe.cr5cf4b6w6l2.us-east-2.rds.amazonaws.com:3306/flavorProfile";
			String url = "jdbc:mysql://database-4-joe.cr5cf4b6w6l2.us-east-2.rds.amazonaws.com:3306/BarBeerDrinkerSample";
			//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mys
			Class.forName("com.mysql.jdbc.Driver");
	
			//Get the database connection
			//ApplicationDB db = new ApplicationDB();	
			Connection con = DriverManager.getConnection(url, "admin", "tapExers556^");	
			//END REPLACING WITH

			
			
			
			
			
		//Create a SQL statement
		Statement stmt = con.createStatement();

		/*Get parameters from the HTML form at the index.jsp
		String userName = request.getParameter("usrname");
		String userNameInsert = "INSERT INTO users(username)"+"VALUES(?)";
		//Create a prepares Sql statement allowing you to introduce the parameters of the query
		PreparedStatement psu = con.prepareStatement(userNameInsert);
		psu.setString(1,userName);
		psu.executeUpdate(); end username insert */
		
		
		
		
		
		//Logic
		//Check if username exsists in users
			//If yes, error: username already taken
			//If no, insert username and password into users table. 
		
		
		
		
		
		//Query person, see if username and password combination exists
		//if qresult.getString("username") != quserName && qresult.getString("password") != qpassword
			//error: invalid username and password combination. 
			
			
		Statement qstmt = con.createStatement();
		String quserName = request.getParameter("usrname");
		String qpassword = request.getParameter("passwrd");
		String qname = request.getParameter("name");
		String quserNameSelect = "SELECT * FROM users U WHERE U.username = '" + quserName + "'";
		ResultSet qresult = qstmt.executeQuery(quserNameSelect);
		
		int userNameFound = 0;
		while(qresult.next()){
			if(qresult.getString("username").equalsIgnoreCase(quserName)){
				//successful login. 
				userNameFound = 1;
				out.print("username already taken");
			}
		}
		if(userNameFound == 0){
			out.print("Creating new user...");
			Statement istmt = con.createStatement();
			String insert = "INSERT INTO users(username, password, name)" + "VALUES(?,?,?)";
			PreparedStatement ps = con.prepareStatement(insert);
			ps.setString(1, quserName);
			ps.setString(2, qpassword);
			ps.setString(3, qname);
			ps.executeUpdate();
			//String insert = "INSERT INTO bars(name)"
				//	+ "VALUES (?)";
		}
		
		out.print("<br>");

		con.close();
		out.print("Account Creation Succeeded");
		
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("login failed");
	}
%>
<form method="post" action="index.jsp">
<input type="submit" name="back" value="logout" >
</form>
</body>
</html>