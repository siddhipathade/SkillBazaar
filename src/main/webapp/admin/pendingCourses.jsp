<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.skillbazaar.dao.DBConnection" %>
<%
    /* Cache control */
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    /* Session check for Admin */
    if (session.getAttribute("user") == null ||
        !"admin".equalsIgnoreCase(session.getAttribute("role").toString())) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pending Approvals | SkillBazaar Admin</title>
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
        .course-title-heading {
            color: #2d3436;
            font-weight: 700;
            margin-bottom: 25px;
            font-size: 2rem;
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
        }
        .video-preview-box {
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        /* Action Buttons */
        .btn-approve {
            background: #6a11cb; /* Deep Purple */
            color: white !important;
            font-weight: 600;
            border-radius: 6px;
            padding: 6px 15px;
            transition: 0.3s;
            text-decoration: none;
            display: inline-block;
            border: none;
        }
        .btn-approve:hover {
            background: #6a11cb; /* Shifts to Blue-Purple on hover */
            transform: scale(1.05);
            color: white;
        }
        .btn-reject {
            background: #e74c3c;
            color: white !important;
            font-weight: 600;
            border-radius: 6px;
            padding: 6px 15px;
            transition: 0.3s;
            text-decoration: none;
            display: inline-block;
        }
        .btn-reject:hover {
            background: #c0392b;
            transform: scale(1.05);
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
                <li class="nav-item"><a class="nav-link active" href="#">Admin</a></li>
                <li class="nav-item"><a class="nav-link disabled" href="#">Instructor</a></li>
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
        <div class="col-lg-12 glass-card">
        
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="course-title-heading mb-0">Pending Course Approvals</h2>
            </div>
            
            <div class="table-responsive">
                <table class="table align-middle">
                    <thead>
                        <tr>
                            <th class="ps-4">Course Title</th>
                            <th>Instructor</th>
                            <th>Category</th>
                            <th>Price</th>
                            <th>Preview</th>
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
                                "SELECT c.*, u.name AS instructor_name FROM courses c " +
                                "JOIN users u ON c.instructor_id=u.user_id " +
                                "WHERE UPPER(c.status)='PENDING' " +
                                "ORDER BY c.course_id DESC"
                            );
                            rs = ps.executeQuery();
                            boolean hasPending = false;
                            while (rs.next()) {
                                hasPending = true;
                        %>
                        <tr>
                            <td class="ps-4 fw-bold"><%= rs.getString("title") %></td>
                            <td><i class="fa fa-user-tie me-2 text-muted"></i><%= rs.getString("instructor_name") %></td>
                            <td><span class="badge bg-light text-dark border"><%= rs.getString("category") %></span></td>
                            <td class="price-text">₹ <%= String.format("%.2f", rs.getDouble("price")) %></td>
                            <td>
                                <div class="video-preview-box">
                                    <iframe width="180" height="100"
                                        src="<%=rs.getString("preview_video")%>" 
                                        style="border:none;" allowfullscreen>
                                    </iframe>
                                </div>
                            </td>
                            <td class="text-center">
                                <div class="d-flex gap-2 justify-content-center">
                                    <a href="../ApproveCourseServlet?id=<%=rs.getInt("course_id")%>" 
                                       class="btn-approve shadow-sm">
                                       <i class="fa fa-check me-1"></i> Approve
                                    </a>
                                    <a href="../RejectCourseServlet?id=<%=rs.getInt("course_id")%>" 
                                       class="btn-reject shadow-sm"
                                       onclick="return confirm('Are you sure you want to reject this course?')">
                                       <i class="fa fa-xmark me-1"></i> Reject
                                    </a>
                                </div>
                            </td>
                        </tr>
                        <%
                            }
                            if (!hasPending) {
                        %>
                        <tr>
                            <td colspan="6" class="text-center py-5">
                                <p class="text-muted mb-0">No pending course approvals at the moment.</p>
                            </td>
                        </tr>
                        <%
                            }
                        } catch(Exception e) {
                            out.println("<tr><td colspan='6'>Error: " + e.getMessage() + "</td></tr>");
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
                <hr>
                <a href="dashboard.jsp" class="back-link">
                    <i class="fa-solid fa-arrow-left me-2"></i>Back to Admin Dashboard
                </a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>