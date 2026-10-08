<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About SkillBazaar - Our Impact</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { background-color: #ffffff; font-family: 'Segoe UI', sans-serif; }
        
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
        
        /* Big Welcome Image Section with Blue to Purple Gradient */
        .welcome-hero {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%), 
                        url('https://images.unsplash.com/photo-1517245386807-bb43f82c33c4?auto=format&fit=crop&w=1920&q=80');
            background-blend-mode: overlay;
            background-size: cover;
            background-position: center;
            height: 60vh;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            text-align: center;
        }

        .welcome-hero h1 { font-size: 4.5rem; font-weight: 800; text-shadow: 2px 2px 20px rgba(0,0,0,0.5); }

        /* Stats Section */
        .stat-card {
            border: none;
            border-radius: 15px;
            background: #f8f9fa;
            transition: 0.3s;
            padding: 30px;
        }
        .stat-card:hover { transform: translateY(-5px); background: #fff; box-shadow: 0 10px 30px rgba(0,0,0,0.1); }
        .stat-icon { font-size: 3rem; margin-bottom: 15px; background: linear-gradient(45deg, #0d6efd, #6610f2); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
        .stat-number { font-size: 2.5rem; font-weight: 800; color: #333; }
        
        /* Course Breakdown Section */
        .category-badge {
            padding: 10px 20px;
            border-radius: 50px;
            background: #e9ecef;
            color: #764ba2;
            font-weight: 600;
            display: inline-block;
            margin: 5px;
        }

        .section-padding { padding: 80px 0; }
        /* Custom Explore Button Color */
.btn-explore {
            background-color: #764ba2;
            color: #ffffff; 
            border: none;
            padding: 0.75rem;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-explore:hover {
            background-color: #5a3782;
            color: #ffffff; 
            transform: translateY(-1px);
        }
        
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="#">SKILLBAZAAR</a>
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


<header class="welcome-hero">
    <div class="container">
        <h1>Empowering 5000+ Learners</h1>
        <p class="lead">At SkillBazaar, we bridge the gap between education and industry requirements.</p>
    </div>
</header>

<section class="container section-padding text-center">
    <h2 class="mb-5 fw-bold">Our Global Impact</h2>
    <div class="row g-4">
        <div class="col-md-3">
            <div class="stat-card">
                <i class="fas fa-users stat-icon"></i>
                <div class="stat-number">5K+</div>
                <p class="text-muted">Active Students</p>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stat-card">
                <i class="fas fa-laptop-code stat-icon"></i>
                <div class="stat-number">12+</div>
                <p class="text-muted">Tech Courses</p>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stat-card">
                <i class="fas fa-star stat-icon"></i>
                <div class="stat-number">4.8/5</div>
                <p class="text-muted">Average Rating</p>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stat-card">
                <i class="fas fa-globe stat-icon"></i>
                <div class="stat-number">3+</div>
                <p class="text-muted">Countries Reached</p>
            </div>
        </div>
    </div>
</section>

<section class="bg-light section-padding">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-6">
                <h2 class="fw-bold mb-4">What We Provide</h2>
                <p class="text-muted mb-4">SkillBazaar specializes in high-end technical training. We don't just provide videos; we provide career paths. Our curriculum is designed by industry experts from top tech giants.</p>
                <div class="mb-4">
                    <span class="category-badge">Web Development</span>
                    <span class="category-badge">Data Science</span>
                    <span class="category-badge">Cloud Computing</span>
                    <span class="category-badge">Cyber Security</span>
                    <span class="category-badge">Mobile App Dev</span>
                    <span class="category-badge">AI & Machine Learning</span>
                </div>
                <a href="index.jsp" class="btn btn-explore btn-lg px-5 shadow">Explore All Courses</a>
            </div>
            <div class="col-md-6">
                <img src="https://images.unsplash.com/photo-1522202176988-66273c2fd55f?auto=format&fit=crop&w=800&q=80" class="img-fluid rounded-4 shadow" alt="Team Learning">
            </div>
        </div>
    </div>
</section>

<footer class="bg-dark text-white text-center py-4">
    <p>&copy; 2026 SkillBazaar Overview. All rights reserved.</p>
</footer>

</body>
</html>