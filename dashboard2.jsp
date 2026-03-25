<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    request.setCharacterEncoding("UTF-8");
    response.setContentType("text/html;charset=UTF-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Doctors</title>

<style>
body{
    font-family:Arial;
    background:#f4f7fa;
    margin:0;
}

.header{
    background:#1f3c88;
    color:white;
    padding:15px;
    display:flex;
    justify-content:space-between;
    align-items:center;
}

.back-btn{
    background:#ff5f6d;
    color:white;
    border:none;
    padding:8px 12px;
    border-radius:6px;
    cursor:pointer;
}

.dashboard{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(220px,1fr));
    gap:20px;
    padding:20px;
}

.card{
    background:white;
    padding:15px;
    border-radius:10px;
    text-align:center;
    box-shadow:0 2px 8px rgba(0,0,0,0.1);
}

.card img{
    width:70px;
    height:70px;
    border-radius:50%;
    object-fit:cover;
}

.card button{
    background:#ff5f6d;
    color:white;
    border:none;
    padding:8px;
    border-radius:6px;
    cursor:pointer;
}
</style>
</head>

<body>

<div class="header">
    <h2>Doctors List</h2>

    <!-- BACK BUTTON -->
    <button class="back-btn" onclick="window.location.href='patient_dashboard.jsp'">
        ⬅ Back
    </button>
</div>

<div class="dashboard">

<%
try{
    Class.forName("com.mysql.cj.jdbc.Driver");

    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:300/healthlink2035",
        "root",
        "manager"
    );

    PreparedStatement ps = con.prepareStatement("SELECT * FROM doctor_register");
    ResultSet rs = ps.executeQuery();

    while(rs.next()){

        String img = rs.getString("profile_image");

        String imagePath = request.getContextPath() + "/uploads/default.png";

        if(img != null && !img.trim().isEmpty()){

            img = img.trim();

            if(img.startsWith("uploads/")){
                img = img.substring(8);
            }
            if(img.startsWith("/uploads/")){
                img = img.substring(9);
            }

            imagePath = request.getContextPath() + "/uploads/" + img;
        }
%>

<div class="card">

    <img src="<%= imagePath %>" 
         onerror="this.src='<%=request.getContextPath()%>/uploads/default.png'">

    <h3>Dr. <%= rs.getString("name") %></h3>

    <p><%= rs.getString("specialization") %></p>

    <button onclick="window.location.href='AppointmentSheduling.jsp?doctor_id=<%= rs.getInt("doctor_id") %>&doctor_name=<%= rs.getString("name") %>'">
        Book Appointment
    </button>

</div>

<%
    }

    rs.close();
    ps.close();
    con.close();

}catch(Exception e){
    out.println(e);
}
%>

</div>

</body>
</html>