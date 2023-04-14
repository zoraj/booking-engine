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
                                
                                <div id="block_remise" class="row" style="display: none;">
                                    <div class="col-md-8 font-title"><span><fmt:message key="COMMON.BOOKING.PROMOCODE.REMISE.PROMO"/></span></div>
                                    <div class="col-md-4 font-title"><span id="valeur_remise"></span></div>
                                </div>
                                <div class="row">
                                    <div class="col-md-8 font-title"><span><fmt:message key="BOOKING.PRICE.TTC"/></span></div>
                                    <div class="col-md-4 font-title"><span id="total-id"></span></div>
                                </div><hr>
                                <div id="code_promo_invalide_msg" class="row" style="display: none;">
                                    <div class="col-md-12"><span style="color:red;font-style: italic;font-size: 17px;"><fmt:message key="COMMON.BOOKING.PROMOCODE.CODEPROMO.MSG.INVALID"/></span></div>
                                </div>
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
    var today = new Date();
    var month = today.getMonth() + 1;
    var day = today.getDate();
    var dateReglement = today.getFullYear()+ '-' +(month.toString().length > 1 ? month : "0" + month) + '-' +(day.toString().length > 1 ? day : "0" + day);
    var reservationTarif = {
                        "reservationTarif": []
                    };

    var ventilation = {
        "ventilation": []
    };

    var arrhesJson;
    
    function calculerEtAfficherRemisePromotionnel(montantTotal, codePromoObj) {
        let typeRemise = codePromoObj.typeRemise;
        let montant = 0;
        if (typeRemise == "POURCENTAGE") {
            $("#valeur_remise").html(codePromoObj.valeur.toString().concat("&percnt;"));
            montant = montantTotal - ( montantTotal * ( codePromoObj.valeur / 100 ) );
        }
        else if (typeRemise == "FIXE") {
            $("#valeur_remise").html(codePromoObj.valeur.toString().concat(sessionStorage.getItem("devisePpalSymbole")));
            montant = montantTotal - codePromoObj.valeur;
        }
        $("#total-id").html(montant.toString().concat(sessionStorage.getItem("devisePpalSymbole")));
        sessionStorage.setItem("montantTotalTtcAvecRemisePromo", montant.toString());
    }
   
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
                 //"qteChb": room.qty,
                 "pmsTypeChambreId": room.roomTypeId,
                 //"pmsTarifGrilleDetailId": room.pmsTarifGrilleDetailId,
                 "nbAdult":room.nbPax,
                 "nbEnf":room.nbChild,
                 "dateDebut":listRoomObject.dateArrivee,
                 "dateFin":listRoomObject.dateDepart,
                 "pmsTarifGrilleDetailId":room.pmsTarifGrilleDetailId,
                 "base":room.base
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
                      //"qteChb": room.qty,
                      "pmsTypeChambreId": room.roomTypeId
                  });
            }

            childs = childs + (parseInt(room.nbChild)*parseInt(room.qty));
            nbPax = nbPax + (parseInt(room.nbPax)*parseInt(room.qty));
            montantTTC = parseFloat(montantTTC)  + parseFloat(room.qty) * parseFloat(room.rate);
            recapitulationChambre = recapitulationChambre + "<div class='col-md-8'>" + room.qty + " x " + room.roomType + "</div>" + "<div class='col-md-4'><span>" + (room.rate).toString().concat(sessionStorage.getItem("devisePpalSymbole")) + "</span></div>";
            arrhesJson = {
                "mmcModeEncaissementId": room.mmcModeEncaissementId,
                "mmcClientId": room.mmcClientId,
                "dateReglement": dateReglement,
                "montant": parseFloat(montantTTC) * parseFloat(night)
            };
        });

        var ventilation_json = JSON.stringify(ventilation);
        sessionStorage.setItem("ventilation_json", ventilation_json);

        var reservationTarif_json = JSON.stringify(reservationTarif);
        sessionStorage.setItem("reservationTarif_json", reservationTarif_json);
        
        var informationArrhes_json = JSON.stringify(arrhesJson);
        sessionStorage.setItem("informationArrhes_json", informationArrhes_json);

        $("#name-user").html("#" + informationPersonObject.name);
        $("#date-id").html("du " + changeFormat(dateArrivee) + " au " + changeFormat(dateDepart));

        $("#adults-id").html(nbPax);
        $("#children-id").html(childs);
        
        var montantTotal = parseFloat(montantTTC) * parseFloat(night);
        $("#night-id").html(night);
        $("#amount-id").html(0);
        $("#tva-id").html(100);
        
        // vérification validité code promo
        if (sessionStorage.getItem("codepromoObjStr") != null) {
            let codePromoObj = JSON.parse(sessionStorage.getItem("codepromoObjStr"));
            let min_applicable = codePromoObj.minApplicable;
            let max_applicable = codePromoObj.maxApplicable;
            if (montantTotal < min_applicable || montantTotal > max_applicable) {
                $("#code_promo_invalide_msg").show();
                $("#block_remise").hide();
                $("#total-id").html(montantTotal.toString().concat(sessionStorage.getItem("devisePpalSymbole")));
            } else {
                $("#code_promo_invalide_msg").hide();
                $("#block_remise").show();
                calculerEtAfficherRemisePromotionnel(montantTotal, codePromoObj);
            }
        } else {
            $("#total-id").html(montantTotal.toString().concat(sessionStorage.getItem("devisePpalSymbole")));
        }
        
        $("#recapitulation-chambre-id").html("<div class = 'row'>" + recapitulationChambre + "</div>");

        function changeFormat(date) {
            var lang = sessionStorage.getItem("lang");
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