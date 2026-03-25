<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
<title>My Payments</title>

<style>
body{
    font-family: Arial;
    background:#f4f7fa;
}

h2{
    text-align:center;
}

.back-btn{
    position:absolute;
    top:15px;
    left:15px;
    padding:10px 15px;
    background:#1f3c88;
    color:white;
    text-decoration:none;
    border-radius:5px;
}

table{
    width:95%;
    margin:auto;
    border-collapse:collapse;
    background:white;
    margin-top:60px;
}

th,td{
    padding:10px;
    border:1px solid #ccc;
    text-align:center;
}

th{
    background:#1f3c88;
    color:white;
}

.msg{
    text-align:center;
    margin-top:20px;
    color:gray;
}
</style>
</head>

<body>

<a class="back-btn" href="patient_dashboard.jsp">⬅ Back</a>

<h2>💰 My Payments</h2>

<table>
<tr>
    <th>Bill ID</th>
    <th>Patient ID</th>
    <th>Full Name</th>
    <th>Amount</th>
    <th>Method</th>
    <th>UPI ID</th>
    <th>Status</th>
    <th>Date</th>
</tr>

<%
Connection con = null;
Statement st = null;
ResultSet rs = null;

boolean hasData = false;

try{
    Class.forName("com.mysql.cj.jdbc.Driver");

    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:300/healthlink2035",
        "root",
        "manager"
    );

    st = con.createStatement();
    rs = st.executeQuery("SELECT * FROM billing ORDER BY bill_id DESC");

    while(rs.next()){
        hasData = true;
%>

<tr>
    <td><%= rs.getInt("bill_id") %></td>
    <td><%= rs.getInt("patient_id") %></td>
    <td><%= rs.getString("full_name") %></td>
    <td>₹ <%= rs.getDouble("amount") %></td>
    <td><%= rs.getString("payment_method") %></td>
    <td><%= rs.getString("upi_id") %></td>
    <td><%= rs.getString("status") %></td>
    <td><%= rs.getTimestamp("paid_at") %></td>
</tr>

<%
    }

    if(!hasData){
%>
        </table>
        <div class="msg">❌ No payments found</div>
<%
    }

} catch(Exception e){
%>
    </table>
    <div class="msg" style="color:red;">
        Error: <%= e.getMessage() %>
    </div>
<%
} finally{
    try{ if(rs!=null) rs.close(); } catch(Exception e){}
    try{ if(st!=null) st.close(); } catch(Exception e){}
    try{ if(con!=null) con.close(); } catch(Exception e){}
}
%>

</table>

</body>
</html>