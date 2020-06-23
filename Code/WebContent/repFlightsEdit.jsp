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
		
		//Strings that store the desired add flight information
		String repAirlineID = request.getParameter("airlineID"); //primary	
		String repFlightNumber = request.getParameter("flightNumber");	//primary
		String repDepartAirportID = request.getParameter("departAirportID");	//foreign	
		String repDestinationAirportID = request.getParameter("destinationAirportID");	//foreign
		String repAircraftID = request.getParameter("aircraftID"); //foreign
		String repType = request.getParameter("type");

		//not VARCHAR
		String repDepartTime = request.getParameter("departTime"); //TIME
		String repArriveTime = request.getParameter("arriveTime"); //TIME
		String repEconomyFare = request.getParameter("economyFare"); // DECIMAL
		String repBusinessFare = request.getParameter("businessFare"); //DECIMAL	
		String repFirstFare = request.getParameter("firstFare"); //DECIMAL
		String checked[] = request.getParameterValues("day");
		//String repDate = request.getParameter("date");
		
		//Check all foreign keys for validity. 
			//airlineID, departAirportID, destinationAirportID, aircraftID,
			
		//Create a SQL statement
		Statement stmt = con.createStatement();
		String str = "SELECT airlineID FROM airline";
		//Run the query against the database.
		ResultSet result = stmt.executeQuery(str);
		 
		int airlineIDExists = 0;
		while(result.next()){
			if(result.getString("airlineID").equalsIgnoreCase(repAirlineID)){
				airlineIDExists = 1;
				break;
			}
		}
		
		//Create a SQL statement
		Statement departstmt = con.createStatement();
		String departstr = "SELECT airportID FROM airport";
		//Run the query against the database.
		ResultSet departresult = departstmt.executeQuery(departstr);
		 
		int departIDExists = 0;
		while(departresult.next()){
			if(departresult.getString("airportID").equalsIgnoreCase(repDepartAirportID)){
				departIDExists = 1;
				break;
			}
		}
		
		//Create a SQL statement
		Statement destinationstmt = con.createStatement();
		String destinationstr = "SELECT airportID FROM airport";
		//Run the query against the database.
		ResultSet destinationresult = destinationstmt.executeQuery(destinationstr);
		 
		int destinationIDExists = 0;
		while(destinationresult.next()){
			if(destinationresult.getString("airportID").equalsIgnoreCase(repDestinationAirportID)){
				destinationIDExists = 1;
				break;
			}
		}
		
		//Create a SQL statement
		Statement aircraftstmt = con.createStatement();
		String aircraftstr = "SELECT aircraftID FROM aircraft";
		//Run the query against the database.
		ResultSet aircraftresult = aircraftstmt.executeQuery(aircraftstr);
		 
		int aircraftIDExists = 0;
		while(aircraftresult.next()){
			if(aircraftresult.getString("aircraftID").equalsIgnoreCase(repAircraftID)){
				aircraftIDExists = 1;
				break;
			}
		}
		
		
		
		if(airlineIDExists == 1 && departIDExists == 1 && destinationIDExists == 1 && aircraftIDExists == 1 ){
			//Check for duplicate flight, primary key(airlineID, flightNumber)
			Statement duplicatestmt = con.createStatement();
			String duplicatestr = "SELECT airlineID, flightNumber FROM flights";
			ResultSet duplicateresult = duplicatestmt.executeQuery(duplicatestr);
			
			int flightExists = 0;
			while(duplicateresult.next()){
				if(duplicateresult.getString("airlineID").equalsIgnoreCase(repAirlineID) &&
					duplicateresult.getString("flightNumber").equalsIgnoreCase(repFlightNumber)){
					flightExists = 1;
					break;
				}
			}
			
			if(flightExists == 1){
				//Update flight with non primary attributes
				out.print("<br>");
				out.print("Found flight. Updating attributes...");
				out.print("<br>");
				
				//repDepartAirportID,repDestinationAirportID,repAircraftID,repType,repDepartTime,repArriveTime,repEconomyFare,repBusinessFare,repFirstFare
				
				String departUpdate = "UPDATE flights SET departAirportID=\"" + repDepartAirportID + "\" WHERE airlineID=\"" + repAirlineID + "\" AND flightNumber=\"" + repFlightNumber + "\"";
				String destinationUpdate = "UPDATE flights SET destinationAirportID=\"" + repDestinationAirportID + "\" WHERE airlineID=\"" + repAirlineID + "\" AND flightNumber=\"" + repFlightNumber + "\"";
				String aircraftUpdate = "UPDATE flights SET aircraftID=\"" + repAircraftID + "\" WHERE airlineID=\"" + repAirlineID + "\" AND flightNumber=\"" + repFlightNumber + "\"";
				String typeUpdate = "UPDATE flights SET type=\"" + repType + "\" WHERE airlineID=\"" + repAirlineID + "\" AND flightNumber=\"" + repFlightNumber + "\"";
				String dtimeUpdate = "UPDATE flights SET departTime=\"" + repDepartTime + "\" WHERE airlineID=\"" + repAirlineID + "\" AND flightNumber=\"" + repFlightNumber + "\"";
				String atimeUpdate = "UPDATE flights SET arriveTime=\"" + repArriveTime + "\" WHERE airlineID=\"" + repAirlineID + "\" AND flightNumber=\"" + repFlightNumber + "\"";
				String econUpdate = "UPDATE flights SET economyFare=\"" + repEconomyFare + "\" WHERE airlineID=\"" + repAirlineID + "\" AND flightNumber=\"" + repFlightNumber + "\"";
				String businessUpdate = "UPDATE flights SET businessFare=\"" + repBusinessFare + "\" WHERE airlineID=\"" + repAirlineID + "\" AND flightNumber=\"" + repFlightNumber + "\"";
				String firstUpdate = "UPDATE flights SET firstFare=\"" + repFirstFare + "\" WHERE airlineID=\"" + repAirlineID + "\" AND flightNumber=\"" + repFlightNumber + "\"";
				
				PreparedStatement departPS = con.prepareStatement(departUpdate);
				PreparedStatement destinationPS = con.prepareStatement(destinationUpdate);
				PreparedStatement aircraftPS = con.prepareStatement(aircraftUpdate);
				PreparedStatement typePS = con.prepareStatement(typeUpdate);
				PreparedStatement dtimePS = con.prepareStatement(dtimeUpdate);
				PreparedStatement atimePS = con.prepareStatement(atimeUpdate);
				PreparedStatement econPS = con.prepareStatement(econUpdate);
				PreparedStatement businessPS = con.prepareStatement(businessUpdate);
				PreparedStatement firstPS = con.prepareStatement(firstUpdate);
				
				departPS.executeUpdate();
				destinationPS.executeUpdate();
				aircraftPS.executeUpdate();
				typePS.executeUpdate();
				dtimePS.executeUpdate();
				atimePS.executeUpdate();
				econPS.executeUpdate();
				businessPS.executeUpdate();
				firstPS.executeUpdate();
				
				//Update fliesOn with the new date
					//Delete...
					//Insert...
					
				//removing flight from fliesOn
				String fliesOnDelete = "DELETE FROM fliesOn WHERE airlineID = '" + repAirlineID + "' AND flightNumber = \""+ repFlightNumber+"\"";
				PreparedStatement fliesOnDeletePS = con.prepareStatement(fliesOnDelete);
				//maybe you cant delete the parent first? ... yup
				fliesOnDeletePS.executeUpdate();
				
				//inserting new days...
				String fliesOnInsert = "INSERT INTO fliesOn(dayNumber,airlineID,flightNumber)" + "VALUES(?,?,?)";
				for(int i = 0; i < checked.length; i++){
					out.print("<br>");
					out.print(Integer.toString(i));
					
					PreparedStatement fliesOnInsertPS = con.prepareStatement(fliesOnInsert);
					fliesOnInsertPS.setString(1, checked[i]);
					fliesOnInsertPS.setString(2, repAirlineID);
					fliesOnInsertPS.setString(3, repFlightNumber);
					fliesOnInsertPS.executeUpdate();
				}
				
			} else{
				out.print("<br>");
				out.print("Flight was not edited. Flight could not be found. If you want to add a flight, use the add field on the previous page");
				out.print("<br>");
			}
			
		} else{
			 if(airlineIDExists == 0){
				out.print("<br>");
				out.print("Flight was not edited. airlineID does not exist in database.");
				out.print("<br>");
			} 
			 if(departIDExists == 0){
				out.print("<br>");
				out.print("Flight was not edited. Departing airportID does not exist in database.");
				out.print("<br>");
			} 
			 if(destinationIDExists == 0){
				out.print("<br>");
				out.print("Flight was not edited. Destination airportID does not exist in database.");
				out.print("<br>");
			} 
			 if(aircraftIDExists == 0){
				out.print("<br>");
				out.print("Flight was not edited. aircraftID does not exist in database.");
				out.print("<br>");
			}
		}
		
		

		
		
		
		
		/*
		//Raw insert testing 
		String insert = "INSERT INTO flights(airlineID,flightNumber, departAirportID, destinationAirportID,aircraftID,type,departTime,arriveTime,economyFare,businessFare,firstFare)"
						+ "VALUES (?,?,?,?,?,?,?,?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(insert);
		ps.setString(1, repAirlineID);
		ps.setString(2, repFlightNumber);
		ps.setString(3, repDepartAirportID);
		ps.setString(4, repDestinationAirportID);
		ps.setString(5, repAircraftID);
		ps.setString(6, repType);
		ps.setString(7, repDepartTime);
		ps.setString(8, repArriveTime);
		ps.setString(9, repEconomyFare);
		ps.setString(10, repBusinessFare);
		ps.setString(11, repFirstFare);
		ps.executeUpdate();
		 */
		
		 //Notes
		 //ins
		 

		//Fin
		
	
		
		
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
		out.print("flight edit page succeeded");
		out.print("<br>");
		
		
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("flight edit page failed");
	}
%>
<form method="post" action="index.jsp">
<input type="submit" name="back" value="logout">
</form>
</body>
</html>