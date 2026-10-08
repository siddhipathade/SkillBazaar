package com.skillbazaar.auth;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.skillbazaar.dao.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO users(name,email,password,role) VALUES(?,?,?,?)"
            );

            ps.setString(1, req.getParameter("name"));
            ps.setString(2, req.getParameter("email"));
            ps.setString(3, req.getParameter("password"));
            ps.setString(4, req.getParameter("role"));

            ps.executeUpdate();

            res.sendRedirect("login.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}