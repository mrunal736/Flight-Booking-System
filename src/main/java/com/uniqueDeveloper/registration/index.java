package com.uniqueDeveloper.registration;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class index
 */
@SuppressWarnings("unused")
@WebServlet("/index")
public class index extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String name = (String) session.getAttribute("name");
		String Aadhar_no = null;
		String DOB = null;
		String Address = null;
		String f_sour = request.getParameter("f_sour");
		String f_dest = request.getParameter("f_dest");
		String f_arr_time = request.getParameter("P_departure");
		
		String company = request.getParameter("company");
		String f_class = request.getParameter("class");
		RequestDispatcher dispatcher = null;
//		PrintWriter out = response.getWriter();
		Connection con = null;
		try {

			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/airline_management?useSSL=false", "root", "root123");
			PreparedStatement pst1;
//			PreparedStatement pst1 = con.prepareStatement("update users set Aadhar_no=?,Addr=?,DOB=? where Name = ?");
//			pst1.setString(1, Aadhar_no);
//			pst1.setString(2, Address);
//			pst1.setString(3, DOB);
//			pst1.setString(4, name);
//			pst1.executeUpdate();
			
			pst1  = con.prepareStatement("select * from user_final where Name = '"+session.getAttribute("name")+"'");
			ResultSet rs1 = pst1.executeQuery();
			if(rs1.next()){
				Aadhar_no = rs1.getString("Aadhar_no");
				Address = rs1.getString("Addr");
				DOB = rs1.getString("DOB");
			}
			
			pst1 = con.prepareStatement("select * from flight where f_sour=? and f_dest=?");
			
			pst1.setString(1, f_sour);
			pst1.setString(2, f_dest);
		    rs1 = pst1.executeQuery();
			String flight_no = null ;
			String f_dest_time = null ;
			int cost = 0;
			if(rs1.next()) {
				 flight_no = rs1.getString("flight_no");
				 f_dest_time = rs1.getString("f_dest_time");
				
				if(f_class == "Economy") {
					cost = rs1.getInt("EC_cost");
				}
				else if(f_class == "Business") {
					cost = rs1.getInt("Busi_cost");
				}
				else {
					cost = rs1.getInt("FC_cost");
				}
//				pst1 = con.prepareStatement("SET FOREIGN_KEY_CHECKS=0;");
//				pst1.executeUpdate();
			}
			
			
			pst1 = con.prepareStatement("insert into reservation_final(Aadhar_no,flight_no,P_departure,P_arrival,class,cost,start_location,end_location)"+" values(?,?,?,?,?,?,?,?)");
			pst1.setString(1, Aadhar_no);
			pst1.setString(2, flight_no);
			pst1.setString(3,f_arr_time);
			pst1.setString(4,f_dest_time);
			pst1.setString(5,f_class);
			pst1.setInt(6, cost);
			pst1.setString(7, f_sour);
			pst1.setString(8,f_dest);
			
			
			dispatcher = request.getRequestDispatcher("index.jsp");

			
			 int rowCount=pst1.executeUpdate();
			 
			 if(rowCount>0) { 
				 request.setAttribute("status", "success");
			 } 
			 else {
			     request.setAttribute("status","failed"); 
			 }
			 
			dispatcher.forward(request, response);
		} catch (Exception e) {
			
			e.printStackTrace();
		}

	}

}
