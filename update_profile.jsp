<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>

<title>Edit Doctor Profile</title>

<style>

body{
margin:0;
font-family:Arial;
background:linear-gradient(to bottom,#f0f0ed,#f1f5ef);
}

.header{
background:linear-gradient(90deg,#1f9bbf,#5cc6d0);
padding:15px;
text-align:center;
font-size:28px;
font-weight:bold;
color:white;
}

.frame{
width:500px;
margin:60px auto;
background:white;
padding:30px;
border-radius:12px;
box-shadow:0 8px 20px rgba(0,0,0,0.2);
}

input{
width:100%;
padding:10px;
margin-top:8px;
border-radius:8px;
border:1px solid #ccc;
}

button{
margin-top:20px;
padding:10px 20px;
background:#1f9bbf;
color:white;
border:none;
border-radius:8px;
cursor:pointer;
}

button:hover{
background:#157a91;
}

</style>

</head>

<body>

<div class="header">
Update Profile
</div>

<div class="frame">

<h2>Edit Profile</h2>

<p>Update your personal and professional information.</p>

<form action="update_doctor_profile.jsp" 
method="post" 
enctype="multipart/form-data">

<label>Doctor Name</label>
<input type="text" name="doctor_name" required>

<label>Specialization</label>
<input type="text" name="specialization">

<label>Contact</label>
<input type="text" name="contact">

<label>Email</label>
<input type="email" name="email">

<label>Choose Profile Image</label>
<input type="file" name="profile_image" accept="image/*">

<button type="submit">
Update Profile
</button>

</form>

</div>

</body>
</html>