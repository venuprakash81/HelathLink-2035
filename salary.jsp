<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
String doctorEmail = (String) session.getAttribute("email");

if (doctorEmail == null) {
    response.sendRedirect("login.jsp");
    return;
}

String doctorName = "";
String doctorId = "";
String profileImage = "default.png";

Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

boolean hasData = false;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");

    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:300/healthlink2035",
        "root",
        "manager"
    );

    ps = con.prepareStatement(
        "SELECT doctor_id, name, profile_image FROM doctor_register WHERE email=?"
    );

    ps.setString(1, doctorEmail);
    rs = ps.executeQuery();

    if (rs.next()) {
        doctorId = rs.getString("doctor_id");
        doctorName = rs.getString("name");

        String img = rs.getString("profile_image");

        if (img != null && !img.trim().isEmpty()) {
            profileImage = img.trim();

            // remove wrong prefixes
            profileImage = profileImage.replace("uploads/", "");
            profileImage = profileImage.replace("/uploads/", "");
        }
    }

    rs.close();
    ps.close();

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Salary</title>

<style>
body { font-family: Arial; margin: 0; background: #f0f2f5; }

.header {
    background: #0f8fbf;
    color: white;
    padding: 15px 30px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.profile {
    display: flex;
    align-items: center;
    gap: 10px;
}

.profile img {
    width: 45px;
    height: 45px;
    border-radius: 50%;
    object-fit: cover;
    border: 2px solid white;
}

.back-btn {
    background: #0f8fbf;
    color: white;
    margin: 20px;
    padding: 8px 15px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

.container {
    width: 95%;
    margin: 20px auto;
    background: white;
    padding: 20px;
    border-radius: 10px;
}

table {
    width: 100%;
    border-collapse: collapse;
}

th, td {
    padding: 12px;
    border-bottom: 1px solid #ccc;
    text-align: center;
}

th {
    background: #e0f0ff;
}

.no-data {
    text-align: center;
    color: #888;
    font-size: 20px;
    padding: 20px;
}
</style>

</head>

<body>

<!-- HEADER -->
<div class="header">

    <div class="profile">

        <!-- ✅ FIXED IMAGE PATH -->
        <img src="<%= request.getContextPath() + "/uploads/" + profileImage %>" 
             onerror="this.src='<%=request.getContextPath()%>/uploads/default.png'">

        <h3>Dr. <%= doctorName %> (ID: <%= doctorId %>)</h3>
    </div>

    <form method="post" action="logout.jsp">
        <button style="background:red;color:white;padding:8px 12px;border:none;border-radius:5px;">
            Logout
        </button>
    </form>

</div>

<!-- BACK -->
<form action="doctor_dashboard.jsp">
    <button class="back-btn">⬅ Back</button>
</form>

<div class="container">

<h2 style="text-align:center;">Month-wise Salary</h2>

<table>

<tr>
    <th>Month</th>
    <th>Year</th>
    <th>Salary (₹)</th>
</tr>

<%
    ps = con.prepareStatement(
        "SELECT month, year, amount FROM doctor_salary WHERE doctor_email=? " +
        "ORDER BY year DESC, month DESC"
    );

    ps.setString(1, doctorEmail);
    rs = ps.executeQuery();

    while (rs.next()) {
        hasData = true;
%>

<tr>
    <td><%= rs.getString("month") %></td>
    <td><%= rs.getInt("year") %></td>
    <td>₹ <%= rs.getDouble("amount") %></td>
</tr>

<%
    }

    if (!hasData) {
%>

<tr>
    <td colspan="3" class="no-data">
        💰 No Salary Records Found
    </td>
</tr>

<%
    }

} catch (Exception e) {
%>

<tr>
    <td colspan="3" style="color:red;">
        Error: <%= e.getMessage() %>
    </td>
</tr>

<%
} finally {
    try { if (rs != null) rs.close(); } catch(Exception e){}
    try { if (ps != null) ps.close(); } catch(Exception e){}
    try { if (con != null) con.close(); } catch(Exception e){}
}
%>

</table>

</div>

</body>
</html>