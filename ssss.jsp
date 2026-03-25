<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
<title>Available Health Services</title>

<style>
body{
    font-family: Arial;
    background:#f4f7fa;
    margin:0;
}

/* HEADER */
.header{
    background:#1f3c88;
    color:white;
    padding:15px;
    text-align:center;
    font-size:22px;
}

/* BACK BUTTON */
.back-btn{
    position:absolute;
    top:15px;
    left:15px;
    padding:8px 14px;
    background:white;
    color:#1f3c88;
    text-decoration:none;
    border-radius:5px;
    font-weight:bold;
}

/* GRID */
.container{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(250px,1fr));
    gap:20px;
    padding:20px;
}

/* CARD */
.card{
    background:white;
    padding:20px;
    border-radius:10px;
    box-shadow:0 0 10px rgba(0,0,0,0.1);
}

.card h3{
    color:#1f3c88;
}

.card p{
    color:#555;
    font-size:14px;
}
</style>
</head>

<body>

<div class="header">
    🏥 Available Health Services
</div>

<a class="back-btn" href="patient_dashboard.jsp">⬅ Back</a>

<div class="container">

    <div class="card">
        <h3>🩺 Doctor Consultation</h3>
        <p>Consult with qualified doctors for diagnosis and treatment.</p>
    </div>

    <div class="card">
        <h3>💊 Prescription Services</h3>
        <p>Access your prescribed medicines and download prescriptions.</p>
    </div>

    <div class="card">
        <h3>💳 Billing & Payments</h3>
        <p>Securely pay hospital bills using UPI or online methods.</p>
    </div>

    <div class="card">
        <h3>📄 Medical Reports</h3>
        <p>View lab test results and medical reports anytime.</p>
    </div>

    <div class="card">
        <h3>💬 Online Doctor Chat</h3>
        <p>Chat with doctors for quick medical advice.</p>
    </div>

    <div class="card">
        <h3>📅 Appointment Management</h3>
        <p>Book and manage your appointments easily.</p>
    </div>

    <div class="card">
        <h3>🚑 Emergency Services</h3>
        <p>Quick access to emergency and ambulance services.</p>
    </div>

    <div class="card">
        <h3>🧪 Lab Test Booking</h3>
        <p>Schedule lab tests and view results online.</p>
    </div>

</div>

</body>
</html>