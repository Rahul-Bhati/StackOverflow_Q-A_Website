<%-- 
    Document   : vote
    Created on : 29 Apr, 2022, 11:50:25 AM
    Author     : hp
--%>

<%@page contentType="text/html" import="java.sql.*,java.util.*,java.util.Date,javax.servlet.*,java.text.*;" pageEncoding="UTF-8"%>
<%
        String email = null;
        Cookie c[] = request.getCookies();
        for(int i=0;i<c.length;i++){
            if(c[i].getName().equals("user")){
                email = c[i].getValue();
                break;
            }
        }
        if(email!=null && session.getAttribute(email)!=null){
            if(request.getParameter("code").length()!=0 && request.getParameter("id").length()!=0){
                String que_code = request.getParameter("code");
                String id = request.getParameter("id");
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/stackoverflow","root","");
                    Statement sn = cn.createStatement();
                    ResultSet rs = sn.executeQuery("select * from vote where que_code='"+que_code+"' AND email='"+email+"'");
                    if(rs.next()){
                        if(id.equals("up")){
                            out.print("exist");
                        }
                        else if(id.equals("down")){
                            PreparedStatement ps = cn.prepareStatement("delete from vote where que_code=? AND email=?");
                            ps.setString(1, que_code);
                            ps.setString(2, email);
                            if(ps.executeUpdate()>0){
                                out.print("success");
                            }
                        }
                    }
                    else{
                        PreparedStatement ps1 = cn.prepareStatement("insert into vote values(?,?)");
                        ps1.setString(1, que_code);
                        ps1.setString(2, email);
                        if(ps1.executeUpdate()>0){
                            out.print("success");
                        }
                        else{
                            out.print("again");
                        }
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
%>



