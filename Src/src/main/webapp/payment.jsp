<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/paiement.css" />	
<div id="booking">
    <form method="post" action="payment">
        <div class="container">
            <div class="row">
                <div class="col-md-12 col-xs-12">
                    <div class="row paiement-securise" id="info-personnelle">
                        <br>
                        <div class="col-md-12">
                            <div class="row">
                                <div class="col-md-10">	
                                    <h5 style="font-weight:bolder; font-size: 18px; color: #06a8c4;">Informations personnelles</h5>
                                </div>
                                <div class="col-md-2">
                                    <i class="obligatoir">*</i><span style="color: red;"> Champs obligatoires</span>
                                </div>
                            </div>
                            <hr style="border-top: 1px dashed rgba(0, 0, 0, 0.2);">
                        </div>
                        <div class="col-md-12">
                            <div class="row">
                                <div class="col-md-8">
                                    <div class="row">
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <span class="form-label">Civilité<i class="obligatoir">*</i></span>
                                                <select name="qualite" id="qualite" class="form-control">
                                                    <option value="MR">M.</option>
                                                    <option value="MME">Mm</option>
                                                    <option value="MLLE">Mll</option>
                                                </select>
                                                <span class="select-arrow"></span>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <input name="nom" maxlength="99" id="nom" class="form-control" type="text" required autocomplete="off">
                                                <span class="form-label">Nom<i class="obligatoir">*</i></span>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <input name="prenom" maxlength="99" id="prenom" class="form-control" type="text" required autocomplete="off">
                                                <span class="form-label">Prénom<i class="obligatoir">*</i></span>
                                            </div>
                                        </div>
                                    </div><br>
                                    <div class="row">
                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <input name="adresse" maxlength="45" id="adresse" class="form-control" type="text" autocomplete="off">
                                                <span class="form-label">Adresse</span>
                                            </div>
                                        </div>
                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <input name="complement" maxlength="45" id="complement" class="form-control" type="text" autocomplete="off">
                                                <span class="form-label">Complément</span>
                                            </div>
                                        </div>
                                    </div><br>
                                    <div class="row">
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <input name="codePostal" pattern="[0-9]+" maxlength="44" id="codePostal" class="form-control" type="text" autocomplete="off">
                                                <span class="form-label">Code postal<i class="obligatoir">*</i></span>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <input name="ville" maxlength="44" id="ville" class="form-control" type="text" autocomplete="off">
                                                <span class="form-label">Ville</span>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <span class="form-label">Pays<i class="obligatoir">*</i></span>
                                                <select name="pays" id="pays" class="form-control">
                                                    <option value="FR">FRANCE</option>
                                                    <option value="MU">MAURICE</option>
                                                    <option value="MG">MADAGASCAR</option>
                                                </select>
                                                <span class="select-arrow"></span>
                                            </div>
                                        </div>
                                    </div><br>
                                    <div class="row">
                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <input name="telephone" maxlength="44" pattern="[0-9]+" id="telephone" class="form-control" type="tel" required autocomplete="off">
                                                <span class="form-label">Téléphone (mobile)<i class="obligatoir">*</i></span>
                                            </div>
                                        </div>
                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <input name="email" maxlength="44" id="email" class="form-control" type="email" required autocomplete="off">
                                                <span class="form-label">Email<i class="obligatoir">*</i></span>
                                            </div>
                                        </div>
                                    </div><br>
                                    <div class="row">
                                        <div class="col-md-1">
                                            <input type="checkbox" class="form-check-input">
                                        </div>
                                        <div class="col-md-11">
                                            <label class="form-check-label">Créer mon compte utilisateur (Facultatif)</label>
                                        </div>
                                    </div>
                                </div>							
                                <div class="col-md-4">
                                    <div class="row">
                                        <div class="col-md-offset-3 col-md-9">

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row paiement-securise">
                        <br>
                        <div class="col-md-12">
                            <h5 style="font-weight:bolder; font-size: 18px; color: #06a8c4;">Paiement sécurisé</h5><hr style="border-top: 1px dashed rgba(0, 0, 0, 0.2);">
                        </div>
                        <div class="col-md-5">
                            <div class="row">
                                <div class="col-md-12">
                                    <strong>Coordonnées bancaires</strong>
                                </div>
                            </div></br>
                            <div class="row">
                                <div class="col-md-12">
                                    <span class="other_label">Type de carte<i class="obligatoir">*</i></span>
                                </div>
                            </div><br>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="row">
                                        <div class="col-md-1">
                                            <input class="form-check-input" type="radio" id="masterCardId">
                                        </div>
                                        <div class="col-md-3">
                                            <label class="form-check-label" for="">
                                                <img src="<%=request.getContextPath()%>/assets/img/masterCard.jpg" alt="" class="image-liste">
                                            </label>
                                        </div>
                                        <div class="col-md-1">
                                            <input class="form-check-input" type="radio" id="visaId">
                                        </div>
                                        <div class="col-md-3">
                                            <label class="form-check-label" for="">
                                                <img src="<%=request.getContextPath()%>/assets/img/visa.jpg" alt="" class="image-liste">
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div></br>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <input class="form-control" id="carte-paiement-numero" pattern="[0-9]+" maxlength="15" name="carte-paiement-numero" type="text" required autocomplete="off">
                                        <span class="form-label">Numéro de carte<i class="obligatoir">*</i></span>
                                    </div>
                                </div>
                            </div></br>
                            <div class="row">									
                                <div class="col-md-6">
                                    <span class="other_label">Date d'expiration<i class="obligatoir">*</i></span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <!--span class="form-label"></span-->
                                        <select id="mounthId" class="form-control">
                                            <option value="01">Janvier</option>
                                            <option value="02">Février</option>
                                            <option value="03">Mars</option>
                                            <option value="04">Avril</option>
                                            <option value="05">Mai</option>
                                            <option value="06">Juin</option>
                                            <option value="07">Juillet</option>
                                            <option value="08">Aout</option>
                                            <option value="09">Septembre</option>
                                            <option value="10">Octobre</option>
                                            <option value="11">Novembre</option>
                                            <option value="12">Décembre</option>
                                        </select>
                                        <span class="select-arrow"></span>
                                        <!--input class="form-control" type="month">
                                        <span class="form-label">Date d'expiration<i class="obligatoir">*</i></span-->
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <!--span class="form-label"></span-->
                                        <select id="yearId" class="form-control">
                                            <option value="2019">2019</option>
                                            <option value="2020">2020</option>
                                            <option value="2021">2021</option>
                                        </select>
                                        <span class="select-arrow"></span>
                                    </div>
                                </div>
                            </div></br>
                            <div class="row">
                                <div class="col-md-7">
                                    <div class="form-group">
                                        <input class="form-control" maxlength="99" id="carte-paiement-titulaire" name="carte-paiement-titulaire" type="text" required autocomplete="off">
                                        <span class="form-label">Nom du titulaire<i class="obligatoir">*</i></span>
                                    </div>
                                </div>
                                <div class="col-md-5">
                                    <div class="form-group">
                                        <input class="form-control" id="carte-paiement-cvv" name="carte-paiement-cvv" type="text" maxlength="3" pattern="[0-9]{3}" required autocomplete="off">
                                        <span class="form-label">Cryptogramme<i class="obligatoir">*</i></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-7">
                            <div class="row">
                                <div class="col-md-10">
                                    <strong>Montant (Acompte)</strong>
                                </div>
                                <div class="col-md-2">
                                    <strong id="amountId"></strong>
                                </div>
                            </div><hr>
                            <div class="row">
                                <div class="col-md-12">
                                    <p>
                                        L'acompte ne s'applique qu'un seule fois (pas de frais supplémentaires pour modification ou annulation). 
                                        Il est non remboursable et vient en déduction du montant total de votre réservation. Le montant reste dû selon
                                        l'échéance indiquée dans les conditions générales de ventes de l'établissement.
                                    </p>
                                </div>
                            </div></br></br></br></br>
                            <div class="row">
                                <div class="col-md-offset-4 col-md-8">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="row">
                                                <div class="col-md-1">
                                                    <input type="checkbox" class="form-check-input">
                                                </div>
                                                <div class="col-md-11">
                                                    <label class="form-check-label">En cochant cette case, je reconnais avoir pris connaissance des 
                                                        <a href="#">Conditions Générales de Vente</a> et je les accepte.</label>
                                                </div>
                                            </div>																								
                                        </div>
                                    </div></br>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="row">
                                                <div class="col-md-1">
                                                    <input type="checkbox" class="form-check-input">
                                                </div>
                                                <div class="col-md-11">
                                                    <label class="form-check-label">Informez-moi par email des nouveautés et des opération spéciales</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div></br></br>
                                    <div class="row">
                                        <input type="hidden" id="reservation" name="reservation">
                                        <input type="hidden" id="room-list" name="room-list">
                                        <input type="hidden" id="carte-paiement-expiration" name="carte-paiement-expiration">
                                        <input type="hidden" id="carte-paiement-type" name="carte-paiement-type">
                                        <input type="hidden" id="montant" name="montant">
                                        <input type="hidden" id="adults" name="adults">
                                        <input type="hidden" id="dateArrivee" name="dateArrivee">
                                        <input type="hidden" id="dateDepart" name="dateDepart">
                                        <input type="hidden" id="recapchambre" name="recapchambre">
                                        
                                    </div>
                                    <div class="row">
                                        <div class="col-md-offset-4 col-md-8">
                                            <div class="form-btn">
                                                <button  id="validateId" class="submit-btn">Valider ma réservation                                                
                                                </button>  
                                                <!--<a href="<%=request.getContextPath()+"/mail"%>">Valider ma réservation</a>-->
                                            </div>                                   
                 
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>					
                </div>
            </div>
        </div>
    </form>
</div>
<script src="./assets/js/jquery.min.js"></script>
<script>
    //lecture liste des chambre 
    var cartePaymentType = "MASTERCARD";
    var listRoom = sessionStorage.getItem("roomList_json");
    var listRoomObject = JSON.parse(listRoom);

    var recapJson = sessionStorage.getItem("informationTypeRooms_json");
    var recapObject = JSON.parse(recapJson);
    
       
    var informationPersonJson = sessionStorage.getItem("informationPerson_json");
    var informationPersonObject = JSON.parse(informationPersonJson);
    
    var dateArrivee = new Date(listRoomObject.dateArrivee);
    var dateDepart = new Date(listRoomObject.dateDepart);
    $('.form-control').each(function () {
        floatedLabel($(this));
    });

    $('.form-control').on('input', function () {
        floatedLabel($(this));
    });

    function floatedLabel(input) {
        var $field = input.closest('.form-group');
        if (input.val()) {
            $field.addClass('input-not-empty');
        } else {
            $field.removeClass('input-not-empty');
        }
    }

    jQuery(document).ready(function () {
       
        var qteChb = 0;
        var nbAdulte = 0;
        var nbPax = 0;
        var montantTTC = 0;
        var recapitulationChambre = "";  
         //recuperation des nbEnfants, qteChb, nbAdulte reservé
        listRoomObject.roomList.forEach(function (room) {
            
            qteChb = qteChb + parseInt(room.qteChb);
            nbAdulte = nbAdulte + parseInt(room.nbAdulte);
        });
        // création de json reservation
        var reservationJson = {
            "dateArrivee": listRoomObject.dateArrivee,
            "dateDepart": listRoomObject.dateDepart,
            "nbPax": nbAdulte,
            "nbChambre": qteChb,
            "pmsServiceId": 1,
            "reservationType": "INDIV",
            "posteUuid": "7291ee70-0d98-4e53-9077-2db1fe91edd1",
            "origine": "BOOKING"
        };
        
        var reservation_json = JSON.stringify(reservationJson);
        sessionStorage.setItem("reservation_json", reservation_json);
        recapObject.bookRoom.forEach(function (room) {
            nbPax = nbPax + parseInt(room.nbAdulte); 
            montantTTC = montantTTC + parseInt(room.qty) * parseInt(room.rate);
            recapitulationChambre = recapitulationChambre  + room.qty + " x " + room.roomType +";";
            });          

        // Affichage de montant ttc
        $("#amountId").html(montantTTC + " &euro;");
              
        //initialisation
        $("#masterCardId").prop('checked', true);
        $("#visaId").prop('checked', false);

        //si on click sur masterCard
        $('#masterCardId').click(function () {
            if ($('#masterCardId').is(':checked') === true) {
                $("#visaId").prop('checked', false);
                cartePaymentType = "MASTERCARD";
            }
        });
        //si on click sur VISA
        $('#visaId').click(function () {
            if ($('#visaId').is(':checked') === true) {
                $("#masterCardId").prop('checked', false);
                cartePaymentType = "VISA";
            }
        });
        // Validation de paiment
        $('#validateId').click(function () {
            var dateExpiration =   new Date($("#yearId").val(),parseInt($("#mounthId").val())-1,1);
            
            if ((dateExpiration < new Date())) {
                $("#mounthId").get(0).setCustomValidity("Date anterieure à la date du jour");
            } else {              
                $("#mounthId").get(0).setCustomValidity("");
                $("#reservation").val(JSON.stringify(reservationJson));
                $("#room-list").val(JSON.stringify(listRoomObject.roomList));
                $("#carte-paiement-expiration").val($("#yearId").val() + "-" + $("#mounthId").val());
                
                $("#montant").val(montantTTC+ " $");
                
                $("#adults").val(nbPax); 
               
                $("#carte-paiement-type").val(cartePaymentType);
                $("#dateArrivee").val(changeFormat(dateArrivee));
                $("#dateDepart").val(changeFormat(dateDepart));
                $("#recapchambre").val(recapitulationChambre);
                
                   
               function changeFormat(date) {
                options = {
                weekday: "short",year: 'numeric', month: 'long', day: 'numeric'
                };            
                return date.toLocaleString('fr-FR', options);
                }                
            }
           
        });

    });
</script>