<%@ page import="java.sql.*" %>
<%@ page import="com.skillbazaar.dao.DBConnection" %>

<%
if (session.getAttribute("user") == null ||
    !"admin".equalsIgnoreCase(session.getAttribute("role").toString())) {
    response.sendRedirect("adminLogin.jsp");
    return;
}

int enrollmentId = Integer.parseInt(request.getParameter("id"));
String action = request.getParameter("action");

String status = "REJECTED";
if ("approve".equalsIgnoreCase(action)) {
    status = "APPROVED";
}

Connection con = DBConnection.getConnection();
PreparedStatement ps = con.prepareStatement(
    "UPDATE enrollments SET approval_status=? WHERE enrollment_id=?"
);
ps.setString(1, status);
ps.setInt(2, enrollmentId);
ps.executeUpdate();

ps.close();
con.close();

response.sendRedirect("pendingEnrollments.jsp");
%>