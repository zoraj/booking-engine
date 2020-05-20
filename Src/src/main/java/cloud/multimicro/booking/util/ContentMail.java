package cloud.multimicro.booking.util;
/**
 * Mail
 */
public class ContentMail {
    public static final String SENDER = "mmc@multimicro.cloud";
    public static final String SENDER_NAME = "MultiMicro Cloud";
    public static final String MMC_MAIL_SUBJECT = "Your booking is confirmed.";
    public static final String MMC_MAIL_DETAIL = "Hi! {booking-name}\r\n\r\n"
                                                 + "Thank you for choosing us. We look forward to hosting your stay. \r\n"
                                                 + "Here are your booking details: \r\n\r\n"
                                                 + "Room Type: {booking-recapchambre}\r\n"
                                                 + "Arrival date:{booking-dateArrivee} \r\n"
                                                 + "Departure date:{booking-dateDepart} \r\n"
                                                 + "number of pax:{booking-adultsid} \r\n"
                                                 + "Total amount:{booking-amount} \r\n\r\n"                                                 
                                                 + "We look forward to welcoming you soon! \r\n\r\n";
                                                
    
}