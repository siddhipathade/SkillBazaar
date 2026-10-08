package com.skillbazaar.instructor;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.skillbazaar.dao.DBConnection;

@WebServlet("/InstructorAddCourseServlet")
public class InstructorAddCourseServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int instructorId = (int) session.getAttribute("userId");

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        double price = Double.parseDouble(request.getParameter("price"));
        String previewVideo = request.getParameter("preview_video");

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO courses (title, description, category, price, instructor_id, preview_video, status) " +
                "VALUES (?, ?, ?, ?, ?, ?, 'PENDING')"
            );

            ps.setString(1, title);
            ps.setString(2, description);
            ps.setString(3, category);
            ps.setDouble(4, price);
            ps.setInt(5, instructorId);
            ps.setString(6, previewVideo);

            ps.executeUpdate();

            response.sendRedirect("instructor/dashboard.jsp?msg=course_submitted");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}