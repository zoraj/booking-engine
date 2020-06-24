<%@page import="java.util.List"%>
<link type="text/css" rel="stylesheet" href="./assets/css/liste_type_chambre.css" />
<div id="booking">
    <div class="container">
        <div class="row">
            <div class="col-md-12 col-xs-12">
                <c:forEach var="room" items="${listRooms}" varStatus="myIndex">
                    <!-- Debut Premier liste type chambre -->
                    <div class="row" id="list-room">	
                        <input type="hidden" id="room_type_id_${myIndex.index}" class="form-control" value = "${room.idTypeChambre}">
                        <div class="col-md-12">
                            <div class="row">
                                <div class="col-md-12 booking-cta">
                                    <h2> ${room.typeChambreLibelle} Room </h2>
                                    <p>${room.typeChambreLibelle} Rooms are designed in open-concept living area and have many facilities.</p>
                                </div>
                            </div>
                            <br/>
                            <div class="row">
                                <div class="col-md-6 col-xs-12">
                                    <div class="row">
                                        <div class="col-md-12 col-xs-12">	
                                            <img src="./assets/img/post-7.jpg" alt="" class="image-liste">
                                        </div>
                                    </div>
                                    <br/>
                                    <div class="row">
                                        <div class="col-md-6 col-xs-6">
                                            <div class="row">
                                                <div class="col-md-1">
                                                    <i class="fa fa-male"></i>
                                                </div>
                                                <div class="col-md-5">
                                                    <span id="nbAdulte_${myIndex.index}">${room.nbAdulte}</span>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-1">
                                                    <i class="fa fa-bookmark"> </i>
                                                </div>
                                                <div class="col-md-5">
                                                    <span id="roomType_${myIndex.index}">${room.typeChambreLibelle} </span>
                                                </div>
                                            </div>

                                        </div>
                                        <div class="col-md-6 col-xs-6">
                                            <c:forEach var="option" items="${room.tarifOptionLibelle}">    
                                                <div class="row">
                                                    <div class="col-md-1">
                                                        <i class="fa fa-eye"> </i>
                                                    </div>
                                                    <div class="col-md-5">
                                                        <span> ${option} </span>
                                                    </div>
                                                </div>
                                            </c:forEach> 
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4 col-xs-12">
                                    <p>Price start at: </p>
                                    <p>
                                        <span style="font-size:30px; font-weight:bolder">$ <label id="rate_${myIndex.index}">${room.prixParDefaut}</label></span>
                                        <span style="font-size:15px;">/per night</span>
                                    </p>	
                                    <form class="form-input">
                                        <p>                                    
                                            <input type="number" class="form-control" value = "1" id="qty_${myIndex.index}" min="1" max="${room.availableRoom}">
                                        </p>

                                        <p>of ${room.availableRoom} accommodations available.</p>
                                        <input type="hidden" class="form-control" value = "${room.availableRoom}" id="disponible_${myIndex.index}">
                                        <input type="hidden" class="form-control" value = "${room.nbEnfant}" id="nbEnfant_${myIndex.index}">
                                    </form>
                                    <div class="form-btn">
                                        <button id="valid-btn" name="bookRoom" class="submit-btn"  data-value='${myIndex.index}'>Book now</button>
                                    </div>

                                    <br/>
                                    <div class="form-btn">
                                        <button id="proceder" class="submit-btn">
                                            <a href="recap-resa" id="proceder_paiement">Proceder au paiement</a>
                                        </button>
                                    </div>
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

    var informationNoteVentilation = {
        "roomList": []
    };

    $(document).ready(function () {
        $("[name='bookRoom']").click(function () {
            let currentIndex = $(this).data("value");
            var saisie = document.getElementById("qty_" + currentIndex).value;
            var maxValue = document.getElementById("disponible_" + currentIndex).value;
            if (parseInt(saisie) > parseInt(maxValue)) {
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

                    informationNoteVentilation = {
                        "roomList": []
                    };

                    typeRoomObject.bookRoom.forEach(function (room) {
                        if (parseInt(room.roomTypeId) != parseInt($("#room_type_id_" + currentIndex).val())) {
                            informationTypeRooms.bookRoom.push({
                                "roomTypeId": room.roomTypeId,
                                "nbAdulte": room.nbAdulte,
                                "roomType": room.roomType,
                                "rate": room.rate,
                                "nbEnfant": room.nbEnfant,
                                "qty": room.qty
                            });
                            for (var i = 0; i < parseInt(room.qty); i++)
                                informationNoteVentilation.roomList.push({
                                    "pmsTypeChambreId": parseInt(room.roomTypeId),
                                    "nbAdulte": parseInt(room.nbAdulte),
                                    "nbEnfant": parseInt(room.nbEnfant)
                                });
                        }

                    });


                } else {
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
                            "roomTypeId": $("#room_type_id_" + currentIndex).val(),
                            "nbAdulte": $("#nbAdulte_" + currentIndex).html(),
                            "roomType": $("#roomType_" + currentIndex).html(),
                            "rate": $("#rate_" + currentIndex).html(),
                            "nbEnfant": $("#nbEnfant_" + currentIndex).val(),
                            "qty": $("#qty_" + currentIndex).val()
                        });
                        for (var i = 0; i < parseInt($("#qty_" + currentIndex).val()); i++)
                            informationNoteVentilation.roomList.push({
                                "pmsTypeChambreId": parseInt($("#room_type_id_" + currentIndex).val()),
                                "nbAdulte": parseInt($("#nbAdulte_" + currentIndex).html()),
                                "nbEnfant": parseInt($("#nbEnfant_" + currentIndex).val())
                            });
                    }
                }

                var informationTypeRooms_json = JSON.stringify(informationTypeRooms);
                sessionStorage.setItem("informationTypeRooms_json", informationTypeRooms_json);

                var informationNoteVentilation_json = JSON.stringify(informationNoteVentilation);
                sessionStorage.setItem("informationNoteVentilation_json", informationNoteVentilation_json);
            }
        });
    });
</script>
