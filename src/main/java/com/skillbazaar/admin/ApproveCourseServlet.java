package com.skillbazaar.admin;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.skillbazaar.dao.DBConnection;

@WebServlet("/ApproveCourseServlet")
public class ApproveCourseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");
        int courseId = Integer.parseInt(id);

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "UPDATE courses SET status='APPROVED' WHERE course_id=?"
            );
            ps.setInt(1, courseId);
            ps.executeUpdate();

            response.sendRedirect("admin/pendingCourses.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}