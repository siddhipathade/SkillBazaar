<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register | SkillBazaar</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            /* Smooth deep blue to purple gradient to match professional tech sites */
            background: linear-gradient(135deg, #EFE6FF 0%, #CDC1FF 50%, #FFFFFF 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .register-container {
            background: rgba(255, 255, 255, 0.95);
            padding: 2.5rem;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 400px;
        }

        .register-container h2 {
            color: #4b3074;
            font-weight: 700;
            text-align: center;
            margin-bottom: 1.5rem;
        }

        .form-label {
            font-weight: 600;
            color: #555;
            font-size: 0.9rem;
        }

        .form-control, .form-select {
            border-radius: 8px;
            padding: 0.6rem 1rem;
        }

        .btn-primary {
            background-color: #764ba2;
            border: none;
            padding: 0.75rem;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #5a3782;
            transform: translateY(-1px);
        }

        .login-link {
            color: #764ba2;
            text-decoration: none;
            font-weight: 600;
        }

        .login-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="register-container">
    <h2>SkillBazaar</h2>
    <p class="text-center text-muted mb-4">Create your account to get started</p>
    
    <form action="RegisterServlet" method="post">
        <div class="mb-3">
            <label class="form-label">Full Name</label>
            <input type="text" class="form-control" name="name" placeholder="Enter your name" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Email Address</label>
            <input type="email" class="form-control" name="email" placeholder="email@example.com" required>
        </div>
        
        <div class="mb-3">
            <label class="form-label">Password</label>
            <input type="password" class="form-control" name="password" placeholder="Min. 6 characters" required>
        </div>

        <div class="mb-4">
            <label class="form-label">I am a...</label>
            <select class="form-select" name="role">
                <option value="STUDENT">Student</option>
                <option value="INSTRUCTOR">Instructor</option>
            </select>
        </div>
        
        <div class="d-grid">
            <button type="submit" class="btn btn-primary">Register</button>
        </div>
    </form>

    <div class="mt-4 text-center">
        <p class="mb-0 text-muted">Already registered? <a href="login.jsp" class="login-link">Login</a></p>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>