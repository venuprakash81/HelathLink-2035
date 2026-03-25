<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
String doctorEmail = (String) session.getAttribute("email");

if(doctorEmail == null){
    response.sendRedirect("login.jsp");
    return;
}

int doctorId = 0;
%>

<!DOCTYPE html>
<html>
<head>
<title>My Prescriptions</title>

<style>
body{
    font-family:Arial;
    background:#f4f7fa;
    margin:0;
}

.header{
    background:#1f3c88;
    color:white;
    padding:15px;
    text-align:center;
    font-size:22px;
}

table{
    width:95%;
    margin:auto;
    margin-top:30px;
    border-collapse:collapse;
    background:white;
}

th,td{
    padding:10px;
    border:1px solid #ccc;
    text-align:center;
}

th{
    background:#1f3c88;
    color:white;
}

a.edit{
    background:#28a745;
    color:white;
    padding:6px 10px;
    text-decoration:none;
    border-radius:5px;
}

/* ✅ BACK BUTTON TOP LEFT */
.back-btn{
    position:fixed;
    top:15px;
    left:15px;
    background:#1f3c88;
    color:white;
    padding:8px 12px;
    border:none;
    border-radius:5px;
    cursor:pointer;
    text-decoration:none;
}
</style>
</head>

<body>

<!-- 🔙 BACK BUTTON (TOP LEFT FIXED) -->
<a href="doctor_dashboard.jsp" class="back-btn">⬅ Back</a>

<div class="header">My Prescriptions</div>

<table>
<tr>
<th>ID</th>
<th>Patient</th>
<th>Medicines</th>
<th>Notes</th>
<th>Date</th>
<th>Edit</th>
</tr>

<%
boolean found = false;

try{
    Class.forName("com.mysql.cj.jdbc.Driver");

    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:300/healthlink2035",
        "root",
        "manager"
    );

    // GET doctor_id FROM EMAIL
    PreparedStatement ps1 = con.prepareStatement(
        "SELECT doctor_id FROM doctor_register WHERE email=?"
    );
    ps1.setString(1, doctorEmail);
    ResultSet rs1 = ps1.executeQuery();

    if(rs1.next()){
        doctorId = rs1.getInt("doctor_id");
    }

    // GET PRESCRIPTIONS
    PreparedStatement ps2 = con.prepareStatement(
        "SELECT p.prescription_id, pt.fullname, p.medicines, p.notes, p.created_at " +
        "FROM prescriptions p " +
        "LEFT JOIN patient_register pt ON p.patient_id = pt.id " +
        "WHERE p.doctor_id=? ORDER BY p.prescription_id DESC"
    );

    ps2.setInt(1, doctorId);

    ResultSet rs2 = ps2.executeQuery();

    while(rs2.next()){
        found = true;
%>

<tr>
<td><%= rs2.getInt(1) %></td>
<td><%= rs2.getString(2) %></td>
<td><%= rs2.getString(3) %></td>
<td><%= rs2.getString(4) %></td>
<td><%= rs2.getTimestamp(5) %></td>

<td>
<a class="edit" href="edit_prescription.jsp?id=<%= rs2.getInt(1) %>">Edit</a>
</td>
</tr>

<%
    }

    if(!found){
%>
<tr><td colspan="6">No prescriptions found</td></tr>
<%
    }

}catch(Exception e){
%>
<tr><td colspan="6"><%= e.getMessage() %></td></tr>
<%
}
%>

</table>

</body>
</html>