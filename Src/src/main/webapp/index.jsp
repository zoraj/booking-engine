<div id="booking" class="section">
    <div class="section-center">
        <div class="container">
            <div class="row">
                <div class="col-md-5">
                    <div class="booking-cta">
                        <h1>Make your reservation</h1>
                        <p></p>
                    </div>
                </div>
                <div class="col-md-6 col-md-offset-1">
                    <div class="booking-form">
<!--                        <form>								-->
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input class="form-control" id="dateArrivee" type="date" required>
                                        <span class="form-label">Check In</span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input class="form-control" type="date" id="dateDepart" required>
                                        <span class="form-label">Check Out</span>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <input class="form-control" type="text" name="name" id="name" required>
                                        <span class="form-label">Name</span>
                                    </div>
                                </div>									
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input class="form-control" type="tel" name="phone" id="phone" required>
                                        <span class="form-label">Phone</span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input class="form-control" type="email" name="email" id="email" required>
                                        <span class="form-label">Email</span>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3 col-sm-3">
                                    <div class="form-group">
                                        <span class="form-label">Rooms</span>
                                        <select class="form-control" id="qtyRoom">
                                            <option>1</option>
                                            <option>2</option>
                                            <option>3</option>
                                        </select>
                                        <span class="select-arrow"></span>
                                    </div>
                                </div>
                                <div class="col-md-4 col-sm-4">
                                    <div class="form-group">
                                        <span class="form-label">Guests</span>
                                        <select class="form-control" id="nbPax">
                                            <option>1 Person</option>
                                            <option>2 People</option>
                                            <option>3 People</option>
                                        </select>
                                        <span class="select-arrow"></span>
                                    </div>
                                </div>
                                <div class="col-md-3 col-sm-3">
                                    <div class="form-group">
                                        <span class="form-label">Childs</span>
                                        <select class="form-control" id="nbEnfant">
                                            <option>1</option>
                                            <option>2</option>
                                            <option>3</option>
                                        </select>
                                        <span class="select-arrow"></span>
                                    </div>
                                </div>
                                <div class="col-md-1" id="add-room">
                                    <div class="form-btn">
                                        <button class="submit-btn" id="add-chambre"><a href="#">(+)</a></button>
                                    </div>
                                </div>									
                            </div>
                            <div id="other-room-add"></div>
                            <div class="form-btn">
                                <button class="submit-btn" id="submit-book"><a href="#" id="bookNow">Book Now</a></button>
                            </div>
<!--                        </form>-->
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="./assets/js/jquery.min.js"></script>