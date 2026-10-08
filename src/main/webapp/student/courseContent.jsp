<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="com.skillbazaar.dao.DBConnection" %>

<%
/* Cache control */
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);

/* Session validation */
HttpSession sess = request.getSession(false);

if (sess == null || sess.getAttribute("userId") == null ||
    !sess.getAttribute("role").toString().equalsIgnoreCase("student")) {

    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
}

int studentId = (int) sess.getAttribute("userId");
int courseId = Integer.parseInt(request.getParameter("courseId"));

/* PAYMENT CHECK */
Connection con = DBConnection.getConnection();
PreparedStatement ps = con.prepareStatement(
    "SELECT * FROM payments WHERE student_id=? AND course_id=? AND payment_status='SUCCESS'"
);
ps.setInt(1, studentId);
ps.setInt(2, courseId);

ResultSet rs = ps.executeQuery();

if (!rs.next()) {
    // Not paid
    response.sendRedirect(request.getContextPath() + "/student/payment.jsp?courseId=" + courseId);
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Course Content</title>
</head>
<body>

<h2>Welcome to Course</h2>
<p>You have successfully purchased this course.</p>

<hr>

<h3>Course Content</h3>

<ul>
  <li>📹 Introduction Video</li>
  <li>📄 Course Notes (PDF)</li>
  <li>📹 Advanced Topics</li>
</ul>

</body>
</html>