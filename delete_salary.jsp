<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    String salaryId = request.getParameter("salary_id");

    if(salaryId != null && !salaryId.isEmpty()){
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:300/healthlink2035",
                "root",
                "manager"
            );

            PreparedStatement ps = con.prepareStatement(
                "DELETE FROM doctor_salary WHERE id=?"
            );
            ps.setInt(1, Integer.parseInt(salaryId));
            int i = ps.executeUpdate();
            ps.close();
            con.close();

            if(i > 0){
%>
<script>
    alert("Salary record deleted successfully!");
    window.location.href = "viewallsaly.jsp";
</script>
<%
            } else {
%>
<script>
    alert("Failed to delete salary record!");
    window.location.href = "viewallsal.jsp";
</script>
<%
            }

        } catch(Exception e){
%>
<script>
    alert("Error: <%= e.getMessage() %>");
    window.location.href = "viewallsal.jsp";
</script>
<%
        }
    } else {
        response.sendRedirect("viewallsal.jsp");
    }
%>