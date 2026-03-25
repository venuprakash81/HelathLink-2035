<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
/* ✅ Set patient manually */
int patientId = 17;   // 🔥 CHANGE THIS VALUE
%>

<!DOCTYPE html>
<html>
<head>
<title>Patient Prescriptions</title>

<style>
body{
    font-family:Arial;
    background:#f4f7fa;
    margin:0;
}

/* HEADER */
.header{
    background:#1f3c88;
    color:white;
    padding:15px;
    text-align:center;
    font-size:22px;
}

/* BACK BUTTON */
.back{
    position:absolute;
    top:15px;
    left:15px;
    background:white;
    color:#1f3c88;
    padding:8px 12px;
    text-decoration:none;
    border-radius:5px;
    font-weight:bold;
}

/* TABLE */
table{
    width:90%;
    margin:auto;
    margin-top:40px;
    border-collapse:collapse;
    background:white;
    box-shadow:0 0 10px #ccc;
}

th, td{
    padding:10px;
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
    padding:15px;
}
</style>
</head>

<body>

<div class="header">
    🧾 Patient Prescriptions
    <a class="back" href="patient_dashboard.jsp">⬅ Back</a>
</div>

<table>

<tr>
<th>ID</th>
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
        "jdbc:mysql://localhost:300/healthlink2035",
        "root",
        "manager"
    );

    PreparedStatement ps = con.prepareStatement(
    "SELECT pr.prescription_id, d.name, pr.medicines, pr.notes, pr.created_at " +
    "FROM prescriptions pr " +
    "LEFT JOIN doctor_register d ON pr.doctor_id = d.doctor_id " +
    "WHERE pr.patient_id=? ORDER BY pr.prescription_id DESC");

    ps.setInt(1, patientId);

    ResultSet rs = ps.executeQuery();

    while(rs.next()){
        hasData = true;
%>

<tr>
<td><%= rs.getInt("prescription_id") %></td>

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
<td colspan="5" class="no">❌ No prescriptions found</td>
</tr>
<%
    }

}catch(Exception e){
%>
<tr>
<td colspan="5" style="color:red;">
Error: <%= e.getMessage() %>
</td>
</tr>
<%
}
%>

</table>

</body>
</html>