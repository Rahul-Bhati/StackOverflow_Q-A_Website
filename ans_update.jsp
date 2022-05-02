<%-- 
    Document   : ans_update
    Created on : 28 Apr, 2022, 5:35:27 PM
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
            if(request.getParameter("code").length()!=0 && request.getParameter("ans").length()!=0){
                String ans_code = request.getParameter("code");
                String ans = request.getParameter("ans");
                
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/stackoverflow","root","");  
                    
                    String date;
                    Date dNow = new Date( );
                    SimpleDateFormat ft = new SimpleDateFormat ("E yyyy.MM.dd 'at' hh:mm:ss a zzz");
                    date = ft.format(dNow);
                    PreparedStatement ps = cn.prepareStatement("update answer set ans=?,date=? where code=?");
                    ps.setString(1, ans);
                    ps.setString(2, date);
                    ps.setString(3, ans_code);
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
%>
