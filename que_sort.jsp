<%-- 
    Document   : que_sort
    Created on : 2 May, 2022, 5:48:28 PM
    Author     : hp
--%>

<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>

<%
    if(request.getParameter("sort").length()!=0){
        String sort = request.getParameter("sort") ;
        try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/stackoverflow","root","");
            if(sort.trim().equals("Newest")){
                Statement sn1 = cn.createStatement();
                ResultSet rs1 = sn1.executeQuery("select * from question where status='0' order by sn asc");
                while(rs1.next()){
                    int ans_count = 0;
                    Statement sn3 = cn.createStatement();
                    ResultSet rs3 = sn3.executeQuery("select count(*) from answer where que_code='"+rs1.getString("code")+"'");
                    if(rs3.next()){
                        ans_count = Integer.parseInt(rs3.getString("count(*)"));
                    }
                    int count_view = 0;
                    Statement sn4 = cn.createStatement();
                    ResultSet rs4 = sn4.executeQuery("select count(*) from user_view where que_code='"+rs1.getString("code")+"'");
                    if(rs4.next()){
                        count_view = Integer.parseInt(rs4.getString("count(*)"));
                    }
                    int count_vote = 0;
                    Statement sn5 = cn.createStatement();
                    ResultSet rs5 = sn5.executeQuery("select count(*) from vote where que_code='"+rs1.getString("code")+"'");
                    if(rs5.next()){
                        count_vote = Integer.parseInt(rs5.getString("count(*)"));
                    }
                  %>
                <div class="col-sm-12" style="border-bottom: 0.5px ridge wheat;border-top: 0.5px ridge wheat;">
                    <div class="row" style="padding:10px;">
                        <div class="col-sm-1">
                            <table class="tabel " cellpadding="5px">
                                <tr><td style="float:right;padding: 5px;"> <%=count_vote%> votes </td></tr>
                                <tr><td style="float:right;padding: 5px;"> <%=ans_count%> answer </td></tr>
                                <tr><td style="float:right;padding: 5px;"> <%=count_view%> views </td></tr>
                            </table>
                        </div>
                        <div class="col-sm-9">
                            <table class="tabel" cellpadding="5px">
                                <tr>
                                    <td><a href="answer.jsp?code=<%=rs1.getString("code")%>" style="font-size: 20px;padding-left:10px;text-decoration:none;"><%=rs1.getString("title")%></a></td>
                                 </tr>
                                <tr>
                                    <td style="padding-left:15px;">
                                        <%
                                            String s[] = rs1.getString("tags").split(",");
                                            for(int i=0;i<s.length;i++){
                                        %>
                                        <button class="w3-button w3-tiny w3-round" style="background-color: #ADD8E6;"><%=s[i]%></button>
                                        <%
                                            }
                                        %>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-sm-2">
                            <%
                                String que_date[] = rs1.getString("date").split("at");
                                String from_email = rs1.getString("from_email");
                                Statement sn2 = cn.createStatement();
                                ResultSet rs2 = sn2.executeQuery("select * from user where email='"+from_email+"'");
                                if(rs2.next()){
                            %>
                            <table class="tabel" cellpadding="5px">
                                <tr>
                                <img src="users/<%=rs2.getString("code")%>.jpg" style="width: 30px;height: 30px;" class="img-fluid rounded">&nbsp;
                                    <%=rs2.getString("username")%>
                                </tr>
                                <tr><td style="padding-top: 10px"><%=que_date[0]%></td></tr>
                                <tr><td style="padding-top: 10px"><%=que_date[1]%></td></tr>
                            </table>
                            <%
                                }
                            %>
                        </div>
                    </div>
                </div>
                <%
                }
            }
            else if(sort.trim().equals("Oldest")){
                Statement sn1 = cn.createStatement();
                ResultSet rs1 = sn1.executeQuery("select * from question where status='0' order by sn desc");
                while(rs1.next()){
                    int ans_count = 0;
                    Statement sn3 = cn.createStatement();
                    ResultSet rs3 = sn3.executeQuery("select count(*) from answer where que_code='"+rs1.getString("code")+"'");
                    if(rs3.next()){
                        ans_count = Integer.parseInt(rs3.getString("count(*)"));
                    }
                    int count_view = 0;
                    Statement sn4 = cn.createStatement();
                    ResultSet rs4 = sn4.executeQuery("select count(*) from user_view where que_code='"+rs1.getString("code")+"'");
                    if(rs4.next()){
                        count_view = Integer.parseInt(rs4.getString("count(*)"));
                    }
                    int count_vote = 0;
                    Statement sn5 = cn.createStatement();
                    ResultSet rs5 = sn5.executeQuery("select count(*) from vote where que_code='"+rs1.getString("code")+"'");
                    if(rs5.next()){
                        count_vote = Integer.parseInt(rs5.getString("count(*)"));
                    }
                  %>
                <div class="col-sm-12" style="border-bottom: 0.5px ridge wheat;border-top: 0.5px ridge wheat;">
                    <div class="row" style="padding:10px;">
                        <div class="col-sm-1">
                            <table class="tabel " cellpadding="5px">
                                <tr><td style="float:right;padding: 5px;"> <%=count_vote%> votes </td></tr>
                                <tr><td style="float:right;padding: 5px;"> <%=ans_count%> answer </td></tr>
                                <tr><td style="float:right;padding: 5px;"> <%=count_view%> views </td></tr>
                            </table>
                        </div>
                        <div class="col-sm-9">
                            <table class="tabel" cellpadding="5px">
                                <tr>
                                    <td><a href="answer.jsp?code=<%=rs1.getString("code")%>" style="font-size: 20px;padding-left:10px;text-decoration:none;"><%=rs1.getString("title")%></a></td>
                                 </tr>
                                <tr>
                                    <td style="padding-left:15px;">
                                        <%
                                            String s[] = rs1.getString("tags").split(",");
                                            for(int i=0;i<s.length;i++){
                                        %>
                                        <button class="w3-button w3-tiny w3-round" style="background-color: #ADD8E6;"><%=s[i]%></button>
                                        <%
                                            }
                                        %>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-sm-2">
                            <%
                                String que_date[] = rs1.getString("date").split("at");
                                String from_email = rs1.getString("from_email");
                                Statement sn2 = cn.createStatement();
                                ResultSet rs2 = sn2.executeQuery("select * from user where email='"+from_email+"'");
                                if(rs2.next()){
                            %>
                            <table class="tabel" cellpadding="5px">
                                <tr>
                                <img src="users/<%=rs2.getString("code")%>.jpg" style="width: 30px;height: 30px;" class="img-fluid rounded">&nbsp;
                                    <%=rs2.getString("username")%>
                                </tr>
                                <tr><td style="padding-top: 10px"><%=que_date[0]%></td></tr>
                                <tr><td style="padding-top: 10px"><%=que_date[1]%></td></tr>
                            </table>
                            <%
                                }
                            %>
                        </div>
                    </div>
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
