<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
if(request.getMethod().equalsIgnoreCase("POST")){

    int patient_id = Integer.parseInt(request.getParameter("patient_id"));
    String full_name = request.getParameter("full_name");
    double amount = Double.parseDouble(request.getParameter("amount"));
    String method = request.getParameter("payment_method");
    String upi_id = request.getParameter("upi_id");

    try{
        Class.forName("com.mysql.cj.jdbc.Driver");

        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:300/healthlink2035",
            "root",
            "manager"
        );

        PreparedStatement ps = con.prepareStatement(
            "INSERT INTO billing(patient_id, full_name, amount, payment_method, upi_id, status) VALUES(?,?,?,?,?,?)"
        );

        ps.setInt(1, patient_id);
        ps.setString(2, full_name);
        ps.setDouble(3, amount);
        ps.setString(4, method);
        ps.setString(5, upi_id);
        ps.setString(6, "COMPLETED");

        int i = ps.executeUpdate();

        if(i > 0){
            response.sendRedirect("payment_gap.jsp");
        } else {
            response.sendRedirect("pay.jsp");
        }

        return;

    } catch(Exception e){
        response.sendRedirect("payment_gap.jsp");
        return;
    }
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Pay Bill</title>

<style>
body{
    font-family: Arial;
    background:#f4f7fa;
}

.box{
    width:420px;
    margin:auto;
    margin-top:40px;
    padding:20px;
    background:white;
    border-radius:10px;
    box-shadow:0 0 10px gray;
}

input, select{
    width:100%;
    padding:10px;
    margin:8px 0;
}

button{
    width:100%;
    padding:10px;
    background:green;
    color:white;
    border:none;
    cursor:pointer;
}

.qr{
    display:none;
    text-align:center;
    margin-top:15px;
}

.qr img{
    width:200px;
    height:200px;
    border:1px solid #ccc;
}
</style>
</head>

<body>

<div class="box">

<h2>💳 Pay Bill</h2>

<form method="post">

<input type="number" name="patient_id" placeholder="Patient ID" required>

<input type="text" name="full_name" placeholder="Full Name" required>

<input type="number" name="amount" placeholder="Amount" required>

<select name="payment_method" onchange="showQR(this.value)" required>
    <option value="">Select Payment Method</option>
    <option value="GPay">Google Pay</option>
    <option value="PhonePe">PhonePe</option>
    <option value="Paytm">Paytm</option>
</select>

<input type="text" name="upi_id" placeholder="UPI ID (optional)">

<div id="qrBox" class="qr">
    <h3>Scan & Pay</h3>
    <img id="qrImg" src="">
</div>

<button type="submit">I Have Paid</button>

</form>

</div>

<script>
function showQR(method){

    let qrBox = document.getElementById("qrBox");
    let qrImg = document.getElementById("qrImg");

    if(method === "GPay"){
        qrImg.src = "img/QR2.jpeg";
        qrBox.style.display = "block";
    }
    else if(method === "PhonePe"){
        qrImg.src = "img/QR1.png.jpeg";
        qrBox.style.display = "block";
    }
    else if(method === "Paytm"){
        qrImg.src = "img/p.jpeg";
        qrBox.style.display = "block";
    }
    else{
        qrBox.style.display = "none";
    }
}
</script>

</body>
</html>