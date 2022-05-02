<%-- 
    Document   : ask_que_insert
    Created on : 26 Apr, 2022, 7:39:32 PM
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
            response.sendRedirect("index.jsp");
        }
        else{
            if(request.getParameter("title").length()!=0 && request.getParameter("detail").length()!=0){
                String title = request.getParameter("title");
                String detail = request.getParameter("detail");
                String ptr = "";
                String s[] = request.getParameterValues("checkbox");
                String tags = "";
                if (s != null && s.length != 0) {
                    for (int i = 0; i < s.length; i++) {
                        tags = tags + ptr + s[i];
                        ptr = ",";
                    }
                }
                
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
                    ResultSet rs = st.executeQuery("select MAX(sn) from question");
                    if(rs.next()){
                         sn = rs.getInt(1);   
                    }
                    sn = sn + 1 ;
                    int warning = 0;
                    code = code+"_"+sn;  
                    String status = "0";
                    String date;
                    Date dNow = new Date( );
                    SimpleDateFormat ft = new SimpleDateFormat ("E yyyy.MM.dd 'at' hh:mm:ss a zzz");
                    date = ft.format(dNow);
                    PreparedStatement ps = cn.prepareStatement("insert into question values(?,?,?,?,?,?,?,?,?)");
                    ps.setInt(1, sn);
                    ps.setString(2, code);
                    ps.setString(3, title);
                    ps.setString(4, detail);
                    ps.setString(5, tags);
                    ps.setString(6, cemail);
                    ps.setString(7, date);
                    ps.setString(8, status);
                    ps.setInt(9, warning);
                    if(ps.executeUpdate()>0){
                         response.sendRedirect("ask_que.jsp?success=1");
                    }
                    else{
                        response.sendRedirect("ask_que.jsp?again=1");
                    }
                    cn.close();
                }
                catch(Exception ec){
                    out.println(ec.getMessage());
                } 
            }
            else{
                response.sendRedirect("ask_que.jsp?empty=1");
            }
        }
%>