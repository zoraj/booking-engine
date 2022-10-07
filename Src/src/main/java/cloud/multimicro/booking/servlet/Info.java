/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cloud.multimicro.booking.servlet;

import cloud.multimicro.booking.util.Constant;
import cloud.multimicro.booking.util.ContentMail;
import cloud.multimicro.booking.util.Jwt;
import cloud.multimicro.booking.util.Util;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.client.Entity;
import javax.ws.rs.core.Response;
import org.jboss.logging.Logger;
import org.jboss.resteasy.client.jaxrs.ResteasyClient;
import org.jboss.resteasy.client.jaxrs.ResteasyClientBuilder;
import org.jboss.resteasy.client.jaxrs.ResteasyWebTarget;
import javax.annotation.Resource;
import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonReader;
import javax.mail.Address;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.naming.NamingException;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Tsiory-PC
 */
@WebServlet(name = "Info", urlPatterns = {"/info"})
public class Info extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(Info.class);
    private String apiKey = null;
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        getServletConfig().getServletContext().getRequestDispatcher("/info.jsp").forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        apiKey = (String) session.getAttribute("api-key");
        String recap = (String) session.getAttribute("recapitulationChambre");
        String montant = (String) session.getAttribute("montant");
        JsonObject reservation = (JsonObject) session.getAttribute("reservation");
        String deposit = (String) session.getAttribute("deposit");
        String ventilation = (String) session.getAttribute("ventilation");
        String informationRate = (String) session.getAttribute("informationRate");
        
        //GET RESERVATION
        reservationCreation(reservation);
        //GET VENTILATION
        JsonObject payloadVentilation = Util.stringToJsonObject(ventilation);
        //GET RESERVATION TARIF
        JsonObject payloadReservationTarif = Util.stringToJsonObject(informationRate);
        //GET ARRHES
        JsonObject depositObject = Util.stringToJsonObject(deposit);
        
        List<String> dataMailList = new ArrayList<String>();
        dataMailList.add(reservation.getString("email"));
        dataMailList.add(reservation.getString("nom"));
        dataMailList.add(reservation.getString("nbPax"));
        dataMailList.add(reservation.getString("dateArrivee"));
        dataMailList.add(reservation.getString("dateDepart"));
        dataMailList.add(montant);
        dataMailList.add(recap);
        try {
            boolean sended = this.sendMail(dataMailList);
            if (sended == true) {
                /*String message = "<span><h2 style = 'text-align: center;'><b>Votre réservation a été pris en compte.</b></h2></span><span><h3 style = 'text-align: center;'><b>Un email de récapitulation vous sera envoyé.</b></h3></span>"; //
                request.setAttribute("message", message);*/
                resaVentilationCreation(payloadVentilation);
                reservationTarifCreation(payloadReservationTarif);
                depositCreation(depositObject);
            }

        } catch (AddressException e) {
            // TODO Auto-generated catch block
            LOGGER.info("AddressException ");
            e.printStackTrace();
        } catch (MessagingException e) {
            // TODO Auto-generated catch block
            LOGGER.info("MessagingException ");
            e.printStackTrace();
        } catch (NamingException e) {
            LOGGER.info("NamingException ");
            e.printStackTrace();
        }
        
        
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    
    private void reservationCreation(JsonObject resaJSONObject) {
        final String urlBooking = Util.getContextVar("api-url").concat(Constant.WS_CREATE_BOOKING);
        String token = Jwt.generateToken();
        ResteasyClient reservation = new ResteasyClientBuilder().build();
        ResteasyWebTarget targetResa = reservation.target(urlBooking);
        Response response = targetResa.request().header("Content-Type", "application/json").header("x-api-key", apiKey)
                .header("Authorization", "Bearer " + token).post(Entity.json(resaJSONObject));
        // Read output in string format
        String value = response.readEntity(String.class);
        System.out.println("reservationCreation : " + value);
        response.close();
    }
    
    private void resaVentilationCreation(JsonObject resaJSONObject) {
        final String urlVentilation = Util.getContextVar("api-url").concat(Constant.WS_CREATE_BOOKING_VENTILATION);
        String token = Jwt.generateToken();
        ResteasyClient reservation = new ResteasyClientBuilder().build();
        ResteasyWebTarget targetResa = reservation.target(urlVentilation);
        Response response = targetResa.request().header("Content-Type", "application/json").header("x-api-key", apiKey)
                .header("Authorization", "Bearer " + token).post(Entity.json(resaJSONObject));
        // Read output in string format
        String value = response.readEntity(String.class);
        System.out.println("resaVentilationCreation : " + value);
        response.close();
    }
    
    private void reservationTarifCreation(JsonObject resaJSONObject) {
        final String urlVentilation = Util.getContextVar("api-url").concat(Constant.WS_CREATE_BOOKING_RATE);
        String token = Jwt.generateToken();
        ResteasyClient reservation = new ResteasyClientBuilder().build();
        ResteasyWebTarget targetResa = reservation.target(urlVentilation);
        Response response = targetResa.request().header("Content-Type", "application/json").header("x-api-key", apiKey)
                .header("Authorization", "Bearer " + token).post(Entity.json(resaJSONObject));
        // Read output in string format
        String value = response.readEntity(String.class);
        System.out.println("reservationTarifCreation : " + value);
        response.close();
    }
    
    private void depositCreation(JsonObject resaJSONObject) {
        final String urlDeposit = Util.getContextVar("api-url").concat(Constant.WS_CREATE_BOOKING_DEPOSIT);
        String token = Jwt.generateToken();
        ResteasyClient reservation = new ResteasyClientBuilder().build();
        ResteasyWebTarget targetResa = reservation.target(urlDeposit);
        Response response = targetResa.request().header("Content-Type", "application/json").header("x-api-key", apiKey)
                .header("Authorization", "Bearer " + token).post(Entity.json(resaJSONObject));
        // Read output in string format
        String value = response.readEntity(String.class);
        System.out.println("depositCreation : " + value);
        response.close();
    }
    
    private String getSettingsByBookingHeader() {
        final String urlBooking = Util.getContextVar("api-url").concat(Constant.WS_GET_SETTINGS_BOOKING_HEADER);
        String token = Jwt.generateToken();
        ResteasyClient cuisson = new ResteasyClientBuilder().build();
        ResteasyWebTarget target = cuisson.target(urlBooking);
        Response response = target.request().header("Content-Type", "application/json").header("x-api-key", apiKey).header("Authorization", "Bearer " + token).get();
        // Read output in string format
        String value = response.readEntity(String.class);
        response.close();
        return value;
    }

    private String getSettingsByBookingDetail() {
        final String urlBooking = Util.getContextVar("api-url").concat(Constant.WS_GET_SETTINGS_BOOKING_DETAIL);
        String token = Jwt.generateToken();
        ResteasyClient cuisson = new ResteasyClientBuilder().build();
        ResteasyWebTarget target = cuisson.target(urlBooking);
        Response response = target.request().header("Content-Type", "application/json").header("x-api-key", apiKey).header("Authorization", "Bearer " + token).get();
        // Read output in string format
        String value = response.readEntity(String.class);
        response.close();
        return value;
    }

    private String getSettingsByBookingFooter() {
        final String urlBooking = Util.getContextVar("api-url").concat(Constant.WS_GET_SETTINGS_BOOKING_FOOTER);
        String token = Jwt.generateToken();
        ResteasyClient cuisson = new ResteasyClientBuilder().build();
        ResteasyWebTarget target = cuisson.target(urlBooking);
        Response response = target.request().header("Content-Type", "application/json").header("x-api-key", apiKey).header("Authorization", "Bearer " + token).get();
        // Read output in string format
        String value = response.readEntity(String.class);
        response.close();
        return value;
    }
    
    @Resource(mappedName = "java:jboss/mail/Default")
    private Session mailSession;

    private boolean sendMail(List<String> dataMailList) throws NamingException, AddressException, MessagingException {
        final String bookingUrl = Util.getContextVar("booking-url");

        Address from = new InternetAddress(ContentMail.SENDER);
        Address[] to = new InternetAddress[]{new InternetAddress(dataMailList.get(0))};
        javax.mail.internet.MimeMessage mimeMessage;
        mimeMessage = new javax.mail.internet.MimeMessage(mailSession);
        mimeMessage.setFrom(from);
        mimeMessage.setSubject(ContentMail.MMC_MAIL_SUBJECT);
        mimeMessage.setRecipients(Message.RecipientType.TO, to);

        String mailContent = ContentMail.MMC_MAIL_DETAIL;

        String bookingHeader = getSettingsByBookingHeader();
        JsonObject getSettingsByBookingHeaderObject = Util.stringToJsonObject(bookingHeader);
        bookingHeader = getSettingsByBookingHeaderObject.getString("valeur");

        String bookingDetail = getSettingsByBookingDetail();
        JsonObject getSettingsByBookingDetailObject = Util.stringToJsonObject(bookingDetail);
        bookingDetail = getSettingsByBookingDetailObject.getString("valeur");

        String bookingFooter = getSettingsByBookingFooter();
        JsonObject getSettingsByBookingFooterObject = Util.stringToJsonObject(bookingFooter);
        bookingFooter = getSettingsByBookingFooterObject.getString("valeur");

        mailContent = mailContent.replace("{booking-url}", bookingUrl);

        mailContent = mailContent.replace("{booking-username}", dataMailList.get(0));
        mailContent = mailContent.replace("{booking-name}", dataMailList.get(1));
        mailContent = mailContent.replace("{booking-amount}", dataMailList.get(5));
        mailContent = mailContent.replace("{booking-adultsid}", dataMailList.get(2));
        mailContent = mailContent.replace("{booking-dateArrivee}", dataMailList.get(3));
        mailContent = mailContent.replace("{booking-dateDepart}", dataMailList.get(4));
        mailContent = mailContent.replace("{booking-recapchambre}", dataMailList.get(6));
        mailContent = mailContent.replace("{booking-bookingHeader}", bookingHeader);
        mailContent = mailContent.replace("{booking-bookingDetail}", bookingDetail);
        mailContent = mailContent.replace("{booking-bookingFooter}", bookingFooter);
        mimeMessage.setContent(mailContent, "text/html; charset=UTF-8");
        Transport.send(mimeMessage);
        return true;
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
