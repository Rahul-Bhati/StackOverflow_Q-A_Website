<%-- 
    Document   : tags
    Created on : 28 Apr, 2022, 6:29:42 PM
    Author     : hp
--%>

<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>

<%
    try{
        String email = null;
        int flag=0;
        Cookie c[] = request.getCookies();
        for(int i=0;i<c.length;i++){
            if(c[i].getName().equals("user")){
                email = c[i].getValue();
                break;
            }
        }
        if(email!=null && session.getAttribute(email)!=null){
            flag=1;
        }
        else{
            flag=0;
        }
        try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/stackoverflow","root","");  
%>
<!DOCTYPE html>
<html lang="en">

<head>
  <!-- Required meta tags --> 
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>StackOverflow - Q & A website</title>
  <!-- base:css -->
  <link rel="stylesheet" href="vendors/mdi/css/materialdesignicons.min.css">
  <link rel="stylesheet" href="vendors/feather/feather.css">
  <link rel="stylesheet" href="vendors/base/vendor.bundle.base.css">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

  <!-- endinject -->
  <!-- plugin css for this page -->
  <link rel="stylesheet" href="vendors/flag-icon-css/css/flag-icon.min.css"/>
  <link rel="stylesheet" href="vendors/font-awesome/css/font-awesome.min.css">
  <link rel="stylesheet" href="vendors/jquery-bar-rating/fontawesome-stars-o.css">
  <link rel="stylesheet" href="vendors/jquery-bar-rating/fontawesome-stars.css">
  <!-- End plugin css for this page -->
  <!-- inject:css -->
  <link rel="stylesheet" href="css/style.css">
  <!-- endinject -->
  <link rel="shortcut icon" href="images/favi.png" />
  
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script>
      $(document).ready(function(){
          $(".search").keyup(function(){
                var val = $(this).val();
                if(val.length>0){
                    $.post(
                          "search_tag.jsp",{sch:val},function(data){
                                $("#data").css("display","none");
                                $("#sch").css("display","block");
                                $("#sch").html(data);
                          }
                    );
                }
                else if(val.length==0){
                    $("#data").css("display","block");
                    $("#sch").css("display","none");
                }
          });
      });
  </script>
</head>
<body>
  <div class="container-scroller">
    <!-- partial:partials/_navbar.html -->
    <nav class="navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
      <div class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-center">
        <a class="navbar-brand brand-logo" href="index.jsp"><img src="images/logo.png" alt="logo"/></a>
        <a class="navbar-brand brand-logo-mini" href="index.jsp"><img src="images/logo-mini.png" alt="logo"/></a>
      </div>
      <div class="navbar-menu-wrapper d-flex align-items-center justify-content-end">
        <button class="navbar-toggler navbar-toggler align-self-center" type="button" data-toggle="minimize">
          <span class="icon-menu"></span>
        </button>
        <ul class="navbar-nav mr-lg-2">
          <li class="nav-item nav-search d-none d-lg-block">
            <div class="input-group">
              <div class="input-group-prepend">
                <span class="input-group-text" id="search">
                  <i class="icon-search"></i>
                </span>
              </div>
              <input type="text" class="form-control search" placeholder="Search Tags.." aria-label="search" aria-describedby="search">
            </div>
          </li>
        </ul>
        <ul class="navbar-nav navbar-nav-right">
            <%
               if(flag==0){
              %>
            <li class="nav-item dropdown d-lg-flex d-none">
                <a href="register.jsp"><button type="button" class="btn btn-info font-weight-bold">+ Create New</button></a>
            </li>
            <%
               }
               %>
         <!--   Message show 
            <li class="nav-item dropdown d-flex">
            <a class="nav-link count-indicator dropdown-toggle d-flex justify-content-center align-items-center" id="messageDropdown" href="#" data-toggle="dropdown">
              <i class="icon-air-play mx-0"></i>
            </a>

<div class="dropdown-menu dropdown-menu-right navbar-dropdown preview-list" aria-labelledby="messageDropdown">
              <p class="mb-0 font-weight-normal float-left dropdown-header">Messages</p>
              <a class="dropdown-item preview-item">
                <div class="preview-thumbnail">
                    <img src="images/faces/face4.jpg" alt="image" class="profile-pic">
                </div>
                <div class="preview-item-content flex-grow">
                  <h6 class="preview-subject ellipsis font-weight-normal">David Grey
                  </h6>
                  <p class="font-weight-light small-text text-muted mb-0">
                    The meeting is cancelled
                  </p>
                </div>
              </a>
            </div>
          </li>
         -->
          <li class="nav-item dropdown d-flex mr-4 ">
            <a class="nav-link count-indicator dropdown-toggle d-flex align-items-center justify-content-center" id="notificationDropdown" href="#" data-toggle="dropdown">
              <i class="icon-cog"></i>
            </a>
            <div class="dropdown-menu dropdown-menu-right navbar-dropdown preview-list" aria-labelledby="notificationDropdown">
              <p class="mb-0 font-weight-normal float-left dropdown-header">Settings</p>
              <%
                if(flag==1){   
               %>
                <a href="profile.jsp" class="dropdown-item preview-item">               
                    <i class="icon-head"></i> Profile
                </a>
                <a href="logout.jsp" class="dropdown-item preview-item">
                    <i class="fa fa-sign-out"></i> Logout
                </a>
               <%
                }
                else{
                %>
                <a href="register.jsp" class="dropdown-item preview-item">               
                    <i class="fa fa-user-plus"></i> Register
                </a>
                <a href="login.jsp" class="dropdown-item preview-item">
                    <i class="fa fa-sign-in"></i> Login
                </a>
                <%
                }
                %>
            </div>
          </li>
        </ul>
        <button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button" data-toggle="offcanvas">
          <span class="icon-menu"></span>
        </button>
      </div>
    </nav>
    <!-- partial -->
    <div class="container-fluid page-body-wrapper">
      <!-- partial:partials/_sidebar.html -->
      <nav class="sidebar sidebar-offcanvas" id="sidebar">
      <%
        if(flag==1){
            Statement st = cn.createStatement();
            ResultSet rs = st.executeQuery("select * from user where email='"+email+"'");
            if(rs.next()){
        %>
        <div class="user-profile">
          <div class="user-image">
              <img src="users/<%=rs.getString("code")%>.jpg">
          </div>
          <div class="user-name">
              <%=rs.getString("username")%>
          </div>
          <div class="user-designation">
              
          </div>
        </div>
     <%
                }
        }
        else{
        %>
         <div class="user-profile">
          <div class="user-image">
               <i class="fa fa-user-circle-o" aria-hidden="true" style=""></i>
          </div>
          <div class="user-name">
                Login 
          </div>
          <div class="user-designation">
<!--              Developer-->
          </div>
        </div>
        <%
        }      
      %>
        <ul class="nav">
          <li class="nav-item">
            <a class="nav-link" href="index.jsp">
              <i class="icon-box menu-icon"></i>
              <span class="menu-title">Home</span>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="tags.jsp">
              <i class="icon-box menu-icon fa fa-tags"></i>
              <span class="menu-title">Tags</span>
            </a>
          </li>
          <%
                if(flag==1){     
             %>
          <li class="nav-item">
            <a class="nav-link" href="ask_que.jsp">
              <i class="icon-box menu-icon fa fa-commenting"></i>
              <span class="menu-title">Ask Question</span>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="your_que.jsp">
              <i class="icon-box menu-icon fa fa-book"></i>
              <span class="menu-title">Your Question</span>
            </a>
          </li>
          <%
                }
           %>
          <li class="nav-item">
            <a class="nav-link" href="question.jsp">
              <i class="icon-box menu-icon fa fa-globe"></i>
              <span class="menu-title">Questions</span>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" data-toggle="collapse" href="#auth" aria-expanded="false" aria-controls="auth">
              <i class="icon-head menu-icon"></i>
              <span class="menu-title">User Pages</span>
              <i class="menu-arrow"></i>
            </a>
            <div class="collapse" id="auth">
              <ul class="nav flex-column sub-menu">
              <%
                if(flag==1){
                %>
                    <li class="nav-item"> <a class="nav-link" href="logout.jsp"> Logout </a></li>
              <%
                }
                else{
                %>
                    <li class="nav-item"> <a class="nav-link" href="login.jsp"> Login </a></li>
                    <li class="nav-item"> <a class="nav-link" href="register.jsp"> Register </a></li>
                <%
                }
                %>
              </ul>
            </div>
          </li>
        </ul>
      </nav>
      <!-- partial -->
      <div class="main-panel">
        <div class="content-wrapper">
            <div class="row">
                <div class="col-sm-10">
                    <h3 style="color:black">Tags</h3><br>
                    <p style="background-color:#f4f7fa;font-size: 18px;">A tag is a keyword or label that categorizes your question with other, similar questions. 
                        <br>Using the right tags makes it easier for others to find and answer your question.</p>
                </div>
                <div class="col-sm-2">
                    <button class="btn btn-primary"><a style="text-decoration: none;color: white;" href="ask_que.jsp">Ask Question</a></button>
                </div>
                <script>
                    $(document).on("click",".btn.btn-primary",function(){
                        if(<%=email%>==null){
                            $("#myModal").modal();
                        }
                    });
                </script>
            </div><br>
            <div class="row">
                <div class="col-sm-10"></div>
                <div class="col-sm-2">
                    <div class="btn-group btn-group-toggle" data-toggle="buttons">
                        <label class="btn btn-secondary active">
                            <input type="radio" name="options" onclick="event()" id="option1" autocomplete="off" checked> Name
                        </label>
                        <label class="btn btn-secondary">
                          <input type="radio" name="options" id="option3" autocomplete="off"> New
                        </label>
                    </div>
                    <script>
                       $(document).ready(function(){
                           $(".btn.btn-secondary").click(function(){
                               var sort = $(this).text();
                               $.post(
                                     "tag_sort.jsp",{sort:sort},function(data){
                                         $("#sort").html(data);
                                     }
                               );
                           });
                       });
                    </script>
                </div>
            </div><br>
            <div class="container-fluid" id="sch"></div>
            <div class="container-fluid" id="data">
                <div class="row" id="sort">
                    <%
                        Statement st1 = cn.createStatement();
                        ResultSet rs1 = st1.executeQuery("select * from category ORDER BY category_name ASC");
                        while(rs1.next()){
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
                                    String s[] = detail.split(" ");
                                    for(int i=0;i<s.length;i++){
                                        out.print(s[i]+" ");
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
                    %>
                </div>
            </div>
        </div>
          <div class="container-fluid">
            <!-- The Modal -->
            <div class="modal" id="myModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                      <!-- Modal Header -->
                      <div class="modal-header">
                          <center><h3>Alert</h3></center>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                      </div>
                      <!-- Modal body -->
                      <div class="modal-body">
                          <h4 class="alert alert-danger" style="font-size:15px;">Login First ! Please Login Before Submit Answer.</h4>
                      </div>
                    </div>
                </div>
            </div>
          </div>
        <!-- content-wrapper ends -->
        <!-- partial:partials/_footer.html -->
        <style>
            .footer-clean {
                padding:50px 0;
                background-color:#fff;
                color:#4b4c4d;
              }

              .footer-clean h3 {
                margin-top:0;
                margin-bottom:12px;
                font-weight:bold;
                font-size:16px;
              }

              .footer-clean ul {
                padding:0;
                list-style:none;
                line-height:1.6;
                font-size:14px;
                margin-bottom:0;
              }

              .footer-clean ul a {
                color:inherit;
                text-decoration:none;
                opacity:0.8;
              }

              .footer-clean ul a:hover {
                opacity:1;
              }

              .footer-clean .item.social {
                text-align:right;
              }

              @media (max-width:767px) {
                .footer-clean .item {
                  text-align:center;
                  padding-bottom:20px;
                }
              }

              @media (max-width: 768px) {
                .footer-clean .item.social {
                  text-align:center;
                }
              }

              .footer-clean .item.social > a {
                font-size:24px;
                width:40px;
                height:40px;
                line-height:40px;
                display:inline-block;
                text-align:center;
                border-radius:50%;
                border:1px solid #ccc;
                margin-left:10px;
                margin-top:22px;
                color:inherit;
                opacity:0.75;
              }

              .footer-clean .item.social > a:hover {
                opacity:0.9;
              }

              @media (max-width:991px) {
                .footer-clean .item.social > a {
                  margin-top:40px;
                }
              }

              @media (max-width:767px) {
                .footer-clean .item.social > a {
                  margin-top:10px;
                }
              }

              .footer-clean .copyright {
                margin-top:14px;
                margin-bottom:0;
                font-size:13px;
                opacity:0.6;
              }

        </style>
        <div class="footer-clean">
            <footer>
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-sm-4 col-md-3 item">
                            <h3>Pages</h3>
                            <ul>
                                <li><a href="index.jsp">Home</a></li>
                                <li><a href="question.jsp">Questions</a></li>
                                <li><a href="#">Help</a></li>
                            </ul>
                        </div>
                        <div class="col-sm-4 col-md-3 item">
                            <h3>Company</h3>
                            <ul>
                                <li><a href="#">About</a></li>
                                <li><a href="#">Team</a></li>
                                <li><a href="#">Legacy</a></li>
                            </ul>
                        </div>
                        <div class="col-sm-4 col-md-3 item">
                            <h3>Stack Network</h3>
                            <ul>
                                <li><a href="#">Technology</a></li>
                                <li><a href="#">Science</a></li>
                                <li><a href="#">Professional</a></li>
                                <li><a href="#">Busiess</a></li>
                                <li><a href="#">API</a></li>
                            </ul>
                        </div>
                        <div class="col-lg-3 item social">
                            <a href="#">
                                <i class="fa fa-facebook"></i>
                            </a>
                            <a href="#">
                                <i class="fa fa-twitter"></i>
                            </a>
                            <a href="#">
                                <i class="fa fa-snapchat"></i>
                            </a>
                            <a href="#">
                                <i class="fa fa-instagram"></i>
                            </a>
                            <p class="copyright">Stack Qverflow © 2022</p>
                        </div>
                    </div>
                </div>
            </footer>
        </div>
        
        <!-- partial -->
      </div>
      <!-- main-panel ends -->
    </div>
    <!-- page-body-wrapper ends -->
  </div>
  <!-- container-scroller -->

  <!-- base:js -->
  <script src="vendors/base/vendor.bundle.base.js"></script>
  <!-- endinject -->
  <!-- Plugin js for this page-->
  <!-- End plugin js for this page-->
  <!-- inject:js -->
  <script src="js/off-canvas.js"></script>
  <script src="js/hoverable-collapse.js"></script>
  <script src="js/template.js"></script>
  <!-- endinject -->
  <!-- plugin js for this page -->
  <script src="vendors/chart.js/Chart.min.js"></script>
  <script src="vendors/jquery-bar-rating/jquery.barrating.min.js"></script>
  <!-- End plugin js for this page -->
  <!-- Custom js for this page-->
  <script src="js/dashboard.js"></script>
  <!-- End custom js for this page-->
</body>

</html>

<%
            cn.close();
      }
      catch(Exception ec){
        out.println(ec.getMessage());
      } 
    }
    catch(NullPointerException e){
        response.sendRedirect("index.jsp");
    }
%>