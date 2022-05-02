<%-- 
    Document   : your_que_search
    Created on : 2 May, 2022, 10:00:30 AM
    Author     : hp
--%>

<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>

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
        if(request.getParameter("sch").length()!=0){
            String sch = request.getParameter("sch") ;
            String s[] = sch.split(" ");
            String sql = "select * from question where title like '%"+sch+"%' and status='0' and from_email='"+email+"'";
            for(int i=0;i<s.length;i++){
                sql = sql+"OR title like '%"+s[i]+"%' and status='0' and from_email='"+email+"'";
            }
            try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/stackoverflow","root","");
                int flag=0;
                Statement sn1 = cn.createStatement();
                ResultSet rs1 = sn1.executeQuery(sql);
                while(rs1.next()){
                    flag=1;
                    int ans_count = 0;
                    Statement sn2 = cn.createStatement();
                    ResultSet rs2 = sn2.executeQuery("select count(*) from answer where que_code='"+rs1.getString("code")+"'");
                    if(rs2.next()){
                        ans_count = Integer.parseInt(rs2.getString("count(*)"));
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
                <div class="col-sm-12" id="d-<%=rs1.getString("code")%>" style="border-bottom: 0.5px ridge wheat;border-top: 0.5px ridge wheat;">
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
                                    <td><a id="t-<%=rs1.getString("code")%>" style="font-size: 20px;padding-left:10px;text-decoration:none;"><%=rs1.getString("title")%></a></td>
                                 </tr>
                                <tr>
                                    <td style="padding-left:15px;">
                                    <%
                                        String tag[] = rs1.getString("tags").split(",");
                                        for(int i=0;i<tag.length;i++){
                                    %>
                                    <button class="w3-button w3-tiny w3-round" style="background-color: #ADD8E6;"><%=tag[i]%></button>
                                    <%
                                        }
                                    %>
                                    </td>
                                </tr>
                                <tr>
                                    <td><pre id="dt-<%=rs1.getString("code")%>" style="width:800px;"><%=rs1.getString("detail")%></pre></td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-sm-2">
                           <table class="tabel" cellpadding="5px">
                                <tr>
                                    <td><i id="<%=rs1.getString("code")%>" rel="<%=rs1.getString("code")%>" style="color:blue;" title="edit" class="fa fa-edit" ></i></td>
                                    <td><i rel="<%=rs1.getString("code")%>" style="color:red;" title="delete" class="fa fa-trash"></i></td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
                <%
                }
                if(flag==0){
                    out.print("<h5>question not find..</h5>");
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
    }
    
%>

