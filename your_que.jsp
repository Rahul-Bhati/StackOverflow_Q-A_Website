<%-- 
    Document   : your_que
    Created on : 27 Apr, 2022, 1:56:15 PM
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
        if(email==null && session.getAttribute(email)==null){
            response.sendRedirect("index.jsp");
        }
        else{
            try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/stackoverflow","root","");  
                Statement st = cn.createStatement();
                ResultSet rs = st.executeQuery("select * from user where email='"+email+"'");
                if(rs.next()){
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
  <style>
      pre {
        overflow-x: auto;
        white-space: pre-wrap;
        white-space: -moz-pre-wrap;
        white-space: -pre-wrap;
        white-space: -o-pre-wrap;
        word-wrap: break-word;
        font-family: verdana;
      }
      textarea{
          resize: none;
      }
      table{
          cursor: pointer;
      }
  </style>
  <script>
        
        $(document).on("click",".fa.fa-edit",function(){
            var code = $(this).attr("rel");
            var t = $("#t-"+code).text();
            var dt = $("#dt-"+code).text();
            $("#t-"+code).html("<input type='text' value='"+t+"' id='s-"+code+"' class='form-control' />");
            $("#dt-"+code).html("<textarea type='text' id='sd-"+code+"' rows='13' class='form-control'>"+dt+"</textarea>");
            $(this).attr("class","fa fa-save");
        });
        $(document).on("click",".fa.fa-save",function(){
                var code = $(this).attr("rel");
                var t = $("#s-"+code).val();
                var dt = $("#sd-"+code).val();
                $.post(
                    "update_que.jsp",{code:code,title:t,detail:dt},function(data){
                        if(data.trim()=="success"){
                            $("#t-"+code).text(t);
                            $("#dt-"+code).text(dt);
                            $("#"+code).attr("class","fa fa-edit");
                        }
                        else if(data.trim()=="again"){
                            $("#again").modal();
                        }
                        else if(data.trim()=="empty"){
                            $("#empty").modal();
                        }
                    }
                );
        });
        $(document).on("click",".fa.fa-trash",function(){
            var code = $(this).attr("rel");
            $.post(
                    "del_que.jsp",{code:code},function(data){
                          if(data.trim()=="success"){
                              $("#d-"+code).fadeOut(500);
                          }
                    }
              );
        });
        $(document).ready(function(){
          $(".search").keyup(function(){
                var val = $(this).val();
                if(val.length>0){
                    $.post(
                          "your_que_search.jsp",{sch:val},function(data){
                                $("#que").css("display","none");
                                $("#sch").css("display","block");
                                $("#sch").html(data);
                          }
                    );
                }
                else if(val.length==0){
                    $("#que").css("display","block");
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
              <input type="text" class="form-control search" placeholder="Search Question.." aria-label="search" aria-describedby="search">
            </div>
          </li>
        </ul>
        <ul class="navbar-nav navbar-nav-right">
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
                <a href="profile.jsp" class="dropdown-item preview-item">               
                    <i class="icon-head"></i> Profile
                </a>
                <a href="logout.jsp" class="dropdown-item preview-item">
                    <i class="fa fa-sign-out"></i> Logout
                </a>
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
                    <li class="nav-item"> <a class="nav-link" href="logout.jsp"> Logout </a></li>
              </ul>
            </div>
          </li>
        </ul>
      </nav>
      <!-- partial -->
      <div class="main-panel">
        <div class="content-wrapper">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-sm-10">
                        <h3 style="color:black">Your Questions</h3>
                    </div>
                    <div class="col-sm-2">
                        <button class="btn btn-primary"><a style="text-decoration: none;color: white;" href="ask_que.jsp">Ask Question</a></button>
                    </div>
                </div><br>
                <div class="row" id="sch"></div>
                <div class="row" id="que">
                    <%
                        int block=0;
                        Statement sn1 = cn.createStatement();
                        ResultSet rs1 = sn1.executeQuery("select * from question where from_email='"+email+"' AND status='0' order by sn desc");
                        while(rs1.next()){
                            block=1;
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
                                            String s[] = rs1.getString("tags").split(",");
                                            for(int i=0;i<s.length;i++){
                                        %>
                                        <button class="w3-button w3-tiny w3-round" style="background-color: #ADD8E6;"><%=s[i]%></button>
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
                        if(block==0){
                            %>
                            <div class="col-sm-12"><center>You are Blocked by admin</center></div>
                            <%
                        }
                       %>
                </div>
                <script>
                    
                </script>
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
            
            <div class="modal" id="empty">
                <div class="modal-dialog">
                    <div class="modal-content">
                      <!-- Modal Header -->
                      <div class="modal-header">
                          <center><h3>Alert</h3></center>
                          <button type="button" class="close" data-dismiss="modal">&times;</button>
                      </div>
                      <!-- Modal body -->
                      <div class="modal-body">
                          <h4 class="alert alert-warning" style="font-size:15px;">Field Required ! Please Fill Answer Before Submit.</h4>
                      </div>
                    </div>
                </div>
            </div>
            <div class="modal" id="again">
                <div class="modal-dialog">
                    <div class="modal-content">
                      <!-- Modal Header -->
                      <div class="modal-header">
                          <center><h3>Alert</h3></center>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                      </div>
                      <!-- Modal body -->
                      <div class="modal-body">
                          <h4 class="alert alert-warning" style="font-size:15px;">Try Again !</h4>
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