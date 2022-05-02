<%-- 
    Document   : tag_sort
    Created on : 2 May, 2022, 6:14:54 PM
    Author     : hp
--%>

<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>

<%
    if(request.getParameter("sort").length()!=0){
        String sort = request.getParameter("sort") ;
        try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/stackoverflow","root","");
            if(sort.trim().equals("Name")){
                Statement st1 = cn.createStatement();
                ResultSet rs1 = st1.executeQuery("select * from category ORDER BY category_name ASC");
                while(rs1.next()){
                %>
                <div class="col-sm-3 w3-round" style="padding: 10px;">
                    <table class="card w3-card tabel table-borderless" style="height: 15rem;" cellpadding="10px">
                        <tr style="">
                            <td style="padding-top:px;padding-left:15px;">
                                <button class="w3-button w3-tiny w3-round" style="background-color: #ADD8E6;"><%=rs1.getString("category_name")%></button>
                            </td>                          
                        </tr>
                        <tr>
                            <td style="padding-left:18px;">
                                <%
                                String detail = rs1.getString("detail");
                                String s[] = detail.split(" ");
                                for(int i=0;i<s.length;i++){
                                    out.print(s[i]+" ");
                                    if(i>45){
                                        out.print(".....");
                                        break;
                                    }
                                }
                                %>
                            </td>

                        </tr>
                    </table>
                </div>
                <%
                }
            }
            else if(sort.trim().equals("New")){
                Statement st1 = cn.createStatement();
                ResultSet rs1 = st1.executeQuery("select * from category ORDER BY category_name DESC");
                while(rs1.next()){
                %>
                <div class="col-sm-3 w3-round" style="padding: 10px;">
                    <table class="card w3-card tabel table-borderless" style="height: 15rem;" cellpadding="10px">
                        <tr style="">
                            <td style="padding-top:px;padding-left:15px;">
                                <button class="w3-button w3-tiny w3-round" style="background-color: #ADD8E6;"><%=rs1.getString("category_name")%></button>
                            </td>                          
                        </tr>
                        <tr>
                            <td style="padding-left:18px;">
                                <%
                                String detail = rs1.getString("detail");
                                String s[] = detail.split(" ");
                                for(int i=0;i<s.length;i++){
                                    out.print(s[i]+" ");
                                    if(i>45){
                                        out.print(".....");
                                        break;
                                    }
                                }
                                %>
                            </td>

                        </tr>
                    </table>
                </div>
                <%
                }
            }
            cn.close();
        }
        catch(ClassNotFoundException e){
                System.out.println("Driver : "+ e.getMessage());
        }
        catch(SQLException ec){
                System.out.println("SQL : "+ec.getMessage());
        }
    }
%>
