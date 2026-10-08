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

@WebServlet("/AddCourseVideoServlet")
public class AddCourseVideoServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int courseId = Integer.parseInt(request.getParameter("courseId"));
        String title = request.getParameter("title");
        String videoUrl = request.getParameter("videoUrl");
        int videoOrder = Integer.parseInt(request.getParameter("videoOrder"));
        boolean isPreview = request.getParameter("isPreview") != null;

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO course_videos (course_id, title, video_url, is_preview, video_order) " +
                "VALUES (?, ?, ?, ?, ?)"
            );

            ps.setInt(1, courseId);
            ps.setString(2, title);
            ps.setString(3, videoUrl);
            ps.setBoolean(4, isPreview);
            ps.setInt(5, videoOrder);

            ps.executeUpdate();

            ps.close();
            con.close();

            response.sendRedirect(
                request.getContextPath() +
                "/instructor/manageVideos.jsp?courseId=" + courseId
            );

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error adding video");
        }
    }
}