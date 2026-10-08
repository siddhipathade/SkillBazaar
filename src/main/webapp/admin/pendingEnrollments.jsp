<%@ page import="java.sql.*" %>
<%@ page import="com.skillbazaar.dao.DBConnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%
    /* Cache control */
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

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
    <title>Pending Enrollments | SkillBazaar Admin</title>
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
        /* Glass Card Design from Pending Courses */
        .glass-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
        }
        .page-title-heading {
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
        /* Buttons adjusted to Purple Theme */
        .btn-purple-approve {
            background: #6a11cb;
            color: white !important;
            font-weight: 600;
            border-radius: 6px;
            padding: 8px 18px;
            transition: 0.3s;
            text-decoration: none;
            display: inline-block;
            border: none;
        }
        .btn-purple-approve:hover {
            background: #6a11cb;
            transform: scale(1.05);
        }
        .rejection-input {
            border-radius: 6px 0 0 6px !important;
            border: 1px solid #dee2e6;
        }
        .btn-danger-reject {
            border-radius: 0 6px 6px 0 !important;
            font-weight: 600;
        }
        .price-text {
            font-weight: bold;
            color: #27ae60;
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
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
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
            
            <h2 class="page-title-heading mb-4">📋 Pending Enrollment Approvals</h2>
            
            <div class="table-responsive">
                <table class="table align-middle">
                    <thead>
                        <tr>
                            <th class="ps-4">Student Name</th>
                            <th>Course Enrolled</th>
                            <th>Amount Paid</th>
                            <th class="text-center">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        Connection con = null;
                        try {
                            con = DBConnection.getConnection();
                            PreparedStatement ps = con.prepareStatement(
                                "SELECT e.enrollment_id, u.name AS student, c.title AS course, p.amount " +
                                "FROM enrollments e " +
                                "JOIN users u ON e.student_id = u.user_id " +
                                "JOIN courses c ON e.course_id = c.course_id " +
                                "JOIN payments p ON p.course_id = e.course_id AND p.student_id = e.student_id " +
                                "WHERE e.approval_status = 'PENDING'"
                            );
                            ResultSet rs = ps.executeQuery();
                            boolean hasData = false;
                            while(rs.next()) {
                                hasData = true;
                        %>
                        <tr>
                            <td class="ps-4">
                                <i class="fa fa-user-circle me-2 text-muted"></i>
                                <strong><%=rs.getString("student")%></strong>
                            </td>
                            <td><span class="badge bg-light text-dark border"><%=rs.getString("course")%></span></td>
                            <td class="price-text">₹ <%= String.format("%.2f", rs.getDouble("amount")) %></td>
                            <td>
                                <div class="d-flex align-items-center justify-content-center gap-3">
                                    <a href="../ApproveEnrollmentServlet?id=<%=rs.getInt("enrollment_id")%>"
                                       class="btn-purple-approve shadow-sm">
                                       <i class="fas fa-check-circle me-1"></i> Approve
                                    </a>
                                    
                                    <form action="<%=request.getContextPath()%>/RejectEnrollmentServlet" method="post" class="m-0">
                                        <input type="hidden" name="enrollmentId" value="<%= rs.getInt("enrollment_id") %>">
                                        <div class="input-group">
                                            <input type="text" name="rejectionReason" class="form-control form-control-sm rejection-input" placeholder="Reason..." required>
                                            <button type="submit" class="btn btn-danger btn-sm btn-danger-reject">Reject</button>
                                        </div>
                                    </form>
                                </div>
                            </td>
                        </tr>
                        <% 
                            }
                            if (!hasData) {
                        %>
                        <tr>
                            <td colspan="4" class="text-center py-5">
                                <p class="text-muted mb-0">No pending enrollments found.</p>
                            </td>
                        </tr>
                        <%
                            }
                        } catch(Exception e) {
                            out.println("<tr><td colspan='4'>Error: " + e.getMessage() + "</td></tr>");
                        } finally {
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