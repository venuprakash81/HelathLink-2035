<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    String doctorEmail = (String) session.getAttribute("email");

    if (doctorEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String doctorName = "";
    int doctorId = 0;
    String profileImage = "default.png";

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    boolean hasData = false;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");

        con = DriverManager.getConnection(
            "jdbc:mysql://localhost:300/healthlink2035",
            "root",
            "manager"
        );

        // =========================
        // DOCTOR DETAILS
        // =========================
        ps = con.prepareStatement(
            "SELECT doctor_id, name, profile_image FROM doctor_register WHERE email=?"
        );

        ps.setString(1, doctorEmail);
        rs = ps.executeQuery();

        if (rs.next()) {
            doctorId = rs.getInt("doctor_id");
            doctorName = rs.getString("name");

            String img = rs.getString("profile_image");

            if (img != null && !img.trim().isEmpty()) {
                profileImage = img.trim();
                profileImage = profileImage.replace("uploads/", "");
                profileImage = profileImage.replace("/uploads/", "");
            }
        }

        rs.close();
        ps.close();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Doctor Reports</title>

<style>
body {
    font-family: Arial;
    margin: 0;
    background: #f4f7fa;
}

.header {
    background: #0f8fbf;
    color: white;
    padding: 15px 30px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.profile {
    display: flex;
    align-items: center;
    gap: 10px;
}

.profile img {
    width: 45px;
    height: 45px;
    border-radius: 50%;
    object-fit: cover;
    border: 2px solid white;
}

table {
    width: 95%;
    margin: 30px auto;
    border-collapse: collapse;
    background: white;
}

th, td {
    padding: 12px;
    border: 1px solid #ddd;
    text-align: center;
}

th {
    background: #0f8fbf;
    color: white;
}

td img {
    width: 80px;
    height: 80px;
    object-fit: cover;
    cursor: pointer;
    border-radius: 6px;
}

.no-data {
    text-align: center;
    color: gray;
}

/* MODAL */
.modal {
    display: none;
    position: fixed;
    z-index: 9999;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background: rgba(0,0,0,0.95);
    justify-content: center;
    align-items: center;
}

.modal img {
    max-width: 95%;
    max-height: 95%;
    border-radius: 10px;
}

.close {
    position: absolute;
    top: 20px;
    right: 30px;
    font-size: 40px;
    color: white;
    cursor: pointer;
}
</style>
</head>

<body>

<!-- HEADER -->
<div class="header">

    <div class="profile">

        <!-- ✅ FIXED PROFILE IMAGE -->
        <img src="<%= request.getContextPath() + "/uploads/" + profileImage %>" 
             onerror="this.src='<%=request.getContextPath()%>/uploads/default.png'">

        <h3>Dr. <%= doctorName %> (ID: <%= doctorId %>)</h3>
    </div>

</div>

<!-- TABLE -->
<table>
    <tr>
        <th>Report ID</th>
        <th>Patient Name</th>
        <th>Report Name</th>
        <th>Date</th>
        <th>Image</th>
    </tr>

<%
        ps = con.prepareStatement(
            "SELECT report_id, patient_name, report_name, report_date, report_image " +
            "FROM reports WHERE doctor_id=? ORDER BY report_date DESC"
        );

        ps.setInt(1, doctorId);
        rs = ps.executeQuery();

        while(rs.next()){
            hasData = true;

            String reportImg = rs.getString("report_image");

            if (reportImg == null || reportImg.trim().isEmpty()) {
                reportImg = "default.png";
            } else {
                reportImg = reportImg.replace("uploads/", "");
                reportImg = reportImg.replace("/uploads/", "");
            }

            String reportPath = request.getContextPath() + "/uploads/" + reportImg;
%>

<tr>
    <td><%= rs.getInt("report_id") %></td>
    <td><%= rs.getString("patient_name") %></td>
    <td><%= rs.getString("report_name") %></td>
    <td><%= rs.getDate("report_date") %></td>

    <td>
        <img src="<%= reportPath %>"
             onclick="openImage(this.src)"
             onerror="this.src='<%=request.getContextPath()%>/uploads/default.png'">
    </td>
</tr>

<%
        }

        if(!hasData){
%>

<tr>
    <td colspan="5" class="no-data">No reports found</td>
</tr>

<%
        }

        rs.close();
        ps.close();
        con.close();

    } catch(Exception e){
%>

<div style="color:red;text-align:center;">
Error: <%= e.getMessage() %>
</div>

<%
    }
%>

</table>

<!-- MODAL -->
<div id="modal" class="modal">
    <span class="close" onclick="closeImage()">&times;</span>
    <img id="fullImg">
</div>

<script>
function openImage(src){
    document.getElementById("modal").style.display = "flex";
    document.getElementById("fullImg").src = src;
}

function closeImage(){
    document.getElementById("modal").style.display = "none";
}

document.getElementById("modal").addEventListener("click", function(e){
    if(e.target.id === "modal"){
        closeImage();
    }
});
</script>

</body>
</html>