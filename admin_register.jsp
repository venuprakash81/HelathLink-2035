<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Registration</title>

<style>
body {
    font-family: Arial;
    background: linear-gradient(135deg,#eef5ff,#ffffff);
}

.container {
    width: 400px;
    margin: 50px auto;
    background: white;
    padding: 25px;
    border-radius: 10px;
}

h2 {
    text-align: center;
    color: #007bff;
}

input, button {
    width: 100%;
    padding: 10px;
    margin: 8px 0;
}

button {
    background: #007bff;
    color: white;
    border: none;
}
</style>

</head>

<body>

<div class="container">
    <h2>Admin Registration</h2>

    <%
        String msg = request.getParameter("message");
        if(msg != null){
    %>
        <p style="color:red; text-align:center;"><%= msg %></p>
    <%
        }
    %>

    <form action="AdminRegisterServlet" method="post" enctype="multipart/form-data">

        <input type="text" name="name" placeholder="Full Name" required>

        <input type="email" name="email" placeholder="Email" required>

        <input type="text" name="mobile" placeholder="Mobile Number" required>

        <input type="password" name="password" placeholder="Password" required>

        <input type="password" name="confirmPassword" placeholder="Confirm Password" required>

        <input type="file" name="image" accept="image/*">

        <button type="submit">Register</button>

    </form>
</div>

</body>
</html>