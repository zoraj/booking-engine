<%
    String backgroundImage = (String) request.getAttribute("backgroundImage");
%>

<%@ page pageEncoding="UTF-8" %>
<!--body style = "background-image: url('../room-type-image/<%out.print(backgroundImage);%>');"-->
<body style = "background-image: url('assets/img/background.jpg');">
    <label id="establishmentName"    name="establishmentName" hidden> 
        <%String attribut = (String) request.getAttribute("establishmentName");
            out.println(attribut);%> </label>
    <label id="publicApiKeyStripe"    name="publicApiKeyStripe" hidden> 
        <%String publicKey = (String) session.getAttribute("publicApiKeyStripe");
            out.println(publicKey);%> </label>
    <div id="booking" class="section">
        <div class="container">
            <div class="row">
                <div class="col-md-5" id="text-reservation">

                    <div class="booking-cta">
                        <h1><fmt:message key="BOOKING.MAKE.YOUR.RESEVATION"/></h1>                   
                    </div>
                </div>
                <div class="col-md-6 col-md-offset-1" id="form-reservation">
                    <div class="booking-form">
                        <form id="criteriaForm" method="post" action="home">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input class="form-control" id="dateArrivee" type="date" required>
                                        <span class="form-label"><fmt:message key="BOOKING.ARRIVAL.DATE.TITLE"/></span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input class="form-control" type="date" id="dateDepart" required  onblur="verifyDateCheckOut()">
                                        <span class="form-label"><fmt:message key="BOOKING.DEPARTURE.DATE.TITLE"/></span>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <input  class="form-control" type="text" name="name" id="name" required>
                                        <span class="form-label"><fmt:message key="BOOKING.LASTNAME.TITLE"/></span>
                                    </div>
                                </div>									
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input class="form-control" type="tel" name="phone" id="phone" required>
                                        <span class="form-label"><fmt:message key="BOOKING.PHONE.TITLE"/></span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input class="form-control" type="email" name="email" id="email" required>
                                        <span class="form-label"><fmt:message key="BOOKING.MAIL.TITLE"/></span>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3 col-sm-3">
                                    <div class="form-group">
                                        <span class="form-label"><fmt:message key="BOOKING.ROOMS.TITLE"/></span>
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
                                        <span class="form-label"><fmt:message key="BOOKING.GUESTS.TITLE"/></span>
                                        <select  class="form-control" id="nbPax">
                                            <option>1 <fmt:message key="BOOKING.PEOPLE.TITLE"/></option>
                                            <option>2 <fmt:message key="BOOKING.PEOPLE.TITLE"/></option>
                                            <option>3 <fmt:message key="BOOKING.PEOPLE.TITLE"/></option>
                                            <option>4 <fmt:message key="BOOKING.PEOPLE.TITLE"/></option>
                                        </select>
                                        <span class="select-arrow"></span>
                                    </div>
                                </div>
                                <div class="col-md-3 col-sm-3">
                                    <div class="form-group">
                                        <span class="form-label"><fmt:message key="BOOKING.CHILDS.TITLE"/></span>
                                        <select  class="form-control" id="nbEnfant">
                                            <option>0</option>
                                            <option>1</option>
                                            <option>2</option>
                                            <option>3</option>
                                        </select>
                                        <span class="select-arrow"></span>
                                    </div>
                                </div>
                                <div class="col-md-1">
                                    <div id="add-chambre"><span>(+)</span></div>
                                </div>									
                            </div>
                            <div id="other-room-add"></div>
                            <input type="hidden" id="room-requested" name="room-requested">
                            <div class="row">
                                <div class="col-md-12 col-sm-12">
                                    <div class="form-btn" id="submit-book">
                                        <button name="bookNow" class="submit-btn" ><fmt:message key="BOOKING.BOOK.NOW.TITLE"/></button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
