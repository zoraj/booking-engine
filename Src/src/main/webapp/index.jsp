<%@ page pageEncoding="UTF-8" %>
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
                        <form id="criteriaForm" method="post" action="home">
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
                                        <option>1 People</option>
                                        <option>2 People</option>
                                        <option>3 People</option>
                                        <option>4 People</option>
                                    </select>
                                    <span class="select-arrow"></span>
                                </div>
                            </div>
                            <div class="col-md-3 col-sm-3">
                                <div class="form-group">
                                    <span class="form-label">Childs</span>
                                    <select class="form-control" id="nbEnfant">
                                        <option>0</option>
                                        <option>1</option>
                                        <option>2</option>
                                        <option>3</option>
                                    </select>
                                    <span class="select-arrow"></span>
                                </div>
                            </div>
                            <div class="col-md-1">
                                <div class="form-btn" id="add-room">
                                    <button class="submit-btn" id="add-chambre"><a href="#">(+)</a></button>
                                </div>
                            </div>									
                        </div>
                        <div id="other-room-add"></div>
                            <input type="hidden" id="room-requested" name="room-requested">
                            <div class="form-btn" id="submit-book">
                                <button class="submit-btn">Book Now</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
