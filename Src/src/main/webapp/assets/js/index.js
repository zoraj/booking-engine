var i = 0;

function deleteRoom(i) {
    $('#room' + i).hide();

}

jQuery(document).ready(function () {
    $("#add-room").click(function () {
        $('#other-room-add').append($("<div class='row' id='room" + i + "'>"
                + "<div class='col-md-3'>"
                + "<div class='form-group'><span class='form-label'></span>"
                + "<select class='form-control' id='qtyRoom" + i + "'><option>1</option><option>2</option><option>3</option></select>"
                + "<span class='select-arrow'></span></div></div>"
                + "<div class='col-md-4'>"
                + "<div class='form-group'><span class='form-label'></span>"
                + "<select class='form-control' id='nbPax" + i + "'><option>1 Person</option><option>2 People</option><option>3 People</option></select>"
                + "<span class='select-arrow'></span></div></div>"
                + "<div class='col-md-3'>"
                + "<div class='form-group'><span class='form-label'></span>"
                + "<select class='form-control' id='nbEnfant" + i + "'><option>1</option><option>2</option><option>3</option></select>"
                + "<span class='select-arrow'></span></div></div>"
                + "<div class='col-md-2'>"
                + "<div class='form-group'><button class='submit-btn' id='del-chambre'><a href='#' onclick='deleteRoom(" + i + ");'>(-)</a></button></div></div>"
                + "</div>"));

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

    $("#bookNow").click(function () {
        var roomAvailable = {
            "dateArrivee": $("#dateArrivee").val(),
            "dateDepart": $("#dateDepart").val(),
            "name": $("#name").val(),
            "email": $("#email").val(),
            "roomList": []
        };

        var count = 0;

        if ($("#room").is(":hidden") == false) {
            roomAvailable.roomList.push({
                "qtyRoom": $("#qtyRoom").val(),
                "nbPax": parseInt($("#nbPax").val()),
                "nbEnfant": $("#nbEnfant").val()
            });
        }

        while (count < i) {
            if ($("#room" + count).is(":hidden") == false) {
                roomAvailable.roomList.push({
                    "qtyRoom": $("#qtyRoom" + count).val(),
                    "nbPax": parseInt($("#nbPax" + count).val()),
                    "nbEnfant": $("#nbEnfant" + count).val()
                });
            }
            count++;
        }

        var roomList_json = JSON.stringify(roomAvailable);
        sessionStorage.setItem("roomList_json", roomList_json);
        var listRoom = sessionStorage.getItem("roomList_json");
        var listRoomObject = JSON.parse(listRoom);
        console.log(roomList_json);
    });
});



