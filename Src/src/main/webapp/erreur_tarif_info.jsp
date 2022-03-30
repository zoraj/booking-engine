<%@ page pageEncoding="UTF-8" %>
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/mail.css" />
<%
    String backgroundImage = (String) request.getAttribute("backgroundImage");
%>
<body style = "background-image: url('../room-type-image/<%out.print(backgroundImage);%>');">
    <div class="text-center" id="mail"  > <br>  
        <!--<%
            String info = (String) request.getAttribute("message");
            if (info != null) {
                out.println(info);
            }
        %>-->
        <span><h3 style = 'text-align: center;' id="erreurInfo"></h3></span>
        <p style = "text-align: center" > <a  onclick="redirection();" id="mainPageErreur"></a></p>
    </div>

    <script>
        var mainPage = sessionStorage.getItem("mainPage");
        var erreur = sessionStorage.getItem('erreurTarif');
        let mainPageInfo = document.getElementById("mainPageErreur");
        mainPageInfo.innerHTML += mainPage;
        let erreurInfo = document.getElementById('erreurInfo');
        erreurInfo.innerHTML += erreur;
        let nameEstablishment = JSON.parse(localStorage.getItem("nameEstablishment"));
        function redirection() {

            let url = "/booking" + nameEstablishment;
            let redirection = url.split(" ").join("");
            location.href = redirection;
        }
    </script>