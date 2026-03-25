<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
String errorMessage="";

if(request.getMethod().equalsIgnoreCase("POST")){

    String username=request.getParameter("username");
    String password=request.getParameter("password");

    Connection conn=null;
    PreparedStatement ps=null;
    ResultSet rs=null;

    try{
        Class.forName("com.mysql.cj.jdbc.Driver");

        conn=DriverManager.getConnection(
            "jdbc:mysql://localhost:300/healthlink2035",
            "root",
            "manager"
        );

        String sql="SELECT * FROM patient_register WHERE username=? AND password=?";
        ps=conn.prepareStatement(sql);

        ps.setString(1,username);
        ps.setString(2,password);

        rs=ps.executeQuery();

        if(rs.next()){
            // Set session attribute
            session.setAttribute("patientName", rs.getString("fullname"));
            session.setAttribute("patientUsername", username);

            // Redirect to dashboard
            response.sendRedirect("patient_dashboard.jsp");
        } else {
            errorMessage="Invalid Username or Password";
        }

    } catch(Exception e){
        errorMessage="Database Error: "+e.getMessage();
    } finally {
        try{ if(rs!=null) rs.close(); } catch(Exception e){}
        try{ if(ps!=null) ps.close(); } catch(Exception e){}
        try{ if(conn!=null) conn.close(); } catch(Exception e){}
    }
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Patient Login</title>
<style>
body { margin:0; font-family:Arial; background:#f3f4f6; }
.container{ display:flex; height:100vh; }
.left{ flex:1; display:flex; justify-content:center; align-items:center; background:#eef2f7; }
.left img{ width:380px; height:380px; border-radius:50%; object-fit:cover; box-shadow:0 10px 30px rgba(0,0,0,0.2); }
.right{ flex:1; display:flex; justify-content:center; align-items:center; }
.login-box{ background:white; padding:40px; width:400px; border-radius:8px; box-shadow:0 4px 20px rgba(0,0,0,0.1); }
.login-box h2{ text-align:center; margin-bottom:30px; }
input{ width:100%; padding:12px; margin:10px 0; border-radius:6px; border:1px solid #ccc; font-size:14px; }
button{ width:100%; padding:12px; margin-top:10px; background:#3b5ccc; color:white; border:none; border-radius:6px; font-size:16px; cursor:pointer; }
button:hover{ background:#2f4db3; }
.error{ color:red; text-align:center; margin-bottom:10px; }
.register-link{ text-align:center; margin-top:15px; }
.register-link a{ color:#3b5ccc; text-decoration:none; }
</style>
</head>
<body>

<div class="container">
<div class="left">
<img src="https://thumbs.dreamstime.com/b/happy-family-portrait-featuring-mother-father-their-two-young-sons-happy-family-portrait-featuring-mother-father-their-356045248.jpg" alt="Healthcare Illustration">
</div>

<div class="right">
<div class="login-box">
<h2>Patient Login</h2>
<% if(!errorMessage.equals("")){ %>
<div class="error"><%= errorMessage %></div>
<% } %>

<form method="post">
<input type="text" name="username" placeholder="Enter Username" required>
<input type="password" name="password" placeholder="Enter Password" required>
<button type="submit">Sign In</button>
</form>

<div class="register-link">
New Patient? <a href="PatientRegistration.jsp">Register Here</a>
</div>
</div>
</div>
</div>

</body>
</html>