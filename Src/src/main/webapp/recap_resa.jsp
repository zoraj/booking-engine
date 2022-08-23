<%@ page pageEncoding="UTF-8" %>
<link type="text/css" rel="stylesheet" href="./assets/css/liste_type_chambre.css" />
 <% 
    String backgroundImage = (String) request.getAttribute("backgroundImage");
 %>
<body style = "background-image: url('../room-type-image/<%out.print(backgroundImage);%>');">
<div id="booking">
    <div class="container">
        <div class="row">
            <div class="col-md-6 col-md-offset-3">
                <div class="row" id="recap">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-12 booking-cta">
                                <h2><fmt:message key="BOOKING.PRICE.BREAKDOWN"/></h2>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="row"><hr>
                                    <div class="col-md-12">
                                        <div class="row"><div class="col-md-12"><span id="name-user"></span></div></div><br />
                                        <div class="row"><div class="col-md-12"><span id="recapitulation-chambre-id"></span></div></div>
                                    </div>
                                </div><hr>
                                <div class="row">
                                    <div class="col-md-8"><span><fmt:message key="BOOKING.ADULTS"/></span></div>
                                    <div class="col-md-4"><span id="adults-id"></span></div>
                                </div><hr>
                                <div class="row">
                                    <div class="col-md-8"><span><fmt:message key="BOOKING.CHILDREN"/></span></div>
                                    <div class="col-md-4"><span id="children-id"></span></div>
                                </div><hr>
                                <div class="row">
                                    <div class="col-md-8"><span><fmt:message key="BOOKING.NIGHTS"/></span></div>
                                    <div class="col-md-4"><span id="night-id">1</span></div>
                                </div><hr>
                                <div class="row">
                                    <div class="col-md-4 "><span><fmt:message key="BOOKING.DATES"/>   ...................................</span></div>
                                    <div class="col-md-8"><span id="date-id"></span></div>
                                </div><hr>
                                <!--                                <div class="row">
                                                                    <div class="col-md-8"><span id="date-arrived-id"></span></div>
                                                                    <div class="col-md-4"><span id="amount-id">$0</span></div>
                                                                </div><hr>-->
                                <div class="row" style="display:none">
                                    <div class="col-md-8 font-title"><span><fmt:message key="BOOKING.TOTAL.TVA"/></span></div>
                                    <div class="col-md-4 font-title"><span id="tva-id"></span></div>
                                </div><!--hr-->
                                <div class="row">
                                    <div class="col-md-8 font-title"><span><fmt:message key="BOOKING.PRICE.TTC"/></span></div>
                                    <div class="col-md-4 font-title"><span id="total-id">$135</span></div>
                                </div><hr>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4 col-md-offset-4">
                                <div class="form-btn">
                                    <button id="valid-btn"><a href="payment" id="payer"><fmt:message key="BOOKING.PAY"/></a></button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>	
            </div>
        </div>
    </div>
</div>

<script src="./assets/js/jquery.min.js"></script>

<script>
    var listRoom = sessionStorage.getItem("roomList_json");
    var listRoomObject = JSON.parse(listRoom);

    var recapJson = sessionStorage.getItem("informationTypeRooms_json");
    var recapObject = JSON.parse(recapJson);

    var informationPersonJson = sessionStorage.getItem("informationPerson_json");
    var informationPersonObject = JSON.parse(informationPersonJson);


    var dateArrivee = new Date(listRoomObject.dateArrivee);
    var dateDepart = new Date(listRoomObject.dateDepart);
    var reservationTarif = {
                        "reservationTarif": []
                    };

    var ventilation = {
        "ventilation": []
    };


   
    jQuery(document).ready(function () {
        var nbPax = 0;
        var childs = 0;
        var montantTTC = 0;
        var recapitulationChambre = "";
        var night = dateDiff(dateArrivee,dateDepart);
        recapObject.bookRoom.forEach(function (room) {
            var isExist = false;
            var qty = 0;
            reservationTarif.reservationTarif.push({
                 "qteChb": room.qty,
                 "pmsTypeChambreId": room.roomTypeId,
                 "pmsTarifGrilleDetailId": room.pmsTarifGrilleDetailId,
                 "nbAdult":room.nbPax,
                 "nbEnf":room.nbChild
            });
            if(ventilation.ventilation.length>0){
                for (var i = 0; i < ventilation.ventilation.length; i++) {
                    if(ventilation.ventilation[i].pmsTypeChambreId == room.roomTypeId){
                       ventilation.ventilation[i].qteChb = ventilation.ventilation[i].qteChb + room.qty;
                       isExist = true;
                       break;
                    } 
                }
            }
            if(isExist == false){
                  ventilation.ventilation.push({
                      "qteChb": room.qty,
                      "pmsTypeChambreId": room.roomTypeId
                  });
            }

            childs = childs + (parseInt(room.nbChild)*parseInt(room.qty));
            nbPax = nbPax + (parseInt(room.nbPax)*parseInt(room.qty));
            montantTTC = parseFloat(montantTTC)  + parseFloat(room.qty) * parseFloat(room.rate);
            recapitulationChambre = recapitulationChambre + "<div class='col-md-8'>" + room.qty + " x " + room.roomType + "</div>" + "<div class='col-md-4'><span>" + room.rate + "&euro;</span></div>";
        });

        var ventilation_json = JSON.stringify(ventilation);
        sessionStorage.setItem("ventilation_json", ventilation_json);

        var reservationTarif_json = JSON.stringify(reservationTarif);
        sessionStorage.setItem("reservationTarif_json", reservationTarif_json);

        $("#name-user").html("#" + informationPersonObject.name);
        $("#date-id").html("du " + changeFormat(dateArrivee) + " au " + changeFormat(dateDepart));

        $("#adults-id").html(nbPax);
        $("#children-id").html(childs);
        
        var montantTotal = parseFloat(montantTTC) * parseFloat(night);
        $("#night-id").html(night);
        $("#amount-id").html(0);
        $("#tva-id").html(100);
        $("#total-id").html(montantTotal + "&euro;");
        $("#recapitulation-chambre-id").html("<div class = 'row'>" + recapitulationChambre + "</div>");

        function changeFormat(date) {           
            var lang= document.getElementById('lang').innerHTML;
            options = {
                weekday: "short", year: 'numeric', month: 'long', day: 'numeric'
            };      
            return date.toLocaleString(lang, options);
        }
        
         function dateDiff(date1, date2) {
            var diff = {}                           // Initialisation du retour
            var tmp = date2 - date1;

            tmp = Math.floor(tmp / 1000);             // Nombre de secondes entre les 2 dates
            diff.sec = tmp % 60;                    // Extraction du nombre de secondes

            tmp = Math.floor((tmp - diff.sec) / 60);    // Nombre de minutes (partie enti�re)
            diff.min = tmp % 60;                    // Extraction du nombre de minutes

            tmp = Math.floor((tmp - diff.min) / 60);    // Nombre d'heures (enti�res)
            diff.hour = tmp % 24;                   // Extraction du nombre d'heures

            tmp = Math.floor((tmp - diff.hour) / 24);   // Nombre de jours restants
            diff.day = tmp;

            return tmp;
        }
        
    });
</script>