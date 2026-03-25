<%@ page import="java.sql.*" %>

<%
String errorMsg="";
boolean invalid=false;

if(request.getMethod().equalsIgnoreCase("POST")){

try{

Class.forName("com.mysql.cj.jdbc.Driver");

Connection conn=DriverManager.getConnection(
"jdbc:mysql://localhost:300/healthlink2035",
"root",
"manager");

/* Get form values */

int appointmentId=Integer.parseInt(request.getParameter("appointment_id"));
String patientName=request.getParameter("patient_name");

/* Check if appointment exists */

PreparedStatement check=conn.prepareStatement(
"SELECT * FROM appointment_scheduling WHERE appointment_id=? AND patient_name=?");

check.setInt(1,appointmentId);
check.setString(2,patientName);

ResultSet rs=check.executeQuery();

if(rs.next()){

/* Insert vitals */

PreparedStatement ps=conn.prepareStatement(
"INSERT INTO vital_entry (appointment_id,patient_name,heart_rate,blood_pressure,temperature,respiratory_rate,oxygen_saturation,vital_date,vital_time) VALUES (?,?,?,?,?,?,?,CURDATE(),CURTIME())");

ps.setInt(1,appointmentId);
ps.setString(2,patientName);
ps.setInt(3,Integer.parseInt(request.getParameter("heart_rate")));
ps.setString(4,request.getParameter("blood_pressure"));
ps.setFloat(5,Float.parseFloat(request.getParameter("temperature")));
ps.setInt(6,Integer.parseInt(request.getParameter("respiratory_rate")));
ps.setInt(7,Integer.parseInt(request.getParameter("oxygen_saturation")));

int result=ps.executeUpdate();

if(result>0){
response.sendRedirect("vitals2.jsp");
}else{
errorMsg="Vitals not saved";
invalid=true;
}

}else{

errorMsg="Enter correct Appointment ID and Patient Name";
invalid=true;

}

conn.close();

}catch(Exception e){
errorMsg="Error : "+e.getMessage();
invalid=true;
}

}
%>

<!DOCTYPE html>
<html>
<head>

<title>Vitals Entry</title>

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
width:500px;
margin:60px auto;
background:white;
padding:30px;
border-radius:12px;
box-shadow:0 8px 20px rgba(0,0,0,0.2);
}

.frame h3{
color:#1f9bbf;
}

input{
width:100%;
padding:10px;
margin-top:8px;
border-radius:8px;
border:1px solid #ccc;
}

button{
width:100%;
padding:12px;
margin-top:20px;
background:#1f9bbf;
color:white;
border:none;
border-radius:8px;
cursor:pointer;
}

button:hover{
background:#157a91;
}

/* Red error box */

.error-box{
border:2px solid red;
background:#ffe6e6;
}

/* Error message */

.field-error{
color:red;
font-size:14px;
margin-top:5px;
}

</style>

</head>

<body>

<div class="header">
HEALTHLINK 2035 - Vitals Entry
</div>

<div class="frame">

<form method="post">

<h3>Appointment ID</h3>
<input type="number" name="appointment_id"
class="<%= invalid ? "error-box" : "" %>" required>

<h3>Patient Name</h3>
<input type="text" name="patient_name"
class="<%= invalid ? "error-box" : "" %>" required>

<% if(invalid){ %>
<div class="field-error"><%=errorMsg%></div>
<% } %>

<h3>Heart Rate (bpm)</h3>
<input type="number" name="heart_rate" required>

<h3>Blood Pressure (mmHg)</h3>
<input type="text" name="blood_pressure" required>

<h3>Temperature (°C)</h3>
<input type="text" name="temperature" required>

<h3>Respiratory Rate</h3>
<input type="number" name="respiratory_rate" required>

<h3>Oxygen Saturation (%)</h3>
<input type="number" name="oxygen_saturation" required>

<button type="submit">
Submit Vitals
</button>

</form>

</div>

</body>
</html>