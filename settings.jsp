<%@ page session="true" %>
<%
    String email = (String) session.getAttribute("email");

    if(email == null){
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Settings</title>

<style>
body {
    font-family: Arial;
    background: #f4f7fa;
}

.container {
    width: 420px;
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
    <h2>Settings</h2>

    <!-- UPDATE PROFILE -->
    <form action="UpdateProfileServlet" method="post" enctype="multipart/form-data">
        <input type="text" name="newName" placeholder="New Name" required>
        <input type="file" name="photo">
        <button type="submit">Update Profile</button>
    </form>

    <hr>

    <!-- CHANGE PASSWORD -->
    <form action="ChangePasswordServlet" method="post">
        <input type="password" name="oldPassword" placeholder="Old Password" required>
        <input type="password" name="newPassword" placeholder="New Password" required>
        <input type="password" name="confirmPassword" placeholder="Confirm Password" required>
        <button type="submit">Change Password</button>
    </form>
</div>

</body>
</html>