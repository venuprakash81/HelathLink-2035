<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
String doctorEmail = (String) session.getAttribute("email");

if (doctorEmail == null) {
    response.sendRedirect("login.jsp");
    return;
}

String doctorId = "";
String doctorName = doctorEmail;
String doctorImage = "default.png";

try {

    Class.forName("com.mysql.cj.jdbc.Driver");

    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:300/healthlink2035",
        "root",
        "manager"
    );

    PreparedStatement ps = con.prepareStatement(
        "SELECT doctor_id, name, profile_image FROM doctor_register WHERE email=?"
    );

    ps.setString(1, doctorEmail);

    ResultSet rs = ps.executeQuery();

    if (rs.next()) {
        doctorId = rs.getString("doctor_id");

        String nm = rs.getString("name");
        if (nm != null) doctorName = nm;

        String img = rs.getString("profile_image");
        if (img != null && !img.trim().isEmpty()) {
            doctorImage = img;
        }
    }

    rs.close();
    ps.close();
    con.close();

} catch(Exception e){
    out.println("Error: " + e.getMessage());
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Doctor Appointments</title>

<style>
body{margin:0;font-family:Arial;background:#f4f7fa;}
.header{background:#0f8fbf;color:white;padding:15px;display:flex;justify-content:space-between;align-items:center;}
.doctor-info{display:flex;align-items:center;gap:10px;}
.doctor-info img{width:50px;height:50px;border-radius:50%;}
.container{width:95%;margin:20px auto;background:white;padding:20px;border-radius:10px;}
table{width:100%;border-collapse:collapse;}
th,td{padding:10px;text-align:center;border-bottom:1px solid #ddd;}
th{background:#e0f0ff;}

.vitals-btn{
    background:orange;color:white;border:none;padding:6px 10px;border-radius:5px;
}

.mark-btn{
    background:green;color:white;border:none;padding:6px 10px;border-radius:5px;
}

.completed-box{
    background:#d4edda;color:#155724;padding:6px 10px;border-radius:5px;
}
</style>

</head>

<body>

<!-- HEADER -->
<div class="header">
    <div class="doctor-info">
        <img src="uploads/<%= doctorImage %>" onerror="this.src='uploads/default.png'">
        <h3>Dr. <%= doctorName %></h3>
    </div>

    <form action="logout.jsp">
        <button style="background:red;color:white;border:none;padding:8px 12px;border-radius:5px;">
            Logout
        </button>
    </form>
</div>

<!-- TABLE -->
<div class="container">

<table>

<tr>
    <th>ID</th>
    <th>Patient</th>
    <th>Date</th>
    <th>Time</th>
    <th>Reason</th>

    <!-- STATUS COLUMN -->
    <th>Status</th>

    <th>Vitals</th>

    <!-- MARK COLUMN -->
    <th>Action</th>
</tr>

<%
try {

    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:300/healthlink2035",
        "root",
        "manager"
    );

    PreparedStatement ps = con.prepareStatement(
        "SELECT * FROM appointment_scheduling WHERE doctor_id=? ORDER BY appointment_date DESC"
    );

    ps.setString(1, doctorId);

    ResultSet rs = ps.executeQuery();

    boolean found = false;

    while(rs.next()){
        found = true;

        int id = rs.getInt("appointment_id");
        String patient = rs.getString("patient_name");
        String reason = rs.getString("reason");
        Date date = rs.getDate("appointment_date");
        Time time = rs.getTime("appointment_time");

        String status = rs.getString("status");  // ✅ ONLY THIS

        boolean completed = "Completed".equalsIgnoreCase(status);
%>

<tr>

<td><%= id %></td>
<td><%= patient %></td>
<td><%= date %></td>
<td><%= time %></td>
<td><%= reason %></td>

<!-- STATUS -->
<td>
<% if(completed){ %>
    <span style="
        background:#d4edda;
        color:#155724;
        padding:6px 12px;
        border-radius:20px;
        font-weight:bold;">
        ✔ Completed
    </span>
<% } else { %>
    <span style="
        background:#fff3cd;
        color:#856404;
        padding:6px 12px;
        border-radius:20px;
        font-weight:bold;">
        ⏳ Pending
    </span>
<% } %>
</td>

<!-- VITALS -->
<td>
    <form action="vitals2.jsp">
        <input type="hidden" name="appointment_id" value="<%= id %>">
        <button class="vitals-btn">Vitals</button>
    </form>
</td>

<!-- MARK / ACTION -->
<td>

<% if(!completed){ %>

    <form action="mark_completed.jsp" method="post">
        <input type="hidden" name="appointment_id" value="<%= id %>">

        <button style="
            background:green;
            color:white;
            border:none;
            padding:6px 12px;
            border-radius:20px;
            cursor:pointer;">
            ✔ Mark Complete
        </button>

    </form>

<% } else { %>

    <span style="
        color:green;
        font-weight:bold;">
        Done
    </span>

<% } %>

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

    rs.close();
    ps.close();
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