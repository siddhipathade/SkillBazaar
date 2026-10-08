<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    
    // Logic for admin role
    if (session.getAttribute("user") == null || 
        !"admin".equals((String)session.getAttribute("role"))) {
        response.sendRedirect("../admin/adminLogin.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | SkillBazaar</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    
    <style>
        body {
            background: linear-gradient(135deg, #EFE6FF 0%, #CDC1FF 50%, #FFFFFF 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            flex-direction: column;
        }
        
        .navbar-brand { 
            font-weight: bold !important; 
            color: #0d6efd !important; 
            transition: color 0.3s ease; 
            text-decoration: none;
        }
        .navbar-brand:hover {
            color: #ffffff !important; 
        }
        .main-content {
            flex-grow: 1;
            display: flex;
            align-items: center;
            padding: 40px 0;
        }
        .dashboard-container {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
        }
        .card-custom {
            border: none;
            border-radius: 15px;
            transition: all 0.3s ease;
            background: #ffffff;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
        }
        .card-custom:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.1);
        }
        .icon-box {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            font-size: 1.8rem;
        }
        /* Keeping your original colors */
        .bg-add { background-color: #f3e5f5; color: #7b1fa2; }
        .bg-view { background-color: #ede7f6; color: #512da8; }
        
        .btn-purple {
            background: linear-gradient(45deg, #6a1b9a, #7b1fa2);
            border: none;
            color: white !important;
            border-radius: 8px;
            font-weight: 600;
            padding: 10px 20px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(106, 27, 154, 0.2);
        }
        .btn-purple:hover {
            background: linear-gradient(45deg, #7b1fa2, #6a1b9a);
            transform: scale(1.02);
            box-shadow: 0 6px 20px rgba(106, 27, 154, 0.4);
        }
        .welcome-text {
            color: #2d3436;
            font-weight: 700;
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
                <li class="nav-item"><a class="nav-link active" href="#">Admin</a></li>
                <li class="nav-item"><a class="nav-link disabled" href="#">Instructor</a></li>
                <li class="nav-item"><a class="nav-link disabled" href="#">Student</a></li>
            </ul>
            <form action="<%=request.getContextPath()%>/LogoutServlet">
                <button class="btn btn-outline-danger" type="submit">Logout</button>
            </form>
        </div>
    </div>
</nav>
<div class="main-content">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-10 dashboard-container">
                
                <div class="text-center mb-5">
                    <h2 class="welcome-text mb-1">Admin Dashboard</h2>
                    <p class="text-muted mb-0">Manage and approve SkillBazaar activities.</p>
                </div>
                
                <div class="row g-4 justify-content-center">
                    
                    <div class="col-md-4">
                        <div class="card card-custom h-100 p-4 text-center">
                            <div class="icon-box bg-view">
                                <i class="fa-solid fa-file-circle-check"></i>
                            </div>
                            <h5 class="card-title fw-bold">Course Approvals</h5>
                            <p class="text-muted small">Review and approve instructor-submitted courses for the platform.</p>
                            <a href="pendingCourses.jsp" class="btn btn-purple btn-custom mt-auto">Review Courses</a>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="card card-custom h-100 p-4 text-center">
                            <div class="icon-box bg-add">
                                <i class="fa-solid fa-credit-card"></i>
                            </div>
                            <h5 class="card-title fw-bold">Enrollment Approvals</h5>
                            <p class="text-muted small">Approve students course access.</p>
                            <a href="pendingEnrollments.jsp" class="btn btn-purple btn-custom mt-auto">View Enrollments.</a>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>