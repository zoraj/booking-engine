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
    public static final String WS_SEARCH_AVAILABILITY = "/booking/room-available-by-type";
    public static final String WS_GET_CODE_SITE = "/sites/?code=";
    public static final String WS_GET_BACKGROUND_IMAGE = "/settings/NAME_BACKGROUND_IMAGE";

    public static final String MMC_JWT_SECRET_KEY = "83fxrLVgeZt5jprz4KVvAhuQs2zCGP4R9gmv2MimAunrzWteUQdE9DULLGVhVZ3oxAbmnQWM84EdocoK7Vd72Nke7HGDrL";
    public static final String MMC_JWT_ID = "cloud.multimicro";
    public static final String MMC_JWT_ISSUER = "MMC";
    public static final String MMC_JWT_SUBJECT = "MMC Token for backend";
    public static final long MMC_JWT_TTL = 86400000; // in Milliseconds
}
