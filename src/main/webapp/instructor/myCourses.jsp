<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.skillbazaar.dao.DBConnection" %>
<%
    /* Disable cache */
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    /* Session + role check */
    if (session.getAttribute("userId") == null ||
        session.getAttribute("role") == null ||
        !session.getAttribute("role").toString().equalsIgnoreCase("instructor")) {
        response.sendRedirect("../login.jsp");
        return;
    }

    /* Get instructor ID */
    Integer instructorId = (Integer) session.getAttribute("userId");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Assigned Courses | SkillBazaar</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    
    <style>
        body {
            background: linear-gradient(135deg, #EFE6FF 0%, #CDC1FF 50%, #FFFFFF 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
        }
        .navbar-brand { 
            font-weight: bold !important; 
            color: #0d6efd !important; 
        }
        .main-container {
            padding-top: 50px; 
            padding-bottom: 50px;
        }
        .glass-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
        }
        .table {
            border-radius: 12px;
            overflow: hidden;
            background: white;
        }
        .table thead {
            background: #ffffff;
            border-bottom: 2px solid #dee2e6;
        }
        .table thead th {
            color: #333;
            font-weight: 700;
            border-bottom: none;
        }
        .btn-action {
            background: #833ab4; 
            border: none;
            color: white !important;
            font-weight: 600;
            padding: 8px 25px;
            border-radius: 6px;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }
        .btn-action:hover {
            background: #6a2f91;
            transform: scale(1.05);
        }
        .course-title-heading {
            color: #2d3436;
            font-weight: 700;
            margin-bottom: 25px;
            font-size: 2rem;
        }
        .price-text {
            font-weight: bold;
            color: #000;
        }
        .back-link {
            color: #833ab4; 
            text-decoration: none; 
            font-weight: 600;
            transition: opacity 0.2s;
        }
        .back-link:hover {
            opacity: 0.8;
            color: #6a2f91;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">SKILLBAZAAR</a>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link disabled" href="#">Home</a></li>
                <li class="nav-item"><a class="nav-link disabled" href="#">Admin</a></li>
                <li class="nav-item"><a class="nav-link active" href="#">Instructor</a></li>
                <li class="nav-item"><a class="nav-link disabled" href="#">Student</a></li>
            </ul>
            <form action="<%=request.getContextPath()%>/LogoutServlet" method="post">
                <button class="btn btn-outline-danger" type="submit">Logout</button>
            </form>
        </div>
    </div>
</nav>

<div class="container main-container">
    <div class="row justify-content-center">
        <div class="col-lg-11 glass-card">
        
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="course-title-heading mb-0">My Assigned Courses</h2>
                <a href="addCourse.jsp" class="btn btn-success"><i class="fa fa-plus me-2"></i>New Course</a>
            </div>
            
            <div class="table-responsive">
                <table class="table align-middle">
                    <thead>
                        <tr>
                            <th class="ps-4">Course Title</th>
                            <th>Price</th>
                            <th class="text-center">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        Connection con = null;
                        PreparedStatement ps = null;
                        ResultSet rs = null;
                        try {
                            con = DBConnection.getConnection();
                            ps = con.prepareStatement(
                                "SELECT * FROM courses WHERE instructor_id=? ORDER BY course_id DESC"
                            );
                            ps.setInt(1, instructorId);
                            rs = ps.executeQuery();
                            boolean hasCourses = false;
                            
                            while(rs.next()){
                                hasCourses = true;
                        %>
                        <tr>
                            <td class="ps-4 fw-bold"><%= rs.getString("title") %></td>
                            <td class="price-text">₹ <%= String.format("%.2f", rs.getDouble("price")) %></td>
                            <td class="text-center">
                                <a href="manageVideos.jsp?courseId=<%= rs.getInt("course_id") %>"
                                   class="btn-action">
                                   <i class="fa-solid fa-video me-2"></i>Manage Videos
                                </a>
                            </td>
                        </tr>
                        <% 
                            } 
                            if (!hasCourses) {
                        %>
                        <tr>
                            <td colspan="3" class="text-center py-5">
                                <p class="text-muted">You haven't uploaded any courses yet.</p>
                                <a href="addCourse.jsp" class="btn btn-outline-primary">Create Your First Course</a>
                            </td>
                        </tr>
                        <%
                            }
                        } catch(Exception e) {
                            out.println("<tr><td colspan='3'>Error: " + e.getMessage() + "</td></tr>");
                        } finally {
                            if(rs != null) rs.close();
                            if(ps != null) ps.close();
                            if(con != null) con.close();
                        }
                        %>
                    </tbody>
                </table>
            </div>
            
            <div class="mt-5 text-center">
                <a href="dashboard.jsp" class="back-link">
                    <i class="fa-solid fa-arrow-left me-2"></i>Back to Dashboard
                </a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>