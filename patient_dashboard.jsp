<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String patientName = (String) session.getAttribute("patientName");

    if(patientName == null){
        response.sendRedirect("patient_login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Patient Dashboard</title>

<style>

body{
    margin:0;
    font-family:Segoe UI;
    background:#f4f7fb;
}

/* TOP NAV BAR (NEW) */
.top-bar{
    width:100%;
    background:#1f3c88;
    color:white;
    display:flex;
    align-items:center;
    justify-content:space-between;
    padding:12px 20px;
    box-shadow:0 4px 10px rgba(0,0,0,0.15);
}

.top-bar .title{
    font-size:18px;
    font-weight:600;
}

.top-bar .btns button{
    margin-left:10px;
    padding:6px 12px;
    border:none;
    border-radius:6px;
    cursor:pointer;
    font-weight:600;
}

.back-btn{
    background:#fbbf24;
    color:#111;
}

.logout-btn{
    background:#ef4444;
    color:white;
}

/* HEADER CARD */
.top-card{
    width:90%;
    margin:20px auto;
    background:#ffffff;
    border-radius:16px;
    padding:20px;
    display:flex;
    align-items:center;
    gap:15px;
    box-shadow:0 8px 20px rgba(0,0,0,0.08);
    border-left:6px solid #2563eb;
}

.profile-img{
    width:70px;
    height:70px;
    border-radius:50%;
    background:#e0f2fe;
    border:2px solid #2563eb;
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:32px;
}

.profile-text h2{
    margin:0;
    font-size:20px;
    color:#111827;
    display:flex;
    align-items:center;
    gap:8px;
}

.profile-text h2::before{
    content:"👤";
    font-size:18px;
}

.profile-text p{
    margin:5px 0 0 0;
    font-size:14px;
    color:#6b7280;
}

/* DASHBOARD */
.dashboard{
    width:90%;
    margin:25px auto;
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(240px,1fr));
    gap:20px;
}

.card{
    background:#fff;
    border-radius:16px;
    padding:20px;
    box-shadow:0 5px 15px rgba(0,0,0,0.06);
    border:1px solid #e5e7eb;
    transition:0.3s;
}

.card:hover{
    transform:translateY(-6px);
    border:1px solid #2563eb;
}

.card h3{
    margin:0;
    font-size:17px;
    color:#2563eb;
}

.card p{
    font-size:13px;
    color:#6b7280;
    margin-top:8px;
}

.card button{
    margin-top:12px;
    padding:8px 12px;
    border:none;
    border-radius:8px;
    background:#2563eb;
    color:white;
    cursor:pointer;
    font-weight:600;
}

.card button:hover{
    background:#1d4ed8;
}

</style>
</head>

<body>

<!-- TOP NAV BAR (NEW) -->
<div class="top-bar">
    <button class="back-btn" onclick="history.back()">⬅ Back</button>

    <div class="title">🏥 Patient Dashboard</div>

    <div class="btns">
        <button class="logout-btn" onclick="location.href='logout.jsp'">Logout 🚪</button>
    </div>
</div>

<!-- PATIENT HEADER CARD -->
<div class="top-card">

    <div class="profile-img">👤</div>

    <div class="profile-text">
        <h2><%= patientName %></h2>
        <p>Patient Panel</p>
    </div>

</div>

<!-- DASHBOARD -->
<div class="dashboard">

    <div class="card">
        <h3>📅 Book Appointment</h3>
        <p>Schedule doctor visit</p>
        <button onclick="location.href='dashboard2.jsp'">Open</button>
    </div>

    <div class="card">
        <h3>📋 View Appointments</h3>
        <p>Check your bookings</p>
        <button onclick="location.href='appoint.jsp'">Open</button>
    </div>

    <div class="card">
        <h3>💳 Payments</h3>
        <p>View payment history</p>
        <button onclick="location.href='my_payments.jsp'">Open</button>
    </div>

    <div class="card">
        <h3>🧾 Billing</h3>
        <p>View bills</p>
        <button onclick="location.href='pay_bill.jsp'">Open</button>
    </div>

    <div class="card">
        <h3>🧪 Reports</h3>
        <p>Download medical reports</p>
        <button onclick="location.href='repor.jsp'">Open</button>
    </div>

    <div class="card">
        <h3>💊 Prescriptions</h3>
        <p>Doctor prescriptions</p>
        <button onclick="location.href='ppre.jsp'">Open</button>
    </div>

    <div class="card">
        <h3>💬 Chat</h3>
        <p>Talk with doctor/admin</p>
        <button onclick="location.href='patient_chat.jsp'">Open</button>
    </div>

    <div class="card">
        <h3>🏥 Services</h3>
        <p>Hospital services</p>
        <button onclick="location.href='services.jsp'">Open</button>
    </div>

</div>

</body>
</html>