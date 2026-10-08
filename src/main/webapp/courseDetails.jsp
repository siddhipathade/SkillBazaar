<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.skillbazaar.dao.DBConnection"%>
<%
/* Data Fetching Logic */
String courseIdStr = request.getParameter("courseId");
if (courseIdStr == null) { out.println("<h2>Invalid course request</h2>"); return; }
int courseId = Integer.parseInt(courseIdStr);

Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

boolean isEnrolled = false;
boolean isApproved = false;

try {
    con = DBConnection.getConnection();
    ps = con.prepareStatement("SELECT * FROM courses WHERE course_id=? AND status='APPROVED'");
    ps.setInt(1, courseId);
    rs = ps.executeQuery();
    
    if (!rs.next()) { 
        out.println("<h2>Course not found</h2>"); 
        return; 
    }
    
    // Check session explicitly
    Object userObj = session.getAttribute("userId");
    if (userObj != null) {
        int studentId = (int) userObj;
        PreparedStatement eps = con.prepareStatement("SELECT approval_status FROM enrollments WHERE student_id=? AND course_id=?");
        eps.setInt(1, studentId);
        eps.setInt(2, courseId);
        ResultSet ers = eps.executeQuery();
        if (ers.next()) {
            isEnrolled = true;
            if ("APPROVED".equalsIgnoreCase(ers.getString("approval_status"))) {
                isApproved = true;
            }
        }
        ers.close(); eps.close();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title><%= rs.getString("title") %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #EFE6FF 0%, #CDC1FF 50%, #FFFFFF 100%);
            min-height: 100vh;
            padding-bottom: 50px;
        }
        .course-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.2);
            overflow: hidden;
            margin-top: 50px;
        }
        .video-wrapper { background: #000; }
        .content-section { padding: 40px; }
        
        /* THE PURPLE BUTTON */
        .btn-purple-login {
            background-color: #833ab4 !important;
            color: white !important;
            border: none !important;
            padding: 15px 30px !important;
            border-radius: 10px !important;
            font-weight: 700 !important;
            font-size: 1.1rem !important;
            text-decoration: none !important;
            display: block !important;
            width: 100% !important;
            text-align: center !important;
            transition: all 0.3s ease;
        }
        .btn-purple-login:hover {
            background-color: #6a2f91 !important;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(131, 58, 180, 0.4) !important;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-10 course-card">
            
            <div class="video-wrapper">
                <iframe id="videoPlayer" width="100%" height="450"
                    src="<%= rs.getString("preview_video") %>"
                    frameborder="0" allowfullscreen>
                </iframe>
            </div>

            <div class="content-section">
                <div class="mb-5">
                    <h1 class="fw-bold"><%= rs.getString("title") %></h1>
                    <span class="badge bg-light text-primary border border-primary mb-3"><%= rs.getString("category") %></span>
                    <p class="text-muted" style="font-size: 1.1rem;"><%= rs.getString("description") %></p>
                    <h2 class="text-success fw-bold">₹ <%= rs.getDouble("price") %></h2>
                </div>

                <hr class="my-5">

                <h4 class="mb-4">Course Curriculum</h4>
                <div class="table-responsive mb-5">
                    <table class="table align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>#</th>
                                <th>Lesson Title</th>
                                <th>Status</th>
                                <th class="text-end">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                        <%
                            PreparedStatement vps = con.prepareStatement("SELECT * FROM course_videos WHERE course_id=? ORDER BY video_order");
                            vps.setInt(1, courseId);
                            ResultSet vrs = vps.executeQuery();
                            while (vrs.next()) {
                                boolean preview = vrs.getBoolean("is_preview");
                                boolean canWatch = preview || (isEnrolled && isApproved);
                        %>
                            <tr>
                                <td><%= vrs.getInt("video_order") %></td>
                                <td><strong><%= vrs.getString("title") %></strong></td>
                                <td><%= canWatch ? "🔓 Available" : "🔒 Locked" %></td>
                                <td class="text-end">
                                    <% if (canWatch) { %>
                                        <button class="btn btn-sm btn-primary" onclick="playVideo('<%=vrs.getString("video_url")%>',<%=vrs.getInt("video_id")%>)">▶Watch</button>
                                    <% } else { %>
                                        <button class="btn btn-sm btn-secondary disabled" disabled>Locked</button>
                                    <% } %>
                                </td>
                            </tr>
                        <% } vrs.close(); vps.close(); %>
                        </tbody>
                    </table>
                </div>

                <div class="d-flex flex-column align-items-center mt-5">
                    <div class="mb-4 w-50">
                        <% if (session.getAttribute("userId") == null) { %>
                            <a href="login.jsp?redirect=payment&courseId=<%=courseId%>" class="btn-purple-login shadow">
                                Login to Enroll
                            </a>
                        <% } else if (!isEnrolled) { %>
                            <a href="student/payment.jsp?courseId=<%=courseId%>" class="btn-purple-login shadow">
                                Enroll Now
                            </a>
                        <% } else if (isApproved) { %>
                            <div class="alert alert-success w-100 text-center">✔ You are currently enrolled</div>
                        <% } else { %>
                             <div href="payment.jsp" class="alert alert-warning w-100 text-center">Enrollment Pending Approval</div>
                        <% } %>
                    </div>

                    <div>
                        <a href="index.jsp" class="btn btn-link text-decoration-none text-muted">
                            ← Cancel 
                        </a>
                    </div>
                </div>

            </div> </div> </div>
</div>

<script>
function playVideo(videoUrl, videoId) {
    document.getElementById("videoPlayer").src = videoUrl;

    fetch("<%=request.getContextPath()%>/MarkVideoWatchedServlet", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: "videoId=" + videoId + "&courseId=<%=courseId%>"
    })
    .then(res => res.text())
    .then(data => console.log(data))
    .catch(err => console.error(err));
}
</script>
</body>
</html>
<%
} catch (Exception e) { 
    out.println("System Error: " + e.getMessage()); 
} finally {
    if (rs != null) rs.close();
    if (ps != null) ps.close();
    if (con != null) con.close();
}
%>