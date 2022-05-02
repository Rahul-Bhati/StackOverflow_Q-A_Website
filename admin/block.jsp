<%-- 
    Document   : block
    Created on : 26 Apr, 2022, 3:54:06 PM
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
                    Statement sn = cn.createStatement();
                    ResultSet rs = sn.executeQuery("select * from user where code='"+code+"'");
                    if(rs.next()){
                        String status = rs.getString("status");
                        String from_email = rs.getString("email");
                        if(status.equals("0")){
                            PreparedStatement ps = cn.prepareStatement("update user set status=? where code=?");
                            ps.setString(1, "1");
                            ps.setString(2, code);
                            if(ps.executeUpdate()>0){
                                Statement sn1 = cn.createStatement();
                                ResultSet rs1 = sn1.executeQuery("select * from question where from_email='"+from_email+"'");
                                if(rs1.next()){
                                    PreparedStatement ps1 = cn.prepareStatement("update question set status=? where from_email=?");
                                    ps1.setString(1, "1");
                                    ps1.setString(2, from_email);
                                    if(ps1.executeUpdate()>0){}
                                }
                                Statement sn2 = cn.createStatement();
                                ResultSet rs2 = sn2.executeQuery("select * from answer where from_email='"+from_email+"'");
                                if(rs2.next()){
                                    PreparedStatement ps2 = cn.prepareStatement("update answer set status=? where from_email=?");
                                    ps2.setString(1, "1");
                                    ps2.setString(2, from_email);
                                    if(ps2.executeUpdate()>0){}
                                }
                                out.print("block");
                            }
                        }
                        else if(status.equals("1")){
                            PreparedStatement ps = cn.prepareStatement("update user set status=? where code=?");
                            ps.setString(1, "0");
                            ps.setString(2, code);
                            if(ps.executeUpdate()>0){
                                Statement sn1 = cn.createStatement();
                                ResultSet rs1 = sn1.executeQuery("select * from question where from_email='"+from_email+"'");
                                if(rs1.next()){
                                    PreparedStatement ps1 = cn.prepareStatement("update question set status=? , warning=? where from_email=?");
                                    ps1.setString(1, "0");
                                    ps1.setInt(2, 0);
                                    ps1.setString(3, from_email);
                                    if(ps1.executeUpdate()>0){}
                                }
                                Statement sn2 = cn.createStatement();
                                ResultSet rs2 = sn2.executeQuery("select * from answer where from_email='"+from_email+"'");
                                if(rs2.next()){
                                    PreparedStatement ps2 = cn.prepareStatement("update answer set status=? , warning=? where from_email=?");
                                    ps2.setString(1, "0");
                                    ps2.setInt(2, 0);
                                    ps2.setString(3, from_email);
                                    if(ps2.executeUpdate()>0){}
                                }
                                out.print("unblock");
                            }
                        }
                    }
                    cn.close();
                }
                catch(Exception ec){
                    out.println(ec.getMessage());
                } 
            }               
        }
        else{
            response.sendRedirect("index.jsp");
        }
%>


