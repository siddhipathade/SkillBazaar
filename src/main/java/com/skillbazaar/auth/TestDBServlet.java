package com.skillbazaar.auth;

import java.io.IOException;
import java.sql.Connection;

import com.skillbazaar.dao.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/testdb")
public class TestDBServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        Connection con = DBConnection.getConnection();

        if (con != null)
            res.getWriter().print("Database Connected Successfully");
        else
            res.getWriter().print("Database Connection Failed");
    }
}