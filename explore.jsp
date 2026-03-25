<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Explore - HealthLink 2035</title>

<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap" rel="stylesheet">

<style>

body{
margin:0;
font-family:'Montserrat', sans-serif;
background:#e0e5ec;
}

/* NAVBAR */

.navbar{
background:white;
padding:15px 40px;
display:flex;
justify-content:space-between;
align-items:center;
box-shadow:0 6px 20px rgba(0,0,0,0.1);
}

.navbar h2{
color:#1f3c88;
}

.navbar ul{
list-style:none;
display:flex;
gap:25px;
}

.navbar ul li a{
text-decoration:none;
color:#1f3c88;
font-weight:600;
}

/* HERO */

.hero{
text-align:center;
padding:60px 20px;
background:linear-gradient(135deg,#dbefff,#ffffff);
}

.hero h1{
font-size:42px;
color:#1f3c88;
}

.hero h2{
font-size:28px;
color:#e63946;
}

/* SECTION */

.section{
padding:60px 20px;
}

.section h2{
text-align:center;
color:#1f3c88;
margin-bottom:40px;
}

/* HOSPITAL CARDS */

.hospital-container{
display:flex;
flex-wrap:wrap;
justify-content:center;
gap:25px;
}

.hospital-card{
width:300px;
background:white;
border-radius:15px;
padding:15px;
box-shadow:0 6px 15px rgba(0,0,0,0.1);
transition:0.3s;
}

.hospital-card:hover{
transform:translateY(-8px);
}

.hospital-card img{
width:100%;
height:180px;
object-fit:cover;
border-radius:10px;
}

.hospital-card h3{
color:#1f3c88;
margin:10px 0;
}

.hospital-card p{
font-size:14px;
}

/* ABOUT */

.about-project{
background:white;
padding:40px;
margin:40px;
border-radius:15px;
}

/* FOOTER */

.footer{
background:#1f3c88;
color:white;
text-align:center;
padding:25px;
margin-top:40px;
}

</style>
</head>

<body>

<div class="navbar">
<h2>HealthLink 2035</h2>
<ul>

<li><a href="index.jsp">Home</a></li>
<li><a href="service.jsp">Services</a></li>
<li><a href="doctor.jsp">Doctors</a></li>
</ul>
</div>

<div class="hero">
<h1>Welcome to HealthLink 2035</h1>
<h2>Future of Digital Healthcare</h2>
<p>Explore top hospitals, AI diagnostics, telemedicine, and cloud healthcare systems.</p>
</div>

<div class="section">
<h2>Top Hospitals</h2>

<div class="hospital-container">

<div class="hospital-card">
<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/8/88/Hospital-de-Bellvitge.jpg/330px-Hospital-de-Bellvitge.jpg" alt="Mayo Clinic">
<h3>Mayo Clinic</h3>
<p><b>Location:</b> Hyderabad, India</p>
<p>World-leading research hospital with advanced medical technologies.</p>
</div>

<div class="hospital-card">
<img src="https://batrahealthcare.com/wp-content/uploads/2024/09/about-us-batra-healthcare.jpg" alt="Cleveland Clinic">
<h3>Cleveland Clinic</h3>
<p><b>Location:</b> Ohio, United States</p>
<p>Specialized heart and vascular care center.</p>
</div>

<div class="hospital-card">
<img src="https://www.carehospitals.com/assets/images/main/care-hitech-new.png" alt="Johns Hopkins Hospital">
<h3>Johns Hopkins Hospital</h3>
<p><b>Location:</b> Sydney, Australia</p>
<p>Top-ranked teaching hospital known for medical research.</p>
</div>

<div class="hospital-card">
<img src="https://yapita-production.s3.ap-south-1.amazonaws.com/uploads/facility/seo_image/03060920-69f3-4d09-b224-5a2940884d52/file.webp" alt="Apollo Hospitals">
<h3>Apollo Hospitals</h3>
<p><b>Location:</b> Chennai, India</p>
<p>Leading multi-specialty hospital network in India.</p>
</div>



</div>

</div>

<div class="about-project">
<h3>About HealthLink 2035</h3>
<p>
HealthLink 2035 integrates AI diagnostics, telemedicine, and cloud healthcare systems to deliver seamless patient care. Our platform connects hospitals, doctors, and patients globally.
</p>
</div>

<div class="footer">
© 2026 HealthLink 2035 | Future of Digital Healthcare
</div>

</body>
</html>
```
