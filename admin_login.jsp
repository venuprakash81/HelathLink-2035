<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    String errorMsg = "";

    if(request.getParameter("login") != null){

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:300/healthlink2035",
                "root",
                "manager"
            );

            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM admin WHERE email=? AND password=?"
            );

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if(rs.next()){
                session.setAttribute("adminEmail", email);
%>
                <script>
                    alert("Login Successful!");
                    window.location="admin_dashboard.jsp";
                </script>
<%
            } else {
                errorMsg = "Invalid Email or Password!";
            }

            rs.close();
            ps.close();
            con.close();

        } catch(Exception e){
            errorMsg = "Database Error!";
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Login</title>

<style>
body {
    margin: 0;
    font-family: 'Segoe UI', sans-serif;
    background: #f2f2f2;
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
}

.main-container {
    width: 1000px;
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.left-image {
    width: 500px;
}

.left-image img {
    width: 100%;
    border-radius: 20px;
}

.login-card {
    width: 400px;
    background: white;
    padding: 40px;
    border-radius: 8px;
}

.title {
    text-align: center;
    font-size: 28px;
    font-weight: bold;
    color: #2b4a8b;
}

.subtitle {
    text-align: center;
    margin-bottom: 20px;
    font-weight: bold;
}

input {
    width: 100%;
    padding: 12px;
    margin-bottom: 15px;
}

.login-btn {
    background: #3b57c4;
    color: white;
    border: none;
    cursor: pointer;
}

.errorMsg {
    color: red;
    text-align: center;
    margin-bottom: 10px;
}
</style>

</head>

<body>

<div class="main-container">

    <!-- IMAGE -->
    <div class="left-image">
        <img src="https://www.shutterstock.com/image-vector/3d-cartoon-hand-hold-medicine-600nw-2260462149.jpg">
    </div>

    <!-- LOGIN -->
    <div class="login-card">

        <div class="title">HealthLink</div>
        <div class="subtitle">LOGIN</div>

        <% if (!errorMsg.isEmpty()) { %>
            <div class="errorMsg"><%= errorMsg %></div>
        <% } %>

        <form method="post">
            <label>Email</label>
            <input type="text" name="email" required>

            <label>Password</label>
            <input type="password" name="password" required>

            <!-- IMPORTANT -->
            <input type="submit" name="login" value="Sign in" class="login-btn">
        </form>

        <div class="register-link">
            I don't have an account?
            <a href="admin_register.jsp">Register Here</a>
        </div>

    </div>

</div>

</body>
</html>