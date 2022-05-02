<%-- 
    Document   : check
    Created on : 23 Apr, 2022, 3:22:04 PM
    Author     : hp
--%>

<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>
<%
        if(request.getParameter("email").length()==0 || request.getParameter("pass").length()==0){
            response.sendRedirect("index.jsp?empty=1");
        }
        else{
            String email = request.getParameter("email");
            String pass = request.getParameter("pass");
            try{
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/stackoverflow","root","");
                    Statement st = cn.createStatement();
                    ResultSet rs = st.executeQuery("select * from admin where email='"+email+"'");
                    if(rs.next()){
                        if(pass.equals(rs.getString("pass"))){
                            Cookie c = new Cookie("login",email);
                            c.setMaxAge(3600);
                            response.addCookie(c);
                            response.sendRedirect("dashboard.jsp");
                            session.setAttribute(email, pass);
                            session.setMaxInactiveInterval(3600);
                        }
                        else{
                            response.sendRedirect("index.jsp?pass_invalid=1");
                        }
                    }
                    else{
                        response.sendRedirect("index.jsp?email_invalid=1");
                    }
                    cn.close();
               }
               catch(Exception ec){
                   out.println(ec.getMessage());
               } 
        }
%>
