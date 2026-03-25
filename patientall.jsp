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
<title>Patients</title>

<style>
body {
    margin:0;
    font-family:'Segoe UI';
    background:#f4f7fa;
}

/* Header */
.header {
    background:#0f8fbf;
    color:white;
    padding:15px 30px;
    display:flex;
    justify-content:space-between;
}

/* Container */
.container {
    width:95%;
    margin:20px auto;
    background:white;
    padding:20px;
    border-radius:10px;
}

/* Table */
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

/* Buttons */
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
</style>

</head>

<body>

<!-- Header -->
<div class="header">
    <h2>All Patients</h2>
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
    <th>Full Name</th>
    <th>Username</th>
    <th>Email</th>
    <th>Contact</th>
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
            "SELECT * FROM patient_register ORDER BY id DESC"
        );

        boolean hasData = false;

        while(rs.next()){
            hasData = true;
%>

<tr>
<td><%= rs.getInt("id") %></td>
<td><%= rs.getString("fullname") %></td>
<td><%= rs.getString("username") %></td>
<td><%= rs.getString("email") %></td>
<td><%= rs.getString("contact") %></td>

<td>
    <form method="post" action="delete_patient.jsp"
          onsubmit="return confirm('Delete this patient?');">
        <input type="hidden" name="id"
               value="<%= rs.getInt("id") %>">
        <button class="delete-btn">Delete</button>
    </form>
</td>

</tr>

<%
        }

        if(!hasData){
%>
<tr>
<td colspan="6" class="no-data">📭 No Patients Found</td>
</tr>
<%
        }

        con.close();

    } catch(Exception e){
%>
<tr>
<td colspan="6" style="color:red;">
    Error: <%= e.getMessage() %>
</td>
</tr>
<%
    }
%>

</table>

</div>

</body>
</html>