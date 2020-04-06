/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var listURL =  window.location.origin + "/pms-rest-api/ws/availability/header/get-all-with-cal";
var createURL = window.location.origin + "/pms-rest-api/ws/client/add";
var sendMailUrl = window.location.origin +"/pms-rest-api/ws/client/send-mail-client";
var addReservationUrl = window.location.origin + "/pms-rest-api/ws/hotel-order/bookingaddresa";
var getCountry =  window.location.origin+"/pms-rest-api/ws/client/nationalite/get-all";
var getHeaderMerchant =  window.location.origin+"/pms-rest-api/ws/syspay-merchant/GetheaderMerchant";
var getApikeyBookingUrl =   window.location.origin + "/admin/ws/etablissement/get-apikey-booking";
var getBgUrl =  window.location.origin+"/pms-rest-api/ws/settings/get-by-key";
var listeImgeTypeChbr =  window.location.origin+"/pms-rest-api/ws/room/type/image/get-by-typechb";

var passMinLength = 6;



function getURLParam( name, url ) {
    if (!url) url = location.href;
    name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
    var regexS = "[\\?&]"+name+"=([^&#]*)";
    var regex = new RegExp( regexS );
    var results = regex.exec( url );
    return results === null ? null : results[1];
}

function getApiKeyBooking(){
    
        var apikey_token = getURLParam('id', window.location.href);
        sessionStorage.apikey_token = apikey_token;
        // alert("apikey_token= "+sessionStorage.apikey_token);
        var request = $.ajax({
            url: getApikeyBookingUrl,
            type: "POST",
            "headers": {
                'Content-Type': 'application/json'
            },
            data: JSON.stringify({"payload": {
                    "apikey_token": sessionStorage.apikey_token
                }}),
            dataType: "json",
            success: function (data) {
                var apiKey = data.payload['api-key'];  
                console.log("apiKey = " + apiKey);     
                sessionStorage.apiKey = apiKey;  
               // alert(sessionStorage.apiKey);
            },
            error: function (j, s) {
                showNotif("[" + j.responseJSON.status.code + "] " + j.responseJSON.status.title + ":" + j.responseJSON.status.message, "danger");
            }
        });
}

function modif_css_style(id,valeur){
    
    var el = document.getElementById(id);
    if(el !== null){                    
        el.setAttribute('style', valeur);   
    }
}

function bg_default_setting(value){
    //BG image
    var style = "background-image: url('./assets/img/header.jpg'); background-size: cover; background-position: top center; height: 100vh;";
    modif_css_style("id_img",style); 
    //Page disponibilite
    $("#id_dispo_card").css("background-color", value);                    
                   
    //Page registration
    $("#id_reg_account").css("background-color", value);
    $("#id_reg_profil").css("background-color", value);
    $("#id_reg_billing").css("background-color", value);
    $('.nav-tabs').css("background-color", value);
    
    style = "color:#fff; padding-top: 10px; background-color:"+value;
    modif_css_style("idConfirm",style);                    
    //Btn load                   
    $("#btLoad").css("background-color", value);    
}

function getParametreBooking(key){
    
        $.ajax({
            url: getBgUrl,
            type: "POST",
            "headers": {
                'Content-Type': 'application/json',
                'api-key': sessionStorage.apiKey
            },
            data: JSON.stringify({"payload": {
                    "key": key
                }}),
            dataType: "json",
            success: function (data) {
                var style="";
                var setting = data.payload['setting'];  
                console.log("key = " + setting.key); 
                if(setting.key === "BOOKING_BG_IMAGE" ){
                    style = "background-image: url('"+window.location.origin+"/backend/assets/images/booking/background/"+setting.value+"'); background-size: cover; background-position: top center; height: 100vh;";
                    modif_css_style("id_img",style);                                       
                }
                if(setting.key === "BOOKING_BG_COLOR" ){                                        
                    //Page disponibilite
                    $("#id_dispo_card").css("background-color", setting.value);                    
                   
                    //Page registration
                    $("#id_reg_account").css("background-color", setting.value);
                    $("#id_reg_profil").css("background-color", setting.value);
                    $("#id_reg_billing").css("background-color", setting.value);
                    $('.nav-tabs').css("background-color", setting.value);
                    style = "color:#fff; padding-top: 10px; background-color:"+setting.value;
                    modif_css_style("idConfirm",style);                    
                    //Btn load                   
                    $("#btLoad").css("background-color", setting.value);
 
                    console.log("#id_dispo_card: " + $("#id_dispo_card"));
                }                
            },
            error: function (j, s) {
                 bg_default_setting("#f96332");
                //showNotif("[" + j.responseJSON.status.code + "] " + j.responseJSON.status.title + ":" + j.responseJSON.status.message, "danger");
            }
        });
}
// -----------------------
getApiKeyBooking();
getParametreBooking("BOOKING_BG_COLOR");        
getParametreBooking("BOOKING_BG_IMAGE");

$(document).ready(() => {
    //alert("ready="+sessionStorage.apiKey);
    $("#accountsetup").addClass('active');
    $("#btE1Verifier").on("click", () => {

        $("#contentPanel").html("");

        //validateSaisie()
        if (!requiredfield("formVerification"))
            return false;
        $("input[name='tsAdult']").val(sessionStorage.nbAdultGlobal);
        $("input[name='tsEnfant']").val(sessionStorage.nbEnfantGlobal);
        //Loading...
        $("#btE1Verifier").hide();
        $("#btLoad").show();

        //Appel ajax wS
        var dStart = $("#formVerification input[name= 'payload[dateArrivee]']").val();
        var dEnd = $("#formVerification input[name= 'payload[dateDepart]']").val();
        
        sessionStorage.datearrive = dStart;
        sessionStorage.datedepart = dEnd;
        var c = 0;
        $.ajax({
            
            type: "POST",
            url: listURL,
            "headers": {
                    'Content-Type': 'application/json',
                    'api-key': sessionStorage.apiKey
            },
            data: JSON.stringify({"payload": {
                    "date-start": formatDate(dStart),
                    "date-end": formatDate(dEnd)
                }}),
            dataType: "json",
            success: function (data) {

                //sinon retour                   
                var headers = data.payload["availability-header"];
                //create headers                 
                if(headers.length === 0) {
             
                    $("#formVerification label.errorLabel").html("Aucune chambre disponible.");
                    $("#formVerification label.errorLabel").show();
                    $("#formVerification #btE1Verifier").prop("disable", true);
                    
                    //Loading... retour normal
                    $("#btE1Verifier").show();
                    $("#btLoad").hide();
                    return false;
                }else {                    
                    headers.forEach((h) => {
                        addCards(c, h);
                        c++;
                    });

                    //Loading... retour normal
                    $("#btE1Verifier").show();
                    $("#btLoad").hide();
                    //les affichers dans ecran2
                    $("#ecran2").show();
                    scrollTo("#ecran2");
                }
            },
            error: function (j, s, data) {
                return false;
                //showNotif("["+j.responseJSON.status.code+"] "+j.responseJSON.status.title+":"+j.responseJSON.status.message, "danger");
            }
        });
    });

    $("#btE2EtapePrevious").on("click", () => {
        $('#confirmModal').modal('hide');
    });

    $("a.toscroll").on('click', function (e) {
        var url = e.target.href;
        var hash = url.substring(url.indexOf("#") + 1);
        scrollTo("#" + hash);
        return false;
    });

    $("input[name='tsAdult']").TouchSpin({
        min: 1,
        max: 99,
        step: 1,
        decimals: 0,
        boostat: 1,
        maxboostedstep: 1       
    });
    $("input[name='tsEnfant']").TouchSpin({
        min: 0,
        max: 99,
        step: 1,
        decimals: 0,
        boostat: 1,
        maxboostedstep: 1
    });
});



$(window).scroll(function () {
    if ($(this).scrollTop() > 50) {
        $('#back-to-top').fadeIn();
    } else {
        $('#back-to-top').fadeOut();
    }
});
// scroll body to 0px on click
$('#back-to-top').click(function () {
    $('#back-to-top').tooltip('hide');
    $('body,html').animate({
        scrollTop: 0
    }, 800);
    return false;
});

function scrollTo(elementId) {
    $('html, body').animate({
        scrollTop: $(elementId).offset().top
    }, 500);
}

//function to use in popup reserver
function confirmResa(id) {
    var nbechambre = $("#nbechambre").val();
    var nbeadultwritten = $("#nbeadulte").val();
    var nbeitem = document.getElementsByClassName("montanttocalcul");

    if (nbeitem.length < nbechambre || nbeitem.length === nbechambre)
    {
        //Ventilation des chambres
        var lastAdult = $("input[name='tsAdult']").val();
        sessionStorage.nbAdultGlobal = parseInt(sessionStorage.nbAdultGlobal) - parseInt(lastAdult);

        var lastEnfant = $("input[name='tsEnfant']").val();
        sessionStorage.nbEnfantGlobal = parseInt(sessionStorage.nbEnfantGlobal) - parseInt(lastEnfant);

        $("input[name='tsAdult']").trigger("touchspin.updatesettings", {max: sessionStorage.nbAdultGlobal});
        $("input[name='tsEnfant']").trigger("touchspin.updatesettings", {max: sessionStorage.nbEnfantGlobal});

        var takelibelle = document.getElementsByClassName("category")[id].innerHTML;
        var takedescription = document.getElementsByClassName("descriptionroom")[id].innerHTML;
        var takemontant = document.getElementsByClassName("montantroom")[id].innerHTML;
        var montanttocalclu = document.getElementsByClassName("mount")[id].innerHTML;
        var tarifId = document.getElementsByClassName("idTarif")[id].innerHTML;
        var descripte = document.getElementsByClassName("descripte")[id].innerHTML;
        var typeChambreId = document.getElementsByClassName("idTypeChambre")[id].innerHTML;
        //var nbepax=document.getElementsByClassName("nbepax")[id].innerHTML;
        //var nbepax = $('#tsAdult').val();

        $('#confirmModal').modal('show');

        var contentmodal = $('<div class="gradient-hr-bot" id="contentchoice' + id + '">' +
                '<div class="text-info text-capitalize" > ' + takelibelle + '</div>' +
                '<div>' + takedescription + ' </div>' +
                '<div id="takendescript" class="takendescript" style="display: none;">' + descripte + '</div>' +
                '<div id="takednbe">Occupants: ' + lastAdult + ' personnes adultes</div>' +
                ' <div class="text-info text-capitalize"><p id="montantroom">' + takemontant + '</p></div>' +
                '<div id="montanttocalcul" class="montanttocalcul" style="display: none;">' + montanttocalclu + '</div>' +
                '<div id="tarifId" class="tarifId" style="display: none;">' + tarifId + '</div>' +
                '<div id="typeChambreId" class="typeChambreId" style="display: none;">' + typeChambreId + '</div>' +
                ' </div>' +
                '<div class="col-sm-2" float="left" id="buttonchoice' + id + '"> ' +
                '<img type="submit" onclick="deletecontent(' + id + ',' + lastAdult + ',' + lastEnfant + ')" src="./assets/img/icons/delete.png" >' +
                '</div> ');

        contentmodal.appendTo('#contentallchoice');

        sessionStorage.montantcanbesum = montanttocalclu;
        sessionStorage.description = descripte;
       sessionStorage.lastAdult = nbeadultwritten;
       sessionStorage.nbechambre = nbechambre;
        sommetotal();
       
    } else {
        showNotif("Cannot add a room anymore, You have chosen " + nbechambre + "room", "danger");
        $('#confirmModal').modal('show');
    }
}
//ajouter nouveau client
function addNewUser() {
   
    sessionStorage.phone = $('#phoneId').val();
    sessionStorage.adresse = $('#adressId').val();
    sessionStorage.city = $('#cityId').val();
    var currentDate = new Date();
    var day = currentDate.getDate();
    var monthNames = ["January", "February", "March", "April", "May", "June",
        "July", "August", "September", "October", "November", "December"
    ];
    var month = currentDate.getMonth();
    var year = currentDate.getFullYear();
    var datefacture = monthNames[month] + " " + day + ", " + year;

    var request = $.ajax({
        url: createURL,
        type: "POST",
        "headers": {
                    'Content-Type': 'application/json',
                    'api-key': sessionStorage.apiKey
                },
        data: JSON.stringify({"payload": {
                "compte": null,
                "compteAuxiliaire": null,
                "numBadge": null,
                "nom": sessionStorage.nomnote,
                "adresse": sessionStorage.adresse,
                "ville": sessionStorage.city,
                "codePostal": "",
                "telephone": sessionStorage.phone,
                "mobile": null,
                "email": sessionStorage.email,
                "dateCreation": datefacture,
                "dateModification": null,
                "hotelPrescripteurId": null,
                "pmsNationaliteId": null,
                "pmsQualiteId": null,
                "pmsSegmentClientId": "1",
                "pmsSocieteId": null,
                "pmsTypeClientId": null

            }}),
        dataType: "json",
        success: function (data) {
            console.log(data.payload.id);
            sessionStorage.idUser = data.payload.id;

            $("#profileTab").hide();
            $("#billingTab").show();
            $("#billingsetup").addClass('active');
            $("#profilsetup").removeClass('active');
        },
        error: function (j, s) {
            showNotif("[" + j.responseJSON.status.code + "] " + j.responseJSON.status.title + ":" + j.responseJSON.status.message, "danger");

        }
    });
    return true;
}

//get nationalite 

function getAllNationalite() {
    
    $.ajax({
        "type": "POST",
        "url": getCountry,
        "crossOrigin": true,
        "headers": {
                    'Content-Type': 'application/json',
                    'api-key': sessionStorage.apiKey
                },
        "dataType": "json",
        "data": JSON.stringify({"payload":{}}),
         success: function(data) { 
            var liste=data.payload["list-nationalite"];
            var select= $("#formdetail select[name='payload[pmsNationaliteId]']");
            select.html("");
            liste.forEach(function(nationalite){
                select.append($('<option>', {value:nationalite.libelle, text:nationalite.libelle}));

            });
        },
        error: function (j, s) {
            showNotif("Impossible de charger les nationalit&eacute;s", "danger");
            showNotif("[" + j.responseJSON.status.code + "] " + j.responseJSON.status.title + ":" + j.responseJSON.status.message, "danger");
        }
    });
}

function getTypeChbrImageById(id) {
    var listeImage;
    
    
    return listeImage;
}

//show notification 
function showNotif(text, type) {
    if (type === undefined)
        type = "success";
    $.bootstrapGrowl(text, {
        ele: 'body', // which element to append to
        type: type, // (null, 'info', 'danger', 'success', 'warning')
        offset: {
            from: "top",
            amount: 50
        }, // 'top', or 'bottom'
        align: "right", // ('left', 'right', or 'center')
        width: "auto", // (integer, or 'auto')
        delay: 10000, // Time while the message will be displayed. It's not equivalent to the *demo* timeOut!
        allow_dismiss: true, // If true then will display a cross to close the popup.
        stackup_spacing: 10 // spacing between consecutively stacked growls.
    });
}
//test if the password is the same
function isSamePassword(formId) {
    var password = $("#" + formId + " input[name='payload[password]']").val();
    var passwordConfirmation = $("#" + formId + " input[name='payload[passwordConfirmation]']").val();
    var samepass = password.localeCompare(passwordConfirmation) === 0;
    var correctLength = password.length > passMinLength - 1;

    if (correctLength && samepass) {
        $("#" + formId + " label.errorLabel").hide();
        $("#" + formId + " #continueregistration").prop("disable", false);
    } else {
        if (!correctLength)
            $("#" + formId + " label.errorLabel").html("Passwords are too short ");
        if (!samepass)
            $("#" + formId + " label.errorLabel").html("Passwords are not the same");
        $("#" + formId + " label.errorLabel").show();
        $("#" + formId + " #continueregistration").prop("disable", true);
    }
    return correctLength && samepass;
}
//test required field inside registration
function requiredfieldregistration(formId) {
    var username = $("#" + formId + " input[name= 'payload[lastname]']").val();
    var emailuser = $("#" + formId + " input[name= 'payload[email]']").val();
    var password = $("#" + formId + " input[name='payload[password]']").val();
    var passwordConfirmation = $("#" + formId + " input[name='payload[passwordConfirmation]']").val();
//$(".requiredAttr").each(function(){
    if (username.length < 1 || emailuser.length < 1 || password.length < 1 || passwordConfirmation.length < 1) {
        $("#" + formId + " label.errorLabel").html("Please fill in all the fields.");
        $("#" + formId + " label.errorLabel").show();
        $("#" + formId + " #continueregistration").prop("disable", true);
        return false;
    } else {
        return true;
    }
//});
    return false;
}

//function to sendMail facture to client
function sendMail(idUser, path,moduleId) {
    var jsonObject = JSON.stringify({"payload": {"id": idUser, "pathfile": path, "moduleId": moduleId}});
    $.ajax({
        url: sendMailUrl,
        type: "POST",
        "headers": {
                    'Content-Type': 'application/json',
                    'api-key': sessionStorage.apiKey
        },
        data: jsonObject,
        dataType: "json",
        success: function (data) {
            
            showNotif("Une Mail comprenant votre facture est envoy&eacute; &agrave; " + data.payload.recipient + "...", "success");
           // window.location = "/booking?apikey="+sessionStorage.apiKey;

            // else showNotif("Erreur lors de l'envoi de mail à "+data.payload.recipient, "danger");
        },
        error: function (j, s) {
            showNotif("[" + j.responseJSON.status.code + "] " + j.responseJSON.status.title + ":" + j.responseJSON.status.message, "danger");
        }
    });
}
//function to add reservation into t_hotel_note_entete
function addResa() {
    //for(var i = 0 ; i< sessionStorage.itemstorage; i++) 
    
    var request = $.ajax({
        url: addReservationUrl,
        type: "POST",
        "headers": {
                    'Content-Type': 'application/json',
                    'api-key': sessionStorage.apiKey
                },
        data: JSON.stringify({"payload": {
                "date-arrive": formatDate(sessionStorage.datearrive),
                "date-depart": formatDate(sessionStorage.datedepart),
                "nb-pax": sessionStorage.lastAdult,
                "nb-chambre":sessionStorage.nbechambre,
                "client-id": sessionStorage.idUser,               
                "nom-note": sessionStorage.nomnote,
                "type-reservation": sessionStorage.reservationType,               
                "activite-poste-id": 1,
                "service-id": 1,
                "listMontant": sessionStorage.listmontant,
                "listTarif": sessionStorage.listTarif,
                "listTypeChambre": sessionStorage.listTypeChambre,
                "payment_id": "",//sessionStorage.payment_id,
                "token_id": "", //sessionStorage.token_id,
                "booking-origin":"BE"
               
            }}),
        dataType: "json",
        success: function (data) {
            //showNotif("Nouveau resa ajouté...", "success");
            console.log("date-arrive" + sessionStorage.datearrive +
                    "date-depart" + sessionStorage.datedepart + "client-id" + sessionStorage.idUser +
                    "nom-note" + sessionStorage.nomnote);       
           
            showNotif("R&eacute;servation enregistr&eacute;e. " /*+ data.payload.recipient + "..."*/, "success");
            setTimeout(function(){  window.location = "/booking?id="+sessionStorage.apikey_token; }, 3000);
        },
        error: function (j, s) {
            showNotif("[" + j.responseJSON.status.code + "] " + j.responseJSON.status.title + ":" + j.responseJSON.status.message, "danger");
        }
    });
    return true;
}

//VALIDATE FORMULAIRE
function requiredfield(formId) {

    var dateArrivee = $("#" + formId + " input[name= 'payload[dateArrivee]']").val();
    var dateDepart = $("#" + formId + " input[name= 'payload[dateDepart]']").val();
    var nbChb = $("#" + formId + " input[name='payload[nbChb]']").val();
    
    sessionStorage.dateArrivee = dateArrivee;
    sessionStorage.dateDepart = dateDepart;
    
    sessionStorage.nbAdultGlobal = $("#" + formId + " input[name='payload[nbAdulte]']").val();
    sessionStorage.nbEnfantGlobal = $("#" + formId + " input[name='payload[nbEnfant]']").val();

    //var codePromo = $("#"+formId+" input[name='payload[codePromo]']").val();

    if (dateArrivee.length < 1 || dateDepart.length < 1
            || nbChb.length < 1 || sessionStorage.nbAdultGlobal.length < 1
            || sessionStorage.nbEnfantGlobal.length < 1 /*|| codePromo.length < 1 */) {

        $("#" + formId + " label.errorLabel").html("Veuillez remplir tous les champs requis.");
        $("#" + formId + " label.errorLabel").show();
        $("#" + formId + " #btE1Verifier").prop("disable", true);
        return false;
    }

    //Date Valide apres date du jour
    var dtValid = dateValide(dateArrivee);
    //alert("dateArrivee = "+ dateArrivee+ ", dtValid= " +dtValid);
    if (dtValid < 0) {
        $("#" + formId + " label.errorLabel").html("La date d'arriv&eacute;e est inf&eacute;rieure &agrave; la date du jour.");
        $("#" + formId + " label.errorLabel").show();
        $("#" + formId + " #btE1Verifier").prop("disable", true);
        return false;
    }

    //focntion de calcul intervalle de date
    var intervalDate = calculteInterval(dateArrivee, dateDepart);

    if (dateArrivee.length >= 0 && dateDepart.length >= 0 && intervalDate < 0) {
        $("#" + formId + " label.errorLabel").html("La date d'arriv&eacute;e est sup&eacute;rieure &agrave; la date de d&eacute;part.");
        $("#" + formId + " label.errorLabel").show();
        $("#" + formId + " #btE1Verifier").prop("disable", true);

        return false;
    }

    $("#" + formId + " label.errorLabel").html("");
    return true;

}

//VALIDATE BILLING SETUP
function requiredfieldBilling(formId) {

    //var codePromo = $("#"+formId+" input[name='payload[codePromo]']").val();
    $("#" + formId + " label.errorLabel").html("Please fill in all the fields.");
    if (sessionStorage.cardHolderName.length < 1 || sessionStorage.cardNumber.length < 1
            || sessionStorage.cvc.length < 1 || sessionStorage.expiryDate.length < 1  ) {
               
        $("#" + formId + " label.errorLabel").html("Please fill in all the fields.");
        $("#" + formId + " label.errorLabel").show();
        $("#" + formId + " #checkbilling").prop("disable", true);
        return false;
    }

    $("#" + formId + " label.errorLabel").html("");
    return true;

}



//Date arrivée doit etre supérieur à la date du jour
function dateValide(dateArrivee) {

    var dNow = new Date().toISOString();
    var toDay = new Date(dNow.substring(0, 4), dNow.substring(5, 7), dNow.substring(8, 10)); // Current date now.  
    var arrive = new Date(dateArrivee.substring(6, 10), dateArrivee.substring(3, 5), dateArrivee.substring(0, 2)); // Current date now.
    var diff = (arrive - toDay);

    return diff;
}

function calculteInterval(dtA, dtD) {

    var arrive = new Date(dtA.substring(6, 10), dtA.substring(3, 5), dtA.substring(0, 2)); // Current date now.
    var depart = new Date(dtD.substring(6, 10), dtD.substring(3, 5), dtD.substring(0, 2)); // Start of 2010.
    var diff = (depart - arrive);

    return diff;
}
//"2017-05-25"
function formatDate(dte) {
    return dte.substring(6, 10) + "-" + dte.substring(3, 5) + "-" + dte.substring(0, 2);
}

//Block de card Chambre
var addCards = function (i, h) {
    var cbedispo;
    h.hotelDisponibiliteCalendrierSet.forEach((c)=>{
            cbedispo= c.tarifMontant;
    });
        
    var myPanel = $('<div class="card" id="' + i + 'Panel">' +
            '<div class="card-block">' +
            '<div class="row">' +
            '<div class="col-md-6">' +
            '<div id="carouselExampleControls' + i + '" class="carousel slide" >' +
            '<ol class="carousel-indicators" id="indicators' + i + '">' +
            '<li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>' +
            '<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>' +
            '<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>' +
            '</ol>' +
            '<div class="carousel-inner" role="listbox" id="contentCaroussel' + i + '">' +
            '</div>' +
            '<a class="carousel-control-prev" href="#carouselExampleControls' + i + '" role="button" data-slide="prev">' +
            '<i class="now-ui-icons arrows-1_minimal-left"></i>' +
            '</a>' +
            '<a class="carousel-control-next" href="#carouselExampleControls' + i + '" role="button" data-slide="next">' +
            '<i class="now-ui-icons arrows-1_minimal-right"></i>' +
            '</a>' +
            '</div>' +
            '</div>' +
            '<div class="col-md-6">' +
            '<p class="category">' + h.libelle + '</p>' +
            '<div id="mount" class="mount" style="display: none;">' + cbedispo+ '</div>' +
            '<div id="idTarif" class="idTarif" style="display: none;">' + h.hotelModeleTarif.id+ '</div>' +
            '<p class="montantroom" align="right">Prix: <b>' + cbedispo + '&euro;</b></p>' +
            '<p class = "descriptionroom">Description:' +
            '<br/><small>' + h.hotelModeleTarif.libelle + ', ' + h.hotelTypeChambre.libelle + '</small></p>' +
            '<div id="idTypeChambre" class="idTypeChambre" style="display: none;">' + h.hotelTypeChambre.id+ '</div>' +
            '<div id="justdescription" class="descripte" style="display: none;">' + h.hotelModeleTarif.libelle + ', ' + h.hotelTypeChambre.libelle + '</div>' +
            '<p class="options" id="contentOption' + i + '">Options:<br/></p>' +
            '<div class="text-center"><button class="btn btn-info btn-round" id="idVentil' + i + '" type="button">R&eacute;server &nbsp; &nbsp;<i class="fa fa-chevron-right"></i></button></div>' +
            '</div>' +
            '</div>' +
            '</div>' +
            '</div>');

    //$("#"+i+"Panel").css("background-color", setting.value);
    myPanel.appendTo('#contentPanel');



    var idTypeChb =  h.hotelTypeChambre.id;
    var id_caroussel_image=1;
    $.ajax({
        "type": "POST",
        "url": listeImgeTypeChbr,
        "crossOrigin": true,
        "headers": {
                    'Content-Type': 'application/json',
                    'api-key': sessionStorage.apiKey
                },
        "dataType": "json",
        "data": JSON.stringify({"payload":{
                "idTypeChb":idTypeChb
        }}),
         success: function(data) {
            var type_chb_imgage;
            var active; 
            var listeImage = data.payload["typeChbre-image-list"]; 
            listeImage.forEach((img)=>{  
                //alert(img.imagePath+img.nom);
                if(id_caroussel_image === 1) {
                     type_chb_imgage = img.imagePath+img.nom;
                     active = "active";
                 } else{
                    type_chb_imgage= img.imagePath+img.nom;
                    active = "";
                }            
                    addImgCarousel(i, id_caroussel_image, type_chb_imgage, active);
                    id_caroussel_image++;
            });
        },
        error: function (j, s) {
            showNotif("Impossible de charger les informations des images du type de chambre.", "danger");
            showNotif("[" + j.responseJSON.status.code + "] " + j.responseJSON.status.title + ":" + j.responseJSON.status.message, "danger");
        }
    });


    var j = 0;
    
    if( h.hotelModeleTarif.thotelTarifOptionCollection !== undefined || h.hotelModeleTarif.thotelTarifOptionCollection > 0){
        //alert("Option!!");
        h.hotelModeleTarif.thotelTarifOptionCollection.forEach((c) => {
            addOptions(i, j, c);
            j++;
        });
    }
    
    //On click ventilation
    $("#idVentil" + i).on("click", () => {
        sessionStorage.idList = i;
        //alert("#idVentil"+i + sessionStorage.nbAdultGlobal);
        if (parseInt(sessionStorage.nbAdultGlobal) !== 0 /*&& parseInt(nbEnfantGlobal) !== 0*/) {
            $("input[name='tsAdult']").trigger("touchspin.updatesettings", {max: sessionStorage.nbAdultGlobal});
            $("input[name='tsEnfant']").trigger("touchspin.updatesettings", {max: sessionStorage.nbEnfantGlobal});
            /*$("input[name='tsAdult']").val(sessionStorage.nbAdultGlobal);*/

            $('#typeChbV').text("Type de chambre : "+ h.libelle);
            $('#ventilationModal').modal('show');

        } else {
            showNotif("All selected persons were divided by room!", "danger");
            confirmResa(i);
        }
    });
};

$("#btReservation").on("click", () => {
    confirmResa(sessionStorage.idList);
});



//Ajout image caroussel
var addImgCarousel = function (id_content_caroussel, id_caroussel_image, type_chb_imgage, active) {
    var myImg = $('<div class="carousel-item ' + active + '" id="img' + id_caroussel_image + '">' +            
            '<img class="d-block" src="./assets' + type_chb_imgage + '" alt="">' + 
            //'<img class="d-block" src="' + window.location.origin+type_chb_imgage + '.jpg" alt="">' +
            '</div>');

    myImg.appendTo('#contentCaroussel' + id_content_caroussel);
};

//Ajout Options
var addOptions = function (i, j, o) {

    var optionName = manageOptionImage(o.id);
    var myOption = $('<img id="' + j + 'option" src="assets/img/icons/' + optionName +
            '" data-toggle="tooltip" title="' + o.libelle +
            '" data-placement="top" data-container="body" data-animation="true"/>');

    myOption.appendTo('#contentOption' + i);

};

var manageOptionImage = function (id) {

    switch (id) {
        case 1:
            name = "bread.png";
            break;
        case 2:
            name = "parking-sign.png";
            break;
        case 3:
            name = "piscine.png";
            break;
        case 4:
            name = "glass-and-bottle-of-wine.png";
            break;
        case 5:
            name = "climatisation.png";
            break;
        case 6:
            name = "wifi.png";
            break;
        case 7:
            name = "restaurant.png";
            break;
        default:
            name = "";
    }

    return name;

};

//delete if user change view about what they choose
function deletecontent(id, lastAdult, lastEnfant) {
    //remettre le dernier nombre adulte saisie ici    
    sessionStorage.nbAdultGlobal = parseInt(sessionStorage.nbAdultGlobal) + parseInt(lastAdult);
    sessionStorage.nbEnfantGlobal = parseInt(sessionStorage.nbEnfantGlobal) + parseInt(lastEnfant);

    document.getElementById('contentchoice' + id).remove();
    document.getElementById('buttonchoice' + id).remove();
    sommetotal();
}

//get total sum of all list price
function sommetotal() {
    var itemCount = document.getElementsByClassName("montanttocalcul");
    sessionStorage.itemstorage = itemCount.length;
    var total = 0;
    for (var i = 0; i < itemCount.length; i++)
    {
        total = total + parseInt(document.getElementsByClassName("montanttocalcul")[i].innerHTML);
    }
    sessionStorage.totalsomme = total;
    
    document.getElementsByClassName("modal-pre-footer")[0].innerHTML 
            = '<div class="text-info text-capitalize" id="sommetotal"><strong>Total: <span>' + total + '</span>&euro;</strong></div>';

    return total;
}

$("#btE2EtapeSuivante").on("click", () => {
    var nbechambre = $("#nbechambre").val();

    var reste = nbechambre - sessionStorage.itemstorage; 
    if (sessionStorage.itemstorage !== nbechambre) {
        if (reste > 0)
        {
            showNotif("there are still " + reste + "  rooms to choose ", "danger");
            $('#confirmModal').modal('hide');
        } else {
            ("You have to delete room, You have choosen " + nbechambre + "  rooms ", "danger");
            $('#confirmModal').modal('hide');
        }
    } else {
        sessionStorage.pmsActivitePoste = 1;
        sessionStorage.serviceId = 1;
        if (sessionStorage.nbepax === 1)
            sessionStorage.reservationType = 1;
        else
            sessionStorage.reservationType = 2;
        //
        ///hotel chambre id
        window.location = "/booking/registration?id="+sessionStorage.apikey_token;
        sessionStorage.listdescr = JSON.stringify(getlistdescr());
        sessionStorage.listmontant = JSON.stringify(getlistmontant());
        sessionStorage.listTarif = JSON.stringify(getlistTarif());
        sessionStorage.listTypeChambre = JSON.stringify(getlistTypeChambre());
    }
});

$('#addotherroom').click(function () {
    $('#confirmModal').modal('hide');
});

$('#continueregistration').click(function () {
    if (!requiredfieldregistration("formaccount"))
        return false;
    if (!isSamePassword("formaccount"))
        return false;
    $("#accountTab").hide();
    $("#profileTab").show();
    $("#profilsetup").addClass('active');
    $("#accountsetup").removeClass('active');
    $("#namelabel").html($("#lastnameid").val() + " " + $("#firstnameid").val());
    sessionStorage.nomnote = $("#lastnameid").val() + " " + $("#firstnameid").val();
    sessionStorage.lastname = $("#lastnameid").val();
    sessionStorage.firstname = $("#firstnameid").val(); 
    sessionStorage.email = $("#emailid").val();
    getAllNationalite();
    
});

$('#backprofildetail').click(function () {
    $("#profileTab").hide();
    $("#accountTab").show();
    $("#accountsetup").addClass('active');
    $("#profilsetup").removeClass('active');
});
$('#registrationdetail').click(function () {
    addNewUser();
   
          /*  $("#profileTab").hide();
            $("#billingTab").show();
            $("#billingsetup").addClass('active');
            $("#profilsetup").removeClass('active');*/
 
});
$('#backbilling').click(function () {
    $("#billingTab").hide();
    $("#profileTab").show();
    $("#accountsetup").addClass('active');
    $("#billingsetup").removeClass('active');
});
$('#checkbilling').click(function () {
    
    
    sessionStorage.cardHolderName = $('#idCardHolderName').val();
    sessionStorage.cardNumber = $('#idCardNumber').val();
    sessionStorage.cvc = $('#idCvc').val();   
    sessionStorage.expiryDate = $("#formBillingSetup input[name='payload[ExpiryDate]']").val();
       
    //booking_id et reference
    var random = Math.random().toString(36).substring(2, 6);
    var ref_booking_id = "BKN"+random+sessionStorage.idUser;
        
    // controle des champs
    if (!requiredfieldBilling("formBillingSetup"))
            return false;
   
    var sExp =  sessionStorage.expiryDate.split('/');
    sessionStorage.expMonth = sExp[0];
    sessionStorage.expYear = sExp[1]; 
    
    /*console.log("ref_booking_id :" ,  ref_booking_id);
    console.log("dateArrivee :" ,  sessionStorage.dateArrivee);
    console.log("dateDepart :" ,  sessionStorage.dateDepart);
    console.log("totalsomme :" , sessionStorage.totalsomme);
    
    console.log("email :" ,  sessionStorage.email);
    console.log("firstname :" ,  sessionStorage.firstname);
    console.log("lastname :" , sessionStorage.lastname);
    
    console.log("cardHolderName :" ,  sessionStorage.cardHolderName);
    console.log("cardNumber :" ,  sessionStorage.cardNumber);
    console.log("cvc :" ,  sessionStorage.cvc);  */     
    
    //Appel Ws syspay
    /*teste apel ws*/
    $.post("/booking/GetheaderMerchant", {
        "merchantLogin": "75849001",
        "passphrase": "jucfbbv6lbgtnqqtsrz6ljtzvn93jx6",
        "partnerLogin" : "25343002",
        "partnerPassphrase" :"Foh0eesaepaereetiathacoteejaeghe" 
    },
    function (AuthToken) {
            console.log("X-Wsse : " , AuthToken);                                             
            //https://app-sandbox.syspay.com/api/v1/partner/user/29364
            //https://receptio-sandbox.syspay.com/user/account/75849/operations            
            var myUrl = "https://app-sandbox.syspay.com/api/v2/merchant/token";
            var proxy = 'https://cors-anywhere.herokuapp.com/';

            /*$.ajax({
                "type": "POST",
                "url": proxy + myUrl,
                //"crossOrigin": true,
                "headers": {
                        'X-Wsse': AuthToken,
                        'Content-Type': 'application/json'                                
                },
                "dataType": "json",
                "data": JSON.stringify(
                {
                    "booking_details": {
                        "booking_currency": "EUR",
                        "booking_id": ref_booking_id, //TODO reference
                        "check_in_date": formatDate(sessionStorage.dateArrivee),   
                        "check_out_date":  formatDate(sessionStorage.dateDepart),
                        "total_booking_amount": sessionStorage.totalsomme,
                        "type": "HOTEL"
                    },
                    "customer": {
                        "address_country": "FR",
                        "email": sessionStorage.email,
                        "firstname":  sessionStorage.firstname,
                        "language": "fr",
                        "lastname": sessionStorage.lastname,
                        "login": "",

                        "password_hash": "",
                        "reference": ref_booking_id
                    },
                    "ems_url": "",
                    "flow": "API",
                    "interactive": "0",
                    "payment": {
                        "amount": sessionStorage.totalsomme,
                        "currency": "EUR",
                        //"preauth": "false",
                        "reference": ref_booking_id
                    },
                    "payment_method": {
                        "cardholder": sessionStorage.cardHolderName,
                        "cvc": sessionStorage.cvc, //123,
                        "exp_month": sessionStorage.expMonth,
                        "exp_year": sessionStorage.expYear,
                        "number": sessionStorage.cardNumber, //"4621457940597001",
                        "type": "CREDITCARD"
                    },  
                    "return_url": ""
                    }),        
                    success: function(data) { 
                        var response = JSON.stringify(data);
                        var success = response.includes("SUCCESS");   

                        if(success === true){                               
                            var pos = response.search("payment");
                            var cut_resp = response.substr(pos,response.length);
                            //console.log("response payment= "+ cut_resp);
                            var reponseArray  = cut_resp.split(',');
                            var i = 0 ;
                            reponseArray.forEach(function(element) {
                                var reg = /\bid\b/i;
                                if(reg.test(element)){
                                    var el =  element.split(':');
                                        if(i===0){
                                            //console.log("payment_id = "+el[1]);
                                            sessionStorage.payment_id = el[1];
                                        }else{
                                            //console.log("token_id = "+el[1]);
                                            sessionStorage.token_id = el[1];
                                        }  
                                    i++;                           
                                }
                            });                                
                            showNotif("Payment successfull.", "success");  

                        }else{
                            showNotif("Payment unsuccessfull.", "danger"); 
                        }                             
                    },
                        error: function (j, s) {           
                            //showNotif("[" + j.responseJSON.status.code + "] " + j.responseJSON.status.title + ":" + j.responseJSON.status.message, "danger");
                            showNotif("WS Syspay Payment doesn't work.", "danger");  
                            console.log("j :" ,  j);
                            console.log("s :" ,  s);
                    }
            }); */       
    });
    
    

    //Confim Billing        
    $("#billingTab").hide();
    $("#confirmTab").show();
    $("#namelabel2").html(($("#lastnameid").val() + " " + $("#firstnameid").val()));
    $("#namelabel3").html(($("#lastnameid").val() + " " + $("#firstnameid").val()));
    $("#emaillabel").html($("#emailid").val());
    $("#phonelabel").html($("#phoneId").val());
    $("#adresslabel").html($("#adressId").val() + " " + $("#cityId").val() + " " + $("#countryId").val());
    $("#genderchoice").html($('input[name="radioSex"]:checked').val());
    if ($("#remarksId").val().length < 1)
        $("#remarkslabel").html("No remarks");
    else
        $("#remarkslabel").html($("#remarksId").val());
    
    
    $("#billingCardNameLabel").html($("#idCardHolderName").val());
    $("#billingCardNumnerLabel").html($("#idCardNumber").val());
    $("#billingCvcLabel").html($("#idCvc").val());
    $("#billingDateExpiryLabel").html($("#formBillingSetup input[name= 'payload[ExpiryDate]']").val());
    $("#billingOptionLabel").html("Auto-Pay with this Credit Card"); //TODO dynamique
    
    $("#confirmlink").addClass('active');
    $("#billingsetup").removeClass('active');
    sessionStorage.adresse = $('#adresslabel').val();
});
$('#backconfirmaccount').click(function () {
    $("#confirmTab").hide();
    $("#billingTab").show();
    $("#billingsetup").addClass('active');
    $("#confirmlink").removeClass('active');
});

$('#submitbutton').click(function () {
    var name = $("#lastnameid").val() + " " + $("#firstnameid").val();
    var email = $("#emailid").val();
    var adress = $("#adressId").val() + " " + $("#cityId").val() + " " + $("#countryId").val();
    var facturenumero = "0010" + Math.floor((Math.random() * 100) + 1);
    var currentDate = new Date();
    var day = currentDate.getDate();
    var monthNames = ["January", "February", "March", "April", "May", "June",
        "July", "August", "September", "October", "November", "December"
    ];
    var month = currentDate.getMonth();
    var year = currentDate.getFullYear();
    var datefacture = monthNames[month] + " " + day + ", " + year;
   
    console.log(sessionStorage.listdescr);
    console.log(sessionStorage.listmontant);

    $.post("/booking/facturation", {
        namecustomer: name,
        emailcustomer: email,
        adresscustomer: adress,
        facturenumber: facturenumero,
        datefacture: datefacture,
        datearrive : sessionStorage.datearrive,
        datedepart : sessionStorage.datedepart,
        description:  sessionStorage.listdescr,
        montant : sessionStorage.listmontant,
        itemstore : sessionStorage.itemstorage,
        sommetotal : sessionStorage.totalsomme
  
    }, function (responseText) {        
        //TODO Module = 2
        sendMail(sessionStorage.idUser, responseText,"2");
        sessionStorage.numresa = facturenumero;
        sessionStorage.dateNote = datefacture;
        addResa();
    });

});

//get array description
function getlistdescr(){
     var listdescript = [];
     for(var i=0;i<sessionStorage.itemstorage;i++)
     {
         listdescript[i] = document.getElementsByClassName("takendescript")[i].innerHTML;
     }
      return listdescript ;
}
//get array montant
function getlistmontant(){
     var listdescript = [];
     for(var i=0;i<sessionStorage.itemstorage;i++)
     {
         listdescript[i] = document.getElementsByClassName("montanttocalcul")[i].innerHTML;
     }
      return listdescript;
}
//get array tarif
function getlistTarif(){
     var listTarif = [];
     for(var i=0;i<sessionStorage.itemstorage;i++)
     {
         listTarif[i] = document.getElementsByClassName("tarifId")[i].innerHTML;
     }
      return listTarif;
}
//get array type chambre
function getlistTypeChambre(){
     var listTypeChambre = [];
     for(var i=0;i<sessionStorage.itemstorage;i++)
     {
         listTypeChambre[i] = document.getElementsByClassName("typeChambreId")[i].innerHTML;
     }
      return listTypeChambre;
}

function SysPayPayment(){
    
}