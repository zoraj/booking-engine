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
                                                <span class="form-label">Civilit�<i class="obligatoir">*</i></span>
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
                                                <input name="nom" id="nom" class="form-control" type="text">
                                                <span class="form-label">Nom<i class="obligatoir">*</i></span>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <input name="prenom" id="prenom" class="form-control" type="text">
                                                <span class="form-label">Pr�nom<i class="obligatoir">*</i></span>
                                            </div>
                                        </div>
                                    </div><br>
                                    <div class="row">
                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <input name="adresse" id="adresse" class="form-control" type="text">
                                                <span class="form-label">Adresse</span>
                                            </div>
                                        </div>
                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <input name="complement" id="complement" class="form-control" type="text">
                                                <span class="form-label">Compl�ment</span>
                                            </div>
                                        </div>
                                    </div><br>
                                    <div class="row">
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <input name="codePostal" id="codePostal" class="form-control" type="text">
                                                <span class="form-label">Code postal</span>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <input name="ville" id="ville" class="form-control" type="text">
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
                                                <input name="telephone" id="telephone" class="form-control" type="tel">
                                                <span class="form-label">T�l�phone (mobile)<i class="obligatoir">*</i></span>
                                            </div>
                                        </div>
                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <input name="email" id="email" class="form-control" type="email">
                                                <span class="form-label">Email<i class="obligatoir">*</i></span>
                                            </div>
                                        </div>
                                    </div><br>
                                    <div class="row">
                                        <div class="col-md-1">
                                            <input type="checkbox" class="form-check-input">
                                        </div>
                                        <div class="col-md-11">
                                            <label class="form-check-label">Cr�er mon compte utilisateur (Facultatif)</label>
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
                            <h5 style="font-weight:bolder; font-size: 18px; color: #06a8c4;">Paiement s�curis�</h5><hr style="border-top: 1px dashed rgba(0, 0, 0, 0.2);">
                        </div>
                        <div class="col-md-5">
                            <div class="row">
                                <div class="col-md-12">
                                    <strong>Coordonn�es bancaires</strong>
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
                                            <input class="form-check-input" type="radio" id="masterCardId" name="" value="">
                                        </div>
                                        <div class="col-md-3">
                                            <label class="form-check-label" for="">
                                                <img src="<%=request.getContextPath()%>/assets/img/masterCard.jpg" alt="" class="image-liste">
                                            </label>
                                        </div>
                                        <div class="col-md-1">
                                            <input class="form-check-input" type="radio" id="visaId" name="" value="">
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
                                        <input class="form-control" id="carte-paiement-numero" name="carte-paiement-numero" type="text">
                                        <span class="form-label">Num�ro de carte<i class="obligatoir">*</i></span>
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
                                            <option value="02">F�vrier</option>
                                            <option value="03">Mars</option>
                                            <option value="04">Avril</option>
                                            <option value="05">Mai</option>
                                            <option value="06">Juin</option>
                                            <option value="07">Juillet</option>
                                            <option value="08">Aout</option>
                                            <option value="09">Septembre</option>
                                            <option value="10">Octobre</option>
                                            <option value="11">Novembre</option>
                                            <option value="12">D�cembre</option>
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
                                            <option value="2020">2021</option>
                                        </select>
                                        <span class="select-arrow"></span>
                                    </div>
                                </div>
                            </div></br>
                            <div class="row">
                                <div class="col-md-7">
                                    <div class="form-group">
                                        <input class="form-control" id="carte-paiement-titulaire" name="carte-paiement-titulaire" type="text">
                                        <span class="form-label">Nom du titulaire<i class="obligatoir">*</i></span>
                                    </div>
                                </div>
                                <div class="col-md-5">
                                    <div class="form-group">
                                        <input class="form-control" id="carte-paiement-cvv" name="carte-paiement-cvv" type="text" maxlength="3">
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
                                    <strong id="amountId">219.50</strong>�
                                </div>
                            </div><hr>
                            <div class="row">
                                <div class="col-md-12">
                                    <p>
                                        L'acompte ne s'applique qu'un seule fois (pas de frais suppl�mentaires pour modification ou annulation). 
                                        Il est non remboursable et vient en d�duction du montant total de votre r�servation. Le montant reste d� selon
                                        l'�ch�ance indiqu�e dans les conditions g�n�rales de ventes de l'�tablissement.
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
                                                        <a href="#">Conditions G�n�rales de Vente</a> et je les accepte.</label>
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
                                                    <label class="form-check-label">Informez-moi par email des nouveaut�s et des op�ration sp�ciales</label>
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
                                    </div>
                                    <div class="row">
                                        <div class="col-md-offset-4 col-md-8">
                                            <div class="form-btn">
                                                <button class="submit-btn" id="validateId">Valider ma r�servation</button>
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
    var listRoom = sessionStorage.getItem("roomList_json");
    var listRoomObject = JSON.parse(listRoom);


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
    var reservation = sessionStorage.getItem("reservation_json");
    var reservationObject = JSON.parse(reservation);

    jQuery(document).ready(function () {
        $('#masterCardId').click(function () {
            if ($('#masterCardId').is(':checked') === true) {
                $("#visaId").prop('checked', false);
                $("#carte-paiement-type").val("MASTERCARD");
            }
        });

        $('#visaId').click(function () {
            if ($('#visaId').is(':checked') === true) {
                $("#masterCardId").prop('checked', false);
                $("#carte-paiement-type").val("VISA");
            }
        });

        $('#validateId').click(function () {
            $("#reservation").val(JSON.stringify(reservationObject));
            $("#room-list").val(JSON.stringify(listRoomObject.roomList));
            $("#carte-paiement-expiration").val($("#yearId").val()+"-" + $("#mounthId").val());
            $("#montant").val($("#amountId").html());
        });
    });
</script>