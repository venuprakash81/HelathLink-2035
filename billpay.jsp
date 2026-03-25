<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
<title>Pay Bill</title>

<style>
body{
    font-family: Arial;
    background: #f4f7fa;
}

.box{
    width: 420px;
    margin: auto;
    margin-top: 40px;
    padding: 20px;
    background: white;
    border-radius: 10px;
    box-shadow: 0 0 10px gray;
}

input, select{
    width: 100%;
    padding: 10px;
    margin: 8px 0;
}

button{
    width: 100%;
    padding: 10px;
    background: green;
    color: white;
    border: none;
    cursor: pointer;
}

.qr{
    display: none;
    text-align: center;
    margin-top: 15px;
}

.qr img{
    width: 200px;
    height: 200px;
}
</style>
</head>

<body>

<div class="box">
<h2>💳 Pay Bill</h2>

<%
String msg = request.getParameter("msg");
if("success".equals(msg)){
    out.println("<p style='color:green'>Payment Successful ✔</p>");
}
if("error".equals(msg)){
    out.println("<p style='color:red'>Payment Failed ❌</p>");
}

if(request.getMethod().equalsIgnoreCase("POST")){

    int patient_id = Integer.parseInt(request.getParameter("patient_id"));
    String full_name = request.getParameter("full_name");
    double amount = Double.parseDouble(request.getParameter("amount"));
    String method = request.getParameter("payment_method");
    String upi_id = request.getParameter("upi_id");

    try{
        Class.forName("com.mysql.cj.jdbc.Driver");

        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/healthlink2035",
            "root",
            "password"
        );

        PreparedStatement ps = con.prepareStatement(
            "INSERT INTO billing(patient_id, full_name, amount, payment_method, upi_id, status) VALUES(?,?,?,?,?,?)"
        );

        ps.setInt(1, patient_id);
        ps.setString(2, full_name);
        ps.setDouble(3, amount);
        ps.setString(4, method);
        ps.setString(5, upi_id);
        ps.setString(6, "PAID");

        ps.executeUpdate();

        response.sendRedirect("pay_bill.jsp?msg=success");
        return;

    } catch(Exception e){
        e.printStackTrace();
        response.sendRedirect("pay_bill.jsp?msg=error");
        return;
    }
}
%>

<form method="post">

    <label>Patient ID</label>
    <input type="number" name="patient_id" required>

    <label>Full Name</label>
    <input type="text" name="full_name" required>

    <label>Amount</label>
    <input type="number" name="amount" required>

    <label>Payment Method</label>
    <select name="payment_method" onchange="showQR(this.value)" required>
        <option value="">--Select--</option>
        <option value="GPay">Google Pay</option>
        <option value="PhonePe">PhonePe</option>
        <option value="Paytm">Paytm</option>
    </select>

    <label>UPI ID (optional)</label>
    <input type="text" name="upi_id">

    <div id="qr" class="qr">
        <p>Scan & Pay</p>
        <img id="qrImg">
    </div>

    <button type="submit">I Have Paid</button>

</form>
</div>

<script>
function showQR(value){

    let qr = document.getElementById("qr");
    let img = document.getElementById("qrImg");

    if(value === "GPay" || value === "PhonePe" || value === "Paytm"){
        img.src = "images/qr/whatsapp_qr.jpeg";
        qr.style.display = "block";
    } else {
        qr.style.display = "none";
    }
}
</script>

</body>
</html>