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
import org.jboss.logging.Logger;
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

/**
 *
 * @author zo
 */
@WebServlet(name = "Payment", urlPatterns = {"/payment"})
public class Payment extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(Payment.class);

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

        getServletConfig().getServletContext().getRequestDispatcher("/payment.jsp").forward(request, response);
    }
    
    private static String montantTTC;
    private static String recap;
    private static JsonObject payloadReservation;
    private static JsonObject payloadVentilation;
    private static JsonObject payloadReservationTarif;
    private static JsonObject depositJson;
    
    public static String getMontantTTC() {
        return montantTTC;
    }

    public static void setMontantTTC(String value) {
        montantTTC = value;
    }

    public static String getRecap() {
        return recap;
    }

    public static void setRecap(String value) {
        recap = value;
    }
    
    public static JsonObject getDepositJson() {
        return depositJson;
    }

    public static void setDepositJson(JsonObject value) {
        depositJson = value;
    }

    public static JsonObject getPayloadReservation() {
        return payloadReservation;
    }

    public static void setPayloadReservation(JsonObject value) {
        payloadReservation = value;
    }

    public static JsonObject getPayloadVentilation() {
        return payloadVentilation;
    }

    public static void setPayloadVentilation(JsonObject value) {
        payloadVentilation = value;
    }

    public static JsonObject getPayloadReservationTarif() {
        return payloadReservationTarif;
    }

    public static void setPayloadReservationTarif(JsonObject value) {
        payloadReservationTarif = value;
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
    // + sign on the left to edit the code.">
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
        request.setAttribute("backgroundImage", Home.getBackgroundimage());
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
        String ventilation = request.getParameter("ventilation");
        JsonObject ventilationObject = Payment.stringToJsonObject(ventilation);
        Payment.setPayloadVentilation(ventilationObject);
        String informationRate = request.getParameter("informationRate");
        JsonObject informationRateObject = Payment.stringToJsonObject(informationRate);
        Payment.setPayloadReservationTarif(informationRateObject);
        String observation = request.getParameter("observation");
        JsonObject payload = Json.createObjectBuilder().add("dateArrivee", reservationObject.getString("dateArrivee"))
                .add("dateDepart", reservationObject.getString("dateDepart")).add("nomReservation", nomReservation)
                .add("nbChambre", nbChambre).add("nbPax", nbPax).add("nbEnfant", nbEnfant)
                .add("reservationType", "INDIV").add("pmsTarifGrilleId", 1).add("cardex", "").add("civilite", civilite)
                .add("nationalite", pays).add("nom", nom).add("prenom", prenom).add("adresse1", adresse1)
                .add("adresse2", adresse2).add("tel", telMobile).add("email", email).add("cp", codePostal)
                .add("ville", ville).add("pays", pays).add("origine", "BOOKING").add("posteUuid", "_BOOKING_")
                .add("observation", observation).build();
        Payment.setPayloadReservation(payload);
        String amount = request.getParameter("montant");
        Payment.setMontantTTC(amount);
        String recap = request.getParameter("recapitulationChambre");
        Payment.setRecap(recap);
        String deposit = request.getParameter("deposit");
        JsonObject depositObject = Payment.stringToJsonObject(deposit);
        Payment.setDepositJson(depositObject);
        
        response.sendRedirect(request.getContextPath() + "/checkout.jsp");

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

    private static JsonObject stringToJsonObject(String jsonString) {
        JsonObject object;
        try (JsonReader jsonReader = Json.createReader(new StringReader(jsonString))) {
            object = jsonReader.readObject();
        }
        return object;

    }

}