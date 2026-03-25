<%@ page import="java.sql.*" %>
<%
    // Get the latest vitals entry from database
    Connection conn = null;
    Statement st = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:300/healthlink2035", "root", "manager");

        st = conn.createStatement();

        // Get latest vitals entry
        rs = st.executeQuery("SELECT * FROM vital_entry ORDER BY vital_id DESC LIMIT 1");

    } catch(Exception e) {
        out.println(e);
    }
%>

<!DOCTYPE html>
<html>
<head>
<title>Vitals Saved Successfully</title>
<style>
body {
    margin:0;
    font-family: Arial;
    background: linear-gradient(to bottom,#f0f0ed,#f1f5ef);
}
.header {
    background: linear-gradient(90deg,#1f9bbf,#5cc6d0);
    padding:15px;
    text-align:center;
    font-size:28px;
    font-weight:bold;
    color:white;
}
.frame {
    width:600px;
    margin:80px auto;
    background:white;
    padding:30px;
    border-radius:12px;
    box-shadow:0 8px 20px rgba(0,0,0,0.2);
}
table {
    width:100%;
    border-collapse:collapse;
}
td, th {
    padding:12px;
    border-bottom:1px solid #ddd;
    font-size:16px;
}
th {
    text-align:left;
    color:#1f9bbf;
}
button {
    margin-top:20px;
    padding:12px 20px;
    background:#1f9bbf;
    color:white;
    border:none;
    border-radius:8px;
    cursor:pointer;
    font-size:16px;
}
</style>
</head>
<body>

<div class="header">HEALTHLINK 2035</div>

<div class="frame">

<h2>Vitals Saved Successfully!</h2>

<table>
<%
if(rs != null && rs.next()){
%>
<tr>
<th>Patient Name</th>
<td><%= rs.getString("patient_name") %></td>
</tr>
<tr>
<th>Heart Rate (bpm)</th>
<td><%= rs.getInt("heart_rate") %></td>
</tr>
<tr>
<th>Blood Pressure (mmHg)</th>
<td><%= rs.getString("blood_pressure") %></td>
</tr>
<tr>
<th>Temperature (°C)</th>
<td><%= rs.getFloat("temperature") %></td>
</tr>
<tr>
<th>Respiratory Rate (breaths/min)</th>
<td><%= rs.getInt("respiratory_rate") %></td>
</tr>
<tr>
<th>Oxygen Saturation (%)</th>
<td><%= rs.getInt("oxygen_saturation") %></td>
</tr>
<%
}
%>
</table>

<form action="admin_dashboard.jsp">
<button type="submit">Back to Dashboard</button>
</form>

</div>
</body>
</html>