<%-- 
    Document   : del_user_answer
    Created on : 1 May, 2022, 5:01:52 PM
    Author     : hp
--%>

<%@page contentType="text/html" import="java.sql.*,java.util.*,java.util.Date;" pageEncoding="UTF-8"%>
<%
        String email = null;
        Cookie c[] = request.getCookies();
        for(int i=0;i<c.length;i++){
            if(c[i].getName().equals("login")){
                email = c[i].getValue();
                break;
            }
        }
        if(email!=null && session.getAttribute(email)!=null){
            if(request.getParameter("code").length()!=0){
                String code = request.getParameter("code");
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/stackoverflow","root","");
                    PreparedStatement ps = cn.prepareStatement("delete from answer where code=?");
                    ps.setString(1, code);
                    if(ps.executeUpdate()>0){
                        Statement sn = cn.createStatement();
                        ResultSet rs = sn.executeQuery("select * from ans_useful where ans_code='"+code+"'");
                        if(rs.next()){
                            PreparedStatement ps1 = cn.prepareStatement("delete from ans_useful where ans_code=?");
                            ps1.setString(1, code);
                            if(ps1.executeUpdate()>0){}
                        }
                        out.print("success");
                    }
                    cn.close();
                }
                catch(Exception ec){
                    out.println(ec.getMessage());
                } 
            }               
        }
        else{
            out.print("index");
        }
%>
