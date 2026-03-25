<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>HealthLink 2035 Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

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
            height: auto;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            object-fit: cover;
        }

        .login-card {
            width: 400px;
            background: white;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.15);
        }

        .title {
            text-align: center;
            font-size: 28px;
            font-weight: bold;
            color: #2b4a8b;
            margin-bottom: 10px;
        }

        .subtitle {
            text-align: center;
            margin-bottom: 25px;
            font-weight: bold;
        }

        label {
            font-weight: bold;
            font-size: 14px;
        }

        input[type=text], input[type=password] {
            width: 100%;
            padding: 12px;
            margin-top: 6px;
            margin-bottom: 18px;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 14px;
        }

        .login-btn {
            width: 100%;
            padding: 12px;
            background: #3b57c4;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
        }

        .login-btn:hover {
            background: #2c43a0;
        }

        .errorMsg {
            color: red;
            text-align: center;
            margin-bottom: 10px;
            font-weight: bold;
        }

        .register-link {
            display: block;
            text-align: center;
            margin-top: 15px;
        }
    </style>
</head>

<body>

<%
    String errorMsg = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if(email != null) email = email.trim();
        if(password != null) password = password.trim();

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:300/healthlink2035", // fix port & DB name
                    "root",
                    "manager"
            );

            String sql = "SELECT * FROM doctor_register WHERE email=? AND password=?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);

            rs = ps.executeQuery();

            if (rs.next()) {
                session.setAttribute("email", email);

                // Show alert and redirect
%>
<script type="text/javascript">
    alert('Login Successful!');
    window.location.href = 'doctor_dashboard.jsp';
</script>
<%
            } else {
                errorMsg = "Invalid Email or Password";
            }

        } catch (Exception e) {
            errorMsg = "Error: " + e.getMessage();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception ex) {}
            try { if (ps != null) ps.close(); } catch (Exception ex) {}
            try { if (conn != null) conn.close(); } catch (Exception ex) {}
        }
    }
%>

<div class="main-container">

    <!-- LEFT IMAGE -->
    <div class="left-image">
        <img src="https://media.cgtrader.com/variants/HDR3zdoFTo5D3G7GcB9XDNeq/78add9c2f02fbd73a43ffb3970be38683c5f15eff6ca849dc78c644f4ff9ce1b/Thumb3.webp" alt="HealthLink Image">
    </div>

    <!-- LOGIN CARD -->
    <div class="login-card">

        <div class="title">HealthLink</div>
        <div class="subtitle">LOGIN</div>

        <% if (!errorMsg.isEmpty()) { %>
            <div class="errorMsg"><%= errorMsg %></div>
        <% } %>

        <form method="post">
            <label>Email</label>
            <input type="text" name="email" placeholder="Enter Email" required>

            <label>Password</label>
            <input type="password" name="password" placeholder="Enter Password" required>

            <input type="submit" value="Sign in" class="login-btn">
        </form>

        <div class="register-link">
            I don't have an account? <a href="register.jsp">Register Here</a>
        </div>

    </div>
</div>

</body>
</html>