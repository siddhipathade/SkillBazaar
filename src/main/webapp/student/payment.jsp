<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.skillbazaar.dao.DBConnection" %>
<%
    if (session.getAttribute("user") == null || 
        !"student".equalsIgnoreCase(session.getAttribute("role").toString())) {
        response.sendRedirect("../login.jsp");
        return;
    }
    int courseId = Integer.parseInt(request.getParameter("courseId"));
    Connection con = DBConnection.getConnection();
    PreparedStatement ps = con.prepareStatement("SELECT title, price FROM courses WHERE course_id=?");
    ps.setInt(1, courseId);
    ResultSet rs = ps.executeQuery();
    rs.next();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Secure Checkout | SkillBazaar</title>
    <style>
        /* Modern styling with the requested gradient */
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
            background: linear-gradient(135deg, #EFE6FF 0%, #CDC1FF 50%, #FFFFFF 100%);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #fff;
        }

        .payment-card {
            background: rgba(255, 255, 255, 0.95);
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 400px;
            text-align: center;
            color: #333;
        }

        .course-details {
            margin-bottom: 25px;
            border-bottom: 1px solid #eee;
            padding-bottom: 20px;
        }

        .course-title {
            font-size: 1.2rem;
            font-weight: 600;
            color: #764ba2;
            margin: 5px 0;
        }

        .course-price {
            font-size: 1.5rem;
            font-weight: 700;
            color: #2d3436;
        }

        h3 {
            font-weight: 500;
            margin-bottom: 15px;
            color: #555;
        }

        .qr-container img {
            border: 2px solid #667eea;
            padding: 10px;
            border-radius: 12px;
            background: white;
            transition: transform 0.3s ease;
        }

        .qr-container img:hover {
            transform: scale(1.03);
        }

        .input-field {
            width: 100%;
            padding: 12px 15px;
            margin: 20px 0;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 16px;
            box-sizing: border-box;
            transition: border-color 0.3s;
            text-align: center;
        }

        .input-field:focus {
            border-color: #667eea;
            outline: none;
        }

        .pay-btn {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            box-shadow: 0 4px 15px rgba(118, 75, 162, 0.3);
            transition: all 0.3s ease;
        }

        .pay-btn:hover {
            opacity: 0.9;
            transform: translateY(-1px);
            box-shadow: 0 6px 20px rgba(118, 75, 162, 0.4);
        }

        .security-note {
            font-size: 12px;
            color: #999;
            margin-top: 15px;
        }
    </style>
</head>
<body>

<div class="payment-card">
    <div class="course-details">
        <h2 style="margin-top:0; color:#333;">Confirm Payment</h2>
        <div class="course-title"><%=rs.getString("title")%></div>
        <div class="course-price">₹<%=rs.getDouble("price")%></div>
    </div>

    <h3>Scan to Pay via UPI</h3>
    <div class="qr-container">
        <img src="http://localhost:8080/SkillBazaar/images/Scanner.jpeg" width="200" alt="Payment QR Code">
    </div>

    <form action="<%=request.getContextPath()%>/PaymentServlet" method="post">
        <input type="hidden" name="courseId" value="<%=courseId%>">
        <input type="hidden" name="amount" value="<%=rs.getDouble("price")%>">
        
        <input type="text" name="txnRef" class="input-field" placeholder="Enter Transaction ID" required>
        
        <button type="submit" class="pay-btn">Complete Payment</button>
    </form>
    
    <div class="security-note">
        🔒 Secured and Encrypted Transaction
    </div>
</div>

</body>
</html>