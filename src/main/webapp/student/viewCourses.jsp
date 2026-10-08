<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.skillbazaar.dao.DBConnection"%>
<%
    /* Cache control */
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    
    /* Session check */
    if (session.getAttribute("userId") == null || !"student".equalsIgnoreCase((String)session.getAttribute("role"))) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Available Courses | SkillBazaar</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    
    <style>
        body {
            background: linear-gradient(135deg, #EFE6FF 0%, #CDC1FF 50%, #FFFFFF 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
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
            background: #6a1b9a;
            color: white;
        }
        .btn-buy {
            background: linear-gradient(45deg, #6a1b9a, #7b1fa2);
            border: none;
            color: white !important;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .btn-buy:hover {
            transform: scale(1.05);
            box-shadow: 0 4px 12px rgba(106, 27, 154, 0.3);
        }
        .course-title {
            color: #2d3436;
            font-weight: 700;
            margin-bottom: 25px;
            font-size: 2rem;
        }
        
        .price-tag {
            font-weight: bold;
            color: #2ecc71;
        }

        /* Centered Back Link Style */
        .back-link {
            color: #6a1b9a; 
            text-decoration: none; 
            font-weight: 600;
            transition: all 0.2s ease;
        }
        .back-link:hover {
            color: #7b1fa2;
            opacity: 0.8;
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
                <li class="nav-item"><a class="nav-link disabled" href="#">Instructor</a></li>
                <li class="nav-item"><a class="nav-link active" href="#">Student</a></li>
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
                <h2 class="course-title mb-0">Explore Available Courses</h2>
            </div>
            
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead>
                        <tr>
                            <th class="ps-4">Course Title</th>
                            <th>Category</th>
                            <th>Price</th>
                            <th class="text-center">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        try (Connection con = DBConnection.getConnection();
                             PreparedStatement ps = con.prepareStatement("SELECT * FROM courses");
                             ResultSet rs = ps.executeQuery()) {
                            
                            boolean hasCourses = false;
                            while (rs.next()) {
                                hasCourses = true;
                        %>
                        <tr>
                            <td class="ps-4 fw-bold"><%=rs.getString("title")%></td>
                            <td><span class="badge bg-light text-dark border"><%=rs.getString("category")%></span></td>
                            <td class="price-tag">Rs.<%=String.format("%.2f", rs.getDouble("price"))%></td>
                            <td class="text-center">
                                <a href="../courseDetails.jsp?courseId=<%=rs.getInt("course_id")%>" 
                                   class="btn btn-buy px-4">
                                   View Details
                                </a>
                            </td>
                        </tr>
                        <%
                            }
                            if (!hasCourses) {
                                out.println("<tr><td colspan='4' class='text-center py-4 text-muted'>No courses currently available.</td></tr>");
                            }
                        } catch(Exception e) {
                            out.println("<tr><td colspan='4'>Error loading courses: " + e.getMessage() + "</td></tr>");
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