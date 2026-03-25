<%@ page import="java.sql.*" %>

<%
    String id = request.getParameter("appointment_id");

    if(id != null){
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:300/healthlink2035",
                "root",
                "manager"
            );

            PreparedStatement ps = con.prepareStatement(
                "DELETE FROM appointment_scheduling WHERE appointment_id=?"
            );

            ps.setInt(1, Integer.parseInt(id));

            int i = ps.executeUpdate();

            con.close();

            if(i > 0){
%>
<script>
alert("Deleted Successfully!");
window.location="appointmentsall.jsp";
</script>
<%
            } else {
%>
<script>
alert("Delete Failed!");
window.location="appointmentsall.jsp";
</script>
<%
            }

        } catch(Exception e){
            out.println("Error: " + e.getMessage());
        }
    }
%>