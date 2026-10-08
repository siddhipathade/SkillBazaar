package com.skillbazaar.instructor;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.skillbazaar.dao.DBConnection;

@WebServlet("/DeleteCourseVideoServlet")
public class DeleteCourseVideoServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int videoId = Integer.parseInt(request.getParameter("videoId"));
        int courseId = Integer.parseInt(request.getParameter("courseId"));

        try (Connection con = DBConnection.getConnection()) {

            PreparedStatement ps = con.prepareStatement(
                "DELETE FROM course_videos WHERE video_id=?"
            );

            ps.setInt(1, videoId);
            ps.executeUpdate();

            response.sendRedirect("instructor/manageVideos.jsp?courseId=" + courseId);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}