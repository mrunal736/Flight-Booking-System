
<%
if (session.getAttribute("name") == null) {
	response.sendRedirect("registration.jsp");
}
%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Udaan-Book Your Flight With Us</title>

<!-- Font Icon -->
<link rel="stylesheet"
	href="fonts/material-icon/css/material-design-iconic-font.min.css">
<link rel="stylesheet" href="alert/dist/sweetalert.css">
<script src="https://kit.fontawesome.com/3db9aa89cf.js"
	crossorigin="anonymous"></script>

<!-- Main css -->
<link rel="stylesheet" href="css/style.css">
<style>
table,th, td {
  border: 1px solid black;
}
</style>
</head>
<body>
	<input type="hidden" id="status"
		value="<%=request.getAttribute("status")%>">
	<div class="main">

		<!-- Sign up form -->
		<section class="signup">
			<div class="container">
				<div class="signup-content">
					<div class="signup-form">
						<h2 class="form-title">Booking flight</h2>
						<a href="logout"><b>Logout</b></a>

						<br>
						<h3>User details :</h3>
						<br>
						
						<div class="form-group">
								<%
								try {
									Class.forName("com.mysql.cj.jdbc.Driver");
									Connection con = (Connection) DriverManager
									.getConnection("jdbc:mysql://localhost:3306/airline_management?useSSL=false", "root", "root123");
									Statement st = con.createStatement();
									ResultSet rs = st.executeQuery("select * from user_final where Name='"+ session.getAttribute("name")+"'");
								%><table border=1 style="text-align: center;">
									<thead>
										<tr>
											<th>Aadhar_No</th>
											<th>Name</th>
											<th>Email</th>
											<th>DOB</th>
											<th>contact</th>
										</tr>
									</thead>
									<tbody>
										<%
										while (rs.next()) {
										%>
										<tr>
											<td><%=rs.getString("Aadhar_No")%></td>
											<td><%=rs.getString("Name")%></td>
											<td><%=rs.getString("Email")%></td>
											<td><%=rs.getString("DOB")%></td>
											<td><%=rs.getString("contact")%></td>

										</tr>
										<%
										}
										%>
									</tbody>
								</table>
								<br>
								<%
								} catch (Exception ex) {
								out.print(ex.getMessage());
								}
								%><br>
							</div>
						
						<form method="post" action="index" class="register-form"
							id="register-form">
<!-- 							<div class="form-group"> -->
<!-- 								<label for="name"><i -->
<!-- 									class="zmdi zmdi-account material-icons-name"></i></label> <input -->
<!-- 									type="text" name="Aadhar_no" id="name" placeholder="Aadhar_no" /> -->
<!-- 							</div> -->
<!-- 							<div class="form-group"> -->
<!-- 								<label for="email"><i class="zmdi zmdi-email"></i></label> <input -->
<!-- 									type="text" name="Addr" id="email" placeholder="Addr" /> -->
<!-- 							</div> -->
<!-- 							<div class="form-group"> -->
<!-- 								<label for="pass"><i class="zmdi zmdi-lock"></i></label> <input -->
<!-- 									type="date" name="DOB" id="pass" placeholder="DOB" /> -->
<!-- 							</div> -->
<!-- 							<br> -->

							<h3>Available Flights :</h3>
							<br>

							<div class="form-group">
								<%
								try {
									Class.forName("com.mysql.cj.jdbc.Driver");
									Connection con = (Connection) DriverManager
									.getConnection("jdbc:mysql://localhost:3306/airline_management?useSSL=false", "root", "root123");
									Statement st = con.createStatement();
									ResultSet rs = st.executeQuery("select * from flight");
								%><table border=1 align=center style="text-align: center">
									<thead>
										<tr>
											<th>Company</th>
											<th>Start location</th>
											<th>End location</th>
											<th>Departure time</th>
											<th>Estimated Arrival time</th>
										</tr>
									</thead>
									<tbody>
										<%
										while (rs.next()) {
										%>
										<tr>
											<td><%=rs.getString("company_name")%></td>
											<td><%=rs.getString("f_sour")%></td>
											<td><%=rs.getString("f_dest")%></td>
											<td><%=rs.getString("f_arr_time")%></td>
											<td><%=rs.getString("f_dest_time")%></td>

										</tr>
										<%
										}
										%>
									</tbody>
								</table>
								<br>
								<%
								} catch (Exception ex) {
								out.print(ex.getMessage());
								}
								%><br>
							</div>




							<h3>Flight details :</h3>

							<div class="form-group">

								<label for="contact"><i
									class="fa-solid fa-location-crosshairs"></i>Start location</label> <br>
								<br> <select name="f_sour" id="f_sour">

									<%
									try {
										Class.forName("com.mysql.cj.jdbc.Driver");
										Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/airline_management?useSSL=false", "root",
										"root123");
										String query = "select distinct(f_sour) from flight";
										Statement st = con.createStatement();
										ResultSet rs = st.executeQuery(query);
										while (rs.next()) {
									%>
									<option value=<%=rs.getString("f_sour")%>><%=rs.getString("f_sour")%></option>
									<%
									}
									} catch (Exception e) {
									e.printStackTrace();
									}
									%>
									<!-- <option value="Kolkata">Kolkata</option> -->
									<!-- <option value="Pune">Pune</option> -->
									<!-- <option value="Goa">Goa</option> -->
									<!-- <option value="Delhi">Delhi</option> -->
								</select>
							</div>
							<div class="form-group">
								<label for="contact">End location</label> <br> <br> <select
									name="f_dest" id="f_dest">
									<%
									try {
										Class.forName("com.mysql.cj.jdbc.Driver");
										Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/airline_management?useSSL=false", "root",
										"root123");
										String query = "select distinct(f_dest) from flight";
										Statement st = con.createStatement();
										ResultSet rs = st.executeQuery(query);
										while (rs.next()) {
									%>
									<option value=<%=rs.getString("f_dest")%>><%=rs.getString("f_dest")%></option>
									<%
									}
									} catch (Exception ez) {
									ez.printStackTrace();
									}
									%>

									<!-- <option value="Kolkata">Kolkata</option> -->
									<!-- <option value="Pune">Pune</option> -->
									<!-- <option value="Goa">Goa</option> -->
									<!-- <option value="Delhi">Delhi</option> -->
								</select>
							</div>
							<div class="form-group">
								<label for="contact">Class</label> <br> <br>
								<div class="nstyled">
									<select name="class" id="class">
										<option value="Economy">Economy</option>
										<option value="Business">Business</option>
										<option value="First Class">First Class</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label for="contact">Company Name</label> <br> <br>
								<div class="nstyled">
									<select name="company" id="company">
										<%
										try {
											Class.forName("com.mysql.cj.jdbc.Driver");
											Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/airline_management?useSSL=false", "root",
											"root123");
											String query = "select distinct(company_name) from flight";
											Statement st = con.createStatement();
											ResultSet rs = st.executeQuery(query);
											while (rs.next()) {
										%>
										<option value=<%=rs.getString("company_name")%>><%=rs.getString("company_name")%></option>
										<%
										}
										} catch (Exception ey) {
										ey.printStackTrace();
										}
										%>
										<!-- <option value="Air India">Air India</option> -->
										<!-- <option value="SpiceJet">SpiceJet</option> -->
										<!-- <option value="GoAir">GoAir</option> -->
										<!-- <option value="Jet Airways">Jet Airways</option> -->
									</select>
								</div>
							</div>
							<div class="form-group">
								<label for="contact">Departure-Date</label> <br> <br>
								<select name="P_departure" id="P_departure">
									<%
									try {
										Class.forName("com.mysql.cj.jdbc.Driver");
										Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/airline_management?useSSL=false", "root",
										"root123");
										String query = "select f_arr_time from flight";
										Statement st = con.createStatement();
										ResultSet rs = st.executeQuery(query);
										while (rs.next()) {
									%>
									<option value=<%=rs.getString("f_arr_time")%>><%=rs.getString("f_arr_time")%></option>
									<%
									}
									} catch (Exception e) {
									e.printStackTrace();
									}
									%>
									<!-- <option value="2022-07-04 08:30:00">2022-07-04 08:30:00</option> -->
									<!-- <option value="2022-07-04 08:00:00">2022-07-04 08:00:00</option> -->
									<!-- <option value="2022-07-04 10:30:00">2022-07-06 10:30:00</option> -->
									<!-- <option value="2022-07-04 13:00:00">2022-07-04 13:00:00</option> -->
								</select>
							</div>
							<div class="form-group">
								<input type="checkbox" name="agree-term" id="agree-term"
									class="agree-term" /> <label for="agree-term"
									class="label-agree-term"><span><span></span></span>I
									agree all statements in <a href="#" class="term-service">Terms
										of service</a></label>
							</div>

							<div class="form-group form-button">
								<input type="submit" name="signup" id="signup"
									class="form-submit" value="Proceed to pay" /> 
							</div>
							<!-- <div class="form-group form-button"> -->
							<!-- <input type="submit" name="signup" id="signup" -->
							<!-- class="form-submit" value="logout" /> -->
							<!-- </div> -->
						</form>
					</div>

				</div>
			</div>

		</section>

	</div>

	<!-- JS -->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="js/main.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

	<script type="text/javascript">
		var status = document.getElementById("status").value;
		if (
	<%=request.getParameter("status")%>
		== "success"
				|| status == "success") {
			swal("Congratulations!!", "Flight booked successfully", "success");
		}
		// else if(status == "failed") {
		// swal("Sorry!!", "Flight Not available currently", "error");
		// }
	</script>



</body>


<!-- This templates was made by Colorlib (https://colorlib.com) -->
</html>