<%-- 
    Document   : user_img_upload
    Created on : 26 Apr, 2022, 10:55:14 AM
    Author     : hp
--%>

<%@ page import="java.io.*" %>
<%
    try{
        String email = null;
        Cookie c[] = request.getCookies();
        for(int i=0;i<c.length;i++){
            if(c[i].getName().equals("user")){
                email = c[i].getValue();
                break;
            }
        }
        if(email!=null){
            response.sendRedirect("index.jsp");
        }
        else{
            if(request.getParameter("code")==null){
                response.sendRedirect("register.jsp?upload_code_error=1");
            }
            else{
                String code = request.getParameter("code") ;
                String contentType = request.getContentType();

                String imageSave=null;
                byte dataBytes[]=null;
                String saveFile=null;
                if ((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0))
                {
                DataInputStream in = new DataInputStream(request.getInputStream());
                int formDataLength = request.getContentLength();
                dataBytes = new byte[formDataLength];
                int byteRead = 0;
                int totalBytesRead = 0;
                while (totalBytesRead < formDataLength)
                {
                byteRead = in.read(dataBytes, totalBytesRead, formDataLength);
                totalBytesRead += byteRead;
                }
               
                /*String code="";
                try{
                    ....
                    ...
                    ....
                ResultSet rs=st.executeQuery("select code from table_name where email='"+email+"'");
                if(rs.next()){
                    code=rs.getString(1);
                }

                } 
                catch(Exception er){

                }*/
                String file = new String(dataBytes);
                /*saveFile = file.substring(file.indexOf("filename=\"") + 10);
                saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
                saveFile = saveFile.substring(saveFile.lastIndexOf("\\") + 1, saveFile.indexOf("\""));*/
                 saveFile = code+".jpg";
                 //out.println(saveFile);
                // out.print(dataBytes);
                int lastIndex = contentType.lastIndexOf("=");
                String boundary = contentType.substring(lastIndex + 1, contentType.length());
                // out.println(boundary);
                int pos;
                pos = file.indexOf("filename=\"");
                pos = file.indexOf("\n", pos) + 1;
                pos = file.indexOf("\n", pos) + 1;
                pos = file.indexOf("\n", pos) + 1;
                int boundaryLocation = file.indexOf(boundary, pos) - 4;
                int startPos = ((file.substring(0, pos)).getBytes()).length;
                int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;
                try
                {
                    FileOutputStream fileOut = new FileOutputStream(request.getRealPath("/")+"/users/"+saveFile);


                    // fileOut.write(dataBytes);
                    fileOut.write(dataBytes, startPos, (endPos - startPos));
                    fileOut.flush();
                    fileOut.close();
                    response.sendRedirect("register.jsp?success=1");
                }
                catch (Exception e){
                    response.sendRedirect("register.jsp?img_error=1");
                }
                }
                //response.sendRedirect("index.jsp");
            }
          }
    }
        catch(NullPointerException er){
            response.sendRedirect("index.jsp");
        } 
%>
