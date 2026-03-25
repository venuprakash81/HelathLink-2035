<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Patient Registration</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f0f4f8;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            background: #fff;
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
            width: 400px;
        }
        h2 {
            text-align: center;
            color: #333;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        label {
            margin-top: 10px;
            margin-bottom: 5px;
            color: #555;
            font-weight: bold;
        }
        input[type="text"], input[type="password"], input[type="email"] {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
        }
        .password-container {
            position: relative;
        }
        .toggle-password {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            font-size: 12px;
            color: #007bff;
            user-select: none;
        }
        input[type="submit"] {
            margin-top: 20px;
            padding: 12px;
            background: #007bff;
            color: #fff;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            transition: 0.3s;
        }
        input[type="submit"]:hover {
            background: #0056b3;
        }
        .message {
            margin-top: 15px;
            text-align: center;
            font-weight: bold;
        }
        .success { color: green; }
        .error { color: red; }
    </style>
    <script>
        function togglePassword(id, toggleId) {
            var pwd = document.getElementById(id);
            var toggle = document.getElementById(toggleId);
            if(pwd.type === "password") {
                pwd.type = "text";
                toggle.innerText = "Hide";
            } else {
                pwd.type = "password";
                toggle.innerText = "Show";
            }
        }
    </script>
</head>
<body>
<div class="container">
    <h2>Patient Registration Form</h2>
    <form method="post" action="PatientRegistration.jsp">
        <label>Full Name:</label>
        <input type="text" name="fullname" required>

        <label>Username:</label>
        <input type="text" name="username" required>

        <label>Password:</label>
        <div class="password-container">
            <input type="password" name="password" id="password" required>
            <span class="toggle-password" id="toggle1" onclick="togglePassword('password','toggle1')">Show</span>
        </div>

        <label>Confirm Password:</label>
        <div class="password-container">
            <input type="password" name="confirmPassword" id="confirmPassword" required>
            <span class="toggle-password" id="toggle2" onclick="togglePassword('confirmPassword','toggle2')">Show</span>
        </div>

        <label>Contact:</label>
        <input type="text" name="contact" required>

        <label>Email:</label>
        <input type="email" name="email" required>

        <input type="submit" value="Register">
    </form>

    <%
        String fullname = request.getParameter("fullname");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String contact = request.getParameter("contact");
        String email = request.getParameter("email");

        if(fullname != null && username != null && password != null && confirmPassword != null) {
            if(!password.equals(confirmPassword)) {
    %>
                <div class="message error">Passwords do not match!</div>
    <%
            } else {
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection(
                        "jdbc:mysql://localhost:300/healthlink2035",
                        "root", "manager"
                    );

                    // Check if username already exists
                    ps = con.prepareStatement("SELECT * FROM patient_register WHERE username=?");
                    ps.setString(1, username);
                    rs = ps.executeQuery();

                    if(rs.next()) {
    %>
                        <div class="message error">Username already taken! Choose another.</div>
    <%
                    } else {
                        ps.close();
                        String sql = "INSERT INTO patient_register (fullname, username, password, contact, email) VALUES (?, ?, ?, ?, ?)";
                        ps = con.prepareStatement(sql);
                        ps.setString(1, fullname);
                        ps.setString(2, username);
                        ps.setString(3, password);
                        ps.setString(4, contact);
                        ps.setString(5, email);

                        int result = ps.executeUpdate();
                        if(result > 0) {
    %>
                            <script>alert("Registration Successful!");
                             window.location.href = "patient_login.jsp";</script>
    <%
                        } else {
    %>
                            <div class="message error">Registration failed!</div>
    <%
                        }
                    }
                } catch(Exception e) {
    %>
                    <div class="message error">Error: <%= e.getMessage() %></div>
    <%
                } finally {
                    try { if(rs != null) rs.close(); } catch(Exception e){}
                    try { if(ps != null) ps.close(); } catch(Exception e){}
                    try { if(con != null) con.close(); } catch(Exception e){}
                }
            }
        }
    %>
</div>
</body>
</html>