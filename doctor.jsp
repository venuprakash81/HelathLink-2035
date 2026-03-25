<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Doctors</title>

<style>
body{
    font-family: 'Segoe UI', sans-serif;
    background: linear-gradient(135deg, #eef2f7, #d9e4f5);
    margin:0;
}

/* HEADER */
.header{
    background: #1f3c88;
    color: white;
    padding: 18px;
    text-align: center;
    font-size: 22px;
    font-weight: bold;
}

/* BACK BUTTONS */
.back-buttons{
    display:flex;
    justify-content:center;
    gap:15px;
    margin:15px;
}

.back-buttons a{
    text-decoration:none;
    padding:10px 18px;
    background:#ffffff;
    color:#1f3c88;
    border-radius:25px;
    font-weight:bold;
    box-shadow:0 2px 6px rgba(0,0,0,0.15);
    transition:0.3s;
}

.back-buttons a:hover{
    background:#1f3c88;
    color:white;
}

/* GRID */
.dashboard{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(230px,1fr));
    gap:22px;
    padding:25px;
}

/* CARD */
.card{
    background:white;
    padding:18px;
    border-radius:15px;
    text-align:center;
    box-shadow:0 4px 12px rgba(0,0,0,0.1);
    transition:0.3s;
}

.card:hover{
    transform:translateY(-6px);
}

.card img{
    width:90px;
    height:90px;
    border-radius:50%;
    object-fit:cover;
    border:3px solid #1f3c88;
    margin-bottom:10px;
}

.card h3{
    margin:8px 0;
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
Doctors List
</div>

<!-- BACK BUTTONS ONLY -->
<div class="back-buttons">
    <a href="index.jsp"> Home</a>
    <a href="service.jsp"> Service</a>
    <a href="explore.jsp"> Explore</a>
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

    PreparedStatement ps = con.prepareStatement(
        "SELECT name, specialization, profile_image FROM doctor_register"
    );

    ResultSet rs = ps.executeQuery();

    while(rs.next()){

        String img = rs.getString("profile_image");
        String imagePath;

        if(img != null && !img.isEmpty()){
            imagePath = request.getContextPath() + "/" + img;
        } else {
            imagePath = request.getContextPath() + "/uploads/default.png";
        }
%>

<div class="card">
    <img src="<%= imagePath %>" 
         onerror="this.src='<%=request.getContextPath()%>/uploads/default.png'">

    <h3>Dr. <%= rs.getString("name") %></h3>
    <p><%= rs.getString("specialization") %></p>
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