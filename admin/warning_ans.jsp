<%-- 
    Document   : warning_ans
    Created on : 1 May, 2022, 4:57:14 PM
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
                String ans_code = request.getParameter("code");
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/stackoverflow","root","");
                    Statement st = cn.createStatement();
                    ResultSet rs = st.executeQuery("select * from answer where code='"+ans_code+"'");
                    if(rs.next()){
                        if(rs.getInt("warning")<2){
                            int warning = rs.getInt("warning") ;
                            warning++;
                            PreparedStatement ps = cn.prepareStatement("update answer set warning=? where code=?");
                            ps.setInt(1,warning);
                            ps.setString(2, ans_code);
                            if(ps.executeUpdate()>0){
                                out.print("success");
                            }
                        }
                        else if(rs.getInt("warning")==2){
                            int warning = rs.getInt("warning") ;
                            warning++;
                            PreparedStatement ps = cn.prepareStatement("update answer set warning=? where code=?");
                            ps.setInt(1,warning);
                            ps.setString(2, ans_code);
                            if(ps.executeUpdate()>0){
                                PreparedStatement ps2 = cn.prepareStatement("update user set status=? where email=?");
                                ps2.setString(1, "1");
                                ps2.setString(2, rs.getString("from_email"));
                                if(ps2.executeUpdate()>0){
                                    PreparedStatement ps1 = cn.prepareStatement("update answer set status=? where from_email=?");
                                    ps1.setString(1, "1");
                                    ps1.setString(2, rs.getString("from_email"));
                                    if(ps1.executeUpdate()>0){
                                        out.print("block");
                                    }
                                }
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
            out.print("index");
        }
%>

