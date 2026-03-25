<%@ page import="java.sql.*" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    // ✅ CURRENT DATE ONLY
    String currentDate = LocalDate.now()
        .format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(
            "jdbc:mysql://localhost:300/healthlink2035", "root", "manager");

        ps = con.prepareStatement("SELECT id, fullname FROM patient_register");
        rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Report Entry</title>

<style>
body {
    font-family: Arial;
    background: #f4f7fa;
}

.container {
    width: 420px;
    margin: 60px auto;
    background: white;
    padding: 25px;
    border-radius: 10px;
    box-shadow: 0 0 10px #ccc;
}

h2 {
    text-align: center;
    color: #0f8fbf;
}

label {
    font-weight: bold;
}

input, select {
    width: 100%;
    padding: 10px;
    margin: 8px 0 15px;
    border: 1px solid #ccc;
    border-radius: 6px;
}

button {
    width: 100%;
    padding: 12px;
    background: #0f8fbf;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
}

button:hover {
    background: #0c6e94;
}

.date-box {
    font-weight: bold;
    text-align: center;
    color: green;
    margin-bottom: 10px;
}
</style>

</head>

<body>

<div class="container">

<h2>Upload Report</h2>

<!-- ✅ CURRENT DATE DISPLAY -->
<div class="date-box">
  
</div>

<form action="ReportEntryServlet" method="post" enctype="multipart/form-data">

    <!-- Doctor ID -->
    <label>Doctor ID</label>
    <input type="number" name="doctor_id" required>

    <!-- Patient ID -->
    <label>Select Patient ID</label>
    <select name="patient_id" required>
        <option value="">-- Select Patient --</option>

        <%
            while(rs.next()){
                int id = rs.getInt("id");
                String name = rs.getString("fullname");
        %>

        <option value="<%= id %>">
            <%= id %> - <%= name %>
        </option>

        <%
            }
        %>

    </select>

    <!-- Report Name -->
    <label>Report Name</label>
    <input type="text" name="report_name" required>

    <!-- ✅ AUTO DATE INPUT (ONLY DATE) -->
    <label>Report Date</label>
    <input type="text" name="report_date" value="<%= currentDate %>" readonly><%= currentDate %>

    <!-- Image -->
    <label>Upload Report Image</label>
    <input type="file" name="report_image" required>

    <button type="submit">Submit Report</button>

</form>

</div>

</body>
</html>

<%
    } catch(Exception e){
%>

<div style="color:red;text-align:center;">
    Error: <%= e.getMessage() %>
</div>

<%
    } finally {
        try { if(rs!=null) rs.close(); } catch(Exception e){}
        try { if(ps!=null) ps.close(); } catch(Exception e){}
        try { if(con!=null) con.close(); } catch(Exception e){}
    }
%>