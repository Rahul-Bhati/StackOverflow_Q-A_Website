<%-- 
    Document   : user
    Created on : 25 Apr, 2022, 5:58:54 PM
    Author     : hp
--%>

<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>

<%
  try{
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
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/stackoverflow","root","");
                    Statement st = cn.createStatement();
                    ResultSet rs = st.executeQuery("select * from admin where email='"+email+"'");
                    if(rs.next()){
    
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Stack Overflow</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
        <link href="css/styles.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <script src="https://use.fontawesome.com/09901d9403.js"></script>
        <link rel="shortcut icon" href="../images/favi.png" />
        <style>
            textarea{
                resize: none;
            }
            pre {
                overflow-x: auto;
                white-space: pre-wrap;
                white-space: -moz-pre-wrap;
                white-space: -pre-wrap;
                white-space: -o-pre-wrap;
                word-wrap: break-word;
                font-family: verdana;
                background-color: windowframe;
                padding: 5px;
            }
        </style>
        <script>
            $(document).ready(function(){
                $(".fa.fa-ban").click(function(){
                    var code = $(this).attr("rel");
                    $.post(
                          "block.jsp",{code:code},function(data){
                                if(data.trim()=="block"){
                                    $("#"+code).text("Unblock");
                                }
                                else if(data.trim()=="unblock"){
                                    $("#"+code).text("Block");
                                }
                          }
                    );
                });
                $(".btn.btn-info").click(function(){
                    var code = $(this).attr("rel");
                    $.post(
                          "view_user.jsp",{code:code},function(data){
                                $("#record").html(data);
                          }
                    );
                });
            });

/*====================================== warning or delete for question with jquery start ===============================================*/

            $(document).on("click",".fa.fa-exclamation-circle",function(){
                var code = $(this).attr("id");
                $.post(
                      "warning_que.jsp",{code:code},function(data){
                            if(data.trim()=="success")
                                $("#myModal").modal();
                            else if(data.trim()=="block")
                                $("#block").modal();
                            if(data.trim()=="index")
                                $("#login").modal();
                      }
                );
            });
            $(document).on("click",".fa.fa-trash",function(){
                var code = $(this).attr("rel");
                $.post(
                      "del_user_que.jsp",{code:code},function(data){
                            if(data.trim()=="success"){
                                $("#del-"+code).fadeOut(500);
                                $("#delSuccess").modal();
                            }
                            if(data.trim()=="index")
                                $("#login").modal();
                      }
                );
            });
/*====================================== warning or delete for question with jquery start ===============================================*/
            
            
/*====================================== warning or delete for answer with jquery start ===============================================*/
            $(document).on("click","#warning-ans",function(){
                var code = $(this).attr("rel");
                $.post(
                      "warning_ans.jsp",{code:code},function(data){
                            if(data.trim()=="success")
                                $("#myModal").modal();
                            else if(data.trim()=="block")
                                $("#block").modal();
                            if(data.trim()=="index")
                                $("#login").modal();
                      }
                );
            });
            $(document).on("click","#delete-ans",function(){
                var code = $(this).attr("rel");
                $.post(
                      "del_user_answer.jsp",{code:code},function(data){
                            alert(data.trim());
                            if(data.trim()=="success"){
                                $("#del-"+code).fadeOut(500);
                                $("#delSuccess").modal();
                            }
                            if(data.trim()=="index")
                                $("#login").modal();
                      }
                );
            });
/*====================================== warning or delete for answer with jquery end ===============================================*/

        </script>
    </head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="dashboard.jsp">Stack Overflow</a>
            <!-- Sidebar Toggle-->
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fa fa-bars"></i></button>
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
                            <div class="sb-sidenav-menu-heading">Core</div>
                            <a class="nav-link" href="dashboard.jsp">
                                <div class="sb-nav-link-icon"><i class="fa fa-tachometer" aria-hidden="true"></i></div>
                                Dashboard
                            </a>
                            <div class="sb-sidenav-menu-heading">Interface</div>
                            <a class="nav-link" href="category.jsp"><i class="fa fa-book" aria-hidden="true"></i>&nbsp;&nbsp;Category</a>
                            <a class="nav-link" href="user.jsp"><i class="fa fa-user" aria-hidden="true"></i>&nbsp;&nbsp;Users</a>
                            <a class="nav-link" href="logout.jsp"><i class="fa fa-sign-out"></i>&nbsp;&nbsp;Logout</a>
                        </div>
                    </div>
                    <div class="sb-sidenav-footer">
                        <div class="small">Logged in as:</div>
                        <%=rs.getString("email")%>
                    </div>
                </nav>
            </div>
            <div id="layoutSidenav_content">
                <main id="record">
                    <span id="store" prel="" pid="" prec="0"></span>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4"><b>Admin Panel</b></h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">All Users</li>
                        </ol><br><br>
                        <div class="row" >
                        <div class="col-sm-12">
                            <div class="container-fluid px-4">
                                <%
                                    Statement st1 = cn.createStatement();
                                    ResultSet rs1 = st1.executeQuery("select * from user");
                                    while(rs1.next()){
                                        %>
                                        <table class="table ">
                                            <tr >
                                                <td style="width:100px" ><%=rs1.getString("username")%></td>                                                
                                                <td style="width:100px" ><%=rs1.getString("email")%></td>
                                                <td style="width:100px" ><%=rs1.getString("tags")%></td>
                                                <td  style="width:100px">
                                                    <button class="btn btn-info" rel="<%=rs1.getString("code")%>" title="view" style="cursor:pointer">View <i class="fa fa-eye"></i></button>
                                                </td>
                                                <td  style="width:100px">
                                                    <%
                                                        if(rs1.getString("status").equals("0")){
                                                      %>      
                                                      <button rel="<%=rs1.getString("code")%>" class="fa fa-ban w3-button w3-red" title="Block" style="cursor:pointer"> <span id="<%=rs1.getString("code")%>">Block</span></button>
                                                    <%
                                                        }
                                                        else if(rs1.getString("status").equals("1")){
                                                       %>
                                                       <button rel="<%=rs1.getString("code")%>" class="fa fa-ban w3-button w3-red" title="Unblock" style="cursor:pointer"> <span id="<%=rs1.getString("code")%>">Unblock</span></button>
                                                    <%
                                                        }
                                                        %>
                                                </td>
                                            </tr>
                                        </table>
                                           <%
                                    }
                                %>
                                </div>
                            </div>
                        </div>
                    </div><br><br>
                </main>
                <footer class="py-4 bg-light mt-auto">
                    <div class="container-fluid px-4">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted">Copyright &copy; Your Website 2022</div>
                            <div>
                                <a href="#">Privacy Policy</a>
                                &middot;
                                <a href="#">Terms &amp; Conditions</a>
                            </div>
                        </div>
                    </div>
                </footer>
            
        </div>
         <div class="modal" id="myModal">
            <div class="modal-dialog">
                <div class="modal-content">
                  <!-- Modal Header -->
                  <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                  </div>
                  <!-- Modal body -->
                  <div class="modal-body">
                      <h4 class="alert alert-warning" style="font-size:15px;">Warning given . Succesfully !</h4>
                  </div>
                </div>
            </div>
        </div>
        <div class="modal" id="delSuccess">
            <div class="modal-dialog">
                <div class="modal-content">
                  <!-- Modal Header -->
                  <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                  </div>
                  <!-- Modal body -->
                  <div class="modal-body">
                      <h4 class="alert alert-success" style="font-size:15px;">Question Deleted. Successfully !</h4>
                  </div>
                </div>
            </div>
        </div>
        <div class="modal" id="login">
            <div class="modal-dialog">
                <div class="modal-content">
                  <!-- Modal Header -->
                  <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                  </div>
                  <!-- Modal body -->
                  <div class="modal-body">
                      <h4 class="alert alert-danger" style="font-size:15px;">Login First !</h4>
                  </div>
                </div>
            </div>
        </div>
        <div class="modal" id="block">
            <div class="modal-dialog">
                <div class="modal-content">
                  <!-- Modal Header -->
                  <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                  </div>
                  <!-- Modal body -->
                  <div class="modal-body">
                      <h4 class="alert alert-warning" style="font-size:15px;">User Blocked !</h4>
                  </div>
                </div>
            </div>
        </div>
        </div>
        <script src="js/scripts.js"></script>
        <script src="js/datatables-simple-demo.js"></script>
    </body>
</html>

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
    catch(NullPointerException e){
        response.sendRedirect("index.jsp");
    }               
%>
