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
        <span><h2 style = 'text-align: center;' id="reservTaken"><b></b></h2></span><span><h3 style = 'text-align: center;' id="summaryEmail"><b></b></h3></span>
        <p style = "text-align: center"> <a onclick="redirection();" id="mainPage"></a></p>
    </div>

    <script>
        var mainPage = sessionStorage.getItem('mainPage');
        var reservTaken = sessionStorage.getItem('reservTaken');
        var summaryEmail = sessionStorage.getItem('summaryEmail');
        var mainPageInfo = document.getElementById('mainPage');
        var summaryEmailInfo = document.getElementById('summaryEmail');
        mainPageInfo.innerHTML += mainPage;
        var reservTakenInfo = document.getElementById('reservTaken');
        reservTakenInfo.innerHTML += reservTaken;
        summaryEmailInfo.innerHTML += summaryEmail;
        let nameEstablishment = JSON.parse(localStorage.getItem("nameEstablishment"));
        function redirection() {

            let url = "/booking" + nameEstablishment;
            let redirection = url.split(" ").join("");
            location.href = redirection;
        }
    </script>


