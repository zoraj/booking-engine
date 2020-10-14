/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cloud.multimicro.booking.servlet;

import cloud.multimicro.booking.util.Constant;
import cloud.multimicro.booking.util.ContentMail;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.client.Entity;
import javax.ws.rs.core.Response;
import org.jboss.resteasy.client.jaxrs.ResteasyClient;
import org.jboss.resteasy.client.jaxrs.ResteasyClientBuilder;
import org.jboss.resteasy.client.jaxrs.ResteasyWebTarget;
import java.io.StringReader;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
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

/**
 *
 * @author zo
 */
@WebServlet(name = "Payment", urlPatterns = { "/payment" })
public class Payment extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        getServletConfig().getServletContext().getRequestDispatcher("/payment.jsp").forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
    // + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String reservation = request.getParameter("reservation");
        JsonObject reservationObject = Payment.stringToJsonObject(reservation);
        String nbChambre =  reservationObject.get("nbChambre").toString();
        String nbPax = reservationObject.get("nbPax").toString();
        String nbEnfant = reservationObject.get("nbEnfant").toString();
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String nomReservation = nom.concat(prenom);
        String adresse1 = request.getParameter("adresse1");
        String ville = request.getParameter("ville");
        String codePostal = request.getParameter("cp");
        String telMobile = request.getParameter("tel");
        String email = request.getParameter("email");
        String pays = request.getParameter("pays");
        String adresse2 = request.getParameter("adresse2");
        String civilite = request.getParameter("civilite");
        String cartePaiementType = request.getParameter("carte-paiement-type");
        String cartePaiementNumero = request.getParameter("carte-paiement-numero");
        String cartePaiementExpiration = request.getParameter("carte-paiement-expiration");
        String cartePaiementTitulaire = request.getParameter("carte-paiement-titulaire");
        String cartePaiementCVV = request.getParameter("carte-paiement-cvv");
        String ventillation = request.getParameter("ventillation");
        JsonObject ventillationObject = Payment.stringToJsonObject(ventillation);
        String informationRate = request.getParameter("informationRate");
        JsonObject informationRateObject = Payment.stringToJsonObject(informationRate);
        JsonObject payload = Json.createObjectBuilder()
                .add("dateArrivee", reservationObject.getString("dateArrivee"))
                .add("dateDepart", reservationObject.getString("dateDepart"))
                .add("nomReservation", nomReservation)
                .add("nbChambre", nbChambre)
                .add("nbPax", nbPax)
                .add("nbEnfant", nbEnfant)
                .add("reservationType", "INDIV")
                .add("pmsTarifGrilleId", 1)
                .add("cardex", "")
                .add("civilite", civilite)
                .add("nationalite", pays)
                .add("nom", nom)
                .add("prenom", prenom)
                .add("adresse1", adresse1)
                .add("adresse2", adresse2)
                .add("tel", telMobile)
                .add("email", email)
                .add("cp", codePostal)
                .add("ville", ville)
                .add("pays", pays)
                .add("origine", "BOOKING")
                .add("cbType", cartePaiementType)
                .add("cbNumero", cartePaiementNumero)
                .add("cbTitulaire", cartePaiementTitulaire)
                .add("cbExp", cartePaiementExpiration)
                .add("cbCvv", cartePaiementCVV)
                .add("ventillation", ventillationObject.getJsonArray("ventillation"))
                .add("reservationTarif", informationRateObject.getJsonArray("reservationTarif"))
                .build();
        Payment.reservationCreation(payload);

        response.setContentType("text/html;charset=UTF-8");
        String message = "<span><h2 style = 'text-align: center;'>Thank you for your visit,</h2></span><span></span>"; //<h3 style = 'text-align: center;'>a summary email has been sent to you.</h3>
        request.setAttribute("message", message);
        this.getServletContext().getRequestDispatcher("/info.jsp").forward(request, response);
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

    private static void postPayment(JsonObject paiment) {
        String apiKey = Home.getApiKey();
        String token = Home.getToken();
        ResteasyClient client = new ResteasyClientBuilder().build();
        ResteasyWebTarget target = client.target(Constant.WS_CREATE_CASHING);
        System.out.println(Entity.json(paiment));
        Response response = target.request().header("Content-Type", "application/json").header("x-api-key", apiKey)
                .header("Authorization", "Bearer " + token).post(Entity.json(paiment));
        // Read output in string format
        String value = response.readEntity(String.class);
        response.close();
    }

    private static void reservationCreation(JsonObject resaJSONObject) {
        String apiKey = Home.getApiKey();
        String token = Home.getToken();
        ResteasyClient reservation = new ResteasyClientBuilder().build();
        ResteasyWebTarget targetResa = reservation.target(Constant.WS_CREATE_BOOKING);
        Response response = targetResa.request().header("Content-Type", "application/json").header("x-api-key", apiKey)
                .header("Authorization", "Bearer " + token).post(Entity.json(resaJSONObject));
        // Read output in string format
        String value = response.readEntity(String.class);
        response.close();
    }

    private static JsonObject stringToJsonObject(String jsonString) {
        JsonReader jsonReader = Json.createReader(new StringReader(jsonString));
        JsonObject object = jsonReader.readObject();
        jsonReader.close();
        return object;

    }

    @Resource(mappedName = "java:jboss/mail/Default")
    private Session mailSession;
/*
    private boolean SendMail() throws AddressException, MessagingException {

        Address from = new InternetAddress(ContentMail.SENDER);
        Address[] to = new InternetAddress[] { new InternetAddress(email) };
        javax.mail.internet.MimeMessage mimeMessage;

        mimeMessage = new javax.mail.internet.MimeMessage(mailSession);
        mimeMessage.setFrom(from);
        mimeMessage.setSubject(ContentMail.MMC_MAIL_SUBJECT);
        mimeMessage.setRecipients(Message.RecipientType.TO, to);

        String mailContent = ContentMail.MMC_MAIL_DETAIL;
        mailContent = mailContent.replace("{booking-url}", Constant.SERVER_BOOKING_ADDRESS);
        mailContent = mailContent.replace("{booking-username}", email);
        mailContent = mailContent.replace("{booking-name}", nom);
        mailContent = mailContent.replace("{booking-amount}", montant);
        mailContent = mailContent.replace("{booking-adultsid}", adults);
        mailContent = mailContent.replace("{booking-dateArrivee}", dateArrivee);
        mailContent = mailContent.replace("{booking-dateDepart}", dateDepart);
        mailContent = mailContent.replace("{booking-recapchambre}", recapchambre);
        mimeMessage.setContent(mailContent, "text/plain");
        Transport.send(mimeMessage);
        return true;
    }*/

}
