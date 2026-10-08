<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
/* Security check */
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
if (session.getAttribute("userId") == null ||
    !"instructor".equalsIgnoreCase(session.getAttribute("role").toString())) {
    response.sendRedirect("../login.jsp");
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Instructor - Add Course</title>
<style>
body, html {
    height: 100%;
    margin: 0;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}
body {
    background: linear-gradient(135deg, #EFE6FF 0%, #CDC1FF 50%, #FFFFFF 100%);
    display: flex;
    justify-content: center;
    align-items: center;
}
.form-container {
    background-color: #ffffff;
    padding: 40px;
    border-radius: 12px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
    width: 100%;
    max-width: 420px;
}
h3 {
    text-align: center;
    color: #333;
    margin-bottom: 25px;
}
input, textarea {
    width: 100%;
    padding: 12px;
    margin-bottom: 18px;
    border: 1px solid #ddd;
    border-radius: 6px;
    font-size: 15px;
    box-sizing: border-box; /* Fixes padding overflow */
}
input:focus, textarea:focus {
    border-color: #764ba2;
    outline: none;
}
textarea {
    height: 100px;
    resize: none;
}
/* Base style for both buttons */
.btn-submit, .btn-cancel {
    width: 100%;
    padding: 12px;
    border: none;
    border-radius: 6px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    display: block;
    text-align: center;
    text-decoration: none;
    box-sizing: border-box;
    transition: background 0.3s ease;
}

.btn-submit {
    background-color: #764ba2;
    color: white;
    margin-bottom: 12px;
}
.btn-submit:hover {
    background-color: #5e3a85;
}

.btn-cancel {
    background-color: #e0e0e0;
    color: #333;
}
.btn-cancel:hover {
    background-color: #d0d0d0;
}

small {
    color: #666;
    display: block;
    margin-top: -12px;
    margin-bottom: 15px;
}
</style>
</head>
<body>
<div class="form-container">
    <h3>Add New Course</h3>
    <form action="../InstructorAddCourseServlet" method="post">
        <input name="title" placeholder="Course Title" required>
        <textarea name="description" placeholder="Course Description" required></textarea>
        <input name="category" placeholder="Category (Java, Web, AI etc)" required>
        <input name="price" type="number" placeholder="Price (₹)" required>
        
        <input name="preview_video" 
               placeholder="YouTube Embed Link (Preview Video)" required>
        
        <button type="submit" class="btn-submit">Submit for Approval</button>
        
        <a href="dashboard.jsp" class="btn-cancel">Cancel</a>
        
    </form>
</div>
</body>
</html>