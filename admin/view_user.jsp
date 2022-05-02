<%-- 
    Document   : view_user
    Created on : 1 May, 2022, 9:55:14 AM
    Author     : hp
--%>
<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>

<%
    String email = null;
    Cookie c[] = request.getCookies();
    for(int i=0;i<c.length;i++){
        if(c[i].getName().equals("login")){
            email = c[i].getValue();
            break;
        }
    }
    if(email==null && session.getAttribute(email)==null){
        response.sendRedirect("index.jsp");
    }
    else{
        if(request.getParameter("code").length()!=0){
            String user_code = request.getParameter("code");
            try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/stackoverflow","root","");
                Statement st = cn.createStatement();
                ResultSet rs = st.executeQuery("select * from user where code='"+user_code+"'");
                if(rs.next()){

                %>
                <span id="store" prel="" pid="" prec="0"></span>
                <div class="container-fluid px-4">
                    <h1 class="mt-4"><b>Admin Panel</b></h1>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item active">View User Data</li>
                    </ol><br><br>
                    <div class="row">
                        <div class="col-sm-2"><img src="../users/<%=rs.getString("code")%>.jpg" class="img-fluid"></div>
                        <div class="col-sm-8">
                            <table class="table table-borderless" align="center">
                                <tr><td><h2><%=rs.getString("username")%></h2></td></tr>
                                <tr><td><i class="fa fa-envelope-o" aria-hidden="true"></i> <%=rs.getString("email")%></td></tr>
                            </table>
                        </div>
                    </div><br><br>
                    <div class="row">
                        <div class="col-sm-10">
                            <h4>Tags</h4><br>
                            <div class="container-lg card w3-round">
                                <table class="table table-borderless">
                                    <tr>
                                        <td>
                                            <%
                                                String tag[] = rs.getString("tags").split(",");
                                                for(int i=0;i<tag.length;i++){
                                            %>
                                            <button class="w3-button w3-tiny w3-round" style="background-color: #ADD8E6;"><%=tag[i]%></button>
                                            <%
                                                }
                                            %>    
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div><br><br>
                    <div class="row">
                        <div class="col-sm-12">
                            <h4>Questions</h4><br>
                        </div>
                        <%
                            Statement sn1 = cn.createStatement();
                            ResultSet rs1 = sn1.executeQuery("select * from question where status='0' AND from_email='"+rs.getString("email")+"' order by sn desc");
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
                        <div class="col-sm-12" style="border-bottom: 0.5px ridge wheat;border-top: 0.5px ridge wheat;" id="del-<%=rs1.getString("code")%>">
                            <div class="row" style="padding:10px;">
                                <div class="col-sm-2">
                                    <table class="tabel " cellpadding="5px">
                                        <tr><td style="float:right;padding: 5px;"> <%=count_vote%> votes </td></tr>
                                        <tr><td style="float:right;padding: 5px;"> <%=ans_count%> answer </td></tr>
                                        <tr><td style="float:right;padding: 5px;"> <%=count_view%> views </td></tr>
                                    </table>
                                </div>
                                <div class="col-sm-8">
                                    <table class="tabel" cellpadding="5px">
                                        <tr>
                                            <td><a style="font-size: 20px;padding-left:10px;text-decoration:none;"><%=rs1.getString("title")%></a></td>
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
                                    <table class="tabel" cellpadding="5px">
                                        <tr>
                                            <td>
                                                <button class="fa fa-exclamation-circle w3-button w3-yellow" id="<%=rs1.getString("code")%>" title="Give warning to user"> Warning</button>
                                            </td>
                                            <td>
                                                <button class="fa fa-trash w3-button w3-red" rel="<%=rs1.getString("code")%>" title="Delete user question"> Delete</button>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <%
                            }
                           %>
                    </div><br><br>
                    <div class="row">
                        <div class="col-sm-12">
                            <h4>Answers</h4><br>
                        </div>
                        <%
                            Statement sn6 = cn.createStatement();
                            ResultSet rs6 = sn6.executeQuery("select * from answer where status='0' AND from_email='"+rs.getString("email")+"' order by sn desc");
                            while(rs6.next()){
                                int count_useful = 0;
                                Statement sn7 = cn.createStatement();
                                ResultSet rs7 = sn7.executeQuery("select count(*) from ans_useful where ans_code='"+rs6.getString("code")+"'");
                                if(rs7.next()){
                                    count_useful = Integer.parseInt(rs7.getString("count(*)"));
                                }
                                Statement sn8 = cn.createStatement();
                                ResultSet rs8 = sn8.executeQuery("select * from question where code='"+rs6.getString("que_code")+"'");
                                if(rs8.next()){
                          %>
                        <div class="col-sm-12" id="del-<%=rs6.getString("code")%>" style="border-bottom: 0.5px ridge wheat;border-top: 0.5px ridge wheat;">
                            <div class="row" style="padding:10px;">
                                <div class="col-sm-2">
                                    <table class="tabel">
                                        <tr>
                                            <td>
                                                <button class="w3-button w3-blue" title="Useful"><%=count_useful%> Useful</button>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="col-sm-8">
                                    <table class="tabel" cellpadding="5px">
                                        <tr><td><%=rs8.getString("title")%></td></tr>
                                        <tr><td><pre><%=rs6.getString("ans")%></pre></td></tr>
                                    </table>
                                </div>
                                <div class="col-sm-2">
                                    <table class="tabel">
                                        <tr>
                                            <td>
                                                <button id="warning-ans" rel="<%=rs6.getString("code")%>" class="fa fa-exclamation-circle w3-button w3-yellow" title="Give warning to user"> Warning</button>
                                            </td>
                                            <td>
                                                <button id="delete-ans" rel="<%=rs6.getString("code")%>" class="fa fa-trash w3-button w3-red" title="Delete user question"> Delete</button>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <%
                                }
                            }
                           %>
                    </div>
                </div>
                <%
                }
                else{
                    response.sendRedirect("index.jsp?email_invalid=1");
                }
                cn.close();
           }
           catch(Exception ec){
             out.println(ec.getMessage());
           } 
        }
   }               
%>