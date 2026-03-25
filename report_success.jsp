r<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Report Success</title>

    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Arial, sans-serif;
            background: linear-gradient(to right, #e3f2fd, #f4f7fa);
        }

        .container {
            width: 420px;
            margin: 80px auto;
            background: #ffffff;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
            text-align: center;
        }

        .success-icon {
            font-size: 50px;
            color: #28a745;
            margin-bottom: 10px;
        }

        h2 {
            color: #28a745;
            margin-bottom: 15px;
        }

        .data {
            text-align: left;
            margin-top: 20px;
        }

        .data p {
            margin: 10px 0;
            font-size: 15px;
            color: #333;
        }

        .data b {
            color: #000;
        }

        img {
            display: block;
            margin: 15px auto;
            width: 220px;
            border-radius: 10px;
            border: 1px solid #ddd;
        }

        .btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 18px;
            background: #007bff;
            color: #fff;
            text-decoration: none;
            border-radius: 6px;
            font-size: 14px;
            transition: 0.3s;
        }

        .btn:hover {
            background: #0056b3;
        }

        .footer {
            margin-top: 10px;
            font-size: 12px;
            color: #888;
        }
    </style>

</head>
<body>

<div class="container">

    <div class="success-icon">✔</div>
    <h2>Report Uploaded Successfully</h2>

    <div class="data">
        <p><b>Doctor ID:</b> ${doctor_id}</p>
        <p><b>Doctor Name:</b> ${doctor_name}</p>
        <p><b>Patient Name:</b> ${patient_name}</p>
        <p><b>Report Name:</b> ${report_name}</p>
        <p><b>Date:</b> ${report_date}</p>
    </div>

    <img src="uploads/${report_image}" alt="Report Image">

    <a href="admin_dashboard.jsp" class="btn">Go To Dashboard</a>

    <div class="footer">HealthLink System</div>

</div>

</body>
</html>