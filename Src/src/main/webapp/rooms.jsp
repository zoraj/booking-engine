<%@ page pageEncoding="UTF-8" %>
<%@page import="java.util.List"%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style>
    .carousel-inner > .item > img,
    .carousel-inner > .item > a > img {
      width: 70%;
      margin: auto;
    }
</style>
<link type="text/css" rel="stylesheet" href="./assets/css/liste_type_chambre.css" />
 <% 
    String backgroundImage = (String) request.getAttribute("backgroundImage");
 %>
<body style = "background-image: url('assets/img/background.jpg');">
<div id="booking">
    <div class="container">
        <div class="row">
            <div class="col-md-12 col-xs-12">
                <c:forEach var="room" items="${listRooms}" varStatus="myIndex">
                    <!-- Debut Premier liste type chambre -->
                    <div class="row" id="list-room">	
                        <input type="hidden" id="room_type_id_${myIndex.index}" class="form-control" value = "${room.pmsTypeChambreId}">
                        <div class="col-md-12">
                            <div class="row">
                                <div class="col-md-12 booking-cta">
                                    <h2> ${room.typeChambre} <fmt:message key="BOOKING.ROOMS.TITLE"/> </h2>
                                    <p>${room.typeChambre} <fmt:message key="BOOKING.ROOMS.DESIGNED"/>.</p>
                                </div>
                            </div>
                            <br/>
                            <div class="row">
                                <div class="col-md-6 col-xs-12">
                                    <div class="row">
                                        <div class="col-md-12 col-xs-12">
                                            <div class="carousel slide myCarousel">
                                                <!-- Wrapper for slides -->
                                                <div class="carousel-inner" role="listbox">
                                                    <c:forEach var="image" items="${listePhotoByRoomType}" varStatus="loop">
                                                        ${image.listePhotoByRoomType}
                                                    </c:forEach>
                                                </div>
                                                <!-- Left and right controls -->
                                                <a class="left carousel-control" href="#" role="button">
                                                    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                                                    <span class="sr-only">Previous</span>
                                                </a>
                                                <a class="right carousel-control" href="#" role="button">
                                                    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                                                    <span class="sr-only">Next</span>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                    <br/>
                                    <div class="row">
                                        <div class="col-md-6 col-xs-6">
                                            <div class="row">
                                                <div class="col-md-5">
                                                    <i class="fa fa-male"></i><b><fmt:message key="BOOKING.GUESTS.TITLE"/> :</b>
                                                </div>
                                                <div class="col-md-5">
                                                  <span id="nbPax_${myIndex.index}">${room.persMax}</span>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-5">
                                                    <i class="fa fa-bookmark">  </i><b><fmt:message key="BOOKING.TYPE"/> :</b>
                                                </div>
                                                <div class="col-md-5">
                                                     <span id="roomType_${myIndex.index}">${room.typeChambre}</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4 col-xs-12">
                                    <p>${room.typeTarifLibelle}</p>
                                    <p>
                                        <span style="font-size:30px; font-weight:bolder"> <label id="rate_${myIndex.index}">${room.amount}</label>&euro;</span>
                                        <span style="font-size:15px;">/<fmt:message key="BOOKING.PER.NIGHT"/></span>
                                    </p>	
                                    <form class="form-input">
                                        <p>                                    
                                            <input type="number" class="form-control" value = "1" id="qty_${myIndex.index}" min="1" max="${room.qteDispo}">
                                        </p>

                                        <p>of ${room.qteDispo} <fmt:message key="BOOKING.ACCOMMODATIONS.AVAILABLE"/>.</p>
                                        <input type="hidden" class="form-control" value = "${room.qteDispo}" id="disponible_${myIndex.index}">
                                        <input type="hidden" class="form-control" value = "${room.nbChild}" id="nbChild_${myIndex.index}">
                                    </form>
                                    <div class="form-btn">
                                        <button id="valid-btn" name="bookRoom" class="submit-btn"  data-value='${myIndex.index}'><fmt:message key="BOOKING.BOOK.NOW.TITLE"/></button>
                                    </div>

                                    <br/>
                                    <div class="form-btn">
                                        <button id="proceder" class="submit-btn">
                                            <a href="recap-resa" id="proceder_paiement"><fmt:message key="BOOKING.PROCEES.PAYMENT"/></a>
                                        </button>
                                    </div>
                                    <div id="pmsTarifGrilleDetailId_${myIndex.index}" style = "display:none;">${room.pmsTarifGrilleDetailId}</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Fin Premier liste type chambre --> 
                </c:forEach>

            </div>
        </div>
    </div>
</div>


<script>
        var informationTypeRooms = {
        "bookRoom": []
    };

    function checkQuantityAvailable(qtyAvailable, qteRequested, roomType) {
        var typeRoomListJson = sessionStorage.getItem("informationTypeRooms_json");
        var typeRoomObject = JSON.parse(typeRoomListJson);
        var qty = parseInt(qteRequested);
        var available = true;
        if (typeRoomObject != null) {
            typeRoomObject.bookRoom.forEach(function(room) {
                if (parseInt(room.roomTypeId) == parseInt(roomType)) {
                    qty = qty + parseInt(room.qty);
                    if (qty > parseInt(qtyAvailable)) {
                        available = false;
                    }
                }
            })
        }
        return available;
    }

    $(document).ready(function() {
        // Activate Carousel
        $(".myCarousel").carousel();
        // Enable Carousel Controls
        $(".left").click(function(){
          $(".myCarousel").carousel("prev");
        });
        $(".right").click(function(){
          $(".myCarousel").carousel("next");
        });
        
        $("[name='bookRoom']").click(function() {
            let currentIndex = $(this).data("value");
            var saisie = document.getElementById("qty_" + currentIndex).value;
            var maxValue = document.getElementById("disponible_" + currentIndex).value;
            var available = checkQuantityAvailable(maxValue, saisie, $("#room_type_id_" + currentIndex).val());
            if ((parseInt(saisie) > parseInt(maxValue))) {
                $(this).css('background-color', '#06a8c4');
            } else {
                if ($(this).css('background-color') == 'rgb(174, 176, 174)') {
                    $(this).css('background-color', 'rgb(6, 168, 196)');
                    var typeRoomListJson = sessionStorage.getItem("informationTypeRooms_json");
                    var typeRoomObject = JSON.parse(typeRoomListJson);
                    sessionStorage.setItem("informationTypeRooms_json", null);

                    informationTypeRooms = {
                        "bookRoom": []
                    };
                    typeRoomObject.bookRoom.forEach(function(room) {
                        if (parseInt(room.roomTypeId) != parseInt($("#room_type_id_" + currentIndex).val())) {
                            informationTypeRooms.bookRoom.push({
                                "roomTypeId": parseInt(room.roomTypeId),
                                "nbPax": parseInt(room.nbPax),
                                "roomType": room.roomType,
                                "rate": parseFloat(room.rate),
                                "nbChild": parseInt(room.nbChild),
                                "qty": parseInt(room.qty),
                                "pmsTarifGrilleDetailId": parseInt(room.pmsTarifGrilleDetailId)
                            });
                        }
                    });


                } else if(available == true){
                    var typeRoomJson = sessionStorage.getItem("informationTypeRooms_json");
                    var typeObject = JSON.parse(typeRoomJson);

                    var ventillationJson = sessionStorage.getItem("informationNoteVentilation");
                    var ventillationObject = JSON.parse(ventillationJson);

                    if (typeObject != null) {
                        informationTypeRooms = typeObject;
                    }

                    if (ventillationObject != null) {
                        informationNoteVentilation = ventillationObject;
                    }

                    $(this).css('background-color', '#aeb0ae');
                    if ($("#list-room").is(":hidden") == false) {
                        informationTypeRooms.bookRoom.push({
                            "roomTypeId": parseInt($("#room_type_id_" + currentIndex).val()),
                            "nbPax": parseInt($("#nbPax_" + currentIndex).html()),
                            "roomType": $("#roomType_" + currentIndex).html(),
                            "rate": parseFloat($("#rate_" + currentIndex).html()),
                            "nbChild": parseInt($("#nbChild_" + currentIndex).val()),
                            "qty": parseInt($("#qty_" + currentIndex).val()),
                            "pmsTarifGrilleDetailId": parseInt($("#pmsTarifGrilleDetailId_" + currentIndex).html()),
                        });
                    }
                }
                var informationTypeRooms_json = JSON.stringify(informationTypeRooms);
                sessionStorage.setItem("informationTypeRooms_json", informationTypeRooms_json);

            }
        });
    });
</script>
