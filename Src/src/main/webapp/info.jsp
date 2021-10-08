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
   <p style = "text-align: center"> <a onclick="redirection();">Revenir à la page principale</a></p>
</div>

  <script>
        let nameEstablishment = JSON.parse(localStorage.getItem("nameEstablishment"));
        function redirection() {

    let url = "/booking" + nameEstablishment;
    let redirection = url.split(" ").join("");
    location.href = redirection;
}
    </script>


