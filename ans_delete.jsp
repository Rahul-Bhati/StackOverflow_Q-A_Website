<%-- 
    Document   : ans_delete
    Created on : 28 Apr, 2022, 5:51:17 PM
    Author     : hp
--%>

<%@page contentType="text/html" import="java.sql.*,java.util.*,java.util.Date,javax.servlet.*,java.text.*" pageEncoding="UTF-8"%>
<%
        String cemail = null;
        Cookie c[] = request.getCookies();
        for(int i=0;i<c.length;i++){
            if(c[i].getName().equals("user")){
                cemail = c[i].getValue();
                break;
            }
        }
        if(cemail==null && session.getAttribute(cemail)==null){
            out.print("login");
        }
        else{
            if(request.getParameter("code").length()!=0){
                String ans_code = request.getParameter("code");
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/stackoverflow","root","");  
                    PreparedStatement ps = cn.prepareStatement("delete from answer where code=?");
                    ps.setString(1, ans_code);
                    if(ps.executeUpdate()>0){
                        Statement sn = cn.createStatement();
                        ResultSet rs = sn.executeQuery("select * from ans_useful where ans_code='"+ans_code+"'");
                        if(rs.next()){
                            PreparedStatement ps1 = cn.prepareStatement("delete from ans_useful where ans_code=?");
                            ps1.setString(1, ans_code);
                            if(ps1.executeUpdate()>0){}
                        }
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
                out.print("code");
            }
        }
%>
