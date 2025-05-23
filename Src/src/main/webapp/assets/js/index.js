var i = 0;
var isStartGreatThanEnd = false;

function verifyDateCheckOut() {
    var debut = document.getElementById("dateArrivee");
    var fin = document.getElementById("dateDepart");

    if (new Date(debut.value) >= new Date(fin.value)) {
        //  fin.value = null;
        isStartGreatThanEnd = true;

    } else {
        isStartGreatThanEnd = false;
    }
}

function addValueInSessionStorage() {
    sessionStorage.setItem("erreur", document.getElementById('erreur').innerHTML);
    sessionStorage.setItem("erreurTarif", document.getElementById('erreurTarif').innerHTML);
    sessionStorage.setItem("mainPage", document.getElementById('mainPage').innerHTML);
    sessionStorage.setItem("lang", document.getElementById('lang').innerHTML);
    sessionStorage.setItem("publicApiKeyStripe", document.getElementById("publicApiKeyStripe").innerHTML);
    var roomAvailable = {
        "dateArrivee": $("#dateArrivee").val(),
        "dateDepart": $("#dateDepart").val(),
        "roomList": []
    };

    var count = 0;

    if ($("#room").is(":hidden") == false) {
        roomAvailable.roomList.push({
            "qteChb": parseInt($("#qtyRoom").val()),
            "nbAdulte": parseInt($("#nbPax").val()),
            "nbEnfant": parseInt($("#nbEnfant").val())
        });
    }

    while (count < i) {
        if ($("#room" + count).is(":hidden") == false) {
            roomAvailable.roomList.push({
                "qteChb": parseInt($("#qtyRoom" + count).val()),
                "nbAdulte": parseInt($("#nbPax" + count).val()),
                "nbEnfant": parseInt($("#nbEnfant" + count).val())
            });
        }
        count++;
    }
    console.log("room-requested : " + JSON.stringify(roomAvailable));
    $("#room-requested").val(JSON.stringify(roomAvailable));
    var roomList_json = JSON.stringify(roomAvailable);
    sessionStorage.setItem("roomList_json", roomList_json);
    var listRoom = sessionStorage.getItem("roomList_json");
    var listRoomObject = JSON.parse(listRoom);
    var informationPerson = {
        "name": $("#name").val(),
        "phone": $("#phone").val(),
        "email": $("#email").val()
    };

    var informationPerson_json = JSON.stringify(informationPerson);
    sessionStorage.setItem("informationPerson_json", informationPerson_json);
}

function deleteRoom(i) {
    $('#room' + i).hide();
}

jQuery(document).ready(function () {

    document.getElementById('dateArrivee').min = new Date().toISOString().substr(0, 10);
    document.getElementById('dateDepart').min = new Date(new Date().getTime() + 24 * 60 * 60 * 1000 - new Date().getTimezoneOffset() * 60 * 1000).toISOString().substr(0, 10);
    
    $("#dateDepart").change(function () {
        verifyDateCheckOut();
    });

    $("#dateArrivee").change(function () {
        verifyDateCheckOut();
    });

    // $("body").css("background-image", "url('../../../../room-type-image/image1002.jpg')");

    sessionStorage.setItem("disponibilite_json", $('#disponibilite-id').html());
    
    $("#add-chambre").click(function () {
        $('#other-room-add').append($("<div class='row' id='room" + i + "'>" +
                "<div class='col-md-3'>" +
                "<div class='form-group'><span class='form-label'></span>" +
                "<select class='form-control' id='qtyRoom" + i + "'><option>1</option><option>2</option><option>3</option></select>" +
                "<span class='select-arrow'></span></div></div>" +
                "<div class='col-md-4'>" +
                "<div class='form-group'><span class='form-label'></span>" +
                "<select class='form-control' id='nbPax" + i + "'><option>1 "+$("#personne_txt").html()+"</option><option>2 "+$("#personne_txt").html()+"</option><option>3 "+$("#personne_txt").html()+"</option><option>4 "+$("#personne_txt").html()+"</option></select>" +
                "<span class='select-arrow'></span></div></div>" +
                "<div class='col-md-3'>" +
                "<div class='form-group'><span class='form-label'></span>" +
                "<select class='form-control' id='nbEnfant" + i + "'><option>0</option><option>1</option><option>2</option><option>3</option></select>" +
                "<span class='select-arrow'></span></div></div>" +
                "<div class='col-md-2'>" +
                "<div id='del-chambre' onclick='deleteRoom(" + i + ");'><span style=\"cursor: default;\">(-)</span></div></div>" +
                "</div>"));

        i++;
    });

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

    $("#submit-book").click(function () {
        if (isStartGreatThanEnd == true) {
            $("#dateDepart").get(0).setCustomValidity("Departure date must be greater than arrival date!");
        } else {
            $("#dateDepart").get(0).setCustomValidity("");
            sessionStorage.clear();
            addValueInSessionStorage();
        }
    });

    $("[name='bookNow']").click(function () {
        let establishmentName = document.getElementById("establishmentName").innerHTML;
        localStorage.setItem("nameEstablishment", JSON.stringify(establishmentName));
    });

});