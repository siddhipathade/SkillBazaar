<%@ page import="java.sql.*" %>
<%@ page import="com.skillbazaar.dao.DBConnection" %>

<h3>All Courses</h3>

<table border="1">
<tr>
    <th>ID</th>
    <th>Title</th>
    <th>Price</th>
    <th>Category</th>
    <th>Action</th>
</tr>

<%
Connection con = DBConnection.getConnection();
Statement st = con.createStatement();
ResultSet rs = st.executeQuery("SELECT * FROM courses");

while(rs.next()){
%>
<tr>
    <td><%= rs.getInt("course_id") %></td>
    <td><%= rs.getString("title") %></td>
    <td><%= rs.getDouble("price") %></td>
    <td><%= rs.getString("category") %></td>
    <td>
        <a href="../DeleteCourseServlet?id=<%= rs.getInt("course_id") %>">Delete</a>
    </td>
</tr>
<% } %>

</table>