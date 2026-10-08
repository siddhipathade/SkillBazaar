package com.skillbazaar.student;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.skillbazaar.dao.DBConnection;

@WebServlet("/RequestReApprovalServlet")
public class RequestReApprovalServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            res.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        int studentId = (int) session.getAttribute("userId");
        int courseId = Integer.parseInt(req.getParameter("courseId"));

        try (Connection con = DBConnection.getConnection()) {

            PreparedStatement ps = con.prepareStatement(
                "UPDATE enrollments " +
                "SET approval_status='PENDING', rejection_reason=NULL " +
                "WHERE student_id=? AND course_id=? AND approval_status='REJECTED'"
            );

            ps.setInt(1, studentId);
            ps.setInt(2, courseId);

            int updated = ps.executeUpdate(); // ✅ ONLY ONCE

            if (updated > 0) {
                res.sendRedirect(req.getContextPath() + "/student/myCourses.jsp");
            } else {
                res.getWriter().print("No rejected enrollment found to re-approve.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            res.getWriter().print("Failed to request re-approval");
        }
    }
}