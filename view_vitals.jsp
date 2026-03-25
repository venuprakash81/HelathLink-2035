<%@ page import="java.sql.*" %>

<%
Connection conn=null;
PreparedStatement ps=null;
ResultSet rs=null;

String appointmentId=request.getParameter("appointment_id");

try{

Class.forName("com.mysql.cj.jdbc.Driver");

conn=DriverManager.getConnection(
"jdbc:mysql://localhost:300/healthlink2035",
"root",
"manager");

ps=conn.prepareStatement(
"SELECT * FROM vital_entry WHERE appointment_id=?");

ps.setInt(1,Integer.parseInt(appointmentId));

rs=ps.executeQuery();

}catch(Exception e){
out.println(e);
}
%>

<!DOCTYPE html>
<html>
<head>

<title>Patient Vitals</title>

<style>

body{
margin:0;
font-family:Arial;
background:linear-gradient(to bottom,#f0f0ed,#f1f5ef);
}

.header{
background:linear-gradient(90deg,#1f9bbf,#5cc6d0);
padding:15px;
text-align:center;
font-size:28px;
font-weight:bold;
color:white;
}

.frame{
width:600px;
margin:80px auto;
background:white;
padding:30px;
border-radius:12px;
box-shadow:0 8px 20px rgba(0,0,0,0.2);
}

table{
width:100%;
border-collapse:collapse;
}

td,th{
padding:10px;
border-bottom:1px solid #ddd;
}

th{
text-align:left;
color:#1f9bbf;
}

button{
margin-top:20px;
padding:10px 20px;
background:#1f9bbf;
color:white;
border:none;
border-radius:8px;
cursor:pointer;
}

</style>

</head>

<body>

<div class="header">
Patient Vitals
</div>

<div class="frame">

<table>

<%

if(rs.next()){

%>

<tr>
<th>Patient Name</th>
<td><%=rs.getString("patient_name")%></td>
</tr>

<tr>
<th>Heart Rate</th>
<td><%=rs.getInt("heart_rate")%></td>
</tr>

<tr>
<th>Blood Pressure</th>
<td><%=rs.getString("blood_pressure")%></td>
</tr>

<tr>
<th>Temperature</th>
<td><%=rs.getFloat("temperature")%></td>
</tr>

<tr>
<th>Respiratory Rate</th>
<td><%=rs.getInt("respiratory_rate")%></td>
</tr>

<tr>
<th>Oxygen Saturation</th>
<td><%=rs.getInt("oxygen_saturation")%></td>
</tr>

<tr>
<th>Date</th>
<td><%=rs.getDate("vital_date")%></td>
</tr>

<tr>
<th>Time</th>
<td><%=rs.getTime("vital_time")%></td>
</tr>

<%
}
%>

</table>

<form action="appointments.jsp">
<button>Back</button>
</form>

</div>

</body>
</html>