<%@ page import="java.sql.*" %>
<%@ page import="com.skillbazaar.dao.DBConnection" %>
<%
Connection con = DBConnection.getConnection();
PreparedStatement ps = con.prepareStatement(
    "SELECT * FROM courses WHERE status='APPROVED'"
);
ResultSet rs = ps.executeQuery();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Skilled Bazaar - Unlock Your Potential</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { background-color: #f8f9fa; }
        .navbar-brand { font-weight: bold; color: #0d6efd; }
        
        /* Consistent Card Layout */
        .course-card { 
            height: 550px; 
            transition: transform 0.3s; 
            border: none; 
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            display: flex;
            flex-direction: column;
            overflow: hidden;
            background: #fff;
            border-radius: 8px;
        }
        
        .course-card:hover { transform: translateY(-10px); }

        /* Force image to 60% of card (330px) */
        .course-img { 
            height: 330px !important; 
            width: 100%;
            object-fit: cover; 
            object-position: center;
            flex-shrink: 0;
        }

        /* Force body to 40% of card (220px) */
        .card-body {
            height: 220px;
            display: flex;
            flex-direction: column;
            justify-content: space-between; 
            padding: 1.25rem;
        }

        /* Standardize title and text height to keep cards identical */
        .card-title {
            font-size: 1.2rem;
            margin-bottom: 0.25rem;
            display: -webkit-box;
            -webkit-line-clamp: 1;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .card-text {
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
            margin-bottom: 0;
        }

        .rating { color: #ffc107; font-size: 0.9rem; }
        .price { font-size: 1.25rem; font-weight: bold; color: #198754; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="#">SKILLED BAZAAR</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item"><a class="nav-link active" href="index.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link deactive" href="http://localhost:8080/SkillBazaar/admin/adminLogin.jsp">Admin</a></li>
                <li class="nav-item"><a class="nav-link disabled" href="#">Instructor</a></li>
                <li class="nav-item"><a class="nav-link disabled" href="#">Student</a></li>
            </ul>
            <form action="login.jsp">
                <button class="btn btn-outline-success" type="submit">Login/Register</button>
            </form>
        </div>
    </div>
</nav>

<header class="bg-primary text-white text-center py-5 mb-5">
    <div class="container">
        <h1>Welcome to Skilled Bazaar</h1>
        <p class="lead">Master the most in-demand tech skills today.</p>
    </div>
</header>

<div class="container mb-5">
    <div class="row g-4">
        
        <div class="col-md-4">
            <div class="card course-card">
                <img src="images/java.jpeg" class="card-img-top course-img" alt="Java">
                <div class="card-body">
                    <div>
                        <h5 class="card-title">Java Programming</h5>
                        <p class="text-muted small mb-1">By CodeWithHarry</p>
                        <div class="rating mb-2">
                            <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star-half-alt"></i>
                            <span class="text-dark">(4.8)</span>
                        </div>
                        <p class="card-text small">Master core Java and advanced backend frameworks like Spring Boot. Build scalable, secure enterprise-level applications from scratch.</p>
                    </div>
                    <div class="d-flex justify-content-between align-items-center">
                        <span class="price">Rs.1999</span>
                        <a href="courseDetails.jsp?courseId=8" class="btn btn-outline-primary btn-sm">View Details</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card course-card">
                <img src="images/cpp.jpg" class="card-img-top course-img" alt="CPP">
                <div class="card-body">
                    <div>
                        <h5 class="card-title">C++ Fundamentals</h5>
                        <p class="text-muted small mb-1">By Shraddha Khapra</p>
                        <div class="rating mb-2">
                            <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="far fa-star"></i>
                            <span class="text-dark">(4.7)</span>
                        </div>
                        <p class="card-text small">Dive into memory management, STL, and high-performance coding. Perfect for developing system software, game engines, and competitive programming skills.</p>
                    </div>
                    <div class="d-flex justify-content-between align-items-center">
                        <span class="price">Rs.1999</span>
                        <a href="courseDetails.jsp?courseId=9" class="btn btn-outline-primary btn-sm">View Details</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card course-card">
                <img src="images/Python.jpg" class="card-img-top course-img" alt="Python">
                <div class="card-body">
                    <div>
                        <h5 class="card-title">Python for Everyone</h5>
                        <p class="text-muted small mb-1">By Kushagra Bhatia</p>
                        <div class="rating mb-2">
                            <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
                            <span class="text-dark">(4.9)</span>
                        </div>
                        <p class="card-text small">Learn the world's most versatile language for Data Science and AI. Automate complex tasks and build smart applications with clean, readable code.</p>
                    </div>
                    <div class="d-flex justify-content-between align-items-center">
                        <span class="price">Rs.2999</span>
                        <a href="courseDetails.jsp?courseId=3" class="btn btn-outline-primary btn-sm">View Details</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card course-card">
                <img src="images/webd.jpg" class="card-img-top course-img" alt="Web Dev">
                <div class="card-body">
                    <div>
                        <h5 class="card-title">Web Development</h5>
                        <p class="text-muted small mb-1">By Angela Yu</p>
                        <div class="rating mb-2">
                            <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
                            <span class="text-dark">(4.9)</span>
                        </div>
                        <p class="card-text small">Go from zero to building responsive, professional websites. Master HTML, CSS, and JavaScript to create stunning user experiences across all devices.</p>
                    </div>
                    <div class="d-flex justify-content-between align-items-center">
                        <span class="price">Rs.3499</span>
                        <a href="courseDetails.jsp?courseId=4" class="btn btn-outline-primary btn-sm">View Details</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card course-card">
                <img src="images/cc.jpg" class="card-img-top course-img" alt="Cloud">
                <div class="card-body">
                    <div>
                        <h5 class="card-title">Cloud Computing (AWS)</h5>
                        <p class="text-muted small mb-1">By Stephane Maarek</p>
                        <div class="rating mb-2">
                            <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star-half-alt"></i>
                            <span class="text-dark">(4.8)</span>
                        </div>
                        <p class="card-text small">Scale your applications globally using Amazon Web Services. Learn cloud architecture, deployment strategies, and how to manage virtual infrastructure.</p>
                    </div>
                    <div class="d-flex justify-content-between align-items-center">
                        <span class="price">Rs.4599</span>
                        <a href="courseDetails.jsp?courseId=5" class="btn btn-outline-primary btn-sm">View Details</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card course-card">
                <img src="images/mernstack.jpg" class="card-img-top course-img" alt="MERN">
                <div class="card-body">
                    <div>
                        <h5 class="card-title">MERN Stack Mastery</h5>
                        <p class="text-muted small mb-1">By Hitesh Choudhary</p>
                        <div class="rating mb-2">
                            <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
                            <span class="text-dark">(5.0)</span>
                        </div>
                        <p class="card-text small">Become a full-stack developer using MongoDB, Express, React, and Node.js. Build and deploy fast, data-driven web applications using a single language: JavaScript.</p>
                    </div>
                    <div class="d-flex justify-content-between align-items-center">
                        <span class="price">Rs.3999</span>
                        <a href="courseDetails.jsp?courseId=6" class="btn btn-outline-primary btn-sm">View Details</a>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<footer class="bg-dark text-white text-center py-4">
    <p>&copy; 2026 Skilled Bazaar. All rights reserved.</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>