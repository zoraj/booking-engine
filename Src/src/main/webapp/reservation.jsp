<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/liste_type_chambre.css" />
<div id="booking">
    <div class="container">
        <div class="row">
            <div class="col-md-6 col-md-offset-3">
                <div class="row" id="recap">
                    <div class="col-md-12">
                        <form method="post" action="reservation">
                            <div class="row">
                                <div class="col-md-12 booking-cta">
                                    <h2>Price Breakdown</h2>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="row"><hr>
                                        <div class="col-md-8">
                                            <div class="row"><div class="col-md-12">#<span id="name-user"></span></div></div>
                                            <div class="row"><div class="col-md-12">Rate:<span id="rate-id"> </span></div></div>
                                        </div>
                                        <!--                                        <div class="col-md-4">$<span id="price-id"></span></div>-->
                                    </div><hr>
                                    <div id="user-id">
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
                                        <div class="col-md-8"><span>Day(s)</span></div>
                                        <div class="col-md-4"><span id="days-id"></span></div>
                                    </div><hr>
                                    <div class="row">
                                        <div class="col-md-8 font-title"><span>Arrival date </span></div>
                                        <div class="col-md-4 font-title"><span id="date-arrived-id"></span></div>
                                    </div><hr>
                                    <div class="row">
                                        <div class="col-md-8 font-title"><span>departure date </span></div>
                                        <div class="col-md-4 font-title"><span id="date-departure-date-id"></span></div>
                                    </div><hr>
                                    <div class="row">
                                        <div class="col-md-8 font-title"><span>Room number</span></div>
                                        <div class="col-md-4 font-title"><span id="qty-room-id"></span></div>
                                    </div><hr>
                                    <div class="row">
                                        <div class="col-md-8 font-title"><span>Total</span></div>
                                        <div class="col-md-4 font-title">$<span id="total-id"></span></div>
                                    </div><hr>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4 col-md-offset-4">
                                    <div class="form-btn">
                                        <button id="valid-btn">Payer</a></button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>	
            </div>
        </div>
    </div>
</div>

<script src="<%=request.getContextPath()%>/assets/js/jquery.min.js"></script>

<script>
    var recapResaJson = [
        {
            "pmsTarifOption": [
                {
                    "id": 1,
                    "libelle": "Piscine",
                    "dateDeletion": null,
                    "isChecked": false
                },
                {
                    "id": 2,
                    "libelle": "Terrasse",
                    "dateDeletion": null,
                    "isChecked": false
                }
            ],
            "pmsModelTarif": {
                "id": 5,
                "reference": "001",
                "libelle": "tarif public",
                "prixParDefaut": 2.30,
                "type": "BY_ROOM",
                "pmsCategorieTarifId": 2,
                "pmsCategorieTarifLibelle": null,
                "dateDeletion": null
            },
            "pmsTypeChambre": {
                "id": 2,
                "libelle": "Class",
                "reference": "ref type C",
                "salon": null,
                "pmsCategorieChambreId": 1,
                "pmsChambre": [
                    {
                        "id": 4,
                        "numeroChambre": "0011",
                        "numeroEtage": 2,
                        "etatChambre": "CLEAN",
                        "pmsTypeChambreId": 2,
                        "pmsTypeChambreLibelle": null,
                        "dateDeletion": null
                    },
                    {
                        "id": 5,
                        "numeroChambre": "0012",
                        "numeroEtage": 2,
                        "etatChambre": "CLEAN",
                        "pmsTypeChambreId": 2,
                        "pmsTypeChambreLibelle": null,
                        "dateDeletion": null
                    }
                ],
                "pmsCategorieChambreLibelle": null,
                "persMin": 1,
                "persMax": 3,
                "nbEnfant": 1,
                "dateCreation": 1586493194000,
                "dateModification": 1587032944000,
                "dateDeletion": null
            },
            "requestedRoom": 1,
            "totalRoom": 2,
            "availableRoom": 2,
            "nbPax": 2
        },
        {
            "pmsTarifOption": [
                {
                    "id": 1,
                    "libelle": "Piscine",
                    "dateDeletion": null,
                    "isChecked": false
                },
                {
                    "id": 2,
                    "libelle": "Terrasse",
                    "dateDeletion": null,
                    "isChecked": false
                }
            ],
            "pmsModelTarif": {
                "id": 5,
                "reference": "001",
                "libelle": "tarif public",
                "prixParDefaut": 2.30,
                "type": "BY_ROOM",
                "pmsCategorieTarifId": 2,
                "pmsCategorieTarifLibelle": null,
                "dateDeletion": null
            },
            "pmsTypeChambre": {
                "id": 2,
                "libelle": "Class",
                "reference": "ref type C",
                "salon": null,
                "pmsCategorieChambreId": 1,
                "pmsChambre": [
                    {
                        "id": 4,
                        "numeroChambre": "0011",
                        "numeroEtage": 2,
                        "etatChambre": "CLEAN",
                        "pmsTypeChambreId": 2,
                        "pmsTypeChambreLibelle": null,
                        "dateDeletion": null
                    },
                    {
                        "id": 5,
                        "numeroChambre": "0012",
                        "numeroEtage": 2,
                        "etatChambre": "CLEAN",
                        "pmsTypeChambreId": 2,
                        "pmsTypeChambreLibelle": null,
                        "dateDeletion": null
                    }
                ],
                "pmsCategorieChambreLibelle": null,
                "persMin": 1,
                "persMax": 3,
                "nbEnfant": 1,
                "dateCreation": 1586493194000,
                "dateModification": 1587032944000,
                "dateDeletion": null
            },
            "requestedRoom": 1,
            "totalRoom": 2,
            "availableRoom": 2,
            "nbPax": 2
        }
    ];
    //stockage
    var recapResa_json = JSON.stringify(recapResaJson);
    sessionStorage.setItem("recapResaJson", recapResa_json);
    sessionStorage.setItem('name', 'Jerimanjaka');
    sessionStorage.setItem('dateArrivee', '2020-02-02');
    sessionStorage.setItem('dateDepart', '2020-02-03');

    //lecture
    var listRoomTypes = sessionStorage.getItem("recapResaJson");
    var listRoomTypesObject = JSON.parse(listRoomTypes);

    var dateArrivee = new Date(sessionStorage.getItem('dateArrivee'));
    var dateDepart = new Date(sessionStorage.getItem('dateDepart'));

    var days = dateDiff(dateArrivee, dateDepart);

    jQuery(document).ready(function () {
        var nbPax = 0;
        var roomNumber = 0;
        var childs = 0;
        var price = 0.0;
        var rateModel = "";
        listRoomTypesObject.forEach(function (roomTypesObject) {
            rateModel = rateModel + ", " + roomTypesObject.pmsModelTarif.libelle;
            price = price + parseFloat(roomTypesObject.pmsModelTarif.prixParDefaut) * parseInt(roomTypesObject.requestedRoom);
            childs = childs + parseInt(roomTypesObject.pmsTypeChambre.nbEnfant);
            nbPax = nbPax + parseInt(roomTypesObject.nbPax);
            roomNumber = roomNumber + parseInt(roomTypesObject.requestedRoom);

            $("#user-id").append('<div class="row"><div class="col-md-8"><span>' + roomTypesObject.requestedRoom + '   ' + roomTypesObject.pmsTypeChambre.libelle + '</span></div> <div class="col-md-4"><span>' + roomTypesObject.pmsModelTarif.prixParDefaut + '</span>$</div></div><hr>');
        });

        $("#rate-id").append(rateModel.substr(1, rateModel.length));
        $("#name-user").html(sessionStorage.getItem('name'));
        $("#date-arrived-id").html(sessionStorage.getItem('dateArrivee'));
        $("#date-departure-date-id").html(sessionStorage.getItem('dateDepart'));

        $("#adults-id").html(nbPax);
        $("#children-id").html(childs);
        $("#qty-room-id").html(roomNumber);
        $("#total-id").html(price);
        $("#days-id").html(days);

    });

    function dateDiff(dateBegin, dateLast) {
        var tmp = dateLast - dateBegin;
        tmp = Math.floor(tmp / 1000);
        var sec = tmp % 60;
        tmp = Math.floor((tmp - sec) / 60);
        var min = tmp % 60;
        tmp = Math.floor((tmp - min) / 60);
        var hour = tmp % 24;
        tmp = Math.floor((tmp - hour) / 24);
        return tmp;
    }

    function postPayment() {
        
    }

</script>