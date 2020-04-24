/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cloud.multimicro.booking.servlet;

import cloud.multimicro.booking.util.Constant;
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
import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonReader;

/**
 *
 * @author zo
 */
@WebServlet(name = "Payment", urlPatterns = {"/payment"})
public class Payment extends HttpServlet {

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
        //CREATION DE COMPTE CLIENT
        Payment.postClient(request);
        processRequest(request, response);
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
        ResteasyClient client = new ResteasyClientBuilder().build();
        ResteasyWebTarget target = client.target(Constant.WS_CREATE_CASHING);
        System.out.println(Entity.json(paiment));
        Response response = target.request().header("Content-Type", "application/json").header("x-api-key", "CD19FD5E87DB2FB0056168D58D24753B42CC4B9B75894632242A2E2BA257402E").header("Authorization", "Bearer 5edc790b914878af26afd0f7cc56715028420006401f2a9f4d8d238b5c2beae7").post(Entity.json(paiment));
        //Read output in string format
        String value = response.readEntity(String.class);
        response.close();
    }

    private static void postClient(HttpServletRequest request) {
        ResteasyClient client = new ResteasyClientBuilder().build();
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String adresse = request.getParameter("adresse");
        String ville = request.getParameter("ville");
        String codePostal = request.getParameter("codePostal");
        String telephone = request.getParameter("telephone");
        String email = request.getParameter("email");
        String pays = request.getParameter("pays");
        String complement = request.getParameter("complement");
        String qualite = request.getParameter("qualite");

        JsonObject clientObject = Json.createObjectBuilder()
                .add("nom", nom)
                .add("prenom", prenom)
                .add("code", "77777")
                .add("adresse", adresse + " " + complement)
                .add("ville", ville)
                .add("codePostal", codePostal)
                .add("telephone", telephone)
                .add("email", email) 
                .add("pays", pays)
                .add("qualite",qualite)
                .build();

        ResteasyWebTarget target = client.target(Constant.WS_CREATE_CLIENT);
        Response response = target.request().header("Content-Type", "application/json").header("x-api-key", "CD19FD5E87DB2FB0056168D58D24753B42CC4B9B75894632242A2E2BA257402E").header("Authorization", "Bearer 5edc790b914878af26afd0f7cc56715028420006401f2a9f4d8d238b5c2beae7").post(Entity.json(clientObject));
        //Read output in string format
        String value = response.readEntity(String.class);
        Integer clientId = getId(value);
        Payment.reservationCreation(clientId, request);
        response.close();
    }

    private static Integer getId(String value) {
        Integer id = null;
        value = value.replaceAll("\"", "");
        value = value.substring(1, value.length() - 1);
        String[] pairs = value.split(",");
        for (int i = 0; i < pairs.length; i++) {
            String pair = pairs[i];
            String[] keyValue = pair.split(":");
            if (keyValue[0].equals("id")) {
                id = Integer.parseInt(keyValue[1]);
                break;
            }
        }
        return id;
    }

   private static void reservationCreation(Integer clientId, HttpServletRequest request) {
        //RESERVATION
        String reservationPayload = request.getParameter("reservation");
        String cartePaiementType = request.getParameter("carte-paiement-type");
        String cartePaiementNumero = request.getParameter("carte-paiement-numero");
        String cartePaiementExpiration = request.getParameter("carte-paiement-expiration");
        String cartePaiementTitulaire = request.getParameter("carte-paiement-titulaire");
        String cartePaiementCVV = request.getParameter("carte-paiement-cvv");
        reservationPayload = reservationPayload.substring(0, reservationPayload.length() - 1);
        reservationPayload = reservationPayload +",\"cartePaiementType\":\""+cartePaiementType+"\","+"\"cartePaiementNumero\":\""+cartePaiementNumero+"\",\"cartePaiementExpiration\":\""+cartePaiementExpiration+"\",\"cartePaiementTitulaire\":\""+cartePaiementTitulaire+"\",\"cartePaiementCVV\":"+cartePaiementCVV+",\"mmcClientId\":"+clientId+"}";
        JsonObject resaJSONObject = Payment.stringToJsonObject(reservationPayload);
        ResteasyClient reservation = new ResteasyClientBuilder().build();
        System.out.println(Entity.json(resaJSONObject));
        ResteasyWebTarget targetResa = reservation.target(Constant.WS_CREATE_BOOKING);
        Response response = targetResa.request().header("Content-Type", "application/json").header("x-api-key", "CD19FD5E87DB2FB0056168D58D24753B42CC4B9B75894632242A2E2BA257402E").header("Authorization", "Bearer 5edc790b914878af26afd0f7cc56715028420006401f2a9f4d8d238b5c2beae7").post(Entity.json(resaJSONObject));
        //Read output in string format
        String value = response.readEntity(String.class);
        
        //NOTE VANTILATION CHAMBRE
        String roomList = request.getParameter("room-list");
        Integer entitieId = getId(value);
        roomList = "\"roomList\":"+roomList;
        String payloadNoteVentillation = "{\"pmsNoteEnteteId\":"+entitieId+","+roomList+"}";
        JsonObject payloadNoteVentillationJsonObject = Payment.stringToJsonObject(payloadNoteVentillation);
        Payment.ventilationNoteCreation(payloadNoteVentillationJsonObject);
         
        //PAYMENT
        String montant = request.getParameter("montant");
        JsonObject paiment = Json.createObjectBuilder()
                .add("montant",montant)
                .add("pmsNoteEnteteId",entitieId)
                .add("mmcModeEncaissementId",1)
                .add("mmcUserId",1)
                .build();
        Payment.postPayment(paiment);

        response.close();
    }

    private static void ventilationNoteCreation(JsonObject ventillationObject) {
        ResteasyClient ventillation = new ResteasyClientBuilder().build();
        ResteasyWebTarget target = ventillation.target(Constant.WS_CREATE_VENTILLATION_NOTE);
        Response response = target.request().header("Content-Type", "application/json").header("x-api-key", "CD19FD5E87DB2FB0056168D58D24753B42CC4B9B75894632242A2E2BA257402E").header("Authorization", "Bearer 5edc790b914878af26afd0f7cc56715028420006401f2a9f4d8d238b5c2beae7").post(Entity.json(ventillationObject));
        //Read output in string format
        String value = response.readEntity(String.class);
        response.close();
    }

    private static JsonObject stringToJsonObject(String jsonString) {
        JsonReader jsonReader = Json.createReader(new StringReader(jsonString));
        JsonObject object = jsonReader.readObject();
        jsonReader.close();
        return object;
    }
}
