/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cloud.multimicro.booking.servlet;

import cloud.multimicro.booking.util.Constant;
import cloud.multimicro.booking.util.ContentMail;
import cloud.multimicro.booking.util.Util;

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
import java.util.ArrayList;
import java.util.List;
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
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

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
        request.setAttribute("backgroundImage", Home.getBackgroundimage());
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
        String nbChambre = reservationObject.get("nbChambre").toString();
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
        String observation = request.getParameter("observation");
        JsonObject payload = Json.createObjectBuilder().add("dateArrivee", reservationObject.getString("dateArrivee"))
                .add("dateDepart", reservationObject.getString("dateDepart")).add("nomReservation", nomReservation)
                .add("nbChambre", nbChambre).add("nbPax", nbPax).add("nbEnfant", nbEnfant)
                .add("reservationType", "INDIV").add("pmsTarifGrilleId", 1).add("cardex", "").add("civilite", civilite)
                .add("nationalite", pays).add("nom", nom).add("prenom", prenom).add("adresse1", adresse1)
                .add("adresse2", adresse2).add("tel", telMobile).add("email", email).add("cp", codePostal)
                .add("ville", ville).add("pays", pays).add("origine", "BOOKING").add("posteUuid", "_BOOKING_")
                .add("cbType", cartePaiementType).add("cbNumero", cartePaiementNumero)
                .add("cbTitulaire", cartePaiementTitulaire).add("cbExp", cartePaiementExpiration)
                .add("cbCvv", cartePaiementCVV).add("observation", observation)
                .add("ventillation", ventillationObject.getJsonArray("ventillation"))
                .add("reservationTarif", informationRateObject.getJsonArray("reservationTarif")).build();
        Payment.reservationCreation(payload);
        List<String> dataMailList = new ArrayList<String>();
        String amount = request.getParameter("montant");
        String recap = request.getParameter("recapitulationChambre");
        dataMailList.add(email);
        dataMailList.add(nom);
        dataMailList.add(nbPax);
        dataMailList.add(payload.getString("dateArrivee"));
        dataMailList.add(payload.getString("dateDepart"));
        dataMailList.add(amount);
        dataMailList.add(recap);
        try {
            boolean sended = this.sendMail(dataMailList);
            if (sended == true) {
                String message = "<span><h2 style = 'text-align: center;'><b>Votre réservation a été pris en compte.</b></h2></span><span><h3 style = 'text-align: center;'><b>Un email de récapitulation vous sera envoyé.</b></h3></span>"; //
                request.setAttribute("message", message);
                request.setAttribute("backgroundImage", Home.getBackgroundimage());
                this.getServletContext().getRequestDispatcher("/info.jsp").forward(request, response);
            }

        } catch (AddressException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (MessagingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (NamingException e) {
            e.printStackTrace();
        }

        response.setContentType("text/html;charset=UTF-8");

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

    private static void reservationCreation(JsonObject resaJSONObject) {
        final String urlBooking = Util.getContextVar("api-url").concat(Constant.WS_CREATE_BOOKING);
        String apiKey = Home.getApiKey();
        String token = Home.getToken();
        ResteasyClient reservation = new ResteasyClientBuilder().build();
        ResteasyWebTarget targetResa = reservation.target(urlBooking);
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

    private boolean sendMail(List<String> dataMailList) throws NamingException, AddressException, MessagingException {
        final String bookingUrl = Util.getContextVar("booking-url");

        Address from = new InternetAddress(ContentMail.SENDER);
        Address[] to = new InternetAddress[] { new InternetAddress(dataMailList.get(0)) };
        javax.mail.internet.MimeMessage mimeMessage;
        mimeMessage = new javax.mail.internet.MimeMessage(mailSession);
        mimeMessage.setFrom(from);
        mimeMessage.setSubject(ContentMail.MMC_MAIL_SUBJECT);
        mimeMessage.setRecipients(Message.RecipientType.TO, to);

        String mailContent = ContentMail.MMC_MAIL_DETAIL;

        mailContent = mailContent.replace("{booking-url}", bookingUrl);
        mailContent = mailContent.replace("{booking-username}", dataMailList.get(0));
        mailContent = mailContent.replace("{booking-name}", dataMailList.get(1));
        mailContent = mailContent.replace("{booking-amount}", dataMailList.get(5));
        mailContent = mailContent.replace("{booking-adultsid}", dataMailList.get(2));
        mailContent = mailContent.replace("{booking-dateArrivee}", dataMailList.get(3));
        mailContent = mailContent.replace("{booking-dateDepart}", dataMailList.get(4));
        mailContent = mailContent.replace("{booking-recapchambre}", dataMailList.get(6));
        mimeMessage.setContent(mailContent, "text/plain");
        Transport.send(mimeMessage);
        return true;
    }

}
