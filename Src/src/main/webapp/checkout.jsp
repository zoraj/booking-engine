<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>Accept a payment</title>
        <meta name="description" content="A demo of a payment on Stripe" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="stylesheet" href="assets/css/checkout.css" />
        <script src="https://js.stripe.com/v3/"></script>
        <script src="assets/js/checkout.js" defer></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    </head>
    <body>
        <div class="row"> 
            <div class="col-md-6" style="margin-top: 100px;">
                <h3>Réservation</h3>
                <div class="row">
                    <div class="col-md-4">
                        <span class="list-recap">Nom :</span>
                    </div>
                    <div class="col-md-8">
                        <span id="name-user" class="list-recap"></span>
                    </div>
                </div><br>
                <div class="row">
                    <div class="col-md-4">
                        <span class="list-recap">Type chambre :</span>
                    </div>
                    <div class="col-md-8">
                        <span id="recapitulation-chambre-id" class="list-recap"></span>
                    </div>
                </div><br>
                <div class="row">
                    <div class="col-md-4">
                        <span class="list-recap">Date arrivée :</span>
                    </div>
                    <div class="col-md-8">
                        <span id="date-arrivee" class="list-recap"></span>
                    </div>
                </div><br>
                <div class="row">
                    <div class="col-md-4">
                        <span class="list-recap">Date départ :</span>
                    </div>
                    <div class="col-md-8">
                        <span id="date-depart" class="list-recap"></span>
                    </div>
                </div><br>
                <div class="row">
                    <div class="col-md-4">
                        <span class="list-recap">Nombre de séjour :</span>
                    </div>
                    <div class="col-md-8">
                        <span id="night-id" class="list-recap">1</span>
                    </div>
                </div><br>
                <div class="row">
                    <div class="col-md-6">
                        <span id="total-id"></span>
                    </div>
                </div>
                <div class="row" style="margin-top: 10px;">
                    <div class="col-md-4">
                        <a href="https://stripe.com" target="_blank"><span class="lien-stripe">Propulsé par <strong>stripe</strong></span></a>
                    </div>
                    <div class="col-md-4">
                        <a href="https://stripe.com/checkout/terms" target="_blank"><span class="lien-stripe">Conditions d'utilisation</span></a>
                    </div>
                    <div class="col-md-4">
                        <a href="https://stripe.com/privacy" target="_blank"><span class="lien-stripe">Confidentialité</span></a>
                    </div>
                </div>
            </div>
            <div class="col-md-6" style="margin-top: 100px;">
                <h3>Payer par carte</h3>
                <!-- Display a payment form -->
                <form id="payment-form">
                    <div id="payment-element">
                      <!--Stripe.js injects the Payment Element-->
                    </div>
                    <button id="submit">
                      <div class="spinner hidden" id="spinner"></div>
                      <span id="button-text">Pay now</span>
                    </button>
                    <div id="payment-message" class="hidden"></div>
                </form>
            </div>
        </div>
    </body>
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
            var montantTTC = 0;
            var recapitulationChambre = "";
            var night = dateDiff(dateArrivee,dateDepart);
            recapObject.bookRoom.forEach(function (room) {
                montantTTC = parseFloat(montantTTC)  + parseFloat(room.qty) * parseFloat(room.rate);
                recapitulationChambre = recapitulationChambre + "<div class='col-md-8'>" + room.qty + " x " + room.roomType + "</div>";
            });
            
            var montantTotal = parseFloat(montantTTC) * parseFloat(night);
            $("#name-user").html(informationPersonObject.name);   
            $("#night-id").html(night);
            $("#date-arrivee").html(listRoomObject.dateArrivee);
            $("#date-depart").html(listRoomObject.dateDepart);
            $("#total-id").html(montantTotal + "&euro;");
            $("#recapitulation-chambre-id").html("<div class = 'row'>" + recapitulationChambre + "</div>");

             function dateDiff(date1, date2) {
                var diff = {}                           // Initialisation du retour
                var tmp = date2 - date1;

                tmp = Math.floor(tmp / 1000);             // Nombre de secondes entre les 2 dates
                diff.sec = tmp % 60;                    // Extraction du nombre de secondes

                tmp = Math.floor((tmp - diff.sec) / 60);    // Nombre de minutes (partie enti?re)
                diff.min = tmp % 60;                    // Extraction du nombre de minutes

                tmp = Math.floor((tmp - diff.min) / 60);    // Nombre d'heures (enti?res)
                diff.hour = tmp % 24;                   // Extraction du nombre d'heures

                tmp = Math.floor((tmp - diff.hour) / 24);   // Nombre de jours restants
                diff.day = tmp;

                return tmp;
            }

        });
    </script>
</html>