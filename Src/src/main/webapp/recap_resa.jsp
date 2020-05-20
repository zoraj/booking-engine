<link type="text/css" rel="stylesheet" href="./assets/css/liste_type_chambre.css" />
<div id="booking">
    <div class="container">
        <div class="row">
            <div class="col-md-6 col-md-offset-3">
                <div class="row" id="recap">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-12 booking-cta">
                                <h2>Price Breakdown</h2>
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
                                    <div class="col-md-8"><span>Adults</span></div>
                                    <div class="col-md-4"><span id="adults-id"></span></div>
                                </div><hr>
                                <div class="row">
                                    <div class="col-md-8"><span>Children</span></div>
                                    <div class="col-md-4"><span id="children-id"></span></div>
                                </div><hr>
                                <div class="row">
                                    <div class="col-md-8"><span>Nights</span></div>
                                    <div class="col-md-4"><span id="night-id">1</span></div>
                                </div><hr>
                                <div class="row">
                                    <div class="col-md-4 "><span>Dates   ...................................</span></div>
                                    <div class="col-md-8"><span id="date-id"></span></div>
                                </div><hr>
                                <!--                                <div class="row">
                                                                    <div class="col-md-8"><span id="date-arrived-id"></span></div>
                                                                    <div class="col-md-4"><span id="amount-id">$0</span></div>
                                                                </div><hr>-->
                                <div class="row">
                                    <div class="col-md-8 font-title"><span>Total TVA</span></div>
                                    <div class="col-md-4 font-title"><span id="tva-id"></span></div>
                                </div><hr>
                                <div class="row">
                                    <div class="col-md-8 font-title"><span>Total TCC</span></div>
                                    <div class="col-md-4 font-title"><span id="total-id">$135</span></div>
                                </div><hr>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4 col-md-offset-4">
                                <div class="form-btn">
                                    <button id="valid-btn"><a href="payment" id="payer">Payer</a></button>
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
   
    jQuery(document).ready(function () {
        var nbPax = 0;
        var childs = 0;
        var montantTTC = 0;
        var recapitulationChambre = "";
        recapObject.bookRoom.forEach(function (room) {
            childs = childs + parseInt(room.nbEnfant);
            nbPax = nbPax + parseInt(room.nbAdulte);
            montantTTC = montantTTC + parseInt(room.qty) * parseInt(room.rate);
            recapitulationChambre = recapitulationChambre + "<div class='col-md-8'>" + room.qty + " x " + room.roomType + "</div>" + "<div class='col-md-4'><span>" + room.rate + "&euro;</span></div>";
        });

        $("#name-user").html("#" + informationPersonObject.name);
        $("#date-id").html("du " + changeFormat(dateArrivee) + " au " + changeFormat(dateDepart));

        $("#adults-id").html(nbPax);
        $("#children-id").html(childs);
        
         var night = dateDiff(dateArrivee,dateDepart);   
        $("#night-id").html(night);
        $("#amount-id").html(0);
        $("#tva-id").html(100);
        $("#total-id").html(montantTTC + "&euro;");
        $("#recapitulation-chambre-id").html("<div class = 'row'>" + recapitulationChambre + "</div>");

        function changeFormat(date) {
            options = {
                weekday: "short", year: 'numeric', month: 'long', day: 'numeric'
            };
            console.log(date.toLocaleString('fr-FR', options));
            return date.toLocaleString('fr-FR', options);
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