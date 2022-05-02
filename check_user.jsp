<%-- 
    Document   : check_user
    Created on : 26 Apr, 2022, 11:35:56 AM
    Author     : hp
--%>

<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>

<% 
            if(request.getParameter("email").length() !=0 && request.getParameter("pass").length() !=0){
                String email = request.getParameter("email");
                String pass = request.getParameter("pass");
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/stackoverflow","root","");
                    Statement st = cn.createStatement();
                    ResultSet rs = st.executeQuery("select * from user where email='"+email+"'");
                    if(rs.next()){
                        if(pass.equals(rs.getString("pass"))){
                            Cookie c = new Cookie("user",email);
                            c.setMaxAge(3600);
                            response.addCookie(c);
                            response.sendRedirect("index.jsp");
                            session.setAttribute(email, pass);
                            session.setMaxInactiveInterval(3600);
                        }
                        else{
                            response.sendRedirect("login.jsp?pass_invalid=1");
                        }
                    }
                    else{
                        response.sendRedirect("login.jsp?email_invalid=1");
                    }
                    cn.close();
               }
               catch(Exception ec){
                   out.println(ec.getMessage());
               } 
            }
            else{
                response.sendRedirect("login.jsp?empty=1");
            }
%>