<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    // Get the last inserted ID from query param
    String lastIdParam = request.getParameter("last_id");
    int lastId = 0;
    if(lastIdParam != null && !lastIdParam.isEmpty()){
        lastId = Integer.parseInt(lastIdParam);
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Recently Added Salary</title>
<style>
body { font-family: Arial; background:#f4f7fa; margin:0; padding:0; }
.container { width: 50%; margin:50px auto; background:white; padding:20px; border-radius:10px; box-shadow:0 0 10px #ccc; text-align:center;}
h2 { color:#0f8fbf; margin-bottom:20px; }
.info { font-size:18px; margin:10px 0; }
.back-btn, .home-btn {
    margin:10px 5px;
    padding:8px 15px;
    border:none;
    border-radius:5px;
    cursor:pointer;
    color:white;
}
.back-btn { background:#0f8fbf; }
.back-btn:hover { background:#0c6f95; }
.home-btn { background:#28a745; }
.home-btn:hover { background:#1e7e34; }
</style>
</head>

<body>
<div class="container">
    <h2>Recently Added Salary</h2>

<%
    if(lastId > 0){
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:300/healthlink2035", "root", "manager"
            );

            ps = con.prepareStatement(
                "SELECT ds.amount, dr.name " +
                "FROM doctor_salary ds " +
                "LEFT JOIN doctor_register dr ON ds.doctor_email = dr.email " +
                "WHERE ds.id=?"
            );
            ps.setInt(1, lastId);
            rs = ps.executeQuery();

            if(rs.next()){
%>
    <div class="info"><strong>Doctor Name:</strong> <%= rs.getString("name") %></div>
    <div class="info"><strong>Salary:</strong> ₹ <%= rs.getDouble("amount") %></div>
<%
            } else {
%>
    <div class="info" style="color:red;">No Salary Record Found</div>
<%
            }

            rs.close(); ps.close(); con.close();

        }catch(Exception e){
%>
    <div class="info" style="color:red;">Error: <%= e.getMessage() %></div>
<%
        }

    } else {
%>
    <div class="info" style="color:red;">No Salary Record Selected</div>
<%
    }
%>

    <button class="back-btn" onclick="history.back()">⬅ Back</button>
    <button class="home-btn" onclick="window.location.href='admin_dashboard.jsp'">🏠 Go Home</button>

</div>
</body>
</html>