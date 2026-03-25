<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    String adminEmail = (String) session.getAttribute("adminEmail");

    if(adminEmail == null){
        response.sendRedirect("admin_login.jsp");
        return;
    }

    String adminName = "";
    String profileImage = "default.png";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");

        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:300/healthlink2035",
            "root",
            "manager"
        );

        PreparedStatement ps = con.prepareStatement(
            "SELECT name, image FROM admin WHERE email=?"
        );
        ps.setString(1, adminEmail);
        ResultSet rs = ps.executeQuery();

        if(rs.next()){
            adminName = rs.getString("name");
            if(rs.getString("image") != null){
                profileImage = "uploads/" + rs.getString("image");
            }
        }

        con.close();

    } catch(Exception e){
        out.println(e);
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>

<style>

/* BODY */
body{
    margin:0;
    font-family:Segoe UI;
    background:#f5f7fb;
    color:#1e293b;
}

/* NAVBAR */
.navbar{
    background:#0a7ee9;
    border-bottom:1px solid #e5e7eb;
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:10px 18px;
    box-shadow:0 2px 10px rgba(0,0,0,0.05);
}

/* SMALL BUTTON */
.nav-btn{
    background:#2563eb;
    border:none;
    padding:5px 10px;
    border-radius:6px;
    cursor:pointer;
    color:white;
    font-size:12px;
    font-weight:600;
    transition:0.2s;
}

/* hover */
.nav-btn:hover{
    background:#1d4ed8;
    transform:scale(1.05);
}

/* logout red */
.logout{
    background:#ef4444;
}

.logout:hover{
    background:#dc2626;
}

/* TITLE */
.navbar h3{
    margin:0;
    font-size:16px;
}

/* PROFILE */
.profile-card{
    width:85%;
    margin:25px auto;
    background:#ffffff;
    border-radius:18px;
    padding:20px;
    display:flex;
    align-items:center;
    gap:15px;
    box-shadow:0 6px 18px rgba(0,0,0,0.06);
    border-left:5px solid #2563eb;
}

.profile-card img{
    width:80px;
    height:80px;
    border-radius:50%;
    border:2px solid #2563eb;
}

/* GRID */
.dashboard{
    width:85%;
    margin:30px auto;
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(240px,1fr));
    gap:20px;
}

/* CARD */
.dashboard-card{
    background:#ffffff;
    border-radius:18px;
    padding:22px;
    transition:0.3s;
    border:1px solid #e5e7eb;
    position:relative;
    overflow:hidden;
}

/* glow */
.dashboard-card::before{
    content:"";
    position:absolute;
    width:120px;
    height:120px;
    background:#93c5fd;
    filter:blur(70px);
    top:-40px;
    right:-40px;
    opacity:0.4;
}

.dashboard-card:hover{
    transform:translateY(-6px);
    box-shadow:0 10px 25px rgba(0,0,0,0.08);
    border:1px solid #2563eb;
}

.dashboard-card h3{
    margin:0;
    font-size:18px;
    color:#2563eb;
}

.dashboard-card p{
    font-size:13px;
    color:#64748b;
    margin-top:8px;
}

.dashboard-card button{
    margin-top:12px;
    padding:8px 12px;
    border:none;
    border-radius:8px;
    background:#2563eb;
    color:white;
    font-weight:600;
    cursor:pointer;
    transition:0.2s;
}

.dashboard-card button:hover{
    background:#1d4ed8;
    transform:scale(1.05);
}

</style>
</head>

<body>

<!-- NAVBAR -->
<div class="navbar">
    <button class="nav-btn" onclick="history.back()">⬅ Back</button>

    <h3>🏥 Admin Dashboard</h3>

    <button class="nav-btn logout" onclick="location.href='logout1.jsp'">
        Logout
    </button>
</div>

<!-- PROFILE -->
<div class="profile-card">
    <img src="<%= profileImage %>" onerror="this.src='default.png'">
    <div>
        <h2>👨‍💼 <%= adminName %></h2>
        <p>Administrator Panel</p>
    </div>
</div>

<!-- DASHBOARD -->
<div class="dashboard">

    <div class="dashboard-card">
        <h3>📅 Appointments</h3>
        <p>Manage patient bookings and schedules.</p>
        <button onclick="location.href='appointmentsall.jsp'">Open</button>
    </div>

    <div class="dashboard-card">
        <h3>🧑 Patients</h3>
        <p>View and manage patient records.</p>
        <button onclick="location.href='patientall.jsp'">Open</button>
    </div>

    <div class="dashboard-card">
        <h3>👨‍⚕️ Doctors</h3>
        <p>Manage doctors and availability.</p>
        <button onclick="location.href='doctorsall.jsp'">Open</button>
    </div>

    <div class="dashboard-card">
        <h3>📄 Reports</h3>
        <p>Access medical reports and documents.</p>
        <button onclick="location.href='reportall.jsp'">Open</button>
    </div>
    <div class="dashboard-card">
        <h3>📄 Enter Reports</h3>
        <p>Enter medical reports and documents.</p>
        <button onclick="location.href='report_entry.jsp'">Open</button>
    </div>

    <div class="dashboard-card">
        <h3>🩺 Send Salary</h3>
        <p>Upload The Salaries To Doctors.</p>
        <button onclick="location.href='sallll.jsp'">Open</button>
    </div>
    <div class="dashboard-card">
        <h3>🩺 Entered Salary</h3>
        <p>See Entered The Salaries To Doctors.</p>
        <button onclick="location.href='viewallsal.jsp'">Open</button>
    </div>
    <div class="dashboard-card">
        <h3>🩺 Vitals Entry</h3>
        <p>Record BP, temperature, pulse rate.</p>
        <button onclick="location.href='VitalsEntry.jsp'">Open</button>
    </div>

    <div class="dashboard-card">
        <h3>💳 Payments</h3>
        <p>View all payment transactions.</p>
        <button onclick="location.href='view_payments.jsp'">Open</button>
    </div>

    <div class="dashboard-card">
        <h3>💊 Prescriptions</h3>
        <p>View all patient prescriptions.</p>
        <button onclick="location.href='apre.jsp'">Open</button>
    </div>

    <div class="dashboard-card">
        <h3>💬 Chat System</h3>
        <p>Communicate with doctors & patients.</p>
        <button onclick="location.href='admin_chat.jsp'">Open</button>
    </div>

    <div class="dashboard-card">
        <h3>⚙ Settings</h3>
        <p>Update profile and password.</p>
        <button onclick="location.href='settings.jsp'">Open</button>
    </div>

</div>

</body>
</html>