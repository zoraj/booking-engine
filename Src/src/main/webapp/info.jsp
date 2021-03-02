<%@ page pageEncoding="UTF-8" %>
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/mail.css" />
 <% 
    String backgroundImage = (String) request.getAttribute("backgroundImage");
 %>
<body style = "background-image: url('../room-type-image/<%out.print(backgroundImage);%>');">
<div class="text-center" id="mail"  > <br>  
 <% 
    String info = (String) request.getAttribute("message");
    if(info != null){
        out.println(info);
    }
  %>
</div>


