<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SkillBazaar - Unlock Your Potential</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { background-color: #f8f9fa; }
        
        /* --- SkillBazaar Brand: Blue to White Hover --- */
        .navbar-brand { 
            font-weight: bold !important; 
            color: #0d6efd !important; /* Start as Blue */
            transition: color 0.3s ease; /* Smooth transition for color only */
            text-decoration: none;
        }

        .navbar-brand:hover {
            color: #ffffff !important; /* Change to White on hover */
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
                <li class="nav-item"><a class="nav-link disabled" href="#">Admin</a></li>
                <li class="nav-item"><a class="nav-link disabled" href="#">Instructor</a></li>
                <li class="nav-item"><a class="nav-link disabled" href="#">Student</a></li>
            </ul>
            <form action="login.jsp">
                <button class="btn btn-outline-success" type="submit">Login/Register</button>
            </form>
        </div>
    </div>
</nav>