package com.skillbazaar.student;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.skillbazaar.dao.DBConnection;

@WebServlet("/MarkVideoWatchedServlet")
public class MarkVideoWatchedServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            res.getWriter().print("NOT LOGGED IN");
            return;
        }

        int studentId = (int) session.getAttribute("userId");
        int videoId = Integer.parseInt(req.getParameter("videoId"));
        int courseId = Integer.parseInt(req.getParameter("courseId"));

        try (Connection con = DBConnection.getConnection()) {

            PreparedStatement ps = con.prepareStatement(
                "INSERT IGNORE INTO student_video_progress " +
                "(student_id, course_id, video_id) VALUES (?, ?, ?)"
            );

            ps.setInt(1, studentId);
            ps.setInt(2, courseId);
            ps.setInt(3, videoId);

            int rows = ps.executeUpdate();
            System.out.println("ROWS INSERTED = " + rows);

            res.getWriter().print("OK");

        } catch (Exception e) {
            e.printStackTrace();
            res.getWriter().print("ERROR");
        }
    }
}