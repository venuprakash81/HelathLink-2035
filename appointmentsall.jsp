<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
String adminEmail = (String) session.getAttribute("adminEmail");

if(adminEmail == null){
    response.sendRedirect("admin_login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>All Appointments</title>

<style>
body{
    margin:0;
    font-family:Segoe UI;
    background:#f4f7fa;
}

/* Header */
.header{
    background:#0f8fbf;
    color:white;
    padding:15px 25px;
    display:flex;
    justify-content:space-between;
    align-items:center;
}

/* Container */
.container{
    width:95%;
    margin:20px auto;
    background:white;
    padding:20px;
    border-radius:10px;
}

/* Table */
table{
    width:100%;
    border-collapse:collapse;
}

th, td{
    padding:10px;
    text-align:center;
    border-bottom:1px solid #ddd;
}

th{
    background:#e0f0ff;
}

/* Appointment ID badge */
.appointment-id-box{
    display:inline-block;
    background:linear-gradient(135deg,#1f3c88,#4ca1af);
    color:white;
    padding:5px 12px;
    border-radius:20px;
    font-weight:bold;
}

/* Status */
.pending{
    color:orange;
    font-weight:bold;
}
.completed{
    color:green;
    font-weight:bold;
}
.cancelled{
    color:red;
    font-weight:bold;
}

/* Buttons */
.delete-btn{
    background:red;
    color:white;
    border:none;
    padding:5px 10px;
    border-radius:5px;
    cursor:pointer;
}

.logout-btn{
    background:red;
    color:white;
    border:none;
    padding:8px 12px;
    border-radius:5px;
}
</style>

</head>

<body>

<!-- HEADER -->
<div class="header">
    <h2>All Appointments</h2>

    <form action="logout.jsp">
        <button class="logout-btn">Logout</button>
    </form>
</div>

<!-- BACK BUTTON -->
<form action="admin_dashboard.jsp" style="margin:10px;">
    <button style="background:#0f8fbf;color:white;padding:10px;border:none;border-radius:5px;">
        ⬅ Back
    </button>
</form>

<div class="container">

<table>
<tr>
    <th>ID</th>
    <th>Doctor</th>
    <th>Patient</th>
    <th>Date</th>
    <th>Time</th>
    <th>Reason</th>
    <th>Status</th>
    <th>Action</th>
</tr>

<%
try {

    Class.forName("com.mysql.cj.jdbc.Driver");

    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:300/healthlink2035",
        "root",
        "manager"
    );

    // 🔥 FIXED: JOIN to avoid NULL doctor name
    PreparedStatement ps = con.prepareStatement(
        "SELECT a.*, d.name AS doctor_name " +
        "FROM appointment_scheduling a " +
        "LEFT JOIN doctor_register d ON a.doctor_id = d.doctor_id " +
        "ORDER BY a.appointment_date DESC"
    );

    ResultSet rs = ps.executeQuery();

    boolean found = false;

    while(rs.next()){
        found = true;

        String status = rs.getString("status");
%>

<tr>

<td>
    <span class="appointment-id-box">
        <%= rs.getInt("appointment_id") %>
    </span>
</td>

<td>
    Dr. <%= rs.getString("doctor_name") != null ? rs.getString("doctor_name") : "Not Assigned" %>
</td>

<td><%= rs.getString("patient_name") %></td>

<td><%= rs.getDate("appointment_date") %></td>

<td><%= rs.getTime("appointment_time") %></td>

<td><%= rs.getString("reason") %></td>

<td>
    <span class="<%= status.equalsIgnoreCase("Completed") ? "completed" :
                   status.equalsIgnoreCase("Cancelled") ? "cancelled" : "pending" %>">
        <%= status %>
    </span>
</td>

<td>
    <form method="post" action="delete_appointment.jsp"
          onsubmit="return confirm('Are you sure to delete this appointment?');">

        <input type="hidden" name="appointment_id"
               value="<%= rs.getInt("appointment_id") %>">

        <button class="delete-btn">Delete</button>
    </form>
</td>

</tr>

<%
    }

    if(!found){
%>
<tr>
    <td colspan="8" style="text-align:center;color:gray;">
        No Appointments Found
    </td>
</tr>
<%
    }

    con.close();

} catch(Exception e){
%>
<tr>
    <td colspan="8" style="color:red;">
        Error: <%= e.getMessage() %>
    </td>
</tr>
<%
}
%>

</table>

</div>

</body>
</html>