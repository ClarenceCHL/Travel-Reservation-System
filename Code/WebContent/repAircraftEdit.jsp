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

			
		//Will be used so we can go to the previous page without having the user log in again. 	
		String repUsername = request.getParameter("username");
		String repPassword = request.getParameter("password");
		
		
		out.print("<br>");
		out.print("rep username: " + repUsername);
		out.print("<br>");
		out.print("rep password: " + repPassword);
		out.print("<br>");
		
		//Strings that store the desired add airport information
		String repAircraftID = request.getParameter("aircraftID");
		String repAircraftName = request.getParameter("aircraftName");
		String repAirlineID = request.getParameter("airlineID");
		
		
		//This will be the page that handles all changes to airports from the representative, as instructed by the project guidelines
		
		//Add, delete, edit. 
		//The only thing airports have is a unique ID and a (non unique) name
		
		//Edit
			//The only information that can be edited is the name. 
			//I have decided to add a name to the airport, this will help I believe, and if not its easy to remove.
			//The only thing we'll be editing is the name, if the airport exists. 
	
			
		//Create a SQL statement
		Statement stmt = con.createStatement();
		//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
		//String str = "SELECT * FROM sells WHERE price <= " + entity;
		
		String str = "SELECT A.aircraftID FROM aircraft A";
		//Run the query against the database.
		ResultSet result = stmt.executeQuery(str);
		
		
		
		//See if there is a match in result. 
		int match = 0;
		while(result.next()){
			if(result.getString("aircraftID").equalsIgnoreCase(repAircraftID)){
				match = 1;
				break;
			}
			
		}
		
		if(match == 1){
		
			//Make sure that airlineID exists in airline table. 
			int validAirlineID = 0;
			Statement airlinestmt = con.createStatement();
			String airlinequery = "SELECT A.airlineID FROM airline A";
			ResultSet airlineIDResult = airlinestmt.executeQuery(airlinequery);
			while(airlineIDResult.next()){
				if(airlineIDResult.getString("airlineID").equalsIgnoreCase(repAirlineID)){
					validAirlineID = 1;
					break;
				}
			}
			
			if(validAirlineID == 1){
				//Match, change the airport name to the new name. 
				out.print("Found aircraft... updating name and airline");
				out.print("<br>");
				
				String nameUpdate = "UPDATE aircraft SET name=\"" + repAircraftName + "\" WHERE aircraftID=\"" + repAircraftID + "\"";
								//UPDATE airport SET name='repAirportName' WHERE airportID='repAirportID'
				String airlineIDUpdate = "UPDATE aircraft SET airlineID=\"" + repAirlineID + "\" WHERE aircraftID=\"" + repAircraftID + "\"";
				PreparedStatement ps = con.prepareStatement(nameUpdate);
				ps.executeUpdate();
				
				
				PreparedStatement airlineIDps = con.prepareStatement(airlineIDUpdate);
				airlineIDps.executeUpdate();
				
				out.print("Aircraft name and airlineID updated.");
				out.print("<br>"); 
			} else{
				out.print("Aircfaft name and airlineID not updated. airlineID does not exist in database.");
				out.print("<br>"); 
			}

		} else{
			out.print("<br>");
			out.print("AircraftID not found... if you want to add an aircraft, use the Add aircraft field on the previous screen. ");
			

		}
		out.print("<form method=\"post\" action=\"login.jsp\">");
		out.print("<input type=\"hidden\" name=\"usrname\" value=\"" + repUsername + "\">");
		out.print("<input type=\"hidden\" name=\"passwrd\" value=\"" + repPassword + "\">");
		out.print("<input type=\"submit\" name=\"back2\" value=\"Home\">");
		/*<input type=\"hidden\" name=\"usrname\" value=\"" + repUsername + "\"" >
		<input type="hidden" name="passwrd" value=>
		<input type=\"submit\" name=\"back2\" value=\"Home\"> */
		out.print("</form>");
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated. */
		con.close();
		out.print("<br>");
		out.print("aircraft edit page succeeded");
		out.print("<br>");
		
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("aircraft edit page failed");
	}
%>
<form method="post" action="index.jsp">
<input type="submit" name="back" value="logout">
</form>
</body>
</html>