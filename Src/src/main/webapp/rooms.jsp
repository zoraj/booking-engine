<%@ page pageEncoding="UTF-8" %>
<%@page import="java.util.List"%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link href="https://cdn.mat.cloud/assets/global/plugins/bootstrap-switch/css/bootstrap-switch.min.css" rel="stylesheet" type="text/css" />
<link href="https://cdn.mat.cloud/assets/global/plugins/bootstrap-modal/css/bootstrap-modal-bs3patch.css" rel="stylesheet" type="text/css" />
<link href="https://cdn.mat.cloud/assets/global/plugins/bootstrap-modal/css/bootstrap-modal.css" rel="stylesheet" type="text/css" />
<link href="https://cdn.mat.cloud/assets/global/css/components-rounded.min.css" rel="stylesheet" type="text/css" />
<link href="https://cdn.mat.cloud/assets/global/css/plugins.min.css" rel="stylesheet" type="text/css" />
<link href="https://cdn.mat.cloud/assets/layouts/layout2/css/themes/blue.min.css" rel="stylesheet" type="text/css" />
<link href="https://cdn.mat.cloud/assets/layouts/layout2/css/custom.min.css" rel="stylesheet" type="text/css" />

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://cdn.mat.cloud/assets/global/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
<script src="https://cdn.mat.cloud/assets/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
<script src="https://cdn.mat.cloud/assets/global/plugins/jquery.blockui.min.js" type="text/javascript"></script>
<script src="https://cdn.mat.cloud/assets/global/plugins/bootstrap-switch/js/bootstrap-switch.min.js" type="text/javascript"></script>
<script src="https://cdn.mat.cloud/assets/global/plugins/bootstrap-modal/js/bootstrap-modalmanager.js" type="text/javascript"></script>
<script src="https://cdn.mat.cloud/assets/global/plugins/bootstrap-modal/js/bootstrap-modal.js" type="text/javascript"></script>
<script src="https://cdn.mat.cloud/assets/pages/scripts/ui-extended-modals.min.js" type="text/javascript"></script>

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
        <c:if test="${empty codepromoObjStr}">
            <div class="col-md-12">
                <div class="row">
                    <div class="col-md-12 booking-cta">
                        <span style="color:red;font-style: italic;font-size: 19px;"><fmt:message key="COMMON.BOOKING.PROMOCODE.CODEPROMO.MSG.INVALID"/></span>
                    </div>
                </div>
            </div>
        </c:if>
        <div class="row">
            <div class="col-md-12 col-xs-12">
                <c:forEach var="room" items="${listRooms}" varStatus="myIndex">
                    <!-- Debut Premier liste type chambre -->
                    <div class="row" id="list-room">	
                        <input type="hidden" id="room_type_id_${myIndex.index}" class="form-control" value = "${room.pmsTypeChambreId}">
                        <input type="hidden" class="form-control" value = "${room.mmcModeEncaissementId}" id="mmcModeEncaissementId_${myIndex.index}">
                        <input type="hidden" class="form-control" value = "${room.mmcClientId}" id="mmcClientId_${myIndex.index}">
                        <input type="hidden" class="form-control" value = "${room.pmsTarifGrilleId}" id="pmsTarifGrilleId_${myIndex.index}">
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
                                                    <c:forEach var="image" items="${room.listePhotoByRoomType}" varStatus="loop">
                                                       ${image}
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
                                                <div class="col-md-6">
                                                    <i class="fa fa-male"></i><b><fmt:message key="BOOKING.GUESTS.TITLE"/> :</b>
                                                </div>
                                                <div class="col-md-5">
                                                  <span id="nbPax_${myIndex.index}">${room.persMax}</span>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-6">
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
                                        <span style="font-size:30px; font-weight:bolder"> <label id="rate_${myIndex.index}">${room.amount}</label><label class="lib_devise"></label></span>
                                        <span style="font-size:15px;"> <fmt:message key="BOOKING.PER.NIGHT"/></span>
                                    </p>	
                                    <form class="form-input">
                                        <p>                                    
                                            <input type="number" class="form-control" value = "1" id="qty_${myIndex.index}" min="1" max="${room.qteDispo}">
                                        </p>

                                        <p><fmt:message key="BOOKING.OF.AVAILABLE"/> ${room.qteDispo} <fmt:message key="BOOKING.ACCOMMODATIONS.AVAILABLE"/>.</p>
                                        <input type="hidden" class="form-control" value = "${room.qteDispo}" id="disponible_${myIndex.index}">
                                        <input type="hidden" class="form-control" value = "${room.nbChild}" id="nbChild_${myIndex.index}">
                                    </form>
                                    <div class="form-btn">
                                        <button id="valid-btn" name="bookRoom" class="submit-btn"  data-value='${myIndex.index}'><fmt:message key="BOOKING.BOOK.ROOMS"/></button>
                                    </div>

                                    <br/>
                                    <div id="pmsTarifGrilleDetailId_${myIndex.index}" style = "display:none;">${room.pmsTarifGrilleDetailId}</div>
                                    <div id="pmsModelTarifId_${myIndex.index}" style = "display:none;">${room.typeTarifId}</div>
                                    <div id="base_${myIndex.index}" style = "display:none;">${room.base}</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Fin Premier liste type chambre --> 
                </c:forEach>
                <div class="row" style="margin-bottom: 15px;">
                    <div class="col-md-4 col-md-offset-4">
                        <div class="form-btn">
                            <button id="proceder" class="submit-btn">
                                <a href="recap-resa" id="proceder_paiement"><fmt:message key="BOOKING.VALIDATE"/></a>
                            </button>
                        </div>
                    </div>
                </div>                
            </div>
        </div>
    </div>
    <div class="portlet light">
        <div class="portlet-body">
            <a class="btn btn-outline dark" data-target="#alertBooking" data-toggle="modal" style="display: none;" id="lAlertBooking"></a>
            <div id="alertBooking" class="modal fade" tabindex="-1" data-backdrop="static" data-keyboard="false" data-attention-animation="false">
                <div class="modal-body">
                    <p id="txtAlertBooking"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" data-dismiss="modal" class="btn green">OK</button>
                </div>
            </div>
            <span id="msgAlertBookingChbrReserverSurplus" style="display: none;"><fmt:message key="BOOKING.CHBR.RESERVER.SURPLUS"/></span>
            <span id="msgAlertBookingChbrReserverEnMoins" style="display: none;"><fmt:message key="BOOKING.CHBR.RESERVER.ENMOINS"/></span>
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
        
        sessionStorage.setItem("devisePpalSymbole", "${devisePpalSymbole}");
        $(".lib_devise").html(sessionStorage.getItem("devisePpalSymbole"));
        
        let codepromoObjStr = '${codepromoObjStr}';
        if (codepromoObjStr != "" && codepromoObjStr != "NOT_SPECIFIED") {
            sessionStorage.setItem("codepromoObjStr", codepromoObjStr);
        }
        
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
            let saisie = document.getElementById("qty_" + currentIndex).value;
            let maxValue = document.getElementById("disponible_" + currentIndex).value;
            let available = checkQuantityAvailable(maxValue, saisie, $("#room_type_id_" + currentIndex).val());
            if ((parseInt(saisie) > parseInt(maxValue))) {
                $(this).css('background-color', '#06a8c4');
            } else {
                if ($(this).css('background-color') == 'rgb(174, 176, 174)') { // grisé
                    $(this).css('background-color', 'rgb(6, 168, 196)');
                    $("#qty_" + currentIndex).removeAttr("readonly");
                    let typeRoomListJson = sessionStorage.getItem("informationTypeRooms_json");
                    let typeRoomObject = JSON.parse(typeRoomListJson);
                    sessionStorage.setItem("informationTypeRooms_json", null);

                    informationTypeRooms = {
                        "bookRoom": []
                    };
                    typeRoomObject.bookRoom.forEach(function(room) {
                        if (parseInt(room.roomTypeId) != parseInt($("#room_type_id_" + currentIndex).val()) || 
                                parseInt(room.pmsTarifGrilleDetailId) != parseInt($("#pmsTarifGrilleDetailId_" + currentIndex).html()) || 
                                parseInt(room.pmsModelTarifId) != parseInt($("#pmsModelTarifId_" + currentIndex).html())) {
                            informationTypeRooms.bookRoom.push({
                                "roomTypeId": parseInt(room.roomTypeId),
                                "nbPax": parseInt(room.nbPax),
                                "roomType": room.roomType,
                                "rate": parseFloat(room.rate),
                                "nbChild": parseInt(room.nbChild),
                                "qty": parseInt(room.qty),
                                "pmsTarifGrilleDetailId": parseInt(room.pmsTarifGrilleDetailId),
                                "pmsModelTarifId": parseInt(room.pmsModelTarifId),
                                "base": parseInt(room.base),
                                "mmcModeEncaissementId": parseInt(room.mmcModeEncaissementId),
                                "mmcClientId": parseInt(room.mmcClientId)
                            });
                        }
                    });
                    
                    let informationTypeRooms_json = JSON.stringify(informationTypeRooms);
                    sessionStorage.setItem("informationTypeRooms_json", informationTypeRooms_json);

                } else if(available == true){
                    
                    let typeRoomJson = sessionStorage.getItem("informationTypeRooms_json");
                    let typeObject = JSON.parse(typeRoomJson);

                    let ventillationJson = sessionStorage.getItem("informationNoteVentilation");
                    let ventillationObject = JSON.parse(ventillationJson);

                    if (typeObject != null) {
                        informationTypeRooms = typeObject;
                    }

                    if (ventillationObject != null) {
                        informationNoteVentilation = ventillationObject;
                    }

                    $(this).css('background-color', '#aeb0ae');
                    $("#qty_" + currentIndex).attr("readonly", "readonly");
                    
                    if ($("#list-room").is(":hidden") == false) {
                        informationTypeRooms.bookRoom.push({
                            "roomTypeId": parseInt($("#room_type_id_" + currentIndex).val()),
                            "nbPax": parseInt($("#nbPax_" + currentIndex).html()),
                            "roomType": $("#roomType_" + currentIndex).html(),
                            "rate": parseFloat($("#rate_" + currentIndex).html()),
                            "nbChild": parseInt($("#nbChild_" + currentIndex).val()),
                            "qty": parseInt($("#qty_" + currentIndex).val()),
                            "pmsTarifGrilleDetailId": parseInt($("#pmsTarifGrilleDetailId_" + currentIndex).html()),
                            "pmsModelTarifId": parseInt($("#pmsModelTarifId_" + currentIndex).html()),
                            "base": parseInt($("#base_" + currentIndex).html()),
                            "mmcModeEncaissementId": parseInt($("#mmcModeEncaissementId_" + currentIndex).val()),
                            "mmcClientId": parseInt($("#mmcClientId_" + currentIndex).val()),
                            "pmsTarifGrilleId": parseInt($("#pmsTarifGrilleId_" + currentIndex).val())
                        });
                    }
                    let informationTypeRooms_json = JSON.stringify(informationTypeRooms);
                    sessionStorage.setItem("informationTypeRooms_json", informationTypeRooms_json);
                }
            }
        });
        
        $("#proceder").on("click", function(e){
            // vérification nombre de chambre cohérent avec celui sélectionné dans le premier écran
            let nbChambreReserver = 0;
            $("[name='bookRoom']").each(function() {
                let data_value = $(this).data("value");
                let champNbChbr = $("#qty_" + data_value);
                if ($(this).css('background-color') == 'rgb(174, 176, 174)') {
                    nbChambreReserver += parseInt(champNbChbr.val());
                }
            });
            let chambresprevus = sessionStorage.getItem("roomList_json");
            chambresprevus = JSON.parse(chambresprevus);
            let roomList = chambresprevus.roomList;
            let nbChambrePrevus = 0;
            for(let j=0; j < roomList.length; j++) {
                let json = roomList[j];
                nbChambrePrevus += json.qteChb;
            }
            if (nbChambreReserver < nbChambrePrevus) {
                e.preventDefault();
                $("#txtAlertBooking").html($("#msgAlertBookingChbrReserverEnMoins").html());
                $("#lAlertBooking")[0].click();
            }
            if (nbChambreReserver > nbChambrePrevus) {
                e.preventDefault();
                $("#txtAlertBooking").html($("#msgAlertBookingChbrReserverSurplus").html());
                $("#lAlertBooking")[0].click();
            }
        });
    });
</script>