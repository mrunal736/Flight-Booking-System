package com.uniqueDeveloper.registration;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class RegistrationServelet
 */
@WebServlet("/register")
public class RegistrationServelet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		String uname = request.getParameter("name");
		String upwd = request.getParameter("pass");
		String umobile = request.getParameter("contact");
		String uemail = request.getParameter("email");
		String Aadhar_No = request.getParameter("Aadhar_no");
		String DOB = request.getParameter("DOB");
		String Address = request.getParameter("Addr");
		Connection con = null;
		RequestDispatcher dispatcher = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/airline_management?autoReconnect=true&useSSL=false","root","root123");
			PreparedStatement pst = con.prepareStatement("insert into user_final values(?,?,?,?,?,?,?)");
			pst.setString(1,Aadhar_No);
			pst.setString(2, uname);
			pst.setString(3, Address);
			pst.setString(4, DOB);
			pst.setString(5,uemail);
			pst.setString(6, upwd);
			pst.setString(7,umobile);
			int rc = pst.executeUpdate();
			dispatcher = request.getRequestDispatcher("registration.jsp");
			if(rc>0) {
				request.setAttribute("status","success");
			}
			else {
				request.setAttribute("status","failed");
			
			}
			dispatcher.forward(request, response);
		}
		catch (Exception e){
			e.printStackTrace();
		}
		
	}

}
