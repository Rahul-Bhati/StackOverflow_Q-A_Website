<%-- 
    Document   : registration
    Created on : 26 Apr, 2022, 9:26:51 AM
    Author     : hp
--%>

<%@page contentType="text/html" import="java.sql.*,java.util.*,java.util.Date;" pageEncoding="UTF-8"%>
<%
        String cemail = null;
        Cookie c[] = request.getCookies();
        for(int i=0;i<c.length;i++){
            if(c[i].getName().equals("user")){
                cemail = c[i].getValue();
                break;
            }
        }
        if(cemail!=null && session.getAttribute(cemail)!=null){
            response.sendRedirect("index.jsp");
        }
        else{
            if(request.getParameter("username").length()!=0 && request.getParameter("email").length()!=0 && request.getParameter("pass").length()!=0 && request.getParameter("gender").length()!=0){
                String username = request.getParameter("username");
                String email = request.getParameter("email");
                String pass = request.getParameter("pass");
                String gender = request.getParameter("gender");
                String ptr = "";
                String s[] = request.getParameterValues("checkbox");
                String tags = "";
                if (s != null && s.length != 0) {
                    for (int i = 0; i < s.length; i++) {
                        tags = tags + ptr + s[i];
                        ptr = ",";
                    }
                }
                //out.print(username+" "+email+" "+pass+" "+gender+" "+tags);
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
                    ResultSet rs = st.executeQuery("select MAX(sn) from user");
                    if(rs.next()){
                         sn = rs.getInt(1);   
                    }
                    sn = sn + 1 ;
                    code = code+"_"+sn;  
                    Statement st1 = cn.createStatement();
                    ResultSet rs1 = st1.executeQuery("select * from user where email='"+email+"'");
                    if(rs1.next()){
                        response.sendRedirect("register.jsp?exist=1");
                    }
                    else{
                        String status = "0";
                        PreparedStatement ps = cn.prepareStatement("insert into user values(?,?,?,?,?,?,?,?)");
                        ps.setInt(1, sn);
                        ps.setString(2, code);
                        ps.setString(3, username);
                        ps.setString(4, email);
                        ps.setString(5, pass);
                        ps.setString(6, gender);
                        ps.setString(7, tags);
                        ps.setString(8, status);
                        if(ps.executeUpdate()>0){
                             response.sendRedirect("user_img.jsp?code="+code+"&success=1");
                        }
                    }
                    cn.close();
                }
                catch(Exception ec){
                    out.println(ec.getMessage());
                } 
            }
            else{
                response.sendRedirect("register.jsp?empty=1");
            }
        }
%>