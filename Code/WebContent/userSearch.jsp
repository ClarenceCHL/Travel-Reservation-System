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
		
		String departAirportID = request.getParameter("departAirportID");
		String destinationAirportID = request.getParameter("destinationAirportID");
		String oneWayOrAnother = request.getParameter("command");
		
		out.print("userDepartAirportID: "+ departAirportID);
		out.print("<br>");
		
		if(oneWayOrAnother.equals("oneWay")){
			//Leaving date [], Flexibile? yes/no	
			out.print("<br>");
			out.print("<form method=\"post\" action=\"userSearchOneWay.jsp\">");
				out.print("<table>");
					out.print("<tr>");
						out.print("Search");
					out.print("</tr>");
					out.print("<tr>");
						out.print("<td>");
							out.print("Leaving date YYYY-MM-DD");
						out.print("</td>");
						out.print("<td>");
							out.print("<input type=\"text\" name=\"leavingDate\">");
						out.print("</td>");
						out.print("<td>");
							out.print("Flexible?");
						out.print("</td>");
						out.print("<td>");
							out.print("yes <input type=\"radio\" name=\"command\" value=\"yes\"/>");
						out.print("</td>");
						out.print("<td>");
							out.print("no <input type=\"radio\" name=\"command\" value=\"no\"/>");						
						out.print("</td>");
					out.print("</tr>");
			
				out.print("</table>");
				out.print("<input type=\"hidden\" name=\"maxPrice\" value=\"NaN\">");
				out.print("<input type=\"hidden\" name=\"minPrice\" value=\"NaN\">");
				out.print("<input type=\"hidden\" name=\"departAirportID\" value=\""+ departAirportID + "\" >");
				out.print("<input type=\"hidden\" name=\"destinationAirportID\" value=\""+ destinationAirportID + "\" >");
				out.print("<input type=\"hidden\" name=\"username\" value=\""+ repUsername + "\" >");
   				out.print("<input type=\"hidden\" name=\"password\" value=\""+ repPassword + "\" >");
				out.print("<input type=\"submit\" value=\"Search!\">");
			out.print("</form>");
			out.print("<br>");
					
		} else{
			//Leave date, return date, flexible? yes/no
		}


		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated. */
		con.close();
		out.print("search checkpoint page succeeded");
		
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("search checkpoint page failed");
	}
%>
<form method="post" action="index.jsp">
<input type="submit" name="back" value="logout" >
</form>
</body>
</html>