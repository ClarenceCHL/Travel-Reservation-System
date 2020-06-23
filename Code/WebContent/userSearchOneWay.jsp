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
		
		//Strings that store the desired search information
		String userDepartAirportID = request.getParameter("departAirportID");
		String userDestinationAirportID = request.getParameter("destinationAirportID");
		String userLeavingDate = request.getParameter("leavingDate");
		String userFlexible = request.getParameter("command"); //yes or no
		
		out.print("userDepartAirportID: "+ userDepartAirportID);
		out.print("<br>");
		//Start by gettin the flights that meet this criteria. 
		
		//Select * FROM flights F WHERE f.departAirportID=userDepartAirportID AND f.destinationAirportID = userDestinationAirportID
			//If date is not flexible
				//Select * FROM flights F fliesOn FO WHERE f.departAirportID=userDepartAirportID AND f.destinationAirportID = userDestinationAirportID
				//AND FO.airlineID=F.airlineID AND FO.flightNumber=F.flightNumber AND FO.dayNumber=(SELECT DAYOFWEEK(userLeavingDate))
		if(userFlexible.equals("no")){
			out.print("userflexible? NO");
			out.print("<br>");
			
			//Create a SQL statement
			Statement noFlexStmt = con.createStatement();
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			//String str = "SELECT * FROM sells WHERE price <= " + entity;
																															//AND FO.airlineID=F.airlineID AND FO.flightNumber=F.flightNumber AND FO.dayNumber=(SELECT DAYOFWEEK(userLeavingDate))
			String str = "Select * FROM flights F, fliesOn FO WHERE F.departAirportID=\""+ userDepartAirportID+"\" AND F.destinationAirportID = \""+userDestinationAirportID+"\" AND FO.airlineID=F.airlineID AND FO.flightNumber=F.flightNumber AND FO.dayNumber=(SELECT DAYOFWEEK(\""+userLeavingDate+"\"))";
			//Run the query against the database.
			ResultSet result = noFlexStmt.executeQuery(str);
			
			//print the results.
			//Make an HTML Table to show the results in
			out.print("<table>");
				out.print("<tr>");
					out.print("<td>");
						out.print("airlineID");
					out.print("</td>");
					out.print("<td>");
						out.print("flightNumber");
					out.print("</td>");
					out.print("<td>");
						out.print("departAirportID");
					out.print("</td>");
					out.print("<td>");
						out.print("destinationAirportID");
					out.print("</td>");
					out.print("<td>");
						out.print("aircraftID");
					out.print("</td>");
					out.print("<td>");
						out.print("type");
					out.print("</td>");
					out.print("<td>");
						out.print("departTime");
					out.print("</td>");
					out.print("<td>");
						out.print("arriveTime");
					out.print("</td>");
					out.print("<td>");
						out.print("economyFare");
					out.print("</td>");
					out.print("<td>");
						out.print("businessFare");
					out.print("</td>");
					out.print("<td>");
						out.print("firstFare");
					out.print("</td>");
					out.print("<td>");
						out.print("Date");
					out.print("</td>");
					out.print("<td>");
						out.print("reserve");
					out.print("</td>");
				out.print("</tr>");
				
				while(result.next()){
					out.print("<tr>");
						out.print("<td>");
							out.print(result.getString("airlineID"));
						out.print("</td>");
						out.print("<td>");
							out.print(result.getString("flightNumber"));
						out.print("</td>");
						out.print("<td>");
							out.print(result.getString("departAirportID"));
						out.print("</td>");
						out.print("<td>");
							out.print(result.getString("destinationAirportID"));
						out.print("</td>");
						out.print("<td>");
							out.print(result.getString("aircraftID"));
						out.print("</td>");
						out.print("<td>");
							out.print(result.getString("type"));
						out.print("</td>");
						out.print("<td>");
							out.print(result.getString("departTime"));
						out.print("</td>");
						out.print("<td>");
							out.print(result.getString("arriveTime"));
						out.print("</td>");
						out.print("<td>");
							out.print(result.getString("economyFare"));
						out.print("</td>");
						out.print("<td>");
							out.print(result.getString("businessFare"));
						out.print("</td>");
						out.print("<td>");
							out.print(result.getString("firstFare"));
						out.print("</td>");
						out.print("<td>");
							out.print(userLeavingDate);
						out.print("</td>");
						out.print("<td>"); 
						//out.print("<input type=\"submit\" value=\"Economy!\">");
						//Go through trip
									String tripstr = "SELECT * FROM trip T WHERE T.airlineID=\""+ result.getString("airlineID")+"\" AND T.flightNumber=\""+result.getString("flightNumber")+"\" AND T.tripDate=\""+ userLeavingDate+"\"";
									
									//I want a count of how many people are in economy. 
			 						//String economystr = "SELECT DATE_SUB(\""+userLeavingDate+"\",INTERVAL 3 DAY) AS day";
									Statement economystmt = con.createStatement();
									ResultSet economyresult = economystmt.executeQuery(tripstr);
									
									int economycount = 0;
									int businesscount = 0;
									int firstclasscount = 0;
									int totalcount = 0;
									
									//audit to find out how many total economy seats there are
									String economySeats = "SELECT COUNT(*) AS economySeats FROM seats WHERE aircraftID=\"" + result.getString("aircraftID") + "\" AND seatClass=\"economy\"";
									String businessSeats = "SELECT COUNT(*) AS businessSeats FROM seats WHERE aircraftID=\"" + result.getString("aircraftID") + "\" AND seatClass=\"business\"";
									String firstSeats = "SELECT COUNT(*) AS firstSeats FROM seats WHERE aircraftID=\"" + result.getString("aircraftID") + "\" AND seatClass=\"first\"";
									String totalSeats = "SELECT COUNT(*) AS totalSeats FROM seats WHERE aircraftID=\"" + result.getString("aircraftID") +"\"";
									
									Statement econSeatstmt = con.createStatement();
									Statement businessSeatstmt = con.createStatement();
									Statement firstSeatstmt = con.createStatement();
									Statement totalSeatstmt = con.createStatement();
									
									
									ResultSet econSeatResult = econSeatstmt.executeQuery(economySeats);
									ResultSet businessSeatResult = businessSeatstmt.executeQuery(businessSeats);
									ResultSet firstSeatResult = firstSeatstmt.executeQuery(firstSeats);
									ResultSet totalSeatResult = totalSeatstmt.executeQuery(totalSeats);
									
									econSeatResult.next();
									businessSeatResult.next();
									firstSeatResult.next();
									totalSeatResult.next();
									
									economycount = Integer.parseInt(econSeatResult.getString("economySeats"));
									businesscount = Integer.parseInt(businessSeatResult.getString("businessSeats"));
									firstclasscount = Integer.parseInt(firstSeatResult.getString("firstSeats"));
									totalcount = Integer.parseInt(totalSeatResult.getString("totalSeats"));
									//  ---------
									int realEconomyCount = 0;
									int realBusinessCount = 0;
									int realFirstCount = 0;
									int realTotalCount = 0;
									while(economyresult.next()){
										//take the assignedSeatNumber, and aircraftID.
										String assignedSeatNumber = economyresult.getString("assignedSeatNumber");
										String aircraftID = economyresult.getString("aircraftID");
										
										
										//Now I have the the number of seats of each type. Now I want to see how many are in each section
										String personalAttack = "SELECT seatClass FROM seats WHERE aircraftID=\"" + aircraftID + "\" AND seatNumber=\""+assignedSeatNumber+"\"";
										Statement personSeat = con.createStatement();
										ResultSet personSeatresult = personSeat.executeQuery(personalAttack);
										personSeatresult.next();
										String personClass = personSeatresult.getString("seatClass");
										
										if(personClass.equalsIgnoreCase("economy")){
											realEconomyCount++;
											realTotalCount++;
										}else if(personClass.equalsIgnoreCase("business")){
											realBusinessCount++;
											realTotalCount++;
										} else if(personClass.equalsIgnoreCase("first")){
											realFirstCount++;
											realTotalCount++;
										}
										
										
									}
									// ------------------
									if(realTotalCount >= totalcount){
										out.print("No more seats....");
										out.print("<br>");
									} else {
			
										if(realFirstCount < firstclasscount){
											 out.print("<form method=\"post\" action=\"userSearchOneWayReserve.jsp\">");
										 	 out.print("<input type=\"submit\" value=\"firstClass!\">");
												out.print("<input type=\"hidden\" name=\"usrname\" value=\"" + repUsername + "\">");
												out.print("<input type=\"hidden\" name=\"passwrd\" value=\"" + repPassword + "\">");
												//Choose random economy seat...
												
												String economyAttack = "SELECT seatNumber AS app FROM seats S, trip T WHERE S.aircraftID=\""+result.getString("aircraftID")+"\" AND S.seatClass=\"first\" AND T.flightNumber = \""+result.getString("flightNumber")+"\" AND T.tripDate=\""+userLeavingDate+"\" AND S.seatNumber NOT IN ( SELECT T.assignedSeatNumber FROM trip T, seats S WHERE T.aircraftID=\""+result.getString("aircraftID")+"\" AND T.assignedSeatNumber = S.seatNumber AND T.flightNumber = \""+result.getString("flightNumber")+"\" AND T.airlineID = \""+result.getString("airlineID")+"\" AND T.tripDate=\""+userLeavingDate+"\")";

												//out.print("")
												Statement economyAttackSeat = con.createStatement();
												ResultSet economyAttackSeatResult = economyAttackSeat.executeQuery(economyAttack);
												//economyAttackSeatResult.next();
												while(economyAttackSeatResult.next()){
													out.print("yo");
													String personSeat2 = economyAttackSeatResult.getString("app");
												}
												out.print("<input type=\"hidden\" name=\"class\" value=\"first\">");
												out.print("<input type=\"hidden\" name=\"price\" value=\"" + result.getString("firstFare") + "\">");
												out.print("<input type=\"hidden\" name=\"flightNumber\" value=\"" + result.getString("flightNumber") + "\">");
												out.print("<input type=\"hidden\" name=\"airlineID\" value=\"" + result.getString("airlineID") + "\">");
												out.print("<input type=\"hidden\" name=\"flightNumber\" value=\"" + result.getString("flightNumber") + "\">");
												out.print("<input type=\"hidden\" name=\"departAirportID\" value=\"" + result.getString("departAirportID") + "\">");
												out.print("<input type=\"hidden\" name=\"destinationAirportID\" value=\"" + result.getString("destinationAirportID") + "\">");
												out.print("<input type=\"hidden\" name=\"aircraftID\" value=\"" + result.getString("aircraftID") + "\">");
												out.print("<input type=\"hidden\" name=\"assignedSeatNumber\" value=\"" + "personSeat2" + "\">"); //uncomment personSeat2
												out.print("<input type=\"hidden\" name=\"tripDate\" value=\"" + userLeavingDate + "\">");
										  out.print("</form>");
										} 
										 if(realBusinessCount <= businesscount){
											 out.print("<form method=\"post\" action=\"userSearchOneWayReserve.jsp\">");
										 	 out.print("<input type=\"submit\" value=\"Business!\">");
												out.print("<input type=\"hidden\" name=\"usrname\" value=\"" + repUsername + "\">");
												out.print("<input type=\"hidden\" name=\"passwrd\" value=\"" + repPassword + "\">");
												//Choose random economy seat...
												
												String economyAttack = "SELECT S.seatNumber FROM seats S, trip T WHERE S.aircraftID=\""+result.getString("aircraftID")+"\" AND S.seatClass=\"business\" AND T.flightNumber = \""+result.getString("flightNumber")+"\" AND T.tripDate=\""+userLeavingDate+"\" AND seatNumber NOT IN ( SELECT T.assignedSeatNumber FROM trip T, seats S WHERE T.aircraftID=\""+result.getString("aircraftID")+"\" AND T.assignedSeatNumber = S.seatNumber AND T.flightNumber = \""+result.getString("flightNumber")+"\" AND T.airlineID = \""+result.getString("airlineID")+"\" AND T.tripDate=\""+userLeavingDate+"\")";

												Statement economyAttackSeat = con.createStatement();
												ResultSet economyAttackSeatResult = economyAttackSeat.executeQuery(economyAttack);
												while(economyAttackSeatResult.next()){
													String personSeat2 = economyAttackSeatResult.getString("S.seatNumber");
													out.print("yo");
												}
												
												
												out.print("<input type=\"hidden\" name=\"class\" value=\"business\">");
												out.print("<input type=\"hidden\" name=\"price\" value=\"" + result.getString("businessFare") + "\">");
												out.print("<input type=\"hidden\" name=\"airlineID\" value=\"" + result.getString("airlineID") + "\">");
												out.print("<input type=\"hidden\" name=\"flightNumber\" value=\"" + result.getString("flightNumber") + "\">");
												out.print("<input type=\"hidden\" name=\"departAirportID\" value=\"" + result.getString("departAirportID") + "\">");
												out.print("<input type=\"hidden\" name=\"destinationAirportID\" value=\"" + result.getString("destinationAirportID") + "\">");
												out.print("<input type=\"hidden\" name=\"aircraftID\" value=\"" + result.getString("aircraftID") + "\">");
												out.print("<input type=\"hidden\" name=\"assignedSeatNumber\" value=\"" + "personSeat2" + "\">");
												out.print("<input type=\"hidden\" name=\"tripDate\" value=\"" + userLeavingDate + "\">");
										  		out.print("</form>");
										 } 
										 if(realEconomyCount <= economycount){
											 out.print("<form method=\"post\" action=\"userSearchOneWayReserve.jsp\">");
											 	 out.print("<input type=\"submit\" value=\"Economy!\">");
											 	 	
											 	 	
													out.print("<input type=\"hidden\" name=\"usrname\" value=\"" + repUsername + "\">");
													out.print("<input type=\"hidden\" name=\"passwrd\" value=\"" + repPassword + "\">");
													//Choose random economy seat...
													
													String economyAttack = "SELECT S.seatNumber FROM seats S, trip T WHERE S.aircraftID=\""+result.getString("aircraftID")+"\" AND S.seatClass=\"economy\" AND T.flightNumber = \""+result.getString("flightNumber")+"\" AND T.tripDate=\""+userLeavingDate+"\" AND seatNumber NOT IN ( SELECT T.assignedSeatNumber FROM trip T, seats S WHERE T.aircraftID=\""+result.getString("aircraftID")+"\" AND T.assignedSeatNumber = S.seatNumber AND T.flightNumber = \""+result.getString("flightNumber")+"\" AND T.airlineID = \""+result.getString("airlineID")+"\" AND T.tripDate=\""+userLeavingDate+"\")";

													Statement economyAttackSeat = con.createStatement();
													ResultSet economyAttackSeatResult = economyAttackSeat.executeQuery(economyAttack);
													while(economyAttackSeatResult.next()){
														String personSeat2 = economyAttackSeatResult.getString("S.seatNumber");
														out.print("yo");
													}
													
													
													
													out.print("<input type=\"hidden\" name=\"price\" value=\"" + result.getString("economyFare") + "\">");
													out.print("<input type=\"hidden\" name=\"class\" value=\"economy\">");
													out.print("<input type=\"hidden\" name=\"airlineID\" value=\"" + result.getString("airlineID") + "\">");
													out.print("<input type=\"hidden\" name=\"flightNumber\" value=\"" + result.getString("flightNumber") + "\">");
													out.print("<input type=\"hidden\" name=\"departAirportID\" value=\"" + result.getString("departAirportID") + "\">");
													out.print("<input type=\"hidden\" name=\"destinationAirportID\" value=\"" + result.getString("destinationAirportID") + "\">");
													out.print("<input type=\"hidden\" name=\"aircraftID\" value=\"" + result.getString("aircraftID") + "\">");
													out.print("<input type=\"hidden\" name=\"assignedSeatNumber\" value=\"" + "personSeat2" + "\">");
													out.print("<input type=\"hidden\" name=\"tripDate\" value=\"" + userLeavingDate + "\">");
											  out.print("</form>");
										 } 
										 
									}
								//	flexDateCopy = flexdayresult.getString("day");
						
						
						
							//PRIMARY KEY(airlineID,flightNumber,ticketNumber),
							//check for unique row that matches this flight, then check if its the same date. 
							//If its the same date, 
								//Find out the seatNumber and Class
									//Find the 
									
								//The seats that have been claimed by this trip
								//SELECT S.aircraftID, S.seatNumber
								//FROM seats S, trip T
								//WHERE T.date = flexDateCopy AND T.airlineID=flexresult.getString("airlineID") 
								//AND T.flightNumber=flexresult.getString("flightNumber") AND T.assignedSeatNumber=S.seatNumber
								
									
					out.print("</td>");
					out.print("</tr>");
				}
			out.print("</table>");
		} else{
			out.print("userflexible? YES");
			out.print("<br>");
			
			//flexible is defined in the project instructions as being +-3 days. Including the original date itself; that is equal to a range of one week.
			//Get the DAYOFWEEK
			String daystr = "SELECT DAYOFWEEK(\""+userLeavingDate+"\") AS day";
			Statement dayStmt = con.createStatement();
			ResultSet dayresult = dayStmt.executeQuery(daystr);
			dayresult.next();
			String dayNum = dayresult.getString("day");
			out.print("Day of the week: " + dayNum);
			out.print("<br>");
			int dayNumInt = Integer.parseInt(dayNum);
			//Select those flights on the dayNum-3 day
			//Select those flights on the dayNum-2 day
			//Select those flights on the dayNum-1 day
			//Select those flights on the day itself (dayNum)
			//Select those flights on the dayNum+1 day
			//Select those flights on the dayNum+2 day
			//Select those flights on the dayNum+3 dayout.print("<form>");
			
		//	out.print("<form method=\"post\" action=\"userSearchOneWayReserve.jsp\">");
			out.print("<table>");
				out.print("<tr>");
					out.print("<td>");
						out.print("airlineID");
					out.print("</td>");
					out.print("<td>");
						out.print("flightNumber");
					out.print("</td>");
					out.print("<td>");
						out.print("departAirportID");
					out.print("</td>");
					out.print("<td>");
						out.print("destinationAirportID");
					out.print("</td>");
					out.print("<td>");
						out.print("aircraftID");
					out.print("</td>");
					out.print("<td>");
						out.print("type");
					out.print("</td>");
					out.print("<td>");
						out.print("departTime");
					out.print("</td>");
					out.print("<td>");
						out.print("arriveTime");
					out.print("</td>");
					out.print("<td>");
						out.print("economyFare");
					out.print("</td>");
					out.print("<td>");
						out.print("businessFare");
					out.print("</td>");
					out.print("<td>");
						out.print("firstFare");
					out.print("</td>");
					out.print("<td>");
						out.print("Day");
					out.print("</td>");
					out.print("<td>");
						out.print("Date");
					out.print("</td>");
					out.print("<td>");
						out.print("Reserve");
					out.print("</td;");
				out.print("</tr>");
				
			for(int i = 0; i < 7; i++){
				String flexDateCopy = userLeavingDate;
				String flexiblestr = "";
				if(i == 0){
				 	flexiblestr = "Select * FROM flights F, fliesOn FO WHERE F.departAirportID=\""+ userDepartAirportID+"\" AND F.destinationAirportID = \""+userDestinationAirportID+"\" AND FO.airlineID=F.airlineID AND FO.flightNumber=F.flightNumber AND FO.dayNumber=(SELECT DAYOFWEEK(DATE_SUB(\""+flexDateCopy+"\",INTERVAL 3 DAY)))";
					
				 	String flexDaystr = "SELECT DATE_SUB(\""+userLeavingDate+"\",INTERVAL 3 DAY) AS day";
					Statement flexdayStmt = con.createStatement();
					ResultSet flexdayresult = flexdayStmt.executeQuery(flexDaystr);
					flexdayresult.next();
					flexDateCopy = flexdayresult.getString("day");
				}
				if(i == 1){
					flexiblestr = "Select * FROM flights F, fliesOn FO WHERE F.departAirportID=\""+ userDepartAirportID+"\" AND F.destinationAirportID = \""+userDestinationAirportID+"\" AND FO.airlineID=F.airlineID AND FO.flightNumber=F.flightNumber AND FO.dayNumber=(SELECT DAYOFWEEK(DATE_SUB(\""+flexDateCopy+"\",INTERVAL 2 DAY)))";
				 	
					String flexDaystr = "SELECT DATE_SUB(\""+userLeavingDate+"\",INTERVAL 2 DAY) AS day";
					Statement flexdayStmt = con.createStatement();
					ResultSet flexdayresult = flexdayStmt.executeQuery(flexDaystr);
					flexdayresult.next();
					flexDateCopy = flexdayresult.getString("day");
				}
				if(i == 2){
					flexiblestr = "Select * FROM flights F, fliesOn FO WHERE F.departAirportID=\""+ userDepartAirportID+"\" AND F.destinationAirportID = \""+userDestinationAirportID+"\" AND FO.airlineID=F.airlineID AND FO.flightNumber=F.flightNumber AND FO.dayNumber=(SELECT DAYOFWEEK(DATE_SUB(\""+flexDateCopy+"\",INTERVAL 1 DAY)))";
				 	String flexDaystr = "SELECT DATE_SUB(\""+userLeavingDate+"\",INTERVAL 1 DAY) AS day";
					Statement flexdayStmt = con.createStatement();
					ResultSet flexdayresult = flexdayStmt.executeQuery(flexDaystr);
					flexdayresult.next();
					flexDateCopy = flexdayresult.getString("day");
				}
				if(i == 3){
					flexiblestr = "Select * FROM flights F, fliesOn FO WHERE F.departAirportID=\""+ userDepartAirportID+"\" AND F.destinationAirportID = \""+userDestinationAirportID+"\" AND FO.airlineID=F.airlineID AND FO.flightNumber=F.flightNumber AND FO.dayNumber=(SELECT DAYOFWEEK(\""+flexDateCopy+"\"))";
				 	String flexDaystr = "SELECT DATE_SUB(\""+userLeavingDate+"\",INTERVAL 0 DAY) AS day";
					Statement flexdayStmt = con.createStatement();
					ResultSet flexdayresult = flexdayStmt.executeQuery(flexDaystr);
					flexdayresult.next();
					flexDateCopy = flexdayresult.getString("day");
				}
				if(i == 4){
					flexiblestr = "Select * FROM flights F, fliesOn FO WHERE F.departAirportID=\""+ userDepartAirportID+"\" AND F.destinationAirportID = \""+userDestinationAirportID+"\" AND FO.airlineID=F.airlineID AND FO.flightNumber=F.flightNumber AND FO.dayNumber=(SELECT DAYOFWEEK(DATE_ADD(\""+flexDateCopy+"\",INTERVAL 1 DAY)))";
				 	
					String flexDaystr = "SELECT DATE_ADD(\""+userLeavingDate+"\",INTERVAL 1 DAY) AS day";
					Statement flexdayStmt = con.createStatement();
					ResultSet flexdayresult = flexdayStmt.executeQuery(flexDaystr);
					flexdayresult.next();
					flexDateCopy = flexdayresult.getString("day");
				}
				if(i == 5){
					flexiblestr = "Select * FROM flights F, fliesOn FO WHERE F.departAirportID=\""+ userDepartAirportID+"\" AND F.destinationAirportID = \""+userDestinationAirportID+"\" AND FO.airlineID=F.airlineID AND FO.flightNumber=F.flightNumber AND FO.dayNumber=(SELECT DAYOFWEEK(DATE_ADD(\""+flexDateCopy+"\",INTERVAL 2 DAY)))";
				 	String flexDaystr = "SELECT DATE_ADD(\""+userLeavingDate+"\",INTERVAL 2 DAY) AS day";
					Statement flexdayStmt = con.createStatement();
					ResultSet flexdayresult = flexdayStmt.executeQuery(flexDaystr);
					flexdayresult.next();
					flexDateCopy = flexdayresult.getString("day");
				}
				if(i == 6){
					flexiblestr = "Select * FROM flights F, fliesOn FO WHERE F.departAirportID=\""+ userDepartAirportID+"\" AND F.destinationAirportID = \""+userDestinationAirportID+"\" AND FO.airlineID=F.airlineID AND FO.flightNumber=F.flightNumber AND FO.dayNumber=(SELECT DAYOFWEEK(DATE_ADD(\""+flexDateCopy+"\",INTERVAL 3 DAY)))";
				 	String flexDaystr = "SELECT DATE_ADD(\""+userLeavingDate+"\",INTERVAL 3 DAY) AS day";
					Statement flexdayStmt = con.createStatement();
					ResultSet flexdayresult = flexdayStmt.executeQuery(flexDaystr);
					flexdayresult.next();
					flexDateCopy = flexdayresult.getString("day");
				}
				
				Statement flexStmt = con.createStatement();
				ResultSet flexresult = flexStmt.executeQuery(flexiblestr);
				
				/*
				out.print("<br>");
				out.print("flexiblestr: " + flexiblestr);
				out.print("<br>");
				out.print("<br>");
				out.print("flexDateCopy: " + flexDateCopy);
				out.print("<br>"); */

				
				while(flexresult.next()){
					out.print("<tr>");
						out.print("<td>");
							out.print(flexresult.getString("airlineID"));
						out.print("</td>");
						out.print("<td>");
							out.print(flexresult.getString("flightNumber"));
						out.print("</td>");
						out.print("<td>");
							out.print(flexresult.getString("departAirportID"));
						out.print("</td>");
						out.print("<td>");
							out.print(flexresult.getString("destinationAirportID"));
						out.print("</td>");
						out.print("<td>");
							out.print(flexresult.getString("aircraftID"));
						out.print("</td>");
						out.print("<td>");
							out.print(flexresult.getString("type"));
						out.print("</td>");
						out.print("<td>");
							out.print(flexresult.getString("departTime"));
						out.print("</td>");
						out.print("<td>");
							out.print(flexresult.getString("arriveTime"));
						out.print("</td>");
						out.print("<td>");
							out.print(flexresult.getString("economyFare"));
						out.print("</td>");
						out.print("<td>");
							out.print(flexresult.getString("businessFare"));
						out.print("</td>");
						out.print("<td>");
							out.print(flexresult.getString("firstFare"));
						out.print("</td>");
						out.print("<td>");
							String daystr1 = "SELECT DAYOFWEEK(\""+flexDateCopy+"\") AS day";
							Statement dayStmt1 = con.createStatement();
							ResultSet dayresult1 = dayStmt1.executeQuery(daystr1);
							dayresult1.next();
							String dayNum1 = dayresult1.getString("day");
							out.print(dayNum1);
						out.print("</td>");
						out.print("<td>");
							out.print(flexDateCopy);
						out.print("</td>");
						out.print("<td>"); 
							//out.print("<input type=\"submit\" value=\"Economy!\">");
							//Go through trip
										String tripstr = "SELECT * FROM trip T WHERE T.airlineID=\""+ flexresult.getString("airlineID")+"\" AND T.flightNumber=\""+flexresult.getString("flightNumber")+"\" AND T.tripDate=\""+ flexDateCopy+"\"";
										
										//I want a count of how many people are in economy. 
				 						//String economystr = "SELECT DATE_SUB(\""+userLeavingDate+"\",INTERVAL 3 DAY) AS day";
										Statement economystmt = con.createStatement();
										ResultSet economyresult = economystmt.executeQuery(tripstr);
										
										int economycount = 0;
										int businesscount = 0;
										int firstclasscount = 0;
										int totalcount = 0;
										
										//audit to find out how many total economy seats there are
										String economySeats = "SELECT COUNT(*) AS economySeats FROM seats WHERE aircraftID=\"" + flexresult.getString("aircraftID") + "\" AND seatClass=\"economy\"";
										String businessSeats = "SELECT COUNT(*) AS businessSeats FROM seats WHERE aircraftID=\"" + flexresult.getString("aircraftID") + "\" AND seatClass=\"business\"";
										String firstSeats = "SELECT COUNT(*) AS firstSeats FROM seats WHERE aircraftID=\"" + flexresult.getString("aircraftID") + "\" AND seatClass=\"first\"";
										String totalSeats = "SELECT COUNT(*) AS totalSeats FROM seats WHERE aircraftID=\"" + flexresult.getString("aircraftID") +"\"";
										
										Statement econSeatstmt = con.createStatement();
										Statement businessSeatstmt = con.createStatement();
										Statement firstSeatstmt = con.createStatement();
										Statement totalSeatstmt = con.createStatement();
										
										
										ResultSet econSeatResult = econSeatstmt.executeQuery(economySeats);
										ResultSet businessSeatResult = businessSeatstmt.executeQuery(businessSeats);
										ResultSet firstSeatResult = firstSeatstmt.executeQuery(firstSeats);
										ResultSet totalSeatResult = totalSeatstmt.executeQuery(totalSeats);
										
										econSeatResult.next();
										businessSeatResult.next();
										firstSeatResult.next();
										totalSeatResult.next();
										
										economycount = Integer.parseInt(econSeatResult.getString("economySeats"));
										businesscount = Integer.parseInt(businessSeatResult.getString("businessSeats"));
										firstclasscount = Integer.parseInt(firstSeatResult.getString("firstSeats"));
										totalcount = Integer.parseInt(totalSeatResult.getString("totalSeats"));
										
										int realEconomyCount = 0;
										int realBusinessCount = 0;
										int realFirstCount = 0;
										int realTotalCount = 0;
										while(economyresult.next()){
											//take the assignedSeatNumber, and aircraftID.
											String assignedSeatNumber = economyresult.getString("assignedSeatNumber");
											String aircraftID = economyresult.getString("aircraftID");
											
											
											//Now I have the the number of seats of each type. Now I want to see how many are in each section
											String personalAttack = "SELECT seatClass FROM seats WHERE aircraftID=\"" + aircraftID + "\" AND seatNumber=\""+assignedSeatNumber+"\"";
											Statement personSeat = con.createStatement();
											ResultSet personSeatresult = personSeat.executeQuery(personalAttack);
											personSeatresult.next();
											String personClass = personSeatresult.getString("seatClass");
											
											if(personClass.equalsIgnoreCase("economy")){
												realEconomyCount++;
												realTotalCount++;
											}else if(personClass.equalsIgnoreCase("business")){
												realBusinessCount++;
												realTotalCount++;
											} else if(personClass.equalsIgnoreCase("first")){
												realFirstCount++;
												realTotalCount++;
											}
											
											
										}
										
										if(realTotalCount >= totalcount){
											out.print("No more seats....");
											out.print("<br>");
										} else {
				
											if(realFirstCount <= firstclasscount){
												 out.print("<form method=\"post\" action=\"userSearchOneWayReserve.jsp\">");
											 	 out.print("<input type=\"submit\" value=\"firstClass!\">");
													out.print("<input type=\"hidden\" name=\"usrname\" value=\"" + repUsername + "\">");
													out.print("<input type=\"hidden\" name=\"passwrd\" value=\"" + repPassword + "\">");
													//Choose random economy seat...
													
													String economyAttack = "SELECT S.seatNumber AS choco FROM seats S, trip T WHERE S.aircraftID=\""+flexresult.getString("aircraftID")+"\" AND S.seatClass=\"first\" AND T.flightNumber = \""+flexresult.getString("flightNumber")+"\" AND T.tripDate=\""+flexDateCopy+"\" AND seatNumber NOT IN ( SELECT T.assignedSeatNumber FROM trip T, seats S WHERE T.aircraftID=\""+flexresult.getString("aircraftID")+"\" AND T.assignedSeatNumber = S.seatNumber AND T.flightNumber = \""+flexresult.getString("flightNumber")+"\" AND T.airlineID = \""+flexresult.getString("airlineID")+"\" AND T.tripDate=\""+flexDateCopy+"\")";

													Statement economyAttackSeat = con.createStatement();
													ResultSet economyAttackSeatResult = economyAttackSeat.executeQuery(economyAttack);
													while(economyAttackSeatResult.next()){
														String personSeat2 = economyAttackSeatResult.getString("choco");
														out.print("<br>");
														out.print("Yo");
														out.print("<br>");
													}
													
													out.print("<br>");
													//out.print("Yo");
													out.print("<input type=\"hidden\" name=\"class\" value=\"first\">");
													out.print("<input type=\"hidden\" name=\"price\" value=\"" + flexresult.getString("firstFare") + "\">");
													out.print("<input type=\"hidden\" name=\"flightNumber\" value=\"" + flexresult.getString("flightNumber") + "\">");
													out.print("<input type=\"hidden\" name=\"airlineID\" value=\"" + flexresult.getString("airlineID") + "\">");
													out.print("<input type=\"hidden\" name=\"flightNumber\" value=\"" + flexresult.getString("flightNumber") + "\">");
													out.print("<input type=\"hidden\" name=\"departAirportID\" value=\"" + flexresult.getString("departAirportID") + "\">");
													out.print("<input type=\"hidden\" name=\"destinationAirportID\" value=\"" + flexresult.getString("destinationAirportID") + "\">");
													out.print("<input type=\"hidden\" name=\"aircraftID\" value=\"" + flexresult.getString("aircraftID") + "\">");
													out.print("<input type=\"hidden\" name=\"assignedSeatNumber\" value=\"" + "personSeat2" + "\">");
													out.print("<input type=\"hidden\" name=\"tripDate\" value=\"" + flexDateCopy + "\">");
											  out.print("</form>");
											}
											 if(realBusinessCount <= businesscount){
												 out.print("<form method=\"post\" action=\"userSearchOneWayReserve.jsp\">");
											 	 out.print("<input type=\"submit\" value=\"Business!\">");
													out.print("<input type=\"hidden\" name=\"usrname\" value=\"" + repUsername + "\">");
													out.print("<input type=\"hidden\" name=\"passwrd\" value=\"" + repPassword + "\">");
													//Choose random economy seat...
													
													String economyAttack = "SELECT S.seatNumber FROM seats S, trip T WHERE S.aircraftID=\""+flexresult.getString("aircraftID")+"\" AND S.seatClass=\"business\" AND T.flightNumber = \""+flexresult.getString("flightNumber")+"\" AND T.tripDate=\""+flexDateCopy+"\" AND seatNumber NOT IN ( SELECT T.assignedSeatNumber FROM trip T, seats S WHERE T.aircraftID=\""+flexresult.getString("aircraftID")+"\" AND T.assignedSeatNumber = S.seatNumber AND T.flightNumber = \""+flexresult.getString("flightNumber")+"\" AND T.airlineID = \""+flexresult.getString("airlineID")+"\" AND T.tripDate=\""+flexDateCopy+"\")";

													Statement economyAttackSeat = con.createStatement();
													ResultSet economyAttackSeatResult = economyAttackSeat.executeQuery(economyAttack);
													while(economyAttackSeatResult.next()){
														String personSeat2 = economyAttackSeatResult.getString("S.seatNumber");
														out.print("yo");
													}
													
													out.print("<input type=\"hidden\" name=\"class\" value=\"business\">");
													out.print("<input type=\"hidden\" name=\"price\" value=\"" + flexresult.getString("businessFare") + "\">");
													out.print("<input type=\"hidden\" name=\"airlineID\" value=\"" + flexresult.getString("airlineID") + "\">");
													out.print("<input type=\"hidden\" name=\"flightNumber\" value=\"" + flexresult.getString("flightNumber") + "\">");
													out.print("<input type=\"hidden\" name=\"departAirportID\" value=\"" + flexresult.getString("departAirportID") + "\">");
													out.print("<input type=\"hidden\" name=\"destinationAirportID\" value=\"" + flexresult.getString("destinationAirportID") + "\">");
													out.print("<input type=\"hidden\" name=\"aircraftID\" value=\"" + flexresult.getString("aircraftID") + "\">");
													out.print("<input type=\"hidden\" name=\"assignedSeatNumber\" value=\"" + "personSeat2" + "\">");
													out.print("<input type=\"hidden\" name=\"tripDate\" value=\"" + flexDateCopy + "\">");
											  		out.print("</form>");
											 }
											 if(realEconomyCount <= economycount){
												 out.print("<form method=\"post\" action=\"userSearchOneWayReserve.jsp\">");
												 	 out.print("<input type=\"submit\" value=\"Economy!\">");
												 	 	
												 	 	
														out.print("<input type=\"hidden\" name=\"usrname\" value=\"" + repUsername + "\">");
														out.print("<input type=\"hidden\" name=\"passwrd\" value=\"" + repPassword + "\">");
														//Choose random economy seat...
														
														String economyAttack = "SELECT S.seatNumber FROM seats S, trip T WHERE S.aircraftID=\""+flexresult.getString("aircraftID")+"\" AND S.seatClass=\"economy\" AND T.flightNumber = \""+flexresult.getString("flightNumber")+"\" AND T.tripDate=\""+flexDateCopy+"\" AND seatNumber NOT IN ( SELECT T.assignedSeatNumber FROM trip T, seats S WHERE T.aircraftID=\""+flexresult.getString("aircraftID")+"\" AND T.assignedSeatNumber = S.seatNumber AND T.flightNumber = \""+flexresult.getString("flightNumber")+"\" AND T.airlineID = \""+flexresult.getString("airlineID")+"\" AND T.tripDate=\""+flexDateCopy+"\")";

														Statement economyAttackSeat = con.createStatement();
														ResultSet economyAttackSeatResult = economyAttackSeat.executeQuery(economyAttack);
														
														while(economyAttackSeatResult.next()){
															String personSeat2 = economyAttackSeatResult.getString("S.seatNumber");
															out.print("yo");
														}
														
														
														
														
														out.print("<input type=\"hidden\" name=\"price\" value=\"" + flexresult.getString("economyFare") + "\">");
														out.print("<input type=\"hidden\" name=\"class\" value=\"economy\">");
														out.print("<input type=\"hidden\" name=\"airlineID\" value=\"" + flexresult.getString("airlineID") + "\">");
														out.print("<input type=\"hidden\" name=\"flightNumber\" value=\"" + flexresult.getString("flightNumber") + "\">");
														out.print("<input type=\"hidden\" name=\"departAirportID\" value=\"" + flexresult.getString("departAirportID") + "\">");
														out.print("<input type=\"hidden\" name=\"destinationAirportID\" value=\"" + flexresult.getString("destinationAirportID") + "\">");
														out.print("<input type=\"hidden\" name=\"aircraftID\" value=\"" + flexresult.getString("aircraftID") + "\">");
														out.print("<input type=\"hidden\" name=\"assignedSeatNumber\" value=\"" + "personSeat2" + "\">");
														out.print("<input type=\"hidden\" name=\"tripDate\" value=\"" + flexDateCopy + "\">");
												  out.print("</form>");
											 }
											 
										}
									//	flexDateCopy = flexdayresult.getString("day");
							
							
							
								//PRIMARY KEY(airlineID,flightNumber,ticketNumber),
								//check for unique row that matches this flight, then check if its the same date. 
								//If its the same date, 
									//Find out the seatNumber and Class
										//Find the 
										
									//The seats that have been claimed by this trip
									//SELECT S.aircraftID, S.seatNumber
									//FROM seats S, trip T
									//WHERE T.date = flexDateCopy AND T.airlineID=flexresult.getString("airlineID") 
									//AND T.flightNumber=flexresult.getString("flightNumber") AND T.assignedSeatNumber=S.seatNumber
									
										
						out.print("</td>");
					out.print("</tr>");
					out.print("<tr>");
					out.print("<br>");
					out.print("</tr>");
					
					//A column to add a flight.
					//Business 
				}
			
				
			}
			
			
			out.print("</table>");
			//out.print("</form>");
			
		} //DELTE this bracket when you uncomment
			/*
			//Create a SQL statement
			Statement flexStmt = con.createStatement();

			
			
			
			//AND FO.airlineID=F.airlineID AND FO.flightNumber=F.flightNumber AND FO.dayNumber=(SELECT DAYOFWEEK(userLeavingDate))
			String str = "Select * FROM flights F, fliesOn FO WHERE F.departAirportID=\""+ userDepartAirportID+"\" AND F.destinationAirportID = \""+userDestinationAirportID+"\" AND FO.airlineID=F.airlineID AND FO.flightNumber=F.flightNumber AND FO.dayNumber=(SELECT DAYOFWEEK(\""+userLeavingDate+"\"))";
			//Run the query against the database.
			ResultSet result = noFlexStmt.executeQuery(str);
			
			//print the results.
			//Make an HTML Table to show the results in
			out.print("<table>");
				out.print("<tr>");
					out.print("<td>");
						out.print("airlineID");
					out.print("</td>");
					out.print("<td>");
						out.print("flightNumber");
					out.print("</td>");
					out.print("<td>");
						out.print("departAirportID");
					out.print("</td>");
					out.print("<td>");
						out.print("destinationAirportID");
					out.print("</td>");
					out.print("<td>");
						out.print("aircraftID");
					out.print("</td>");
					out.print("<td>");
						out.print("type");
					out.print("</td>");
					out.print("<td>");
						out.print("departTime");
					out.print("</td>");
					out.print("<td>");
						out.print("arriveTime");
					out.print("</td>");
					out.print("<td>");
						out.print("economyFare");
					out.print("</td>");
					out.print("<td>");
						out.print("businessFare");
					out.print("</td>");
					out.print("<td>");
						out.print("firstFare");
					out.print("</td>");
				out.print("</tr>");
				
				while(result.next()){
					out.print("<tr>");
						out.print("<td>");
							out.print(result.getString("airlineID"));
						out.print("</td>");
						out.print("<td>");
							out.print(result.getString("flightNumber"));
						out.print("</td>");
						out.print("<td>");
							out.print(result.getString("departAirportID"));
						out.print("</td>");
						out.print("<td>");
							out.print(result.getString("destinationAirportID"));
						out.print("</td>");
						out.print("<td>");
							out.print(result.getString("aircraftID"));
						out.print("</td>");
						out.print("<td>");
							out.print(result.getString("type"));
						out.print("</td>");
						out.print("<td>");
							out.print(result.getString("departTime"));
						out.print("</td>");
						out.print("<td>");
							out.print(result.getString("arriveTime"));
						out.print("</td>");
						out.print("<td>");
							out.print(result.getString("economyFare"));
						out.print("</td>");
						out.print("<td>");
							out.print(result.getString("businessFare"));
						out.print("</td>");
						out.print("<td>");
							out.print(result.getString("firstFare"));
						out.print("</td>");
					out.print("</tr>");
				}
			out.print("</table>");
		} */
		
		
		
		//Sort: everything that meets criteria, in a certain order "Descending Price"
		//filter: exclude some things. "Max price"
		
		//Sort: price (ascending/descending) takeoff time (ascending/descending) landing time(ascending/descending)
		//Filter: price (Max, min) airline ~stops~
		
	//Filter
		
		//Get the available airlines for the departAirport, destinationAirport, and time constraints
		String excludeAirline = request.getParameter("excludeAirline"); 
		String includeAirline = request.getParameter("includeAirline");
		String maxPrice = request.getParameter("maxPrice"); //field
		String minPrice = request.getParameter("minPrice"); //field
		
		
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
		out.print("search page succeeded");
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