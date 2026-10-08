package com.skillbazaar.payment;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.skillbazaar.dao.DBConnection;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        
    	HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            res.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        int studentId = (int) session.getAttribute("userId");
        int courseId = Integer.parseInt(req.getParameter("courseId"));
        double amount = Double.parseDouble(req.getParameter("amount"));
        String txnRef = req.getParameter("txnRef");

        Connection con = null;

        try {
            con = DBConnection.getConnection();
            con.setAutoCommit(false); // 🔐 important

            /* 🚫 CHECK IF ALREADY PAID */
            PreparedStatement paidCheck = con.prepareStatement(
                "SELECT 1 FROM enrollments WHERE student_id=? AND course_id=? AND payment_status='PAID'"
            );
            paidCheck.setInt(1, studentId);
            paidCheck.setInt(2, courseId);

            ResultSet paidRs = paidCheck.executeQuery();

            if (paidRs.next()) {
                con.rollback();
                res.sendRedirect(req.getContextPath() + "/student/myCourses.jsp?msg=alreadyPaid");
                return;
            }

            
            
            
            
            /* 1️⃣ INSERT PAYMENT */
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO payments " +
                "(student_id, course_id, amount, payment_method, payment_status, transaction_ref) " +
                "VALUES (?, ?, ?, ?, ?, ?)"
            );

            ps.setInt(1, studentId);
            ps.setInt(2, courseId);
            ps.setDouble(3, amount);
            ps.setString(4, "UPI");
            ps.setString(5, "SUCCESS");
            ps.setString(6, txnRef);
            ps.executeUpdate();

            /* 2️⃣ CHECK ENROLLMENT */
            PreparedStatement last = con.prepareStatement(
            	    "SELECT approval_status FROM enrollments WHERE student_id=? AND course_id=? ORDER BY enrollment_id DESC LIMIT 1"
            	);
            	last.setInt(1, studentId);
            	last.setInt(2, courseId);
            	ResultSet lrs = last.executeQuery();

            	boolean allowNew = true;

            	if (lrs.next()) {
            	    String status = lrs.getString("approval_status");
            	    if ("APPROVED".equalsIgnoreCase(status) || "PENDING".equalsIgnoreCase(status)) {
            	        allowNew = false;
            	    }
            	}

            	if (!allowNew) {
            	    con.rollback();
            	    res.getWriter().print("Already enrolled or pending approval");
            	    return;
            	}

            	/* INSERT NEW ENROLLMENT */
            	PreparedStatement ins = con.prepareStatement(
            	    "INSERT INTO enrollments (student_id, course_id, payment_status, approval_status) " +
            	    "VALUES (?, ?, 'PAID', 'PENDING')"
            	);
            	ins.setInt(1, studentId);
            	ins.setInt(2, courseId);
            	ins.executeUpdate();


            con.commit(); // ✅ finalize transaction
            res.sendRedirect(req.getContextPath() + "/student/myCourses.jsp");

        } catch (Exception e) {
            try {
                if (con != null) con.rollback();
            } catch (Exception ex) {}

            e.printStackTrace(); // 🔥 MUST CHECK CONSOLE
            res.getWriter().print("Payment failed");
        }
    }
}