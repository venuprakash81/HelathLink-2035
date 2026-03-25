<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String message = "";
    boolean success = false;

    if ("POST".equalsIgnoreCase(request.getMethod())) {

        String doctorEmail = request.getParameter("doctor_email");
        String month = request.getParameter("month");
        String year = request.getParameter("year");
        String amount = request.getParameter("amount");

        Connection con = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:300/healthlink2035",
                "root",
                "manager"
            );

            ps = con.prepareStatement(
                "INSERT INTO doctor_salary(doctor_email, month, year, amount) VALUES(?,?,?,?)"
            );

            ps.setString(1, doctorEmail);
            ps.setString(2, month);
            ps.setInt(3, Integer.parseInt(year));
            ps.setDouble(4, Double.parseDouble(amount));

            int i = ps.executeUpdate();

            if (i > 0) {
                message = "Salary Added Successfully!";
                success = true;
            } else {
                message = "Failed to Add Salary!";
            }

            ps.close();
            con.close();

        } catch (Exception e) {
            message = "Error: " + e.getMessage();
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Doctor Salary Entry</title>
<style>
body { font-family: Arial; background: #f4f7fa; }
.container { width: 40%; margin:50px auto; background:white; padding:20px; border-radius:10px; box-shadow:0 0 10px #ccc;}
h2 { text-align:center; color:#0f8fbf; }
input, select { width:100%; padding:10px; margin:10px 0; border-radius:5px; border:1px solid #ccc;}
button { width:100%; padding:10px; background:#0f8fbf; color:white; border:none; cursor:pointer; border-radius:5px;}
button:hover { background:#0c6f95; }
.back-btn { width:auto; margin-bottom:15px; padding:8px 15px; background:#777; color:white; border:none; cursor:pointer; border-radius:5px;}
.back-btn:hover { background:#555; }
</style>
</head>
<body>

<div class="container">
<h2>Doctor Salary Entry</h2>

<!-- Back Button -->
<form action="admin_dashboard.jsp" method="get">
    <button type="submit" class="back-btn">⬅ Back to Dashboard</button>
</form>

<form method="post">
    <label>Select Doctor</label>
    <select name="doctor_email" required>
        <option value="">-- Select Doctor --</option>
        <%
            Connection con2 = null;
            Statement st = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con2 = DriverManager.getConnection(
                    "jdbc:mysql://localhost:300/healthlink2035", "root", "manager"
                );
                st = con2.createStatement();
                rs = st.executeQuery("SELECT email, name FROM doctor_register");
                while(rs.next()) {
        %>
        <option value="<%= rs.getString("email") %>"><%= rs.getString("name") %> (<%= rs.getString("email") %>)</option>
        <%
                }
                rs.close(); st.close(); con2.close();
            } catch(Exception e) {}
        %>
    </select>

    <label>Month</label>
    <select name="month" required>
        <option>January</option><option>February</option><option>March</option><option>April</option>
        <option>May</option><option>June</option><option>July</option><option>August</option>
        <option>September</option><option>October</option><option>November</option><option>December</option>
    </select>

    <input type="number" name="year" placeholder="Enter Year (e.g., 2026)" required>
    <input type="number" name="amount" placeholder="Enter Salary Amount" required>

    <button type="submit">Add Salary</button>
</form>
</div>

<% if(success){ %>
<script>
    alert("<%= message %>");
    // Redirect to view_salary.jsp to show all entered salary records
    window.location.href = "view_salary.jsp";
</script>
<% } else if (!message.isEmpty()) { %>
<script>
    alert("<%= message %>");
</script>
<% } %>

</body>
</html>