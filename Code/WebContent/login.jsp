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
		//Query person, see if username and password combination exists
		//if qresult.getString("username") != quserName && qresult.getString("password") != qpassword
			//error: invalid username and password combination. 
			
		//Check if they are a representative. 
			//If they are a representative, give them representative options. 
			//Else, give them typical user options. 
		Statement qstmt = con.createStatement();
		String quserName = request.getParameter("usrname");
		String qpassword = request.getParameter("passwrd");
		String quserNameSelect = "SELECT * FROM users U WHERE U.username = '" + quserName + "'";
		ResultSet qresult = qstmt.executeQuery(quserNameSelect);
		
		int isRepresentative = 0;
		int isAdmin = 0;
		int loginSuccess = 0;
		while(qresult.next()){
			if(qresult.getString("username").equalsIgnoreCase(quserName) && qresult.getString("password").equals(qpassword)){
				//successful login. 
				loginSuccess = 1;
				//out.print("successful login");
				out.print("Hello " + quserName);
				if(qresult.getInt("representative") == 1){
					isRepresentative = 1;
				}
		
			}
			break;
		}
		if(loginSuccess == 0){
			out.print("error: invalid username and password combination");
		} else if(isRepresentative == 1){
			//Give representative options.
			
			out.print("<br>");
			
			//To AIRPORT data manipulation.
   			out.print("<form method=\"post\" action=\"repAirports.jsp\">");
   				out.print("<input type=\"hidden\" name=\"username\" value=\""+ quserName + "\" >");
   				out.print("<input type=\"hidden\" name=\"password\" value=\""+ qpassword + "\" >");
   				out.print("<input type=\"submit\" name=\"forward\" value=\"airports\" >");
   			out.print("</form>");
   			out.print("<br>");
   
   			//To AIRCRAFT data manipulation
   			out.print("<form method=\"post\" action=\"repAircrafts.jsp\">");
   				out.print("<input type=\"hidden\" name=\"username\" value=\""+ quserName + "\" >");
   				out.print("<input type=\"hidden\" name=\"password\" value=\""+ qpassword + "\" >");
   				out.print("<input type=\"submit\" name=\"forward\" value=\"aircrafts\" >");
   			out.print("</form>");
   			//To FLIGHTS data manipulation
   			out.print("<form method=\"post\" action=\"repFlights.jsp\">");
   				out.print("<input type=\"hidden\" name=\"username\" value=\""+ quserName + "\" >");
   				out.print("<input type=\"hidden\" name=\"password\" value=\""+ qpassword + "\" >");
   				out.print("<input type=\"submit\" name=\"forward\" value=\"flights\" >");
   			out.print("</form>");
   			
   			
   			
   			 
			//Radio: aircrafts, airports, flights
				//Search airports
				//Add airports
				//Delete airports, no idea why a rep should be able to do that but whatever. 
			
		} else{
			//Search
			//Leaving from airport... [], Destination airport.... [] , one-way/roundtrip, date
		
			out.print("<br>");
			out.print("<br>");
			out.print("<form method=\"post\" action=\"userSearch.jsp\">");
				out.print("<table>");
					out.print("<tr>");
						out.print("<b>Search</b>");
					out.print("</tr>");
					out.print("<tr>");
						out.print("<td>");
							out.print("Departing airport(e.g. LAX)");
						out.print("</td>");
						out.print("<td>");
							out.print("<input type=\"text\" name=\"departAirportID\">");
						out.print("</td>");
						out.print("<td>");
							out.print("Destination airport");
						out.print("</td>");
						out.print("<td>");
							out.print("<input type=\"text\" name=\"destinationAirportID\">");
						out.print("</td>");
						out.print("<td>");
							out.print("one-way <input type=\"radio\" name=\"command\" value=\"oneWay\"/>");
						out.print("</td>");
						out.print("<td>");
							out.print("roundtrip <input type=\"radio\" name=\"command\" value=\"roundTrip\"/>");						
						out.print("</td>");
					
					out.print("</tr>");
					out.print("<tr>");
						out.print("");
					out.print("</tr>");
				out.print("</table>");
				out.print("<input type=\"hidden\" name=\"username\" value=\""+ quserName + "\" >");
   				out.print("<input type=\"hidden\" name=\"password\" value=\""+ qpassword+ "\" >");
				out.print("<input type=\"submit\" value=\"Search!\">");
			out.print("</form>");
			out.print("<br>");
		}
		/*
		out.print("<br>");
		out.print("<table>");
			//make a row
			out.print("<tr>");
				//make a column
				out.print("<td>");
					//print out column header
					out.print("username");
				out.print("</td>");
				//make a column
				out.print("<td>");
					out.print("password");
				out.print("</td>");
			out.print("</tr>");
		while(qresult.next()){
			//make a row
			out.print("<tr>");
				//make a column
				out.print("<td>");
			
					out.print(qresult.getString("username"));
				out.print("</td>");
				out.print("<td>");
					out.print(qresult.getString("password"));
				out.print("</td>");
			out.print("</tr>");

		}
		out.print("</table>"); */
		/*Start print query logic
		out.print("<table>");
			out.print("<td>");
				out.print("username");
			out.print("</td>");
		while (qresult.next()) {
			out.print("<td>");
				out.print(qresult.getString("username"));
			out.print("</td>");
		}
		out.print("</table>");
		//End print query logc */
		//End query logic
		
		
		
		

		
		/*
		String newBar = request.getParameter("bar");
		String newBeer = request.getParameter("beer");
		float price = Float.valueOf(request.getParameter("price"));


		//Make an insert statement for the Sells table:
		String insert = "INSERT INTO bars(name)"
				+ "VALUES (?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, newBar);
		ps.executeUpdate();

		
		//Make an insert statement for the Sells table:
		insert = "INSERT INTO beers(name)"
				+ "VALUES (?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		ps = con.prepareStatement(insert);
		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself		
		ps.setString(1, newBeer);
		ps.executeUpdate();

		
		//Make an insert statement for the Sells table:
		insert = "INSERT INTO sells(bar, beer, price)"
				+ "VALUES (?, ?, ?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, newBar);
		ps.setString(2, newBeer);
		ps.setFloat(3, price);
		//Run the query against the DB
		ps.executeUpdate();
		//Run the query against the DB
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated. */
		con.close();
		out.print("login succeeded");
		
		
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