<%@ page import="java.sql.*, java.text.SimpleDateFormat, java.util.Date" %>

<%
String doctorId = request.getParameter("doctor_id");

String todayDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
String currentTime = new SimpleDateFormat("HH:mm").format(new Date());

String doctorName = "";

Connection con = null;
int appointmentId = 0;

try {

    Class.forName("com.mysql.cj.jdbc.Driver");

    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:300/healthlink2035",
        "root",
        "manager"
    );

    // GET DOCTOR NAME
    if(doctorId != null){
        PreparedStatement ps = con.prepareStatement(
            "SELECT name FROM doctor_register WHERE doctor_id=?"
        );

        ps.setInt(1, Integer.parseInt(doctorId));
        ResultSet rs = ps.executeQuery();

        if(rs.next()){
            doctorName = rs.getString("name");
        }
    }

} catch(Exception e){
    out.println(e.getMessage());
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Book Appointment</title>

<style>
body{
    font-family: Arial;
    background:#eef3f9;
}

.container{
    width:420px;
    margin:40px auto;
    background:white;
    padding:20px;
    border-radius:10px;
    box-shadow:0 0 10px rgba(0,0,0,0.1);
}
.cancel{
    background:#e3dfdf;
    color:rgb(33, 30, 30);
    padding:10px;
    border:none;
    border-radius:6px;
    cursor:pointer;
}
.cancel:hover{
    background:#c0392b;
}

input,select{
    width:100%;
    padding:10px;
    margin:8px 0;
}

button{
    width:100%;
    padding:10px;
    border:none;
    border-radius:6px;
    cursor:pointer;
}

.book{
    background:#1f3c88;
    color:white;
}
</style>
</head>

<body>

<div class="container">

<h2>Book Appointment</h2>

<form method="post">

<input type="hidden" name="doctor_id" value="<%= doctorId %>">

<label>Doctor</label>
<input type="text" value="Dr. <%= doctorName %>" readonly>

<label>Patient Name</label>
<input type="text" name="patient_name" required>

<label>Date</label>
<input type="date" name="date" value="<%= todayDate %>" required>

<label>Time</label>
<input type="time" name="time" value="<%= currentTime %>" required>

<label>Reason</label>
<select name="reason" required>
    <option value="">-- Select Reason --</option>
    <option>General Checkup</option>
    <option>Fever</option>
    <option>Cold</option>
    <option>Injury</option>
    <option>Follow-up</option>
</select>

<button type="submit" name="book" class="book">Book Appointment</button>
<button type="button" class="cancel" onclick="history.back()">
    Cancel
</button>
</form>

<%
if(request.getParameter("book") != null){

    PreparedStatement ps = con.prepareStatement(
        "INSERT INTO appointment_scheduling " +
        "(patient_id, doctor_id, appointment_date, appointment_time, reason, status, patient_name) " +
        "VALUES (?,?,?,?,?,?,?)",
        Statement.RETURN_GENERATED_KEYS
    );

    ps.setNull(1, Types.INTEGER);
    ps.setInt(2, Integer.parseInt(doctorId));
    ps.setString(3, request.getParameter("date"));
    ps.setString(4, request.getParameter("time"));
    ps.setString(5, request.getParameter("reason"));
    ps.setString(6, "Pending");
    ps.setString(7, request.getParameter("patient_name"));

    ps.executeUpdate();

    ResultSet rs = ps.getGeneratedKeys();

    if(rs.next()){
        appointmentId = rs.getInt(1);
    }

    con.close();
%>

<script>
alert("Appointment Booked Successfully!");
window.location="appointment2.jsp?appointment_id=<%= appointmentId %>";
</script>

<%
}
%>

</div>

</body>
</html>