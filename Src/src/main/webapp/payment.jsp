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
                                                <input name="nom" id="nom" class="form-control" type="text">
                                                <span class="form-label">Nom<i class="obligatoir">*</i></span>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <input name="prenom" id="prenom" class="form-control" type="text">
                                                <span class="form-label">Prénom<i class="obligatoir">*</i></span>
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
                                                <input name="code" id="code" class="form-control" type="text">
                                                <span class="form-label">Complément</span>
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
                                                <span class="form-label">Téléphone (mobile)<i class="obligatoir">*</i></span>
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
                                            <input class="form-check-input" type="radio" name="" value="">
                                        </div>
                                        <div class="col-md-3">
                                            <label class="form-check-label" for="">
                                                <img src="<%=request.getContextPath()%>/assets/img/masterCard.jpg" alt="" class="image-liste">
                                            </label>
                                        </div>
                                        <div class="col-md-1">
                                            <input class="form-check-input" type="radio" name="" value="">
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
                                        <input class="form-control" type="text">
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
                                        <select class="form-control">
                                            <option>Janvier</option>
                                            <option>Février</option>
                                            <option>Mars</option>
                                            <option>Avril</option>
                                            <option>Mai</option>
                                            <option>Juin</option>
                                            <option>Juillet</option>
                                            <option>Aout</option>
                                            <option>Septembre</option>
                                            <option>Octobre</option>
                                            <option>Novembre</option>
                                            <option>Décembre</option>
                                        </select>
                                        <span class="select-arrow"></span>
                                        <!--input class="form-control" type="month">
                                        <span class="form-label">Date d'expiration<i class="obligatoir">*</i></span-->
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <!--span class="form-label"></span-->
                                        <select class="form-control">
                                            <option>2019</option>
                                            <option>2020</option>
                                            <option>2021</option>
                                        </select>
                                        <span class="select-arrow"></span>
                                    </div>
                                </div>
                            </div></br>
                            <div class="row">
                                <div class="col-md-7">
                                    <div class="form-group">
                                        <input class="form-control" type="text">
                                        <span class="form-label">Nom du titulaire<i class="obligatoir">*</i></span>
                                    </div>
                                </div>
                                <div class="col-md-5">
                                    <div class="form-group">
                                        <input class="form-control" type="text" maxlength="3">
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
                                    <strong>219,50£</strong>
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
                                        <div class="col-md-offset-4 col-md-8">
                                            <div class="form-btn">
                                                <button class="submit-btn">Valider ma réservation</button>
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

<script>
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
</script>