<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    String patientEmail = (String) session.getAttribute("email");

    if (patientEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String patientName = "";
    int patientId = 0;

    boolean hasData = false;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");

        con = DriverManager.getConnection(
            "jdbc:mysql://localhost:300/healthlink2035",
            "root",
            "manager"
        );

        // ✅ STEP 1: GET LOGGED PATIENT ID
        ps = con.prepareStatement(
            "SELECT id, fullname FROM patient_register WHERE email=?"
        );
        ps.setString(1, patientEmail);
        rs = ps.executeQuery();

        if (rs.next()) {
            patientId = rs.getInt("id");
            patientName = rs.getString("fullname");
        }

        rs.close();
        ps.close();

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Reports</title>

<style>
body {
    font-family: Arial;
    background: #f4f7fa;
}

h2 {
    text-align: center;
    color: #0f8fbf;
}

.container {
    width: 90%;
    margin: auto;
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 20px;
}

.card {
    background: white;
    padding: 15px;
    border-radius: 10px;
    text-align: center;
    box-shadow: 0 0 10px #ccc;
}

.card img {
    width: 200px;
    height: 200px;
    object-fit: cover;
    border-radius: 10px;
    cursor: pointer;
}

.no-data {
    text-align: center;
    color: gray;
    font-size: 18px;
}
</style>
</head>

<body>

<h2>Welcome, <%= patientName %></h2>

<div class="container">

<%

        // ❗ IMPORTANT FIX:
        // Handle NULL patient_id properly
        ps = con.prepareStatement(
            "SELECT report_name, report_image, report_date " +
            "FROM reports " +
            "WHERE patient_id=?"
        );

        ps.setInt(1, patientId);

        rs = ps.executeQuery();

        while (rs.next()) {
            hasData = true;
%>

    <div class="card">
        <img src="uploads/<%= rs.getString("report_image") %>"
             onclick="openImage(this.src)"
             onerror="this.src='uploads/default.png'">

        <h3><%= rs.getString("report_name") %></h3>
        <p><%= rs.getString("report_date") %></p>

        <a href="uploads/<%= rs.getString("report_image") %>" download>Download</a>
    </div>

<%
        }

        if (!hasData) {
%>

    <div class="no-data">No reports found for you</div>

<%
        }

        rs.close();
        ps.close();
        con.close();

    } catch (Exception e) {
%>

<div style="color:red;text-align:center;">
    Error: <%= e.getMessage() %>
</div>

<%
    }
%>

</div>

<!-- IMAGE POPUP -->
<div id="modal"
     style="display:none;position:fixed;top:0;left:0;width:100%;height:100%;background:black;">
    <img id="fullImg"
         style="display:block;margin:auto;max-width:90%;max-height:90%;">
</div>

<script>
function openImage(src){
    document.getElementById("modal").style.display="block";
    document.getElementById("fullImg").src=src;
}

document.getElementById("modal").onclick=function(){
    this.style.display="none";
}
</script>

</body>
</html>