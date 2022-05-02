<%-- 
    Document   : search_tag
    Created on : 2 May, 2022, 9:50:09 AM
    Author     : hp
--%>

<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>

<%
    if(request.getParameter("sch").length()!=0){
        String sch = request.getParameter("sch") ;
        String s[] = sch.split(" ");
        String sql = "select * from category where category_name like '%"+sch+"%'";
        for(int i=0;i<s.length;i++){
            sql = sql+"OR category_name like '%"+s[i]+"%'";
        }
        try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/stackoverflow","root","");
            
           %>
            <div class="row">
                <%
                    int flag=0;
                    Statement st1 = cn.createStatement();
                    ResultSet rs1 = st1.executeQuery(sql);
                    while(rs1.next()){
                        flag=1;
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
                                String dt[] = detail.split(" ");
                                for(int i=0;i<dt.length;i++){
                                    out.print(dt[i]+" ");
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
                    if(flag==0){
                        out.print("<h5>tag not find..</h5>");
                    }
                %>
            </div>
            <%
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

