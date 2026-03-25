<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>HealthLink 2035 Dashboard</title>

<style>

@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap');

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Poppins',sans-serif;
}

/* BODY BACKGROUND */

body{
min-height:100vh;
background:linear-gradient(-45deg,#e0f2ff,#ffffff,#dbeafe,#eef6ff);
background-size:400% 400%;
animation:bgMove 12s infinite alternate;
display:flex;
flex-direction:column;
}

@keyframes bgMove{
0%{background-position:left;}
100%{background-position:right;}
}

/* TOPBAR */

.topbar{
background:linear-gradient(90deg,#002855,#005fa3);
color:white;
padding:12px 50px;
display:flex;
justify-content:space-between;
font-size:14px;
}

/* NAVBAR */

.navbar{
background:white;
padding:18px 50px;
display:flex;
justify-content:space-between;
align-items:center;
box-shadow:0 6px 25px rgba(0,0,0,0.08);
}

.navbar h2{
color:#003973;
}

/* MENU ICON */

.menu-icon{
font-size:30px;
cursor:pointer;
color:#003973;
}

/* SIDE MENU */

.side-menu{
height:100%;
width:0;
position:fixed;
top:0;
right:0;
background:white;
overflow-x:hidden;
transition:0.4s;
padding-top:70px;
box-shadow:-6px 0 25px rgba(0,0,0,0.2);
z-index:999;
}

.side-menu a{
display:block;
padding:16px 35px;
font-size:18px;
color:#003973;
text-decoration:none;
transition:0.3s;
}

.side-menu a:hover{
background:#eef4ff;
color:#e63946;
padding-left:45px;
}

/* CLOSE BUTTON */

.close-btn{
position:absolute;
top:15px;
right:25px;
font-size:32px;
cursor:pointer;
color:#003973;
font-weight:bold;
}

.close-btn:hover{
color:#e63946;
}

/* MAIN CENTER */

.main{
flex:1;
display:flex;
justify-content:center;
align-items:center;
flex-direction:column;
padding:40px;
}

/* WELCOME */

.welcome{
text-align:center;
margin-bottom:40px;
}

.welcome h1{
font-size:40px;
color:#003973;
}

.welcome span{
color:#e63946;
}

.welcome p{
margin-top:10px;
color:#555;
}

/* CARDS */

.access-container{
display:flex;
gap:40px;
flex-wrap:wrap;
justify-content:center;
margin-bottom:60px;
}

.card{
width:280px;
padding:40px;
border-radius:20px;
background:rgba(255,255,255,0.7);
backdrop-filter:blur(10px);
box-shadow:0 10px 40px rgba(0,0,0,0.15);
text-align:center;
transition:0.4s;
}

.card:hover{
transform:translateY(-10px);
}

.card h3{
color:#003973;
margin-bottom:10px;
}

.card p{
font-size:14px;
margin-bottom:20px;
}

/* BUTTON */

.card button{
padding:12px 30px;
border:none;
border-radius:40px;
background:linear-gradient(90deg,#003973,#005fa3);
color:white;
cursor:pointer;
}

.card button:hover{
background:linear-gradient(90deg,#e63946,#ff6b6b);
}

/* ABOUT SECTION */

.about{
max-width:900px;
text-align:center;
margin-bottom:50px;
}

.about h2{
color:#003973;
margin-bottom:15px;
}

.about p{
color:#444;
line-height:1.6;
}

/* FEATURES */

.features{
display:grid;
grid-template-columns:repeat(auto-fit,minmax(200px,1fr));
gap:25px;
max-width:900px;
margin-bottom:60px;
}

.feature-box{
background:white;
padding:20px;
border-radius:15px;
box-shadow:0 8px 25px rgba(0,0,0,0.08);
text-align:center;
}

.feature-box h4{
color:#003973;
margin-bottom:8px;
}

/* FOOTER */

.footer{
background:linear-gradient(90deg,#002855,#005fa3);
color:white;
text-align:center;
padding:25px;
}

</style>
</head>

<body>

<!-- TOP BAR -->
<div class="topbar">
<div>HEALTHLINK 2035</div>
<div>Emergency Contact : 767-0924-977</div>
</div>

<!-- NAVBAR -->
<div class="navbar">
<h2>MEDICARE HOSPITALS</h2>
<span class="menu-icon" onclick="openMenu()">☰</span>
</div>

<!-- SIDE MENU -->
<div id="sideMenu" class="side-menu">

<span class="close-btn" onclick="closeMenu()">&times;</span>


<a href="service.jsp">Services</a>
<a href="doctor.jsp">Doctors</a>
<a href="explore.jsp">Explore</a>

</div>

<!-- MAIN CONTENT -->
<div class="main">

<div class="welcome">
<h1>Welcome to <span>HealthLink 2035</span></h1>
<p>Your Smart Healthcare Management System</p>
</div>

<div class="access-container">

<div class="card">
<h3>Admin Panel</h3>
<p>Manage doctors, patients and reports.</p>
<button onclick="location.href='admin_login.jsp'">Admin Login</button>
</div>

<div class="card">
<h3>Doctor Portal</h3>
<p>Doctors manage appointments and patients.</p>
<button onclick="location.href='login.jsp'">Doctor Login</button>
</div>

<div class="card">
<h3>Patient Portal</h3>
<p>Register and book appointments.</p>
<button onclick="location.href='patient_login.jsp'">Patient Register</button>
</div>

</div>

<!-- ABOUT SECTION -->
<div class="about">
<h2>About HealthLink 2035</h2>
<p>
HealthLink 2035 is a smart healthcare management system designed to simplify hospital operations 
and improve patient care. Our platform connects patients, doctors, and administrators through 
a secure and intelligent system that supports appointment booking, medical records management, 
and digital health services.
</p>
</div>

<!-- FEATURES -->
<div class="features">

<div class="feature-box">
<h4>Online Appointments</h4>
<p>Patients can easily book doctor appointments online.</p>
</div>

<div class="feature-box">
<h4>Doctor Management</h4>
<p>Admins can manage doctor details and schedules.</p>
</div>

<div class="feature-box">
<h4>Secure Data</h4>
<p>All patient and doctor records are safely stored.</p>
</div>

<div class="feature-box">
<h4>Smart Healthcare</h4>
<p>Digital solutions to improve healthcare efficiency.</p>
</div>

</div>

</div>

<!-- FOOTER -->
<div class="footer">
MEDICARE HOSPITALS • HealthLink 2035 • © 2026
</div>

<script>

function openMenu(){
document.getElementById("sideMenu").style.width="260px";
}

function closeMenu(){
document.getElementById("sideMenu").style.width="0";
}

</script>

</body>
</html>
```
