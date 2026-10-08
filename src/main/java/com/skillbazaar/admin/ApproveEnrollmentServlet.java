package com.skillbazaar.admin;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.skillbazaar.dao.DBConnection;

@WebServlet("/ApproveEnrollmentServlet")
public class ApproveEnrollmentServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null || !"admin".equalsIgnoreCase((String) session.getAttribute("role"))) {
            res.sendRedirect("admin/adminLogin.jsp");
            return;
        }

        int enrollmentId = Integer.parseInt(req.getParameter("id"));

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "UPDATE enrollments SET approval_status='APPROVED' WHERE enrollment_id=?"
            );
            ps.setInt(1, enrollmentId);
            ps.executeUpdate();

            res.sendRedirect("admin/pendingEnrollments.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            res.getWriter().print("Approval failed");
        }
    }
}