/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package cloud.multimicro.booking.util;

/**
 *
 * @author Tsiory
 */
public class Constant {
    public static final String WS_CREATE_BOOKING = "/reservation/";
    public static final String WS_CREATE_BOOKING_NOTIF = "/reservation/notif";
    public static final String WS_CREATE_BOOKING_VENTILATION = "/reservation/ventilation";
    public static final String WS_CREATE_BOOKING_RATE = "/reservation/rate";
    public static final String WS_CREATE_BOOKING_DEPOSIT = "/deposit/booking";
    public static final String WS_SEARCH_AVAILABILITY = "/booking/room-available-by-type";
    public static final String WS_GET_CODEPROMO_VALIDITY = "/booking/codepromo/isvalid";
    public static final String WS_GET_CODEPROMO_BY_CODE = "/booking/codepromo/bycode";
    public static final String WS_GET_NAME_SITE = "/sites/";
    public static final String WS_GET_BACKGROUND_IMAGE = "/settings/NAME_BACKGROUND_IMAGE";
    public static final String WS_GET_SETTINGS_BOOKING_HEADER = "/settings/BOOKING_MAIL_HEADER";
    public static final String WS_GET_SETTINGS_BOOKING_DETAIL = "/settings/BOOKING_MAIL_DETAIL";
    public static final String WS_GET_SETTINGS_BOOKING_FOOTER = "/settings/BOOKING_MAIL_FOOTER";
    public static final String WS_GET_SETTINGS_STRIPE_PRIVATE_KEY = "/settings/STRIPE_PRIVATE_KEY";
    public static final String WS_GET_SETTINGS_STRIPE_PUBLIC_KEY = "/settings/STRIPE_PUBLIC_KEY";
    public static final String WS_GET_SETTINGS_DEVISE_PPAL_SYMBOLE = "/Devise/principal/symbole";

    public static final String MMC_JWT_ID = "cloud.multimicro";
    public static final String MMC_JWT_ISSUER = "MMC";
    public static final String MMC_JWT_SUBJECT = "MMC Token for backend";
    public static final long MMC_JWT_TTL = 86400000; // in Milliseconds
}
