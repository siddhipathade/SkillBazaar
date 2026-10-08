package com.skillbazaar.student;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.skillbazaar.dao.DBConnection;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/EnrollServlet")
public class EnrollServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        HttpSession session = req.getSession();

        int studentId = (int) session.getAttribute("userId");
        int courseId = Integer.parseInt(req.getParameter("courseId"));

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO enrollments(student_id, course_id) VALUES(?, ?)"
            );

            ps.setInt(1, studentId);
            ps.setInt(2, courseId);

            ps.executeUpdate();

            res.sendRedirect("student/myCourses.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}