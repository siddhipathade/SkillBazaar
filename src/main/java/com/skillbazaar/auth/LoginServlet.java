package com.skillbazaar.auth;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.skillbazaar.dao.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM users WHERE email=? AND password=?"
            );

            ps.setString(1, req.getParameter("email"));
            ps.setString(2, req.getParameter("password"));

            ResultSet rs = ps.executeQuery();
            String redirect = req.getParameter("redirect");
            String courseId = req.getParameter("courseId");
            
        
            if (rs.next()) {
                HttpSession session = req.getSession();
                session.setAttribute("user", rs.getString("name"));
                session.setAttribute("role", rs.getString("role"));
                session.setAttribute("userId", rs.getInt("user_id"));

                String role = rs.getString("role");

                if ("ADMIN".equalsIgnoreCase(role)) {
                    res.sendRedirect("admin/dashboard.jsp");

                } else if ("INSTRUCTOR".equalsIgnoreCase(role)) {
                    res.sendRedirect("instructor/dashboard.jsp");

                } else if ("STUDENT".equalsIgnoreCase(role)) {

                    if ("payment".equals(redirect) && courseId != null) {
                        res.sendRedirect("student/payment.jsp?courseId=" + courseId);
                    } else {
                    	 res.sendRedirect("student/dashboard.jsp");
                    }
                }

            } else {
                res.getWriter().print("Invalid Credentials");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}