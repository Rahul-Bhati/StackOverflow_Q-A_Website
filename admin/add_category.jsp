<%-- 
    Document   : add_category
    Created on : 23 Apr, 2022, 4:02:02 PM
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
            if(request.getParameter("cat").length()!=0 && request.getParameter("detail").length()!=0){
                String cat = request.getParameter("cat");
                String detail = request.getParameter("detail");
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
                    ResultSet rs = st.executeQuery("select MAX(sn) from category");
                    if(rs.next()){
                         sn = rs.getInt(1);   
                    }
                    sn = sn + 1 ;
                    code = code+"_"+sn;  
                    Statement st1 = cn.createStatement();
                    ResultSet rs1 = st1.executeQuery("select * from category where category_name='"+cat+"'");
                    if(rs1.next()){
                        out.print("already");
                    }
                    else{
                        PreparedStatement ps = cn.prepareStatement("insert into category values(?,?,?,?)");
                        ps.setInt(1, sn);
                        ps.setString(2, code);
                        ps.setString(3, cat);
                        ps.setString(4, detail);
                        if(ps.executeUpdate()>0){
                            out.print("success");
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

