package cloud.multimicro.booking.util;

/**
 * Mail
 */
public class ContentMail {

    public static final String SENDER = "mmc@multimicro.cloud";
    public static final String SENDER_NAME = "MultiMicro Cloud";
    public static final String MMC_MAIL_SUBJECT = "Your booking is confirmed.";
    public static final String MMC_MAIL_DETAIL = "<h1 style=\"background: none repeat scroll 0 0 #10253f; color: white;"
            + " font-family: Georgia,sans-serif; margin: 0; padding: 10px 5px 5px; width: 100%\">"
            + " Channel: Hotel website</h1>\n"          
            + "<h3 style=\"width: 100%; font-family: Georgia, sans-serif; margin-bottom: 4px; "
            + "color: #10253f; background: #f0f0f0; padding: 5px\">{booking-bookingHeader} </h3>"
            + "Hi!{booking-name} <br>Thank you for choosing us. We look forward to hosting your stay. <h3 style=\"width: 100%; font-family: Georgia, sans-serif; "
            + "margin-bottom: 4px; color: #10253f; background: #f0f0f0; padding: 5px\"> <span >{booking-bookingDetail}</span></h3><br>"
            + "Here are your booking details: <br><br>"
            + "Room Type: {booking-recapchambre}<br>"
            + "Arrival date:{booking-dateArrivee} <br>"
            + "Departure date:{booking-dateDepart} <br>"
            + "number of pax:{booking-adultsid} <br><br>"
            + "Total amount:{booking-amount} <br><hr>"
            + "<div > {booking-bookingFooter} </div>";

}
