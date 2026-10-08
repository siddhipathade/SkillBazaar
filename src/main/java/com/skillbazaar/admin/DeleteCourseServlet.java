package com.skillbazaar.admin;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.skillbazaar.dao.DBConnection;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DeleteCourseServlet")
public class DeleteCourseServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "DELETE FROM courses WHERE course_id=?"
            );
            ps.setInt(1, Integer.parseInt(req.getParameter("id")));
            ps.executeUpdate();

            res.sendRedirect("admin/viewCourses.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}