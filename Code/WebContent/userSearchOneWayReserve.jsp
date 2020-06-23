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
		String repUsername = request.getParameter("usrname");
		String repPassword = request.getParameter("passwrd");
		
		
		out.print("<br>");
		out.print("rep usrname: " + repUsername);
		out.print("<br>");
		out.print("rep passwrd: " + repPassword);
		out.print("<br>");
		
		//Strings that store the desired add airport information
		/*
														 out.print("<form method=\"post\" action=\"userSearchOneWayReserve.jsp\">");
											 	 out.print("<input type=\"submit\" value=\"Business!\">");
													out.print("<input type=\"hidden\" name=\"usrname\" value=\"" + repUsername + "\">");
													out.print("<input type=\"hidden\" name=\"passwrd\" value=\"" + repPassword + "\">");
													//Choose random economy seat...
													
													String economyAttack = "SELECT S.seatNumber FROM seats S, trip T WHERE S.aircraftID=\""+flexresult.getString("aircraftID")+"\" AND S.seatClass=\"economy\" AND T.flightNumber = \""+flexresult.getString("flightNumber")+"\" AND T.tripDate=\""+flexDateCopy+"\" AND seatNumber NOT IN ( SELECT T.assignedSeatNumber FROM trip T, seats S WHERE T.aircraftID=\""+flexresult.getString("aircraftID")+"\" AND T.assignedSeatNumber = S.seatNumber AND T.flightNumber = \""+flexresult.getString("flightNumber")+"\" AND T.airlineID = \""+flexresult.getString("airlineID")+"\" AND T.tripDate=\""+flexDateCopy+"\")";

													Statement economyAttackSeat = con.createStatement();
													ResultSet economyAttackSeatResult = economyAttackSeat.executeQuery(economyAttack);
													economyAttackSeatResult.next();
													String personSeat2 = economyAttackSeatResult.getString("S.seatNumber");
													
													out.print("<input type=\"hidden\" name=\"airlineID\" value=\"" + flexresult.getString("airlineID") + "\">");
													out.print("<input type=\"hidden\" name=\"flightNumber\" value=\"" + flexresult.getString("flightNumber") + "\">");
													out.print("<input type=\"hidden\" name=\"departAirportID\" value=\"" + flexresult.getString("departAirportID") + "\">");
													out.print("<input type=\"hidden\" name=\"destinationAirportID\" value=\"" + flexresult.getString("destinationAirportID") + "\">");
													out.print("<input type=\"hidden\" name=\"aircraftID\" value=\"" + flexresult.getString("aircraftID") + "\">");
													out.print("<input type=\"hidden\" name=\"assignedSeatNumber\" value=\"" + personSeat2 + "\">");
													out.print("<input type=\"hidden\" name=\"tripDate\" value=\"" + flexDateCopy + "\">");
		*/
		
		String class1 = request.getParameter("class");
		String price = request.getParameter("price");
		String airlineID = request.getParameter("airlineID");
		String aircraftID = request.getParameter("aircraftID");
		String flightNumber = request.getParameter("flightNumber");
		String tripDate = request.getParameter("tripDate");
		String assignedSeatNumber = request.getParameter("assignedSeatNumber");

		
		//First the ticket.
		Statement tickstmt = con.createStatement();
		String ticketstr = "SELECT MAX(ticketNumber) AS maxtick FROM ticket";
		ResultSet tickResult = tickstmt.executeQuery(ticketstr);
		tickResult.next();
		String newTicketNum = tickResult.getString("maxtick");
		newTicketNum = newTicketNum+"1";
		
		Statement datestmt = con.createStatement();
		String datenow = "SELECT DATE(NOW())";
		ResultSet datenoweth =  datestmt.executeQuery(ticketstr);
		String mydate="";
		while(datenoweth.next()){
			//mydate = datenoweth.getString("lid");
		}
		//insert new ticket into the tickets table. 
		Statement iticketstmt = con.createStatement();
		//String iticketstr = "SELECT MAX(ticketNumber) AS maxtick FROM ticket";
		String iticketstr = "INSERT INTO ticket(ticketNumber, roundTrip, bookingFee,totalFare,issueDate,username)"
				+ "VALUES (?, ?, ?, ?,?,?)";
		PreparedStatement ticketPS = con.prepareStatement(iticketstr);
		ticketPS.setString(1,newTicketNum);
		ticketPS.setString(2,"0");
		ticketPS.setString(3,"50.00");
		ticketPS.setString(4,price);
		ticketPS.setString(5,"SELECT DATE(NOW())");
		ticketPS.setString(6,repUsername);
		ticketPS.executeUpdate();
		
		//Next the trip
			//Statement tripstmt = con.createStatement();
			//String ticketstr = "SELECT MAX(ticketNumber) AS maxtick FROM ticket";
			//ResultSet tickResult = tickstmt.executeQuery(ticketstr);
			//tickResult.next();
			//String newTicketNum = tickResult.getString("maxtick");
			//newTicketNum = newTicketNum+"1";
		
		//insert new trip into the trip table. 
		Statement tinsertstmt = con.createStatement();
		//String iticketstr = "SELECT MAX(ticketNumber) AS maxtick FROM ticket";
		String tinserttrip = "INSERT INTO trip(airlineID, flightNumber, aircraftID,ticketNumber,assignedSeatNumber,tripDate)"
				+ "VALUES (?, ?, ?, ?,?,?)";
		
		PreparedStatement tripPS = con.prepareStatement(tinserttrip);
		ticketPS.setString(1,airlineID);
		ticketPS.setString(2,flightNumber);
		ticketPS.setString(3,aircraftID);
		ticketPS.setString(4,newTicketNum);
		ticketPS.setString(5,assignedSeatNumber);
		ticketPS.setString(6,tripDate);
		ticketPS.executeUpdate();
		
		out.print("<br>");
		out.print("Thank you for your purchase!");
		out.print("<br>");
		
	
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
		out.print("airport add page succeeded");
		out.print("<br>");
		
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("airport add page failed");
	}
%>
<form method="post" action="index.jsp">
<input type="submit" name="back" value="logout">
</form>
</body>
</html>