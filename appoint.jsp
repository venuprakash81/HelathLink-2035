<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    String patientEmail = (String) session.getAttribute("email");

    if (patientEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String patientName = "";
    int patientId = 0;

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    boolean hasData = false;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");

        con = DriverManager.getConnection(
            "jdbc:mysql://localhost:300/healthlink2035",
            "root",
            "manager"
        );

        // GET PATIENT ID
        ps = con.prepareStatement(
            "SELECT id, fullname FROM patient_register WHERE email=?"
        );
        ps.setString(1, patientEmail);

        rs = ps.executeQuery();

        if (rs.next()) {
            patientId = rs.getInt("id");
            patientName = rs.getString("fullname");
        }

        rs.close();
        ps.close();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Open Appointments</title>

<style>
body {
    font-family: Arial;
    background: #f4f7fa;
    margin: 0;
}

.header {
    background: #0f8fbf;
    color: white;
    padding: 15px;
    text-align: center;
}

table {
    width: 95%;
    margin: 30px auto;
    border-collapse: collapse;
    background: white;
}

th, td {
    padding: 12px;
    border: 1px solid #ddd;
    text-align: center;
}

th {
    background: #0f8fbf;
    color: white;
}

.status {
    padding: 5px 10px;
    border-radius: 5px;
    color: white;
    background: orange;
}

.no-data {
    text-align: center;
    padding: 20px;
    color: gray;
}
</style>
</head>

<body>

<div class="header">
    <h2>Welcome, <%= patientName %> - Open Appointments</h2>
</div>

<table>
    <tr>
        <th>Appointment ID</th>
        <th>Doctor ID</th>
        <th>Date</th>
        <th>Time</th>
        <th>Reason</th>
        <th>Status</th>
    </tr>

<%
        // OPEN APPOINTMENTS ONLY (NOT COMPLETED)
        ps = con.prepareStatement(
            "SELECT appointment_id, doctor_id, appointment_date, appointment_time, reason, status " +
            "FROM appointment_scheduling " +
            "WHERE patient_id=? AND (completed=0 OR status='Pending') " +
            "ORDER BY appointment_date ASC"
        );

        ps.setInt(1, patientId);

        rs = ps.executeQuery();

        while(rs.next()){
            hasData = true;
%>

<tr>
    <td><%= rs.getInt("appointment_id") %></td>
    <td><%= rs.getInt("doctor_id") %></td>
    <td><%= rs.getDate("appointment_date") %></td>
    <td><%= rs.getTime("appointment_time") %></td>
    <td><%= rs.getString("reason") %></td>
    <td>
        <span class="status"><%= rs.getString("status") %></span>
    </td>
</tr>

<%
        }

        if(!hasData){
%>

<tr>
    <td colspan="6" class="no-data">No open appointments found</td>
</tr>

<%
        }

        con.close();

    } catch(Exception e){
%>

<div style="color:red;text-align:center;">
Error: <%= e.getMessage() %>
</div>

<%
    }
%>

</table>

</body>
</html>