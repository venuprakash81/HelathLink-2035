<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Services - HealthLink 2035</title>

<style>

/* ===== GLOBAL ===== */

*{
margin:0;
padding:0;
box-sizing:border-box;
}

body{
font-family:'Segoe UI',sans-serif;
background:linear-gradient(135deg,#eef5ff,#ffffff);
color:#333;
}

/* ===== TOP BAR ===== */

.topbar{
background:linear-gradient(90deg,#003973,#005fa3);
color:white;
padding:12px 50px;
display:flex;
justify-content:space-between;
font-size:14px;
letter-spacing:1px;
}

/* ===== NAVBAR ===== */

.navbar{
background:white;
padding:18px 50px;
display:flex;
justify-content:space-between;
align-items:center;
box-shadow:0 4px 15px rgba(0,0,0,0.08);
position:sticky;
top:0;
z-index:1000;
}

.navbar h2{
color:#003973;
font-weight:700;
}

.navbar ul{
list-style:none;
display:flex;
gap:30px;
}

.navbar ul li a{
text-decoration:none;
font-weight:600;
color:#003973;
transition:0.3s;
}

.navbar ul li a:hover{
color:#e63946;
}

/* ===== HERO ===== */

.hero{
padding:90px 50px;
text-align:center;
background:linear-gradient(120deg,#dbefff,#ffffff);
}

.hero h1{
font-size:42px;
color:#003973;
margin-bottom:15px;
}

.hero p{
max-width:700px;
margin:auto;
font-size:18px;
line-height:1.6;
}

/* ===== SERVICES SECTION ===== */

.section{
padding:70px 50px;
}

.section h2{
text-align:center;
font-size:34px;
color:#003973;
margin-bottom:50px;
}

/* ===== SERVICE GRID ===== */

.cards{
display:grid;
grid-template-columns:repeat(auto-fit,minmax(250px,1fr));
gap:30px;
}

/* ===== SERVICE CARD ===== */

.card{
background:white;
border-radius:18px;
padding:30px;
text-align:center;
box-shadow:0 8px 25px rgba(0,0,0,0.08);
transition:0.4s;
}

.card:hover{
transform:translateY(-12px);
box-shadow:0 15px 35px rgba(0,0,0,0.15);
}

.card img{
width:70px;
margin-bottom:15px;
}

.card h3{
color:#005fa3;
margin-bottom:10px;
font-size:20px;
}

.card p{
font-size:15px;
color:#444;
line-height:1.5;
}

/* ===== DESCRIPTION ===== */

.bottom-description{
background:linear-gradient(120deg,#ffffff,#dbefff);
padding:70px 50px;
text-align:center;
}

.bottom-description h2{
color:#003973;
margin-bottom:20px;
font-size:32px;
}

.bottom-description p{
max-width:900px;
margin:auto;
font-size:18px;
line-height:1.8;
}

/* ===== FOOTER ===== */

.footer{
background:linear-gradient(90deg,#003973,#005fa3);
color:white;
padding:50px;
text-align:center;
margin-top:40px;
}

</style>
</head>

<body>

<div class="topbar">
<div>HEALTHLINK 2035</div>
<div>Dial: 767-0924-977</div>
</div>

<div class="navbar">
<h2>Our Services</h2>
<ul>
<li><a href="index.jsp">Dashboard</a></li>
<li><a href="dashboard1.jsp">Patient Registration</a></li>
<li><a href="doctor.jsp">Doctors</a></li>
<li><a href="service.jsp">Services</a></li>
</ul>
</div>

<div class="hero">
<h1>Advanced Healthcare Services</h1>
<p>Health Link 2035 delivers innovative healthcare solutions combining technology and expert medical care.</p>
</div>

<div class="section">
<h2>Our Medical Services</h2>

<div class="cards">

<div class="card">
<img src="https://cdn-icons-png.flaticon.com/512/2966/2966486.png">
<h3>Emergency Care</h3>
<p>24/7 emergency response with advanced trauma support.</p>
</div>

<div class="card">
<img src="https://cdn-icons-png.flaticon.com/512/3774/3774299.png">
<h3>Cardiology</h3>
<p>Heart diagnostics, ECG monitoring, and cardiac surgery.</p>
</div>

<div class="card">
<img src="https://cdn-icons-png.flaticon.com/512/4320/4320337.png">
<h3>Neurology</h3>
<p>Brain and nervous system treatments using modern technology.</p>
</div>

<div class="card">
<img src="https://cdn-icons-png.flaticon.com/512/2785/2785544.png">
<h3>Pediatrics</h3>
<p>Specialized care for infants, children, and adolescents.</p>
</div>

<div class="card">
<img src="https://cdn-icons-png.flaticon.com/512/3050/3050525.png">
<h3>Orthopedics</h3>
<p>Bone, joint, and muscle treatments with surgical expertise.</p>
</div>

<div class="card">
<img src="https://cdn-icons-png.flaticon.com/512/4333/4333609.png">
<h3>Radiology</h3>
<p>X-ray, MRI, CT scan, and diagnostic imaging services.</p>
</div>

<div class="card">
<img src="https://cdn-icons-png.flaticon.com/512/4320/4320371.png">
<h3>Telemedicine</h3>
<p>Online doctor consultations and remote patient monitoring.</p>
</div>

<div class="card">
<img src="https://cdn-icons-png.flaticon.com/512/3774/3774260.png">
<h3>Laboratory</h3>
<p>Advanced pathology testing and diagnostic lab services.</p>
</div>

<div class="card">
<img src="https://cdn-icons-png.flaticon.com/512/3774/3774255.png">
<h3>Pharmacy</h3>
<p>24-hour pharmacy providing essential medications.</p>
</div>

<div class="card">
<img src="https://cdn-icons-png.flaticon.com/512/4320/4320341.png">
<h3>Dermatology</h3>
<p>Skin care treatments and cosmetic dermatology services.</p>
</div>

<div class="card">
<img src="https://cdn-icons-png.flaticon.com/512/4320/4320328.png">
<h3>Dental Care</h3>
<p>Comprehensive dental checkups and treatments.</p>
</div>

<div class="card">
<img src="https://cdn-icons-png.flaticon.com/512/3774/3774248.png">
<h3>Oncology</h3>
<p>Cancer diagnosis, chemotherapy, and oncology support.</p>
</div>

<div class="card">
<img src="https://cdn-icons-png.flaticon.com/512/3774/3774269.png">
<h3>Physiotherapy</h3>
<p>Rehabilitation and recovery programs for patients.</p>
</div>

<div class="card">
<img src="https://cdn-icons-png.flaticon.com/512/2966/2966448.png">
<h3>Maternity Care</h3>
<p>Pregnancy care, delivery services, and neonatal support.</p>
</div>

<div class="card">
<img src="https://cdn-icons-png.flaticon.com/512/2966/2966506.png">
<h3>ICU Services</h3>
<p>Advanced intensive care with critical patient monitoring.</p>
</div>

<div class="card">
<img src="https://cdn-icons-png.flaticon.com/512/4320/4320351.png">
<h3>Nutrition Clinic</h3>
<p>Diet planning and nutritional counseling.</p>
</div>

<div class="card">
<img src="https://cdn-icons-png.flaticon.com/512/2785/2785482.png">
<h3>Eye Care</h3>
<p>Vision tests, eye surgeries, and optical services.</p>
</div>

<div class="card">
<img src="https://cdn-icons-png.flaticon.com/512/3774/3774274.png">
<h3>ENT Services</h3>
<p>Ear, nose, and throat medical treatments.</p>
</div>

<div class="card">
<img src="https://cdn-icons-png.flaticon.com/512/3774/3774239.png">
<h3>Mental Health</h3>
<p>Psychiatric counseling and mental health support.</p>
</div>

<div class="card">
<img src="https://cdn-icons-png.flaticon.com/512/4320/4320349.png">
<h3>Vaccination</h3>
<p>Immunization programs for children and adults.</p>
</div>

</div>

</div>

<div class="bottom-description">
<h2>Why Choose HealthLink 2035?</h2>
<p>
HealthLink 2035 integrates advanced technology with compassionate healthcare.
Our services include AI diagnostics, telemedicine platforms, robotic-assisted
surgery, and real-time patient monitoring. We ensure that every patient receives
personalized care with maximum safety, efficiency, and innovation.
</p>
</div>

<div class="footer">
<h3>MEDICARE HOSPITALS - HealthLink 2035</h3>
<p>Excellence in Care Through Innovation</p>
<p>© 2026 All Rights Reserved</p>
</div>

</body>
</html>
```
