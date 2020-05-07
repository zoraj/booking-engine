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
                                                <span id="nbAdulte_${myIndex.index}"> ${room.nbAdulte}</span>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-1">
                                              <i class="fa fa-bookmark"> </i>
                                            </div>
                                            <div class="col-md-5">
                                              <span id="roomType_${myIndex.index}"> ${room.typeChambreLibelle} </span>
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
                                    <span style="font-size:30px; font-weight:bolder" id="rate_${myIndex.index}">$ ${room.prixParDefaut}</span>
                                    <span style="font-size:15px;">/per night</span>
                                </p>	
                                <form class="form-input">
                                    <p>                                    
                                        <input type="number" class="form-control" value = "${room.availableRoom}" id="qty_${myIndex.index}" min="1" max="${room.availableRoom}">
                                    </p>
                                </form>
                                <p>of ${room.totalRoom} accommodations available.</p>
                                <input type="hidden" class="form-control" value = "${room.nbEnfant}" id="nbEnfant_${myIndex.index}">

                                <div class="form-btn">
                                    <button id="valid-btn" name="bookRoom" class="submit-btn"  data-value='${myIndex.index}' onclick="changeColor(this)">Book now</button>
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
            
    function changeColor(btn) {
        btn.style.backgroundColor = "#aeb0ae";
    }
     
    $(document).ready(function () {
        $("[name='bookRoom']").click(function () {
            let currentIndex = $(this).data("value");
            
            if ($("#list-room").is(":hidden") == false) {
                informationTypeRooms.bookRoom.push({
                    "roomTypeId": $("#room_type_id_" + currentIndex).val(),
                    "nbAdulte": $("#nbAdulte_" + currentIndex).html(),
                    "roomType": $("#roomType_" + currentIndex).html(),
                    "rate": $("#rate_" + currentIndex).html(),
                    "nbEnfant": $("#nbEnfant_" + currentIndex).val(),
                    "qty": $("#qty_" + currentIndex).val()
                });
            }
            
            var informationTypeRooms_json = JSON.stringify(informationTypeRooms);
            sessionStorage.setItem("informationTypeRooms_json", informationTypeRooms_json);
        });
    });                    
</script>
