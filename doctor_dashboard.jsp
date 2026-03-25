<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String doctorEmail = (String) session.getAttribute("email");
    String doctorName = (String) session.getAttribute("name");

    if (doctorEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String dbURL = "jdbc:mysql://localhost:300/healthlink2035";
    String dbUser = "root";
    String dbPass = "manager";

    String specialization = "";
    String hospital = "";
    String profileImage = request.getContextPath() + "/uploads/default_doctor.png";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");

        Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

        PreparedStatement ps = conn.prepareStatement(
            "SELECT name, specialization, hospital, profile_image FROM doctor_register WHERE email=?"
        );

        ps.setString(1, doctorEmail.trim());

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {

            doctorName = rs.getString("name");
            specialization = rs.getString("specialization");
            hospital = rs.getString("hospital");

            String img = rs.getString("profile_image");

            // ✅ FIXED IMAGE PATH
            if (img != null && !img.isEmpty()) {
                profileImage = request.getContextPath() + "/" + img;
            }
        }

        conn.close();

    } catch (Exception e) {
        out.println(e);
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Doctor Dashboard</title>

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
    background:#078eef;
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:12px 18px;
    color:white;
}

.nav-btn{
    background:#2563eb;
    border:none;
    padding:6px 12px;
    border-radius:6px;
    cursor:pointer;
    color:white;
    font-size:12px;
}

.nav-btn:hover{
    background:#1d4ed8;
}

.logout{
    background:#ef4444;
}

.logout:hover{
    background:#dc2626;
}

/* PROFILE */
.profile-card{
    width:85%;
    margin:25px auto;
    background:#fff;
    border-radius:15px;
    padding:20px;
    display:flex;
    align-items:center;
    gap:15px;
    box-shadow:0 6px 18px rgba(0,0,0,0.06);
}

.profile-card img{
    width:80px;
    height:80px;
    border-radius:50%;
    object-fit:cover;
    border:2px solid #2563eb;
}

.profile-info h2{
    margin:0;
    color:#2563eb;
}

.profile-info p{
    margin:5px 0;
    color:#64748b;
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
    background:#fff;
    border-radius:15px;
    padding:20px;
    border:1px solid #e5e7eb;
    transition:0.3s;
}

.dashboard-card:hover{
    transform:translateY(-6px);
    border-color:#2563eb;
    box-shadow:0 8px 20px rgba(0,0,0,0.08);
}

.dashboard-card h3{
    margin:0;
    color:#2563eb;
}

.dashboard-card p{
    font-size:13px;
    color:#64748b;
    margin-top:8px;
}

.dashboard-card button{
    margin-top:10px;
    padding:8px 12px;
    border:none;
    border-radius:8px;
    background:#2563eb;
    color:white;
    cursor:pointer;
}

.dashboard-card button:hover{
    background:#1d4ed8;
}

</style>
</head>

<body>

<!-- NAVBAR -->
<div class="navbar">
    <button class="nav-btn" onclick="history.back()">⬅ Back</button>
    <h3>🏥 Doctor Dashboard</h3>
    <button class="nav-btn logout" onclick="location.href='logout.jsp'">Logout</button>
</div>

<!-- PROFILE -->
<div class="profile-card">
    <img src="<%= profileImage %>" 
         onerror="this.src='<%=request.getContextPath()%>/uploads/default_doctor.png'">

    <div class="profile-info">
        <h2>👨‍⚕️ Dr. <%= doctorName %></h2>
        <p><%= specialization %> • <%= hospital %></p>
    </div>
</div>

<!-- DASHBOARD -->
<div class="dashboard">

    <div class="dashboard-card">
        <h3>📅 Appointments</h3>
        <p>Check patient appointments</p>
        <button onclick="location.href='appointments.jsp'">Open</button>
    </div>
    <div class="dashboard-card">
        <h3>📝 Reports</h3>
        <p>See Reports</p>
        <button onclick="location.href='report.jsp'">Open</button>
    </div>
    <div class="dashboard-card">
        <h3>📝 Salary</h3>
        <p>See Salary Details</p>
        <button onclick="location.href='salary.jsp'">Open</button>
    </div>

    <div class="dashboard-card">
        <h3>💬 Chat Patients</h3>
        <p>Chat with patients</p>
        <button onclick="location.href='#'">Open</button>
    </div>

    <div class="dashboard-card">
        <h3>💬 Chat Admin</h3>
        <p>Chat with admin</p>
        <button onclick="location.href='#'">Open</button>
    </div>
    

    <div class="dashboard-card">
        <h3>📝 Prescription</h3>
        <p>Create prescriptions</p>
        <button onclick="location.href='enterpre.jsp'">Open</button>
    </div>

    <div class="dashboard-card">
        <h3>📄 View Prescriptions</h3>
        <p>View history</p>
        <button onclick="location.href='dpre.jsp'">Open</button>
    </div>

    <div class="dashboard-card">
        <h3>⚙ Settings</h3>
        <p>Update profile</p>
        <button onclick="location.href='settings.jsp'">Open</button>
    </div>

</div>

</body>
</html>