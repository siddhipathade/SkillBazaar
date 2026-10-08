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

@WebServlet("/RejectEnrollmentServlet")
public class RejectEnrollmentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null || !"admin".equalsIgnoreCase((String) session.getAttribute("role"))) {
            res.sendRedirect(req.getContextPath() + "/admin/adminLogin.jsp");
            return;
        }

        String enrollmentIdStr = req.getParameter("enrollmentId");
        String rejectionReason = req.getParameter("rejectionReason");

        if (enrollmentIdStr == null || rejectionReason == null || rejectionReason.trim().isEmpty()) {
            res.getWriter().print("Invalid rejection data");
            return;
        }

        int enrollmentId = Integer.parseInt(enrollmentIdStr);

        try (Connection con = DBConnection.getConnection()) {

            PreparedStatement ps = con.prepareStatement(
                "UPDATE enrollments " +
                "SET approval_status='REJECTED', rejection_reason=? " +
                "WHERE enrollment_id=?"
            );

            ps.setString(1, rejectionReason);
            ps.setInt(2, enrollmentId);
            ps.executeUpdate();

            res.sendRedirect(req.getContextPath() + "/admin/pendingEnrollments.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            res.getWriter().print("Reject failed");
        }
    }
}