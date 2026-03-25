<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    String adminEmail = (String) session.getAttribute("adminEmail");

    if(adminEmail == null){
        response.sendRedirect("admin_login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reports</title>

<style>
body {
    margin:0;
    font-family:'Segoe UI';
    background:#f4f7fa;
}

.header {
    background:#0f8fbf;
    color:white;
    padding:15px 30px;
    display:flex;
    justify-content:space-between;
}

.container {
    width:95%;
    margin:20px auto;
    background:white;
    padding:20px;
    border-radius:10px;
}

table {
    width:100%;
    border-collapse:collapse;
}

th, td {
    padding:10px;
    border-bottom:1px solid #ccc;
    text-align:center;
}

th {
    background:#e0f0ff;
}

.report-img {
    width:60px;
    height:60px;
    object-fit:cover;
    border-radius:5px;
    cursor:pointer;
}

.back-btn {
    background:#0f8fbf;
    color:white;
    border:none;
    padding:10px 15px;
    margin:15px;
    cursor:pointer;
    border-radius:5px;
}

.logout-btn {
    background:red;
    color:white;
    border:none;
    padding:8px 12px;
    cursor:pointer;
    border-radius:5px;
}

.delete-btn {
    background:red;
    color:white;
    border:none;
    padding:6px 10px;
    border-radius:5px;
    cursor:pointer;
}

.no-data {
    text-align:center;
    color:#888;
}

/* Modal */
.modal {
    display: none;
    position: fixed;
    z-index: 999;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0,0,0,0.9);
}

.modal-content {
    display: block;
    margin: auto;
    margin-top: 50px;
    max-width: 90%;
    max-height: 90%;
    border-radius: 10px;
}

.close {
    position: absolute;
    top: 20px;
    right: 40px;
    color: white;
    font-size: 35px;
    cursor: pointer;
}
</style>

</head>

<body>

<!-- Header -->
<div class="header">
    <h2>All Reports</h2>
    <form action="logout.jsp">
        <button class="logout-btn">Logout</button>
    </form>
</div>

<!-- Back -->
<form action="admin_dashboard.jsp">
    <button class="back-btn">⬅ Back</button>
</form>

<div class="container">

<table>
<tr>
    <th>ID</th>
    <th>Doctor ID</th>
    <th>Doctor Name</th>
    <th>Patient Name</th>
    <th>Report Name</th>
    <th>Date</th>
    <th>Image</th>
    <th>Delete</th>
</tr>

<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");

        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:300/healthlink2035",
            "root",
            "manager"
        );

        Statement st = con.createStatement();

        ResultSet rs = st.executeQuery(
            "SELECT r.*, d.name FROM reports r " +
            "JOIN doctor_register d ON r.doctor_id = d.doctor_id " +
            "ORDER BY r.report_id DESC"
        );

        boolean hasData = false;

        while(rs.next()){
            hasData = true;

            String img = rs.getString("report_image");
            String imagePath = "uploads/default.png";

            if(img != null && !img.isEmpty()){
                imagePath = "uploads/" + img;
            }
%>

<tr>
<td><%= rs.getInt("report_id") %></td>
<td><%= rs.getInt("doctor_id") %></td>
<td><%= rs.getString("name") %></td>
<td><%= rs.getString("patient_name") %></td>
<td><%= rs.getString("report_name") %></td>
<td><%= rs.getDate("report_date") %></td>

<td>
    <img src="<%= imagePath %>" 
         class="report-img"
         onclick="openImage(this.src)">
</td>

<td>
    <form method="post" action="delete_report.jsp"
          onsubmit="return confirm('Delete this report?');">
        <input type="hidden" name="report_id"
               value="<%= rs.getInt("report_id") %>">
        <button class="delete-btn">Delete</button>
    </form>
</td>

</tr>

<%
        }

        if(!hasData){
%>
<tr>
<td colspan="8" class="no-data">📭 No Reports Found</td>
</tr>
<%
        }

        con.close();

    } catch(Exception e){
%>
<tr>
<td colspan="8" style="color:red;">
    Error: <%= e.getMessage() %>
</td>
</tr>
<%
    }
%>

</table>

</div>

<!-- FULL SCREEN MODAL -->
<div id="imageModal" class="modal">
    <span class="close" onclick="closeImage()">&times;</span>
    <img class="modal-content" id="fullImage">
</div>

<!-- JAVASCRIPT -->
<script>
function openImage(src) {
    document.getElementById("imageModal").style.display = "block";
    document.getElementById("fullImage").src = src;
}

function closeImage() {
    document.getElementById("imageModal").style.display = "none";
}
</script>

</body>
</html>