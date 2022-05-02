<%-- 
    Document   : change_user_img
    Created on : 2 May, 2022, 7:20:18 AM
    Author     : hp
--%>

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
        if(cemail==null && session.getAttribute(cemail)==null){
            response.sendRedirect("index.jsp");
        }
        else{
            if(request.getParameter("code")==null){
                response.sendRedirect("profile.jsp?change_img_code_error=1");
            }
            else{
                String code = request.getParameter("code") ;
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
            <div class="auth-form-light text-left py-5 px-4 px-sm-5 ">
              <div class="brand-logo">
                <img src="images/logo.png" alt="logo">
              </div>
              <form class="pt-3" method="post" action="change_user_img_upload.jsp?code=<%=code%>" ENCTYPE='multipart/form-data'>
                <div class="form-group">
                    <label>Image upload</label>
                    <input type="file" name="uploadFile" class="form-control" required>
                </div>
                <div class="mt-3">
                    <input type="submit" class="btn btn-block btn-info btn-lg font-weight-medium auth-form-btn" value="Upload">
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
        }
%>