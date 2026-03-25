<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Invalidate the current session
    if (session != null) {
        session.invalidate();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Logout</title>
    <script>
        // Show alert
        alert("You have been logged out successfully!");

        // Redirect to login page
        window.location.href = "login.jsp";
    </script>
</head>
<body>
</body>
</html>