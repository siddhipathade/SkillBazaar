package com.skillbazaar.admin;

import java.io.IOException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        String expectedUsername = System.getenv("SKILLBAZAAR_ADMIN_USERNAME");
        String expectedPassword = System.getenv("SKILLBAZAAR_ADMIN_PASSWORD");

        if (expectedUsername != null && expectedPassword != null
                && expectedUsername.equals(username)
                && expectedPassword.equals(password)) {

            HttpSession session = req.getSession();
            session.setAttribute("user", "admin");
            session.setAttribute("role", "admin");

            res.sendRedirect("admin/dashboard.jsp");
        } else {
            res.getWriter().println("Invalid Admin Credentials");
        }
    }
}
