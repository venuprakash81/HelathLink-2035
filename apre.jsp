<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>All Prescriptions</title>

<style>
body{
    font-family: Arial;
    background:#f4f7fa;
    margin:0;
}

.back{
    position:absolute;
    top:15px;
    left:15px;
    background:#1f3c88;
    color:white;
    padding:8px 12px;
    text-decoration:none;
    border-radius:5px;
}

h2{
    text-align:center;
    margin-top:20px;
}

table{
    width:95%;
    margin:auto;
    margin-top:40px;
    border-collapse:collapse;
    background:white;
    box-shadow:0 4px 10px rgba(0,0,0,0.1);
}

th, td{
    padding:12px;
    border:1px solid #ccc;
    text-align:center;
}

th{
    background:#1f3c88;
    color:white;
}

tr:hover{
    background:#f1f1f1;
}

.no{
    text-align:center;
    color:gray;
    font-size:18px;
}
</style>
</head>

<body>

<a class="back" href="admin_dashboard.jsp">⬅ Back</a>

<h2>📋 All Prescriptions</h2>

<table>

<tr>
<th>ID</th>
<th>Patient Name</th>
<th>Doctor Name</th>
<th>Medicines</th>
<th>Notes</th>
<th>Date</th>
</tr>

<%
boolean hasData = false;

try{
    Class.forName("com.mysql.cj.jdbc.Driver");

    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:300/healthlink2035",  // ✅ YOUR PORT
        "root",
        "manager"
    );

    Statement st = con.createStatement();

    ResultSet rs = st.executeQuery(
    "SELECT pr.prescription_id, p.fullname, d.name, pr.medicines, pr.notes, pr.created_at " +
    "FROM prescriptions pr " +
    "LEFT JOIN patient_register p ON pr.patient_id = p.id " +  // ✅ FIXED TABLE
    "LEFT JOIN doctor_register d ON pr.doctor_id = d.doctor_id " + // ✅ FIXED TABLE
    "ORDER BY pr.prescription_id DESC");

    while(rs.next()){
        hasData = true;
%>

<tr>
<td><%= rs.getInt("prescription_id") %></td>

<td>
<%= rs.getString("fullname") == null ? "Unknown Patient" : rs.getString("fullname") %>
</td>

<td>
<%= rs.getString("name") == null ? "Unknown Doctor" : rs.getString("name") %>
</td>

<td><%= rs.getString("medicines") %></td>
<td><%= rs.getString("notes") %></td>
<td><%= rs.getTimestamp("created_at") %></td>
</tr>

<%
    }

    if(!hasData){
%>
<tr>
<td colspan="6" class="no">❌ No prescriptions found</td>
</tr>
<%
    }

}catch(Exception e){
%>
<tr>
<td colspan="6" style="color:red;">Error: <%= e.getMessage() %></td>
</tr>
<%
}
%>

</table>

</body>
</html>