<%@ page import="java.sql.*" %>

<%

Connection conn=null;
Statement st=null;
ResultSet rs=null;

try{

Class.forName("com.mysql.cj.jdbc.Driver");

conn=DriverManager.getConnection(
"jdbc:mysql://localhost:300/healthlink2035",
"root",
"manager");

st=conn.createStatement();

rs=st.executeQuery("SELECT * FROM patient_register");

}catch(Exception e){
out.println(e);
}

%>

<!DOCTYPE html>
<html>
<head>

<title>Patient Records</title>

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
width:95%;
margin:60px auto;
background:white;
padding:30px;
border-radius:12px;
box-shadow:0 8px 20px rgba(0,0,0,0.2);
}

table{
width:100%;
border-collapse:collapse;
}

th,td{
padding:10px;
border-bottom:1px solid #ddd;
text-align:center;
}

th{
background:#1f9bbf;
color:white;
}

tr:hover{
background:#f5f5f5;
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

button:hover{
background:#157a91;
}

</style>

</head>

<body>

<div class="header">
HEALTHLINK 2035
</div>

<div class="frame">

<h2>Patient Records</h2>

<p>Access patient medical history and details.</p>

<table>

<tr>

<th>ID</th>
<th>Full Name</th>
<th>DOB</th>
<th>Gender</th>
<th>Blood Group</th>
<th>Contact</th>
<th>Email</th>
<th>Address</th>
<th>Emergency Contact</th>

</tr>

<%

while(rs.next()){

%>

<tr>

<td><%=rs.getInt("id")%></td>

<td><%=rs.getString("fullname")%></td>

<td><%=rs.getDate("dob")%></td>

<td><%=rs.getString("gender")%></td>

<td><%=rs.getString("blood_group")%></td>

<td><%=rs.getString("contact")%></td>

<td><%=rs.getString("email")%></td>

<td><%=rs.getString("address")%></td>

<td><%=rs.getString("emergency_contact")%></td>

</tr>

<%

}

%>

</table>

<br>

<form action="doctor_dashboard.jsp">

<button type="submit">
Back
</button>

</form>

</div>

</body>
</html>