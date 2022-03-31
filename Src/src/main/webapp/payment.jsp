<%@ page pageEncoding="UTF-8" %>
<link type="text/css" rel="stylesheet" href="./assets/css/paiement.css" />	
<%
    String backgroundImage = (String) request.getAttribute("backgroundImage");
%>
<body onload="afficherAnnee();" style = "background-image: url('../room-type-image/<%out.print(backgroundImage);%>');">
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
                                        <h5 style="font-weight:bolder; font-size: 18px; color: #06a8c4;"><fmt:message key="BOOKING.PERSONAL.INFORMATIONS.MIN_TITLE"/></h5>
                                    </div>
                                    <div class="col-md-2">
                                        <i class="obligatoir">*</i><span style="color: red;"> <fmt:message key="BOOKING.REQUIRED.FIELDS"/></span>
                                        <span id="reservTaken" style="display:none;"><fmt:message key="BOOKING.RESERVATION.TAKEN.INTO.ACCOUNT"/></span>
                                        <span id="summaryEmail" style="display:none;"><fmt:message key="BOOKING.SUMMARY.EMAIL"/></span>                                   

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
                                                    <span class="form-label"><fmt:message key="BOOKING.CIVILITY"/><i class="obligatoir">*</i></span>
                                                    <select name="civilite" id="civilite" class="form-control">
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
                                                    <span class="form-label"><fmt:message key="BOOKING.LASTNAME.TITLE"/><i class="obligatoir">*</i></span>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <input name="prenom" maxlength="99" id="prenom" class="form-control" type="text"  autocomplete="off">
                                                    <span class="form-label"><fmt:message key="BOOKING.FIRSTNAME.TITLE"/></span>
                                                </div>
                                            </div>
                                        </div><br>
                                        <div class="row">
                                            <div class="col-md-5">
                                                <div class="form-group">
                                                    <input name="adresse1" maxlength="45" id="adresse" class="form-control" type="text" autocomplete="off">
                                                    <span class="form-label"><fmt:message key="BOOKING.ADDRESS"/></span>
                                                </div>
                                            </div>
                                            <div class="col-md-5">
                                                <div class="form-group">
                                                    <input name="adresse2" maxlength="45" id="adresseComp" class="form-control" type="text" autocomplete="off">
                                                    <span class="form-label"><fmt:message key="BOOKING.COMPLEMENT.MIN_TITLE"/></span>
                                                </div>
                                            </div>
                                        </div><br>
                                        <div class="row">
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <input name="cp" pattern="[0-9]+" maxlength="44" id="codePostal" class="form-control" type="text" autocomplete="off">
                                                    <span class="form-label"><fmt:message key="BOOKING.POSTAL.CODE"/></span>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <input name="ville" maxlength="44" id="ville" class="form-control" type="text" autocomplete="off">
                                                    <span class="form-label"><fmt:message key="BOOKING.CITY"/></span>
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <span class="form-label"><fmt:message key="BOOKING.COUNTRY"/><i class="obligatoir">*</i></span>
                                                    <select name="pays" id="pays" class="form-control">
                                                        <option value='af'>Afghanistan</option>
                                                        <option value='al'>Albania</option>
                                                        <option value='dz'>Algeria</option>
                                                        <option value='as'>American Samoa</option>
                                                        <option value='ad'>Andorra</option>
                                                        <option value='ao'>Angola</option>
                                                        <option value='ai'>Anguilla</option>
                                                        <option value='aq'>Antarctica</option>
                                                        <option value='ag'>Antigua And Barbuda</option>
                                                        <option value='ar'>Argentina</option>
                                                        <option value='am'>Armenia</option>
                                                        <option value='aw'>Aruba</option>
                                                        <option value='au'>Australia</option>
                                                        <option value='at'>Austria</option>
                                                        <option value='az'>Azerbaijan</option>
                                                        <option value='bs'>Bahamas</option>
                                                        <option value='bh'>Bahrain</option>
                                                        <option value='bd'>Bangladesh</option>
                                                        <option value='bb'>Barbados</option>
                                                        <option value='by'>Belarus</option>
                                                        <option value='be'>Belgium</option>
                                                        <option value='bz'>Belize</option>
                                                        <option value='bj'>Benin</option>
                                                        <option value='bm'>Bermuda</option>
                                                        <option value='bt'>Bhutan</option>
                                                        <option value='bo'>Bolivia</option>
                                                        <option value='ba'>Bosnia And Herzegovina</option>
                                                        <option value='bw'>Botswana</option>
                                                        <option value='bv'>Bouvet Island</option>
                                                        <option value='br'>Brazil</option>
                                                        <option value='io'>British Indian Ocean continent</option>
                                                        <option value='bn'>Brunei Darussalam</option>
                                                        <option value='bg'>Bulgaria</option>
                                                        <option value='bf'>Burkina Faso</option>
                                                        <option value='bi'>Burundi</option>
                                                        <option value='kh'>Cambodia</option>
                                                        <option value='cm'>Cameroon</option>
                                                        <option value='ca'>Canada</option>
                                                        <option value='cv'>Cape Verde</option>
                                                        <option value='ky'>Cayman Islands</option>
                                                        <option value='cf'>Central African Republic</option>
                                                        <option value='td'>Chad</option>
                                                        <option value='cl'>Chile</option>
                                                        <option value='cn'>China</option>
                                                        <option value='cx'>Christmas Island</option>
                                                        <option value='cc'>Cocos (Keeling) Islands</option>
                                                        <option value='co'>Colombia</option>
                                                        <option value='km'>Comoros</option>
                                                        <option value='cg'>Congo</option>
                                                        <option value='ck'>Cook Islands</option>
                                                        <option value='cr'>Costa Rica</option>
                                                        <option value='ci'>Cote D'Ivoire</option>
                                                        <option value='hr'>Croatia</option>
                                                        <option value='cu'>Cuba</option>
                                                        <option value='cy'>Cyprus</option>
                                                        <option value='cz'>Czech Republic</option>
                                                        <option value='dk'>Denmark</option>
                                                        <option value='dj'>Djibouti</option>
                                                        <option value='dm'>Dominica</option>
                                                        <option value='do'>Dominican Republic</option>
                                                        <option value='ec'>Ecuador</option>
                                                        <option value='eg'>Egypt</option>
                                                        <option value='sv'>El Salvador</option>
                                                        <option value='gq'>Equatorial Guinea</option>
                                                        <option value='er'>Eritrea</option>
                                                        <option value='ee'>Estonia</option>
                                                        <option value='et'>Ethiopia</option>
                                                        <option value='fk'>Falkland Islands (Malvinas)</option>
                                                        <option value='fo'>Faroe Islands</option>
                                                        <option value='fj'>Fiji</option>
                                                        <option value='fi'>Finland</option>
                                                        <option selected="selected" value='fr'>France</option>
                                                        <option value='fx'>France, Metropolitan</option>
                                                        <option value='gf'>French Guiana</option>
                                                        <option value='pf'>French Polynesia</option>
                                                        <option value='tf'>French Southern Territories</option>
                                                        <option value='ga'>Gabon</option>
                                                        <option value='gm'>Gambia</option>
                                                        <option value='ge'>Georgia</option>
                                                        <option value='de'>Germany</option>
                                                        <option value='gh'>Ghana</option>
                                                        <option value='gi'>Gibraltar</option>
                                                        <option value='gr'>Greece</option>
                                                        <option value='gl'>Greenland</option>
                                                        <option value='gd'>Grenada</option>
                                                        <option value='gp'>Guadeloupe</option>
                                                        <option value='gu'>Guam</option>
                                                        <option value='gt'>Guatemala</option>
                                                        <option value='gn'>Guinea</option>
                                                        <option value='gw'>Guinea-Bissau</option>
                                                        <option value='gy'>Guyana</option>
                                                        <option value='ht'>Haiti</option>
                                                        <option value='hm'>Heard Island and Mcdonald Islands</option>
                                                        <option value='hn'>Honduras</option>
                                                        <option value='hk'>Hong Kong</option>
                                                        <option value='hu'>Hungary</option>
                                                        <option value='is'>Iceland</option>
                                                        <option value='in'>India</option>
                                                        <option value='id'>Indonesia</option>
                                                        <option value='ir'>Iran, Islamic Republic Of</option>
                                                        <option value='iq'>Iraq</option>
                                                        <option value='ie'>Ireland</option>
                                                        <option value='il'>Israel</option>
                                                        <option value='it'>Italy</option>
                                                        <option value='jm'>Jamaica</option>
                                                        <option value='jp'>Japan</option>
                                                        <option value='jo'>Jordan</option>
                                                        <option value='kz'>Kazakhstan</option>
                                                        <option value='ke'>Kenya</option>
                                                        <option value='ki'>Kiribati</option>
                                                        <option value='kp'>Korea, Democratic People'S Republic Of</option>
                                                        <option value='kr'>Korea, Republic Of</option>
                                                        <option value='kw'>Kuwait</option>
                                                        <option value='kg'>Kyrgyzstan</option>
                                                        <option value='la'>Lao People's Democratic Republic</option>
                                                        <option value='lv'>Latvia</option>
                                                        <option value='lb'>Lebanon</option>
                                                        <option value='ls'>Lesotho</option>
                                                        <option value='lr'>Liberia</option>
                                                        <option value='ly'>Libyan Arab Jamahiriya</option>
                                                        <option value='li'>Liechtenstein</option>
                                                        <option value='lt'>Lithuania</option>
                                                        <option value='lu'>Luxembourg</option>
                                                        <option value='mo'>Macau</option>
                                                        <option value='mk'>Macedonia, The Former Yugoslav Republic Of</option>
                                                        <option value='mg'>Madagascar</option>
                                                        <option value='mw'>Malawi</option>
                                                        <option value='my'>Malaysia</option>
                                                        <option value='mv'>Maldives</option>
                                                        <option value='ml'>Mali</option>
                                                        <option value='mt'>Malta</option>
                                                        <option value='mh'>Marshall Islands</option>
                                                        <option value='mq'>Martinique</option>
                                                        <option value='mr'>Mauritania</option>
                                                        <option value='mu'>Mauritius</option>
                                                        <option value='yt'>Mayotte</option>
                                                        <option value='mx'>Mexico</option>
                                                        <option value='fm'>Micronesia, Federated States Of</option>
                                                        <option value='md'>Moldova, Republic Of</option>
                                                        <option value='mc'>Monaco</option>
                                                        <option value='mn'>Mongolia</option>
                                                        <option value='ms'>Montserrat</option>
                                                        <option value='ma'>Morocco</option>
                                                        <option value='mz'>Mozambique</option>
                                                        <option value='mm'>Myanmar</option>
                                                        <option value='na'>Namibia</option>
                                                        <option value='nr'>Nauru</option>
                                                        <option value='np'>Nepal</option>
                                                        <option value='nl'>Netherlands</option>
                                                        <option value='an'>Netherlands Antilles</option>
                                                        <option value='nc'>New Caledonia</option>
                                                        <option value='nz'>New Zealand</option>
                                                        <option value='ni'>Nicaragua</option>
                                                        <option value='ne'>Niger</option>
                                                        <option value='ng'>Nigeria</option>
                                                        <option value='nu'>Niue</option>
                                                        <option value='nf'>Norfolk Island</option>
                                                        <option value='mp'>Northern Mariana Islands</option>
                                                        <option value='no'>Norway</option>
                                                        <option value='om'>Oman</option>
                                                        <option value='pk'>Pakistan</option>
                                                        <option value='pw'>Palau</option>
                                                        <option value='pa'>Panama</option>
                                                        <option value='pg'>Papua New Guinea</option>
                                                        <option value='py'>Paraguay</option>
                                                        <option value='pe'>Peru</option>
                                                        <option value='ph'>Philippines</option>
                                                        <option value='pn'>Pitcairn</option>
                                                        <option value='pl'>Poland</option>
                                                        <option value='pt'>Portugal</option>
                                                        <option value='pr'>Puerto Rico</option>
                                                        <option value='qa'>Qatar</option>
                                                        <option value='re'>Reunion</option>
                                                        <option value='ro'>Romania</option>
                                                        <option value='ru'>Russian Federation</option>
                                                        <option value='rw'>Rwanda</option>
                                                        <option value='sh'>Saint Helena</option>
                                                        <option value='kn'>Saint Kitts And Nevis</option>
                                                        <option value='lc'>Saint Lucia</option>
                                                        <option value='pm'>Saint Pierre And Miquelon</option>
                                                        <option value='vc'>Saint Vincent And The Grenadines</option>
                                                        <option value='ws'>Samoa</option>
                                                        <option value='sm'>San Marino</option>
                                                        <option value='st'>Sao Tome And Principe</option>
                                                        <option value='sa'>Saudi Arabia</option>
                                                        <option value='sn'>Senegal</option>
                                                        <option value='sc'>Seychelles</option>
                                                        <option value='sl'>Sierra Leone</option>
                                                        <option value='sg'>Singapore</option>
                                                        <option value='sk'>Slovakia (Slovak Republic)</option>
                                                        <option value='si'>Slovenia</option>
                                                        <option value='sb'>Solomon Islands</option>
                                                        <option value='so'>Somalia</option>
                                                        <option value='za'>South Africa</option>
                                                        <option value='es'>Spain</option>
                                                        <option value='lk'>Sri Lanka</option>
                                                        <option value='sd'>Sudan</option>
                                                        <option value='sr'>Suriname</option>
                                                        <option value='sj'>Svalbard And Jan Mayen Islands</option>
                                                        <option value='sz'>Swaziland</option>
                                                        <option value='se'>Sweden</option>
                                                        <option value='ch'>Switzerland</option>
                                                        <option value='sy'>Syrian Arab Republic</option>
                                                        <option value='tw'>Taiwan, Province Of China</option>
                                                        <option value='tj'>Tajikistan</option>
                                                        <option value='tz'>Tanzania, United Republic Of</option>
                                                        <option value='th'>Thailand</option>
                                                        <option value='tg'>Togo</option>
                                                        <option value='tk'>Tokelau</option>
                                                        <option value='to'>Tonga</option>
                                                        <option value='tt'>Trinidad And Tobago</option>
                                                        <option value='tn'>Tunisia</option>
                                                        <option value='tr'>Turkey</option>
                                                        <option value='tm'>Turkmenistan</option>
                                                        <option value='tc'>Turks And Caicos Islands</option>
                                                        <option value='tv'>Tuvalu</option>
                                                        <option value='ug'>Uganda</option>
                                                        <option value='ua'>Ukraine</option>
                                                        <option value='ae'>United Arab Emirates</option>
                                                        <option value='gb'>United Kingdom</option>
                                                        <option value='us'>United States</option>
                                                        <option value='um'>United States Minor Outlying Islands</option>
                                                        <option value='uy'>Uruguay</option>
                                                        <option value='uz'>Uzbekistan</option>
                                                        <option value='vu'>Vanuatu</option>
                                                        <option value='va'>Vatican City State (Holy See)</option>
                                                        <option value='ve'>Venezuela</option>
                                                        <option value='vn'>Vietnam</option>
                                                        <option value='vg'>Virgin Islands (British)</option>
                                                        <option value='vi'>Virgin Islands (U.S.)</option>
                                                        <option value='wf'>Wallis And Futuna Islands</option>
                                                        <option value='eh'>Western Sahara</option>
                                                        <option value='ye'>Yemen</option>
                                                        <option value='yu'>Yugoslavia</option>
                                                        <option value='zr'>Zaire</option>
                                                        <option value='zm'>Zambia</option>
                                                        <option value='zw'>Zimbabwe</option>
                                                    </select>
                                                    <span class="select-arrow"></span>
                                                </div>
                                            </div>
                                        </div><br>
                                        <div class="row">
                                            <div class="col-md-5">
                                                <div class="form-group">
                                                    <input name="tel" maxlength="44" pattern="[0-9]+" id="telephone" class="form-control" type="tel"  autocomplete="off">
                                                    <span class="form-label"><fmt:message key="BOOKING.MOBILE.PHONE"/></span>
                                                </div>
                                            </div>
                                            <div class="col-md-5">
                                                <div class="form-group">
                                                    <input name="email" maxlength="44" id="email" class="form-control" type="email" required autocomplete="off">
                                                    <span class="form-label"><fmt:message key="BOOKING.MAIL.TITLE"/><i class="obligatoir">*</i></span>
                                                </div>
                                            </div>
                                            <div class="col-md-5">
                                                <div class="form-group">
                                                    <input name="observation" maxlength="44" id="observation" class="form-control" type="text" autocomplete="off">
                                                    <span class="form-label"><fmt:message key="BOOKING.OBSERVATION"/></span>
                                                </div>
                                            </div>
                                        </div><br>
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
                                <h5 style="font-weight:bolder; font-size: 18px; color: #06a8c4;"><fmt:message key="BOOKING.SECURE.PAYEMENT"/></h5><hr style="border-top: 1px dashed rgba(0, 0, 0, 0.2);">
                            </div>
                            <div class="col-md-5">
                                <div class="row">
                                    <div class="col-md-12">
                                        <strong><fmt:message key="BOOKING.BANK.DETAILS"/></strong>
                                    </div>
                                </div></br>
                                <div class="row">
                                    <div class="col-md-12">
                                        <span class="other_label"><fmt:message key="BOOKING.CARD.TYPE"/><i class="obligatoir">*</i></span>
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
                                                    <img src="./assets/img/masterCard.jpg" alt="" class="image-liste">
                                                </label>
                                            </div>
                                            <div class="col-md-1">
                                                <input class="form-check-input" type="radio" id="visaId">
                                            </div>
                                            <div class="col-md-3">
                                                <label class="form-check-label" for="">
                                                    <img src="./assets/img/visa.jpg" alt="" class="image-liste">
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </div></br>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <input class="form-control" id="carte-paiement-numero" pattern="[0-9]+" maxlength="15" name="carte-paiement-numero" type="text" required autocomplete="off">
                                            <span class="form-label"><fmt:message key="BOOKING.CARD.NUMBER"/><i class="obligatoir">*</i></span>
                                        </div>
                                    </div>
                                </div></br>
                                <div class="row">									
                                    <div class="col-md-6">
                                        <span class="other_label"><fmt:message key="BOOKING.EXPIRATION.DATE"/><i class="obligatoir">*</i></span>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <!--span class="form-label"></span-->
                                            <select id="mounthId" class="form-control" onchange="window.open('payment.jsp?mois=' + document.forms[0].mois.selectedValue, '_self');">
                                                <option value="01"><fmt:message key="BOOKING.JANUARY"/></option>
                                                <option value="02"><fmt:message key="BOOKING.FEBRUARY"/></option>
                                                <option value="03"><fmt:message key="BOOKING.MARCH"/></option>
                                                <option value="04"><fmt:message key="BOOKING.APRIL"/></option>
                                                <option value="05"><fmt:message key="BOOKING.MAY"/></option>
                                                <option value="06"><fmt:message key="BOOKING.JUNE"/></option>
                                                <option value="07"><fmt:message key="BOOKING.JULY"/></option>
                                                <option value="08"><fmt:message key="BOOKING.AUGUST"/></option>
                                                <option value="09"><fmt:message key="BOOKING.SEPTEMBER"/></option>
                                                <option value="10"><fmt:message key="BOOKING.OCTOBER"/></option>
                                                <option value="11"><fmt:message key="BOOKING.NOVEMBER"/></option>
                                                <option value="12"><fmt:message key="BOOKING.DECEMBER"/></option>
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
                                                <!--<option value="2020">2020</option>
                                                <option value="2021">2021</option>
                                                <option value="2022">2022</option>
                                                <option value="2023">2023</option>
                                                <option value="2024">2024</option>
                                                <option value="2025">2025</option>-->
                                            </select>
                                            <span class="select-arrow"></span>
                                        </div>
                                    </div>
                                </div></br>
                                <div class="row">
                                    <div class="col-md-7">
                                        <div class="form-group">
                                            <input class="form-control" maxlength="99" id="carte-paiement-titulaire" name="carte-paiement-titulaire" type="text" required autocomplete="off">
                                            <span class="form-label"><fmt:message key="BOOKING.CARDHOLDER.NAME"/><i class="obligatoir">*</i></span>
                                        </div>
                                    </div>
                                    <div class="col-md-5">
                                        <div class="form-group">
                                            <input class="form-control" id="carte-paiement-cvv" name="carte-paiement-cvv" type="text" maxlength="3" pattern="[0-9]{3}" required autocomplete="off">
                                            <span class="form-label"><fmt:message key="BOOKING.CRYPTOGRAM"/><i class="obligatoir">*</i></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-7">
                                <div class="row">
                                    <div class="col-md-10">
                                        <strong><fmt:message key="BOOKING.AMOUNT.DEPOSIT"/></strong>
                                    </div>
                                    <div class="col-md-2">
                                        <strong id="amountId"></strong>
                                    </div>
                                </div><hr>
                                <div class="row">
                                    <div class="col-md-12">
                                        <p><fmt:message key="BOOKING.DEPOSIT.APPLIES"/>
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
                                                        <label class="form-check-label"><fmt:message key="BOOKING.CHECKING.BOX"/> 
                                                            <a href="#"><fmt:message key="BOOKING.TERMS.OF.SALES"/></a> <fmt:message key="BOOKING.ACCEPT"/>.</label>
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
                                                        <label class="form-check-label"><fmt:message key="BOOKING.INFORM.EMAIL"/></label>
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
                                            <input type="hidden" id="ventillation" name="ventillation">
                                            <input type="hidden" id="informationRate" name="informationRate">
                                            <input type="hidden" id="recapitulationChambre" name="recapitulationChambre">


                                        </div>
                                        <div class="row">
                                            <div class="col-md-offset-4 col-md-8">
                                                <div class="form-btn">
                                                    <button class="submit-btn" id="validateId"><fmt:message key="BOOKING.VALIDATE"/></button>
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

                                                var informationNoteVentilation = sessionStorage.getItem("informationNoteVentilation_json");
                                                var informationNoteVentilationObject = JSON.parse(informationNoteVentilation);
                                                var informationVentilation = sessionStorage.getItem("ventillation_json");
                                                var informationRate = sessionStorage.getItem("reservationTarif_json");
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
                                                function getYear(number) {
                                                    let ladate = new Date();
                                                    return ladate.getFullYear() + number;

                                                }



                                                function afficherAnnee() {
                                                    $("#yearId").html(
                                                            '<option value="' + getYear(0) + '">' + getYear(0) + '</option>' +
                                                            '<option value="' + getYear(1) + '">' + getYear(1) + '</option>' +
                                                            '<option value="' + getYear(2) + '">' + getYear(2) + '</option>' +
                                                            '<option value="' + getYear(3) + '">' + getYear(3) + '</option>' +
                                                            '<option value="' + getYear(4) + '">' + getYear(4) + '</option>' +
                                                            '<option value="' + getYear(5) + '">' + getYear(5) + '</option>'
                                                            );
                                                }
                                                jQuery(document).ready(function () {
                                                    $("#carte-paiement-type").val(cartePaymentType);
                                                    var nbPax = 0;
                                                    var montantTTC = 0;
                                                    var recapitulationChambre = "";
                                                    var nbEnfant = 0;
                                                    var qteChb = 0;

                                                    recapObject.bookRoom.forEach(function (room) {
                                                        nbPax = parseInt(nbPax) + (parseInt(room.nbPax) * parseInt(room.qty));
                                                        montantTTC = parseFloat(montantTTC) + parseFloat(room.qty) * parseFloat(room.rate);
                                                        recapitulationChambre = recapitulationChambre + room.qty + " x " + room.roomType + ";";
                                                        qteChb = parseInt(qteChb) + parseInt(room.qty);
                                                        nbEnfant = parseInt(nbEnfant) + (parseInt(room.nbChild) * parseInt(room.qty));
                                                    });

                                                    // création de json reservation
                                                    var reservationJson = {
                                                        "dateArrivee": listRoomObject.dateArrivee,
                                                        "dateDepart": listRoomObject.dateDepart,
                                                        "nbPax": nbPax,
                                                        "nbChambre": qteChb,
                                                        "nbEnfant": nbEnfant,
                                                        "reservationType": "INDIV",
                                                        "posteUuid": "1000",
                                                        "origine": "BOOKING"
                                                    };

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
                                                            $("#carte-paiement-type").val(cartePaymentType);
                                                        }
                                                    });
                                                    //si on click sur VISA
                                                    $('#visaId').click(function () {
                                                        if ($('#visaId').is(':checked') === true) {
                                                            $("#masterCardId").prop('checked', false);
                                                            cartePaymentType = "VISA";
                                                            $("#carte-paiement-type").val(cartePaymentType);
                                                        }
                                                    });
                                                    // Validation de paiment
                                                    $('#validateId').click(function () {
                                                        var dateExpiration = new Date($("#yearId").val(), parseInt($("#mounthId").val()) - 1, 1);

                                                        if ((dateExpiration <= new Date())) {
                                                            $("#mounthId").get(0).setCustomValidity("Date anterieure à la date du jour");
                                                        } else {
                                                            $("#mounthId").get(0).setCustomValidity("");
                                                            $("#reservation").val(JSON.stringify(reservationJson));
                                                            $("#carte-paiement-expiration").val($("#yearId").val() + "-" + $("#mounthId").val() + "-" + "01");
                                                            $("#adults").val(nbPax);
                                                            $("#montant").val(montantTTC);
                                                            $("#carte-paiement-type").val(cartePaymentType);
                                                            $("#dateArrivee").val(changeFormat(dateArrivee));
                                                            $("#dateDepart").val(changeFormat(dateDepart));
                                                            $("#ventillation").val(informationVentilation);
                                                            $("#informationRate").val(informationRate);
                                                            $("#recapitulationChambre").val(recapitulationChambre);

                                                            function changeFormat(date) {
                                                                options = {
                                                                    weekday: "short", year: 'numeric', month: 'long', day: 'numeric'
                                                                };
                                                                return date.toLocaleString('fr-FR', options);
                                                            }
                                                        }
                                                    });

                                                });

                                                var t = new Date();
                                                document.getElementById("mounthId").selectedIndex = t.getMonth();
                                                sessionStorage.setItem("mainPage", document.getElementById('mainPage').innerHTML);
                                                sessionStorage.setItem("reservTaken", document.getElementById('reservTaken').innerHTML);
                                                sessionStorage.setItem("summaryEmail", document.getElementById('summaryEmail').innerHTML);
    </script>