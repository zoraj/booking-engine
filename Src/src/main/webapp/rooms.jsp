<%@page import="java.util.List"%>
<link type="text/css" rel="stylesheet" href="./assets/css/liste_type_chambre.css" />
<div id="booking">
    <div class="container">
        <div class="row">
            <div class="col-md-12 col-xs-12">
                <c:forEach var="room" items="${listRooms}">
                <!-- Debut Premier liste type chambre -->
                <div class="row" id="list-one">			
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
                                                <span> ${room.nbAdulte}</span>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-1">
                                              <i class="fa fa-bookmark"> </i>
                                            </div>
                                            <div class="col-md-5">
                                              <span> ${room.typeChambreLibelle} </span>
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
                                <form class="form-input">
                                    <p>Price start at: </p>
                                    <p>
                                        <span style="font-size:30px; font-weight:bolder">$ ${room.prixParDefaut}</span>
                                        <span style="font-size:15px;">/per night</span>
                                    </p>	
                                    <p><input type="number" class="form-control" readonly value = "${room.availableRoom}"></p>
                                    <p>of ${room.totalRoom} accommodations available.</p>
                                    <div class="form-btn">
                                        <button id="valid-btn" class="submit-btn">
                                            <a href="#" id="bookNow">Book</a>
                                        </button>
                                    </div>
                                    <br/>
                                    <div class="form-btn">
                                        <button id="proceder" class="submit-btn">
                                            <a href="recap_resa" id="proceder_paiement">Proceder au paiement</a>
                                        </button>
                                    </div>
                                </form>
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
