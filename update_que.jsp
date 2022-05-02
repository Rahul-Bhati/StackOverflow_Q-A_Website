<%-- 
    Document   : update_que
    Created on : 28 Apr, 2022, 10:55:56 PM
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
            if(request.getParameter("code").length()!=0 && request.getParameter("title").length()!=0 && request.getParameter("detail").length()!=0){
                String code = request.getParameter("code");
                String title = request.getParameter("title");
                String detail = request.getParameter("detail");
                String date;
                Date dNow = new Date( );
                SimpleDateFormat ft = new SimpleDateFormat ("E yyyy.MM.dd 'at' hh:mm:ss a zzz");
                date = ft.format(dNow);
                //out.print(code+" "+title+" "+detail+" "+date);
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/stackoverflow","root","");
                    PreparedStatement ps = cn.prepareStatement("update question set title=?,detail=?,date=? where code=?");
                    ps.setString(1, title);
                    ps.setString(2, detail);
                    ps.setString(3, date);
                    ps.setString(4, code);
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


