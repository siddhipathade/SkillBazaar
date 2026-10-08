<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String courseIdStr = request.getParameter("courseId");

if (courseIdStr == null) {
    out.println("<h3>Course ID missing</h3>");
    return;
}

int courseId = Integer.parseInt(courseIdStr);
%>

<form action="../AddCourseVideoServlet" method="post">

    <input type="hidden" name="courseId" value="<%= courseId %>">

    <div class="mb-3">
        <label>Video Title</label>
        <input type="text" name="title" class="form-control" required>
    </div>

    <div class="mb-3">
        <label>YouTube Embed Link</label>
        <input type="text" name="videoUrl" class="form-control" required>
        <small>Example: https://www.youtube.com/embed/VIDEO_ID</small>
    </div>

    <div class="mb-3">
        <label>Video Order</label>
        <input type="number" name="videoOrder" class="form-control" required>
    </div>

    <div class="form-check mb-3">
        <input class="form-check-input" type="checkbox" name="isPreview" value="1">
        <label class="form-check-label">Preview Video</label>
    </div>

    <button class="btn btn-primary">Add Video</button>

</form>