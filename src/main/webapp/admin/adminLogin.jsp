<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login | SkillBazaar</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* Shared Brand Identity */
        .navbar-brand { 
            font-weight: bold !important; 
            color: #0d6efd !important; 
            transition: color 0.3s ease; 
            text-decoration: none;
        }
        .navbar-brand:hover {
            color: #ffffff !important; 
        }
        
        body {
            /* Identical Gradient to Login Page */
            background: linear-gradient(135deg, #EFE6FF 0%, #CDC1FF 50%, #FFFFFF 100%);
            min-height: 100vh;
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            flex-direction: column;
        }

        /* Centering Wrapper */
        .login-wrapper {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        /* Card Style - Matched to Login Page */
        .login-card {
            background: rgba(255, 255, 255, 0.95);
            padding: 2.5rem;
            border-radius: 15px; /* Same rounded corners */
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 400px;
        }

        .login-card h2 {
            color: #4b3074; /* Theme Purple */
            font-weight: 700;
            margin-bottom: 0.5rem;
            text-align: center;
        }

        /* Consistent Purple Button */
        .btn-purple {
            background-color: #764ba2;
            color: white;
            border: none;
            padding: 10px;
            font-weight: 600;
            transition: 0.3s;
        }

        .btn-purple:hover {
            background-color: #5a3782;
            color: white;
            transform: translateY(-2px);
        }

        .form-control:focus {
            border-color: #764ba2;
            box-shadow: 0 0 0 0.25rem rgba(118, 75, 162, 0.25);
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
           <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-outline-success">Back</a>
        </div>
    </div>
</nav>

<div class="login-wrapper">
    <div class="login-card">
        <h2>Admin Login</h2>
        <p class="text-center text-muted mb-4">Please enter administrator credentials.</p>
        
        <form action="<%=request.getContextPath()%>/AdminLoginServlet" method="post">
            <div class="mb-3">
                <label class="form-label text-muted small fw-bold">Admin Username</label>
                <input type="text" name="username" class="form-control" placeholder="Username" required>
            </div>
            
            <div class="mb-3">
                <label class="form-label text-muted small fw-bold">Password</label>
                <input type="password" name="password" class="form-control" placeholder="••••••••" required>
            </div>
            
            <button type="submit" class="btn btn-purple w-100 mt-2">Login</button>
        </form>
        
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>