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

		//This will be the page that handles all changes to airports from the representative, as instructed by the project guidelines
		
		//Add, delete, edit. 
		//The only thing airports have is a unique ID. 
		//Add
			//Will see if the airportID is already in the list of airports
				//If yes, it will not add it to the table
				//If no, it will add it, and the provided name,  to the table. 
		//Delete
			//Will see if the airportId is in the list of airports
				//If yes, it will remove the airport. 
				//If no, it will do nothing.
		//Edit
			//The only information that can be edited is the ID. Maybe I do want the airport name just to implement this functionality.
			//I have decided to add a name to the airport, this will help I believe, and if not its easy to remove.
			
		//ADD
			//A form with two fields. ID and name. 
			
			//what do I actually want this to do. I don't want it to load a new page. 
			//Screw it it will load a page. 
			out.print("<br>");
			out.print("<form method=\"post\" action=\"repAircraftAdd.jsp\">");
				out.print("<table>");
					out.print("<tr>");
						out.print("Add an aircraft");
					out.print("</tr>");
					out.print("<tr>");
						out.print("<td>");
							out.print("aircraftID");
						out.print("</td>");
						out.print("<td>");
							out.print("<input type=\"text\" name=\"aircraftID\">");
						out.print("</td>");
						out.print("<td>");
							out.print("name");
						out.print("</td>");
						out.print("<td>");
							out.print("<input type=\"text\" name=\"aircraftName\">");
						out.print("</td>");
						out.print("<td>");
							out.print("<input type=\"text\" name=\"airlineID\">");
						out.print("</td>");
					out.print("</tr>");
			
				out.print("</table>");
				out.print("<input type=\"hidden\" name=\"username\" value=\""+ repUsername + "\" >");
   				out.print("<input type=\"hidden\" name=\"password\" value=\""+ repPassword + "\" >");
				out.print("<input type=\"submit\" value=\"add!\">");
			out.print("</form>");
			out.print("<br>");
			
		//DELETE
			//a form with one field. airportID
			
			out.print("<br>");
			out.print("<form method=\"post\" action=\"repAircraftDelete.jsp\">");
				out.print("<table>");
					out.print("<tr>");
						out.print("Delete an aircraft");
					out.print("</tr>");
					out.print("<tr>");
						out.print("<td>");
							out.print("aircraftID");
						out.print("</td>");
						out.print("<td>");
							out.print("<input type=\"text\" name=\"aircraftID\">");
						out.print("</td>");

					out.print("</tr>");
			
				out.print("</table>");
				out.print("<input type=\"hidden\" name=\"username\" value=\""+ repUsername + "\" >");
   				out.print("<input type=\"hidden\" name=\"password\" value=\""+ repPassword + "\" >");
				out.print("<input type=\"submit\" value=\"Delete!\">");
			out.print("</form>");
		//EDIT
			//a form with two fields: airportID and name. 
			
			out.print("<br>");
			out.print("<form method=\"post\" action=\"repAircraftEdit.jsp\">");
				out.print("<table>");
					out.print("<tr>");
						out.print("Edit an aircraft");
					out.print("</tr>");
					out.print("<tr>");
						out.print("<td>");
							out.print("aircraftID");
						out.print("</td>");
						out.print("<td>");
							out.print("<input type=\"text\" name=\"aircraftID\">");
						out.print("</td>");
						out.print("<td>");
							out.print("name");
						out.print("</td>");
						out.print("<td>");
							out.print("<input type=\"text\" name=\"aircraftName\">");
						out.print("</td>");
						out.print("<td>");
							out.print("<input type=\"text\" name=\"airlineID\">");
						out.print("</td>");
					out.print("</tr>");
			
				out.print("</table>");
				out.print("<input type=\"hidden\" name=\"username\" value=\""+ repUsername + "\" >");
   				out.print("<input type=\"hidden\" name=\"password\" value=\""+ repPassword + "\" >");
				out.print("<input type=\"submit\" value=\"Edit!\">");
			out.print("</form>");
			
			
			
		
		out.print("<br>");
		out.print("<form method=\"post\" action=\"login.jsp\">");
			out.print("<input type=\"hidden\" name=\"usrname\" value=\"" + repUsername + "\">");
			out.print("<input type=\"hidden\" name=\"passwrd\" value=\"" + repPassword + "\">");
			out.print("<input type=\"submit\" name=\"back2\" value=\"Home\">");
		out.print("</form");
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated. */
		con.close();
		out.print("airport page succeeded");
		
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("airport page failed");
	}
%>
<form method="post" action="index.jsp">
<input type="submit" name="back" value="logout" >
</form>
</body>
</html>