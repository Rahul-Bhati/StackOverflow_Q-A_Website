<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>
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
  <!-- endinject -->
  <!-- plugin css for this page -->
  <!-- End plugin css for this page -->
  <!-- inject:css -->
  <link rel="stylesheet" href="css/style.css">
  <!-- endinject -->
  <link rel="shortcut icon" href="images/favi.png" />
</head>

<body>
  <div class="container-scroller">
    <div class="container-fluid page-body-wrapper full-page-wrapper">
      <div class="content-wrapper d-flex align-items-center auth px-0">
        <div class="row w-100 mx-0">
          <div class="col-lg-4 mx-auto">
              <%
                  if(request.getParameter("success")!=null){
                    out.println("<h6 class='alert alert-success'>Account Created Succesfully. Login Now!</h6>");
                  }
                  else if(request.getParameter("empty")!=null){
                    out.println("<h6 class='alert alert-warning'>All Field Required!</h6>");
                  }
                  else if(request.getParameter("img_code_error")!=null){
                    out.println("<h6 class='alert alert-danger'>Try Again!</h6>");
                  }
                  else if(request.getParameter("img_error")!=null){
                    out.println("<h6 class='alert alert-danger'>Image Not Uploaded!</h6>");
                  }
              %>
            <div class="auth-form-light text-left py-5 px-4 px-sm-5">
              <div class="brand-logo">
                  <a href="index.jsp"><img src="images/logo.png" alt="logo"></a>
              </div>
              <h4>New here?</h4>
              <h6 class="font-weight-light">Signing up is easy. It only takes a few steps</h6>
              <form class="pt-3" method="post" action="registration.jsp">
                <div class="form-group">
                  <label for="name">Username</label>
                  <input type="text" class="form-control form-control-lg" name="username" placeholder="Username">
                </div>
                <div class="form-group">
                  <label for="email">Email</label>
                  <input type="email" class="form-control form-control-lg" name="email" placeholder="Email">
                </div>
                <div class="form-group">
                  <label for="pass">Password</label>
                  <input type="password" class="form-control form-control-lg" name="pass" placeholder="Password">
                </div>
                <div class="form-group">
                    <label for="gender">Gender</label>
                      <select class="form-control form-control-lg" name="gender">
                        <option>Male</option>
                        <option>Female</option>
                      </select>
                </div>
<!--                <div class="form-group">
                    <label>File upload</label>
                    <input type="file" name="img" class="file-upload-default">
                    <div class="input-group col-xs-12">
                      <input type="text" class="form-control file-upload-info form-control-lg" disabled placeholder="Upload Image">
                      <span class="input-group-append">
                        <button class="file-upload-browse btn btn-primary" type="button">Upload</button>
                      </span>
                    </div>
                </div>-->
                <div class="form-group">
                  <label for="gender">Interested Tags</label>
                  <div class="row" style="margin-left: 1px">
                  <%
                    try{
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/stackoverflow","root","");
                        Statement st = cn.createStatement();
                        ResultSet rs = st.executeQuery("select * from category");
                        while(rs.next()){
                  %>   
                            <div class="form-check">
                              <label class="form-check-label">
                                  <input type="checkbox" name="checkbox" class="form-check-input" value="<%=rs.getString("category_name")%>">
                                <%=rs.getString("category_name")%>
                              </label>
                            </div>&nbsp;&nbsp;
                    <%
                        }
                        cn.close();
                    }
                    catch(Exception ec){
                      out.println(ec.getMessage());
                    }
                    %>  
                  </div>
                </div>
                <div class="mt-3">
                    <input type="submit" class="btn btn-block btn-info btn-lg font-weight-medium auth-form-btn" value="SIGN UP">
                </div>
                <div class="text-center mt-4 font-weight-light">
                  Already have an account? <a href="login.jsp" class="text-primary">Login</a>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
      <!-- content-wrapper ends -->
    </div>
    <!-- page-body-wrapper ends -->
  </div>
  <!-- container-scroller -->
  <!-- base:js -->
  <script src="vendors/base/vendor.bundle.base.js"></script>
  <!-- endinject -->
  <!-- inject:js -->
  <script src="js/off-canvas.js"></script>
  <script src="js/hoverable-collapse.js"></script>
  <script src="js/template.js"></script>
  <!-- endinject -->
</body>

</html>
<%
        }        
%>