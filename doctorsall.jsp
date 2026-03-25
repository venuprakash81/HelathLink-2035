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
<title>Doctors</title>

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

.profile-img {
    width:50px;
    height:50px;
    border-radius:50%;
    object-fit:cover;
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
</style>

</head>

<body>

<div class="header">
    <h2>All Doctors</h2>
    <form action="logout.jsp">
        <button class="logout-btn">Logout</button>
    </form>
</div>

<form action="admin_dashboard.jsp">
    <button class="back-btn">⬅ Back</button>
</form>

<div class="container">

<table>
<tr>
    <th>ID</th>
    <th>Photo</th>
    <th>Name</th>
    <th>Email</th>
    <th>Phone</th>
    <th>Qualification</th>
    <th>Specialization</th>
    <th>Experience</th>
    <th>Hospital</th>
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
        "SELECT * FROM doctor_register ORDER BY doctor_id DESC"
    );

    boolean hasData = false;

    while(rs.next()){
        hasData = true;

        String img = rs.getString("profile_image");

        // ✅ FIXED IMAGE PATH FOR PORT 300
        String imagePath = request.getContextPath() + "/uploads/default.png";

        if(img != null && !img.trim().isEmpty()){

            img = img.trim();

            if(img.startsWith("uploads/")){
                img = img.substring(8);
            }
            if(img.startsWith("/uploads/")){
                img = img.substring(9);
            }

            imagePath = request.getContextPath() + "/uploads/" + img;
        }
%>

<tr>
<td><%= rs.getInt("doctor_id") %></td>

<td>
    <img src="<%= imagePath %>" 
         onerror="this.src='<%=request.getContextPath()%>/uploads/default.png'" 
         class="profile-img">
</td>

<td><%= rs.getString("name") %></td>
<td><%= rs.getString("email") %></td>
<td><%= rs.getString("phone") %></td>
<td><%= rs.getString("qualification") %></td>
<td><%= rs.getString("specialization") %></td>
<td><%= rs.getInt("experience") %> yrs</td>
<td><%= rs.getString("hospital") %></td>

<td>
    <form method="post" action="delete_doctor.jsp"
          onsubmit="return confirm('Delete this doctor?');">
        <input type="hidden" name="doctor_id"
               value="<%= rs.getInt("doctor_id") %>">
        <button class="delete-btn">Delete</button>
    </form>
</td>

</tr>

<%
    }

    if(!hasData){
%>
<tr>
<td colspan="10" class="no-data">📭 No Doctors Found</td>
</tr>
<%
    }

    con.close();

} catch(Exception e){
%>
<tr>
<td colspan="10" style="color:red;">
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