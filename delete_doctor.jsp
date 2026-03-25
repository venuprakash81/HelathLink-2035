<%@ page import="java.sql.*" %>

<%
    String id = request.getParameter("doctor_id");

    if(id != null){
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:300/healthlink2035",
                "root",
                "manager"
            );

            PreparedStatement ps = con.prepareStatement(
                "DELETE FROM doctor_register WHERE doctor_id=?"
            );

            ps.setInt(1, Integer.parseInt(id));

            int i = ps.executeUpdate();

            con.close();

            if(i > 0){
%>
<script>
alert("Doctor Deleted Successfully!");
window.location="doctorsall.jsp";
</script>
<%
            } else {
%>
<script>
alert("Delete Failed!");
window.location="doctorsall.jsp";
</script>
<%
            }

        } catch(Exception e){
            out.println("Error: " + e.getMessage());
        }
    }
%>