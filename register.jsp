<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Doctor Registration</title>

<style>
    body {
        margin: 0;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(135deg,#eef5ff,#ffffff);
    }
    h2 {
        text-align: center;
        color: #003973;
        margin-top: 30px;
    }
    .container {
        max-width: 500px;
        margin: 50px auto;
        background: white;
        padding: 40px;
        border-radius: 15px;
        box-shadow: 0 10px 25px rgba(0,0,0,0.1);
    }
    form input, form select {
        width: 100%;
        padding: 12px 10px;
        margin: 10px 0;
        border-radius: 8px;
        border: 1px solid #ccc;
        font-size: 14px;
    }
    form button {
        width: 100%;
        padding: 12px;
        background: linear-gradient(90deg,#0073e6,#005fa3);
        border: none;
        border-radius: 8px;
        color: white;
        font-size: 16px;
        font-weight: bold;
        cursor: pointer;
    }

    .password-container {
        position: relative;
    }
    .toggle-password {
        position: absolute;
        right: 10px;
        top: 50%;
        transform: translateY(-50%);
        cursor: pointer;
        font-size: 12px;
        color: #007bff;
    }

    .message {
        text-align: center;
        color: red;
        font-weight: bold;
    }
</style>

<script>
function togglePassword(id, toggleId) {
    var pwd = document.getElementById(id);
    var toggle = document.getElementById(toggleId);
    if (pwd.type === "password") {
        pwd.type = "text";
        toggle.innerText = "Hide";
    } else {
        pwd.type = "password";
        toggle.innerText = "Show";
    }
}
</script>

</head>

<body>

<h2>Doctor Registration</h2>

<div class="container">

<%
    String message = request.getParameter("message");
    if(message != null){
%>
    <div class="message"><%= message %></div>
<%
    }
%>

<form action="DoctorRegisterServlet" method="post" enctype="multipart/form-data">

    <!-- REQUIRED FOR YOUR DB -->
    

    <input type="text" name="name" placeholder="Full Name" required>

    <input type="email" name="email" placeholder="Email" required>

    <input type="tel" name="phone" placeholder="Phone Number" required>

    <select name="qualification" required>
        <option value="">Select Qualification</option>
        <option>MBBS</option>
        <option>MD</option>
        <option>BDS</option>
        <option>BPT</option>
    </select>

    <select name="specialization" required>
        <option value="">Select Specialization</option>
        <option>Cardiologist</option>
        <option>Neurologist</option>
        <option>Orthopedic</option>
        <option>Pediatrician</option>
        <option>Dermatologist</option>
    </select>

    <select name="experience" required>
        <option value="">Experience</option>
        <% for(int i=0;i<=40;i++){ %>
            <option value="<%=i%>"><%=i%> Years</option>
        <% } %>
    </select>

    <select name="hospital" required>
    <option value="">Select Hospital</option>

    <option value="Mayo Clinic">Mayo Clinic</option>
    <option value="Cleveland Clinic">Cleveland Clinic</option>
    <option value="Johns Hopkins Hospital">Johns Hopkins Hospital</option>
    <option value="Apollo Hospitals">Apollo Hospitals</option>

</select>

    <!-- PASSWORD -->
    <div class="password-container">
        <input type="password" name="password" id="password" placeholder="Password" required>
        <span class="toggle-password" id="t1" onclick="togglePassword('password','t1')">Show</span>
    </div>

    <div class="password-container">
        <input type="password" name="confirmPassword" id="confirmPassword" placeholder="Confirm Password" required>
        <span class="toggle-password" id="t2" onclick="togglePassword('confirmPassword','t2')">Show</span>
    </div>

    <!-- IMAGE -->
    <input type="file" name="profile_image" accept="image/*" required>

    <button type="submit">Register</button>

</form>

</div>

</body>
</html>