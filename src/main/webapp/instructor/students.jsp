<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.skillbazaar.dao.DBConnection" %>
<%
/* ===============================
   SECURITY CHECK (Unchanged)
================================ */
if (session.getAttribute("userId") == null ||
    !"instructor".equalsIgnoreCase((String) session.getAttribute("role"))) {
    response.sendRedirect("../login.jsp");
    return;
}
int instructorId = (int) session.getAttribute("userId");

/* ===============================
   SELECTED COURSE
================================ */
String selectedCourseId = request.getParameter("courseId");
Connection con = DBConnection.getConnection();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Students | SkillBazaar</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* --- SkillBazaar Brand: Blue to White Hover (Unchanged) --- */
        .navbar-brand { 
            font-weight: bold !important; 
            color: #0d6efd !important; 
            transition: color 0.3s ease; 
            text-decoration: none;
        }
        .navbar-brand:hover {
            color: #ffffff !important; 
        }

        /* Exact Background Color from Screenshot */
        body { 
            background: linear-gradient(135deg, #EFE6FF 0%, #CDC1FF 50%, #FFFFFF 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;

        }
        
        /* White Container with exact 20px curves and shadow */
        .content-card {
            background-color: #ffffff;
            border-radius: 20px; 
            padding: 40px;
            margin-top: 50px;
            margin-bottom: 50px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.2);
        }

        .page-title {
            font-weight: 700;
            color: #2d3436;
            font-size: 2rem;
            margin-bottom: 10px;
        }

        /* Purple Button Styles matching Manage Videos */
      /* Base Button Style */
.btn-purple {
    background-color: #833ab4; /* Specific Purple from your screenshot */
    color: white !important;
    border: none;
    padding: 10px 25px;
    border-radius: 8px; /* Rounded corners */
    font-weight: 600;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    transition: all 0.3s ease; /* Makes the hover transition smooth */
}

/* Hover Effect */
.btn-purple:hover {
    background-color: #6a2f91; /* A slightly darker purple on hover */
    transform: translateY(-2px); /* Lifts the button slightly */
    box-shadow: 0 5px 15px rgba(0,0,0,0.2); /* Adds a soft shadow */
}

        /* Table Styling matching Screenshot (523) */
        .table {
            margin-top: 30px;
            border-collapse: separate;
            border-spacing: 0;
        }
        .table thead th {
            color: #2d3436;
            font-weight: 700;
            border-bottom: 2px solid #f1f2f6;
            padding: 15px;
            font-size: 1.05rem;
        }
        .table tbody td {
            padding: 20px 15px;
            vertical-align: middle;
            border-bottom: 1px solid #f1f2f6;
            color: #2d3436;
        }
        
        /* Progress Bar style */
        .progress {
            height: 12px;
            border-radius: 20px;
            background-color: #f1f2f6;
        }
        .progress-bar {
            background-color: #8e44ad;
        }

        /* Footer Link Style */
        .footer-link {
            color: #8e44ad;
            text-decoration: none;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 5px;
            margin-top: 20px;
        }
        .footer-link:hover {
            color: #7d3c98;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">SKILLBAZAAR</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item"><a class="nav-link disabled" href="#">Home</a></li>
                <li class="nav-item"><a class="nav-link disabled" href="#">Admin</a></li>
                <li class="nav-item"><a class="nav-link active" href="#">Instructor</a></li>
                <li class="nav-item"><a class="nav-link disabled" href="#">Student</a></li>
            </ul>
            <form action="<%=request.getContextPath()%>/LogoutServlet">
                <button class="btn btn-outline-danger" type="submit">Logout</button>
            </form>
        </div>
    </div>
</nav>

<div class="container">
    <div class="content-card">
        
        <h2 class="page-title">
            <%= (selectedCourseId == null) ? "My Students" : "Student Progress Tracking" %>
        </h2>

        <% if (selectedCourseId == null) { %>
            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Course Title</th>
                            <th class="text-center">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        PreparedStatement cps = con.prepareStatement(
                            "SELECT course_id, title FROM courses WHERE instructor_id=? AND status='APPROVED'"
                        );
                        cps.setInt(1, instructorId);
                        ResultSet crs = cps.executeQuery();
                        boolean hasCourses = false;
                        while (crs.next()) {
                            hasCourses = true;
                    %>
                        <tr>
                            <td class="fw-bold"><%= crs.getString("title") %></td>
                            <td class="text-center">
                                <a href="students.jsp?courseId=<%= crs.getInt("course_id") %>" class="btn btn-purple">
                                    <i class="fas fa-users me-2"></i>View Students
                                </a>
                            </td>
                        </tr>
                    <% } 
                        if (!hasCourses) { %>
                        <tr><td colspan="2" class="text-center py-4 text-muted">No approved courses available.</td></tr>
                    <% } 
                       crs.close(); cps.close(); %>
                    </tbody>
                </table>
            </div>
            <div class="text-center">
                <a href="dashboard.jsp" class="footer-link">
                    <i class="fas fa-arrow-left"></i> Back to Dashboard
                </a>
            </div>
        <% } %>

        <% if (selectedCourseId != null) {
            int courseId = Integer.parseInt(selectedCourseId);
            PreparedStatement sps = con.prepareStatement(
                "SELECT u.name, u.email, " +
                "COUNT(DISTINCT svp.video_id) AS watched, " +
                "(SELECT COUNT(*) FROM course_videos WHERE course_id=?) AS total " +
                "FROM enrollments e " +
                "JOIN users u ON e.student_id = u.user_id " +
                "LEFT JOIN student_video_progress svp " +
                "ON svp.student_id = u.user_id AND svp.course_id = e.course_id " +
                "WHERE e.course_id=? AND e.approval_status='APPROVED' " +
                "GROUP BY u.user_id, u.name, u.email"
            );
            sps.setInt(1, courseId);
            sps.setInt(2, courseId);
            ResultSet srs = sps.executeQuery();
        %>
            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Student Name</th>
                            <th>Email Address</th>
                            <th style="width: 300px;">Progress</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        boolean hasStudents = false;
                        while (srs.next()) {
                            hasStudents = true;
                            int watched = srs.getInt("watched");
                            int total = srs.getInt("total");
                            int progress = (total > 0) ? (watched * 100) / total : 0;
                    %>
                        <tr>
                            <td class="fw-bold"><%= srs.getString("name") %></td>
                            <td class="text-muted"><%= srs.getString("email") %></td>
                            <td>
                                <div class="d-flex align-items-center gap-3">
                                    <div class="progress flex-grow-1">
                                        <div class="progress-bar" style="width: <%=progress%>%"></div>
                                    </div>
                                    <span class="fw-bold small"><%=progress%>%</span>
                                </div>
                                <div class="text-muted extra-small" style="font-size: 0.8rem; margin-top: 4px;">
                                    <%=watched%> of <%=total%> lessons watched
                                </div>
                            </td>
                        </tr>
                    <% } 
                        if (!hasStudents) { %>
                        <tr><td colspan="3" class="text-center py-5 text-muted">No students currently enrolled in this course.</td></tr>
                    <% } 
                       srs.close(); sps.close(); %>
                    </tbody>
                </table>
            </div>
            <div class="text-center">
                <a href="students.jsp" class="footer-link">
                    <i class="fas fa-arrow-left"></i> Back to Courses
                </a>
            </div>
        <% } 
           con.close(); %>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>