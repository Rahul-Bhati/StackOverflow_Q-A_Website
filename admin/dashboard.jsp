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
        <link rel="shortcut icon" href="../images/favi.png" />
        <script src="https://use.fontawesome.com/09901d9403.js"></script>
        <style>
            textarea{
                resize: none;
            }
        </style>
        <script>
            $(document).ready(function(){
                $(".btn.btn-success").click(function(){
                    var cat = $("#category").val();
                    var dt = $("#detail").val();
                    $.post(
                         "add_category.jsp",{cat:cat,detail:dt},function(data){
                                if(data.trim()=="success"){
                                    $("#alert").html("<h5 class='alert alert-success'>Category Added !</h5>");
                                    $("#category").val("");
                                    $("#detail").val("");
                                }
                                else if(data.trim()=="already"){
                                    $("#alert").html("<h5 class='alert alert-success'>Category already exist !</h5>");
                                    $("#detail").val("");
                                    $("#category").val("");
                                }
                         }
                    );
                });
                
            });
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
                            <li class="breadcrumb-item active">Dashboard</li>
                        </ol><br><br>
                        <div class="row">
                            <div class="col-sm-3"></div>
                            <div class="col-sm-6">
                                <div id="alert"></div>
                                <div class="card text-white bg-primary mb-3">
                                    <div class="card-header">Category</div>
                                    <div class="card-body" style="background-color: whitesmoke">
                                        <div id="cat">	
                                            <label class="form-label" style="color: black">Add Category</label>
                                            <input class="form-control"  type="text" name="category" id="category" placeholder="category name" required/><br>
                                            <textarea class="form-control" type="text" id="detail" rows="4" placeholder="Detail.." required></textarea><br>
                                            <button class="btn btn-success">add</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-3"></div>
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