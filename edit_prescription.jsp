<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
String doctorEmail = (String) session.getAttribute("email");

if(doctorEmail == null){
    response.sendRedirect("login.jsp");
    return;
}

int id = Integer.parseInt(request.getParameter("id"));

int doctorId = 0;
int patientId = 0;
String medicines = "";
String notes = "";
%>

<%
Class.forName("com.mysql.cj.jdbc.Driver");

Connection con = DriverManager.getConnection(
    "jdbc:mysql://localhost:300/healthlink2035",
    "root",
    "manager"
);

// GET doctor_id
PreparedStatement ps0 = con.prepareStatement(
    "SELECT doctor_id FROM doctor_register WHERE email=?"
);
ps0.setString(1, doctorEmail);
ResultSet rs0 = ps0.executeQuery();

if(rs0.next()){
    doctorId = rs0.getInt("doctor_id");
}

// GET PRESCRIPTION (SECURITY CHECK)
PreparedStatement ps = con.prepareStatement(
    "SELECT * FROM prescriptions WHERE prescription_id=? AND doctor_id=?"
);
ps.setInt(1, id);
ps.setInt(2, doctorId);

ResultSet rs = ps.executeQuery();

if(rs.next()){
    patientId = rs.getInt("patient_id");
    medicines = rs.getString("medicines");
    notes = rs.getString("notes");
} else {
%>
<script>
alert("Unauthorized access!");
window.location="doctor_my_prescriptions.jsp";
</script>
<%
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Edit Prescription</title>

<style>
body{font-family:Arial;background:#f4f7fa;}

.box{
    width:400px;
    margin:auto;
    margin-top:60px;
    background:white;
    padding:20px;
    border-radius:10px;
}

input,textarea{
    width:100%;
    padding:10px;
    margin:8px 0;
}

button{
    width:100%;
    padding:10px;
    background:#1f3c88;
    color:white;
    border:none;
}
</style>
</head>

<body>

<div class="box">

<h2>Edit Prescription</h2>

<form method="post">

<input type="hidden" name="id" value="<%= id %>">

Patient ID:
<input type="number" name="patient_id" value="<%= patientId %>" required>

Medicines:
<textarea name="medicines"><%= medicines %></textarea>

Notes:
<textarea name="notes"><%= notes %></textarea>

<button type="submit">Update</button>

</form>

</div>

</body>
</html>

<%
if("POST".equalsIgnoreCase(request.getMethod())){

    try{
        int pid = Integer.parseInt(request.getParameter("id"));
        int p = Integer.parseInt(request.getParameter("patient_id"));
        String med = request.getParameter("medicines");
        String nt = request.getParameter("notes");

        PreparedStatement ps2 = con.prepareStatement(
            "UPDATE prescriptions SET patient_id=?, medicines=?, notes=? " +
            "WHERE prescription_id=? AND doctor_id=?"
        );

        ps2.setInt(1, p);
        ps2.setString(2, med);
        ps2.setString(3, nt);
        ps2.setInt(4, pid);
        ps2.setInt(5, doctorId);

        int i = ps2.executeUpdate();

        if(i > 0){
%>
<script>
alert("Updated successfully");
window.location="dpre.jsp";
</script>
<%
        } else {
%>
<script>alert("Update failed");</script>
<%
        }

    }catch(Exception e){
%>
<script>alert("<%= e.getMessage() %>");</script>
<%
    }
}
%>