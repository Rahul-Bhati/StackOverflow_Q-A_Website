<%-- 
    Document   : update_profile
    Created on : 1 May, 2022, 6:49:07 PM
    Author     : hp
--%>

<%@page contentType="text/html" import="java.sql.*,java.util.*,java.util.Date;" pageEncoding="UTF-8"%>
<%
        String cemail = null;
        Cookie c[] = request.getCookies();
        for(int i=0;i<c.length;i++){
            if(c[i].getName().equals("user")){
                cemail = c[i].getValue();
                break;
            }
        }
        if(cemail!=null && session.getAttribute(cemail)!=null){
            if(request.getParameter("code").length()!=0 && request.getParameter("username").length()!=0 && request.getParameter("gender").length()!=0){
                String username = request.getParameter("username");
                String code = request.getParameter("code");
                String gender = request.getParameter("gender");
                //out.print(username+" "+email+" "+pass+" "+gender+" "+tags);
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/stackoverflow","root","");
                    PreparedStatement ps = cn.prepareStatement("update user set username=?,gender=? where code=?");
                    ps.setString(1, username);
                    ps.setString(2, gender);
                    ps.setString(3, code);
                    if(ps.executeUpdate()>0){
                         out.print("success");
                    }
                    else{
                        out.print("again");
                    }
                    cn.close();
                }
                catch(Exception ec){
                    out.println(ec.getMessage());
                } 
            }
            else{
                out.print("empty");
            }
        }
        else{
            out.print("index");
        }
%>