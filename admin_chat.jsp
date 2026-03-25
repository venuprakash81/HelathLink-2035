<%@ page import="java.sql.*" %>

<%
/* ================= SESSION CHECK ================= */
String adminEmail = (String) session.getAttribute("adminEmail");

if(adminEmail == null){
    response.sendRedirect("admin_login.jsp");
    return;
}

int adminId = 0;
Connection conn = null;

try{
    Class.forName("com.mysql.cj.jdbc.Driver");

    conn = DriverManager.getConnection(
    "jdbc:mysql://localhost:300/healthlink2035","root","manager");

    /* ================= GET ADMIN ID ================= */
    PreparedStatement ps1 = conn.prepareStatement(
    "SELECT admin_id,image FROM admin WHERE email=?");

    ps1.setString(1, adminEmail);
    ResultSet r1 = ps1.executeQuery();

    String adminImg = null;

    if(r1.next()){
        adminId = r1.getInt("admin_id");
        adminImg = r1.getString("image");
    }

%>

<!DOCTYPE html>
<html>
<head>
<title>Admin Chat</title>

<style>
body{margin:0;font-family:Arial;display:flex;background:#f4f8ff;}

/* LEFT PANEL */
.sidebar{
    width:25%;
    background:#1e3a8a;
    color:white;
    height:100vh;
    overflow:auto;
}

.sidebar h2{
    padding:15px;
    background:#172554;
    margin:0;
}

.patient{
    padding:12px;
    border-bottom:1px solid #3b82f6;
}

.patient a{
    color:white;
    text-decoration:none;
}

.patient:hover{
    background:#2563eb;
}

/* RIGHT PANEL */
.chat-area{
    width:75%;
    display:flex;
    flex-direction:column;
}

.header{
    background:#2563eb;
    color:white;
    padding:15px;
}

/* CHAT */
.chat-box{
    flex:1;
    padding:15px;
    overflow:auto;
    background:#eaf2ff;
}

.msg{
    display:flex;
    margin:10px 0;
}

.sent{
    justify-content:flex-end;
}

.bubble{
    padding:10px;
    border-radius:10px;
    max-width:60%;
}

.sent .bubble{
    background:#2563eb;
    color:white;
}

.received .bubble{
    background:white;
}

/* IMAGE */
.msg img{
    width:35px;
    height:35px;
    border-radius:50%;
    margin-right:8px;
}

/* DELETE BUTTON */
.delete-btn{
    font-size:12px;
    color:red;
    cursor:pointer;
    background:none;
    border:none;
}

/* SEND BOX */
.send-box{
    display:flex;
    padding:10px;
    background:#dbeafe;
}

.send-box input{
    flex:1;
    padding:10px;
    border-radius:20px;
    border:1px solid #3b82f6;
}

.send-box button{
    padding:10px;
    margin-left:10px;
    background:#1e3a8a;
    color:white;
    border:none;
    border-radius:20px;
}
</style>
</head>

<body>

<!-- ================= LEFT PANEL ================= -->
<div class="sidebar">
<h2>Patients</h2>

<%
Statement st = conn.createStatement();
ResultSet rs = st.executeQuery("SELECT * FROM patient_register");

while(rs.next()){
%>
    <div class="patient">
        <a href="admin_chat.jsp?patient_id=<%= rs.getInt("id") %>">
            <%= rs.getString("fullname") %>
        </a>
    </div>
<%
}
%>

</div>

<!-- ================= RIGHT PANEL ================= -->
<div class="chat-area">

<div class="header">
    Admin Chat
    <a href="LogoutServlet" style="float:right;color:white;">Logout</a>
</div>

<div class="chat-box">

<%
String patientIdStr = request.getParameter("patient_id");
int patientId = (patientIdStr != null) ? Integer.parseInt(patientIdStr) : 0;

if(patientId != 0){

PreparedStatement ps = conn.prepareStatement(
"SELECT c.*, a.image FROM chat_messages c " +
"LEFT JOIN admin a ON c.sender_id=a.admin_id AND c.sender_type='admin' " +
"WHERE c.is_deleted=0 AND ((c.sender_id=? AND c.receiver_id=?) OR (c.sender_id=? AND c.receiver_id=?)) " +
"ORDER BY c.timestamp ASC");
ps.setInt(1, adminId);
ps.setInt(2, patientId);
ps.setInt(3, patientId);
ps.setInt(4, adminId);

ResultSet chat = ps.executeQuery();

while(chat.next()){
    int msgId = chat.getInt("id");
    int sender = chat.getInt("sender_id");
    String msg = chat.getString("message");
    String type = chat.getString("sender_type");
    String img = chat.getString("image");

    if(sender == adminId){
%>
<div class="msg sent">
    <div class="bubble">
        <%= msg %>

        <!-- DELETE -->
        <form action="DeleteMessageServlet" method="post" style="display:inline;">
            <input type="hidden" name="msg_id" value="<%= msgId %>">
            <input type="hidden" name="other_id" value="<%= patientId %>">
            <button class="delete-btn">🗑</button>
        </form>
    </div>
</div>
<%
    } else {
%>
<div class="msg received">
    <% if(img!=null){ %>
        <img src="images/<%= img %>">
    <% } %>
    <div class="bubble"><%= msg %></div>
</div>
<%
    }
}
}
%>

</div>

<!-- SEND -->
<% if(patientId != 0){ %>
<form class="send-box" action="SendMessageServlet" method="post">
    <input type="hidden" name="sender_type" value="admin">
    <input type="hidden" name="sender_id" value="<%= adminId %>">
    <input type="hidden" name="receiver_type" value="patient">
    <input type="hidden" name="receiver_id" value="<%= patientId %>">

    <input type="text" name="message" placeholder="Type message..." required>
    <button>Send</button>
</form>
<% } %>

</div>

</body>
</html>

<%
}catch(Exception e){
    out.println(e);
}
%>