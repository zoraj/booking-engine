<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/liste_type_chambre.css" />
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
                                    <div class="col-md-8">
                                        <div class="row"><div class="col-md-12"><span id="name-user"></span></div></div>
                                        <div class="row"><div class="col-md-12"><span>Rate: Regular Rate</span></div></div>
                                    </div>
                                    <div class="col-md-4" id="rate-id"><span>$0</span></div>
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
                                    <div class="col-md-8 font-title"><span>Dates</span></div>
                                    <div class="col-md-4 font-title"><span>Amount</span></div>
                                </div><hr>
                                <div class="row">
                                    <div class="col-md-8"><span id="date-arrived-id"></span></div>
                                    <div class="col-md-4"><span id="amount-id">$0</span></div>
                                </div><hr>
                                <div class="row">
                                    <div class="col-md-8 font-title"><span>Dates Subtotal</span></div>
                                    <div class="col-md-4 font-title"><span id="date-sub-total-id">$135</span></div>
                                </div><hr>
                                <div class="row">
                                    <div class="col-md-8 font-title"><span>Accommodation Subtotal</span></div>
                                    <div class="col-md-4 font-title"><span id="accommodation-id">$135</span></div>
                                </div><hr>
                                <div class="row">
                                    <div class="col-md-8 font-title"><span>Subtotal</span></div>
                                    <div class="col-md-4 font-title"><span id="sub-total-id">$135</span></div>
                                </div><hr>
                                <div class="row">
                                    <div class="col-md-8 font-title"><span>Total</span></div>
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
    var dateArrivee = new Date(listRoomObject.dateArrivee);
    var dateDepart = new Date(listRoomObject.dateDepart);

    // var days = dateDiff(dateArrivee, dateDepart);

    jQuery(document).ready(function () {
        var nbPax = 0;
        var childs = 0;
        listRoomObject.roomList.forEach(function (room) {
            childs = childs + parseInt(room.nbEnfant);
            nbPax = nbPax + parseInt(room.nbPax);
        });

        $("#name-user").html("#" + listRoomObject.name);
        $("#date-arrived-id").html(dateArrivee.toDateString("mm dd, yyyy"));

        $("#adults-id").html(nbPax);
        $("#children-id").html(childs);

        $("#rate-id").html(0);
        $("#night-id").html(1);
        $("#amount-id").html(0);
        $("#date-sub-total-id").html(0);
        $("#accommodation-id").html(0);
        $("#sub-total-id").html(0);
        $("#total-id").html(0);
    });

</script>