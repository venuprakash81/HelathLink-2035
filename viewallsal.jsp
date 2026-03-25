<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Doctor Salary Records</title>
<style>
body { font-family: Arial; background: #f4f7fa; margin:0; padding:0; }
.container { width: 95%; margin: 30px auto; background:white; padding:20px; border-radius:10px; box-shadow:0 0 10px #ccc;}
h2 { text-align:center; color:#0f8fbf; }

/* TABLE */
table { width:100%; border-collapse: collapse; margin-top:20px;}
th, td { padding:12px; border:1px solid #ccc; text-align:center; }
th { background:#0f8fbf; color:white; }
.no-data { text-align:center; color:gray; font-size:18px; padding:20px; }

/* BUTTONS */
.back-btn, .home-btn, .delete-btn {
    margin:5px 5px 15px 0;
    padding:8px 15px;
    color:white;
    border:none;
    cursor:pointer;
    border-radius:5px;
}

.back-btn { background:#0f8fbf; }
.back-btn:hover { background:#0c6f95; }

.home-btn { background:#28a745; }
.home-btn:hover { background:#1e7e34; }

.delete-btn { background:red; }
.delete-btn:hover { background:#b20000; }
</style>
</head>

<body>

<div class="container">
    <h2>All Doctor Salary Records</h2>

    <!-- Buttons -->
    <button class="back-btn" onclick="history.back()">⬅ Back</button>
    <button class="home-btn" onclick="window.location.href='admin_dashboard.jsp'">🏠 Go Home</button>

    <table>
        <tr>
            <th>ID</th>
            <th>Doctor Name</th>
            <th>Doctor Email</th>
            <th>Month</th>
            <th>Year</th>
            <th>Amount (₹)</th>
            <th>Action</th>
        </tr>

<%
    Connection con = null;
    Statement st = null;
    ResultSet rs = null;
    boolean hasData = false;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(
            "jdbc:mysql://localhost:300/healthlink2035",
            "root",
            "manager"
        );

        st = con.createStatement();

        // JOIN with doctor_register to get doctor's name
        String sql = "SELECT ds.id, ds.doctor_email, ds.month, ds.year, ds.amount, dr.name " +
                     "FROM doctor_salary ds " +
                     "LEFT JOIN doctor_register dr ON ds.doctor_email = dr.email " +
                     "ORDER BY ds.year DESC, ds.month DESC";

        rs = st.executeQuery(sql);

        while(rs.next()){
            hasData = true;
%>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("name") != null ? rs.getString("name") : "Unknown" %></td>
            <td><%= rs.getString("doctor_email") %></td>
            <td><%= rs.getString("month") %></td>
            <td><%= rs.getInt("year") %></td>
            <td>₹ <%= rs.getDouble("amount") %></td>
            <td>
                <form method="post" action="delete_salary.jsp" onsubmit="return confirm('Are you sure to delete this record?');">
                    <input type="hidden" name="salary_id" value="<%= rs.getInt("id") %>">
                    <button type="submit" class="delete-btn">Delete</button>
                </form>
            </td>
        </tr>
<%
        }

        if(!hasData){
%>
        <tr>
            <td colspan="7" class="no-data">No Salary Records Found</td>
        </tr>
<%
        }

        rs.close();
        st.close();
        con.close();

    } catch(Exception e){
%>
        <tr>
            <td colspan="7" style="color:red;">Error: <%= e.getMessage() %></td>
        </tr>
<%
    }
%>
    </table>
</div>

</body>
</html>