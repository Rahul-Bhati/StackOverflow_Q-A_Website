<%-- 
    Document   : ans_insert
    Created on : 28 Apr, 2022, 10:17:36 AM
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
                String que_code = request.getParameter("code");
                String ans = request.getParameter("ans");
                
                int sn = 0;
                String code = "";
                LinkedList l = new LinkedList();
                for(char ch='A' ; ch<='Z' ; ch++){
                    l.add(ch+"");
                }
                for(char ch='a' ; ch<='z' ; ch++){
                    l.add(ch+"");
                }
                for(char ch='0' ; ch<='9' ; ch++){
                    l.add(ch+"");
                }
                Collections.shuffle(l);
                for(int i=0 ; i<6 ; i++){
                    code = code+l.get(i);
                }
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/stackoverflow","root","");
                    Statement st = cn.createStatement();
                    ResultSet rs = st.executeQuery("select MAX(sn) from answer");
                    if(rs.next()){
                         sn = rs.getInt(1);   
                    }
                    sn = sn + 1 ;
                    code = code+"_"+sn;  
                    String status = "0";
                    String date;
                    Date dNow = new Date( );
                    SimpleDateFormat ft = new SimpleDateFormat ("E yyyy.MM.dd 'at' hh:mm:ss a zzz");
                    date = ft.format(dNow);
                    PreparedStatement ps = cn.prepareStatement("insert into answer values(?,?,?,?,?,?,?,?)");
                    ps.setInt(1, sn);
                    ps.setString(2, code);
                    ps.setString(3, ans);
                    ps.setString(4, que_code);
                    ps.setString(5, cemail);
                    ps.setString(6, date);
                    ps.setString(7, status);
                    ps.setInt(8, 0);
                    if(ps.executeUpdate()>0){
                         %>
                         <div class="row" id="del-<%=code%>">
                               <div class="col-sm-9" id="ans-<%=code%>">
                                   <pre><%=ans%></pre><br>
                               </div>
                               <div class="col-sm-1">
                                    <table class="tabel" cellpadding="5px">
                                        <tr>
                                            <td><i rel="<%=code%>" style="color:blue;" title="edit" class="fa fa-edit" ></i></td>
                                            <td><i rel="<%=code%>" style="color:red;" title="delete" class="fa fa-trash"></i></td>
                                        </tr>
                                    </table>
                               </div>
                               <div class="col-sm-2">
                                   <%
                                       Statement sn5 = cn.createStatement();
                                       ResultSet rs5 = sn5.executeQuery("select * from user where email='"+cemail+"'");
                                       if(rs5.next()){
                                   %>
                                   <table class="tabel" cellpadding="5px">
                                       <tr>
                                       <img src="users/<%=rs5.getString("code")%>.jpg" style="width: 30px;height: 30px;" class="img-fluid rounded">&nbsp;
                                           <%=rs5.getString("username")%>
                                       </tr>
                                       <tr><td style="padding-top: 10px"><%=date%></td></tr>
                                   </table>
                                   <%
                                       }
                                   %>
                               </div>
                           </div><br>
                         <%
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