<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
String alertMsg = "";
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Prescription</title>

<style>
body{
    font-family: Arial;
    background:#f4f7fa;
    margin:0;
}

.box{
    width:420px;
    margin:auto;
    margin-top:60px;
    background:white;
    padding:20px;
    border-radius:10px;
    box-shadow:0 0 10px #ccc;
}

input, textarea{
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
    border-radius:5px;
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
</style>
</head>

<body>

<a class="back" href="doctor_dashboard.jsp">⬅ Back</a>

<div class="box">
<h2>Add Prescription</h2>

<%
if(request.getMethod().equalsIgnoreCase("POST")){

    try{
        int patient_id = Integer.parseInt(request.getParameter("patient_id"));
        int doctor_id = Integer.parseInt(request.getParameter("doctor_id")); // ✅ NEW
        String medicines = request.getParameter("medicines");
        String notes = request.getParameter("notes");

        Class.forName("com.mysql.cj.jdbc.Driver");

        Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:300/healthlink2035","root","manager");

        PreparedStatement ps = con.prepareStatement(
        "INSERT INTO prescriptions(patient_id,doctor_id,medicines,notes) VALUES(?,?,?,?)");

        ps.setInt(1, patient_id);
        ps.setInt(2, doctor_id); // ✅ using input
        ps.setString(3, medicines);
        ps.setString(4, notes);

        int i = ps.executeUpdate();

        if(i > 0){
            alertMsg = "success";
        }else{
            alertMsg = "fail";
        }

    }catch(Exception e){
        alertMsg = "error";
    }
}
%>

<form method="post">

<input type="number" name="patient_id" placeholder="Patient ID" required>

<!-- ✅ NEW FIELD -->
<input type="number" name="doctor_id" placeholder="Doctor ID" required>

<textarea name="medicines" placeholder="Medicines" required></textarea>

<textarea name="notes" placeholder="Notes"></textarea>

<button type="submit">Add Prescription</button>

</form>

</div>

<!-- ✅ ALERT SCRIPT -->
<script>
let msg = "<%= alertMsg %>";

if(msg === "success"){
    alert("✅ Prescription Added Successfully!");
}
else if(msg === "fail"){
    alert("❌ Failed to Add Prescription");
}
else if(msg === "error"){
    alert("⚠ Error occurred");
}
</script>

</body>
</html>