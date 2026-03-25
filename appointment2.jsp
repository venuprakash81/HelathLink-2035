<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
int appointmentId = Integer.parseInt(request.getParameter("appointment_id"));

String patientName = "-";
String doctorName = "-";
String reason = "-";
String status = "-";
String date = "-";
String time = "-";
String createdAt = "-";

try {

    Class.forName("com.mysql.cj.jdbc.Driver");

    Connection conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:300/healthlink2035",
        "root",
        "manager"
    );

    // 1️⃣ GET APPOINTMENT DETAILS
    PreparedStatement ps = conn.prepareStatement(
        "SELECT * FROM appointment_scheduling WHERE appointment_id=?"
    );

    ps.setInt(1, appointmentId);
    ResultSet rs = ps.executeQuery();

    int doctorId = 0;

    if(rs.next()){
        patientName = rs.getString("patient_name");
        reason = rs.getString("reason");
        status = rs.getString("status");
        date = String.valueOf(rs.getDate("appointment_date"));
        time = String.valueOf(rs.getTime("appointment_time"));
        createdAt = String.valueOf(rs.getTimestamp("created_at"));

        doctorId = rs.getInt("doctor_id");  // ✅ IMPORTANT
    }

    // 2️⃣ GET DOCTOR NAME FROM DOCTOR TABLE
    PreparedStatement ps2 = conn.prepareStatement(
        "SELECT name FROM doctor_register WHERE doctor_id=?"
    );

    ps2.setInt(1, doctorId);
    ResultSet rs2 = ps2.executeQuery();

    if(rs2.next()){
        doctorName = rs2.getString("name");
    }

    conn.close();

} catch(Exception e){
%>
    <h3 style="color:red;text-align:center;">
        Error: <%= e.getMessage() %>
    </h3>
<%
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Appointment Success</title>

<style>
body{
    font-family: Arial;
    background:#eef3f9;
}

.container{
    width:600px;
    margin:50px auto;
    background:white;
    padding:25px;
    border-radius:10px;
    box-shadow:0 0 10px rgba(0,0,0,0.1);
}

h2{
    text-align:center;
    color:#1f3c88;
}

table{
    width:100%;
    border-collapse:collapse;
}
.download{
    background:#4ca1af;
    color:white;
    padding:10px;
    border:none;
    border-radius:6px;
    cursor:pointer;
}
.download:hover{
    background:#2d7f8c;
}

td,th{
    padding:10px;
    border-bottom:1px solid #ddd;
}

th{
    text-align:left;
    color:#1f3c88;
}

button{
    padding:10px;
    border:none;
    border-radius:6px;
    cursor:pointer;
}
.appointment-box{
    display:inline-block;
    background: linear-gradient(135deg, #1f3c88, #4ca1af);
    color:white;
    padding:10px 18px;
    border-radius:25px;
    font-weight:bold;
    font-size:14px;
    box-shadow:0 4px 10px rgba(0,0,0,0.15);
}

.done{
    background:#1f3c88;
    color:white;
}
</style>
</head>

<body>

<div class="container">

<h2>Appointment Booked Successfully 🎉</h2>

<table>

<tr><span class="appointment-box">
    Appointment ID: <%= appointmentId %>
</span>                         Required Appointment ID At Vitals Entry....</tr>
<tr><th>Patient</th><td><%= patientName %></td></tr>
<tr><th>Doctor</th><td>Dr. <%= doctorName %></td></tr>
<tr><th>Date</th><td><%= date %></td></tr>
<tr><th>Time</th><td><%= time %></td></tr>
<tr><th>Reason</th><td><%= reason %></td></tr>
<tr><th>Status</th><td><%= status %></td></tr>
<tr><th>Created</th><td><%= createdAt %></td></tr>

</table>

<br>

<form action="patient_dashboard.jsp">
    <button class="done">Done</button>
    <form action="downloadAppointment.jsp" method="get" style="display:inline;">
    <input type="hidden" name="appointment_id" value="<%= appointmentId %>">
    <button type="submit" class="download">Download</button>
</form>
</form>

</div>

</body>
</html>