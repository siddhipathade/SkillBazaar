<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.skillbazaar.dao.DBConnection" %>
<%
    /* Security */
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    
    if (session.getAttribute("userId") == null ||
        !"instructor".equalsIgnoreCase(session.getAttribute("role").toString())) {
        response.sendRedirect("../login.jsp");
        return;
    }
    
    /* Get courseId safely */
    String courseIdStr = request.getParameter("courseId");
    if (courseIdStr == null) {
        response.sendRedirect("myCourses.jsp");
        return;
    }
    int courseId = Integer.parseInt(courseIdStr);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Course Videos | SkillBazaar</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    
    <style>
        /* Exact Background Match from Student Page */
        body {
            background: linear-gradient(135deg, #EFE6FF 0%, #CDC1FF 50%, #FFFFFF 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
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
            border: none;
            margin-bottom: 30px;
        }
        .course-title-heading {
            color: #2d3436;
            font-weight: 700;
            margin-bottom: 25px;
            font-size: 2rem;
        }
        .section-subtitle {
            font-weight: 700;
            color: #333;
            margin-bottom: 20px;
            border-bottom: 2px solid #eee;
            padding-bottom: 10px;
            display: flex;
            align-items: center;
        }
        .section-subtitle i {
            margin-right: 10px;
            color: #833ab4;
        }
        .form-control {
            border-radius: 8px;
            padding: 10px 15px;
            border: 1px solid #dee2e6;
        }
        /* Buttons */
        .btn-action {
            background: #833ab4; 
            border: none;
            color: white !important;
            font-weight: 600;
            padding: 12px 40px;
            border-radius: 8px;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }
        .btn-action:hover {
            background: #6a2f91;
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .table {
            background: white;
            border-radius: 12px;
            overflow: hidden;
        }
        .badge-preview {
            background: #e3f2fd;
            color: #0d6efd;
            border: 1px solid #0d6efd;
            font-weight: 600;
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

<div class="container main-container">
    <div class="row justify-content-center">
        <div class="col-lg-11 glass-card">
            
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="course-title-heading mb-0">📹 Manage Course Content</h2>
            </div>

            <div class="mb-5">
                <h5 class="section-subtitle"><i class="fa fa-plus-circle"></i>Add New Lesson</h5>
                <form action="../AddCourseVideoServlet" method="post">
                    <input type="hidden" name="courseId" value="<%=courseId%>">
                    <div class="row g-3">
                        <div class="col-md-7">
                            <label class="form-label fw-bold">Video Title</label>
                            <input type="text" name="title" class="form-control" placeholder="e.g. Introduction to Variables" required>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label fw-bold">YouTube URL</label>
                            <input type="text" name="videoUrl" class="form-control" placeholder="Embed link..." required>
                        </div>
                        <div class="col-md-2">
                            <label class="form-label fw-bold">Sort Order</label>
                            <input type="number" name="videoOrder" class="form-control" placeholder="1" required>
                        </div>
                    </div>
                    
                    <div class="mt-3 mb-4">
                        <div class="form-check form-switch">
                            <input class="form-check-input" type="checkbox" name="isPreview" value="1" id="previewSwitch">
                            <label class="form-check-label" for="previewSwitch">Make this a Free Preview Video</label>
                        </div>
                    </div>

                    <div class="text-center mt-4">
                        <button class="btn-action shadow-sm">
                            <i class="fa fa-cloud-upload-alt me-2"></i>Upload Lesson
                        </button>
                    </div>
                </form>
            </div>

            <div class="mb-4">
                <h5 class="section-subtitle"><i class="fa fa-list-ul"></i>Lesson Curriculum</h5>
                <div class="table-responsive">
                    <table class="table align-middle">
                        <thead class="table-light">
                            <tr>
                                <th class="text-center" style="width: 80px;">Order</th>
                                <th class="ps-3">Lesson Title</th>
                                <th class="text-center">Status</th>
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
                            ps = con.prepareStatement("SELECT * FROM course_videos WHERE course_id=? ORDER BY video_order");
                            ps.setInt(1, courseId);
                            rs = ps.executeQuery();
                            boolean hasVideos = false;
                            while (rs.next()) {
                                hasVideos = true;
                        %>
                            <tr>
                                <td class="text-center fw-bold text-muted"><%=rs.getInt("video_order")%></td>
                                <td class="fw-semibold ps-3"><%=rs.getString("title")%></td>
                                <td class="text-center">
                                    <% if (rs.getBoolean("is_preview")) { %>
                                        <span class="badge badge-preview px-3 py-2 rounded-pill">Preview</span>
                                    <% } else { %>
                                        <span class="badge bg-light text-muted border px-3 py-2 rounded-pill">Locked</span>
                                    <% } %>
                                </td>
                                <td class="text-center">
                                    <a href="../DeleteCourseVideoServlet?videoId=<%=rs.getInt("video_id")%>&courseId=<%=courseId%>"
                                       class="btn btn-outline-danger btn-sm px-3"
                                       onclick="return confirm('Delete this video lesson?')">
                                       <i class="fa fa-trash-alt me-1"></i> Delete
                                    </a>
                                </td>
                            </tr>
                        <%
                            }
                            if (!hasVideos) {
                        %>
                            <tr><td colspan="4" class="text-center py-5 text-muted">No videos uploaded yet.</td></tr>
                        <%
                            }
                        } catch(Exception e) {
                            out.println("<tr><td colspan='4'>Error: " + e.getMessage() + "</td></tr>");
                        } finally {
                            if(rs != null) rs.close();
                            if(ps != null) ps.close();
                            if(con != null) con.close();
                        }
                        %>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="mt-5 text-center">
                <hr class="mb-4">
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