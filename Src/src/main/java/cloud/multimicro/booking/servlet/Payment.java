/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cloud.multimicro.booking.servlet;

import cloud.multimicro.booking.util.Constant;
import org.json.simple.JSONObject;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;
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
import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;

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

    private static void postPayment(JSONObject paiment) {
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
        JSONObject clientObject = new JSONObject();
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

        clientObject.put("code", "0900");
        clientObject.put("nom", nom);
        clientObject.put("prenom", prenom);
        clientObject.put("adresse", adresse+" "+complement);
        clientObject.put("ville", ville);
        clientObject.put("codePostal", codePostal);
        clientObject.put("telephone", telephone);
        clientObject.put("email", email);
        clientObject.put("pays", pays);
        clientObject.put("qualite", qualite);

        ResteasyWebTarget target = client.target(Constant.WS_CREATE_CLIENT);
        Response response = target.request().header("Content-Type", "application/json").header("x-api-key", "CD19FD5E87DB2FB0056168D58D24753B42CC4B9B75894632242A2E2BA257402E").header("Authorization", "Bearer 5edc790b914878af26afd0f7cc56715028420006401f2a9f4d8d238b5c2beae7").post(Entity.json(clientObject));
        //Read output in string format
        String value = response.readEntity(String.class);
        Integer clientId = getId(value);
        
        String roomList = request.getParameter("room-list");
        String reservationPayload = request.getParameter("reservation");

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

    // create 
    private static void reservationCreation(Integer clientId, HttpServletRequest request) {
        String roomList = request.getParameter("room-list");
        String reservationPayload = request.getParameter("reservation");
        JSONObject resaJSONObject = Payment.createJSONObject(reservationPayload);
        
        String cartePaiementType = request.getParameter("carte-paiement-type");
        String cartePaiementNumero = request.getParameter("carte-paiement-numero");
        String cartePaiementExpiration = request.getParameter("carte-paiement-expiration");
        String cartePaiementTitulaire = request.getParameter("carte-paiement-titulaire");
        String cartePaiementCVV = request.getParameter("carte-paiement-cvv");
        
        resaJSONObject.put("cartePaiementType", cartePaiementType);
        resaJSONObject.put("cartePaiementNumero", cartePaiementNumero);
        resaJSONObject.put("cartePaiementExpiration", cartePaiementExpiration);
        resaJSONObject.put("cartePaiementTitulaire", cartePaiementTitulaire);
        resaJSONObject.put("cartePaiementCVV", cartePaiementCVV);
        resaJSONObject.put("mmcClientId", clientId);

        ResteasyClient reservation = new ResteasyClientBuilder().build();
        System.out.println(Entity.json(resaJSONObject));
        ResteasyWebTarget targetResa = reservation.target(Constant.WS_CREATE_BOOKING);
        Response response = targetResa.request().header("Content-Type", "application/json").header("x-api-key", "CD19FD5E87DB2FB0056168D58D24753B42CC4B9B75894632242A2E2BA257402E").header("Authorization", "Bearer 5edc790b914878af26afd0f7cc56715028420006401f2a9f4d8d238b5c2beae7").post(Entity.json(resaJSONObject));
        //Read output in string format
        String value = response.readEntity(String.class);
        Integer entitieId = getId(value);
        Payment.ventilationNoteCreation(entitieId, roomList);
        String montant = request.getParameter("montant");
        JSONObject paiment = new JSONObject();
        paiment.put("montant",montant);
        paiment.put("pmsNoteEnteteId",entitieId);
        paiment.put("mmcModeEncaissementId",1);
        paiment.put("mmcUserId",1);
        Payment.postPayment(paiment);

        response.close();
    }

    //list of room: modification of type String in JSONArray
    private static JSONArray stringToJSONArrayRoomList(String roomList) {
        JSONArray arrayList = new JSONArray();
        JSONObject objectRoom = new JSONObject();
        Map<String, String> myMap = new HashMap<String, String>();

        roomList = roomList.replaceAll("\"", "");
        roomList = roomList.substring(1, roomList.length() - 2);
        String[] parts = roomList.split("},");

        for (int i = 0; i < parts.length; i++) {
            String part = parts[i];
            part = part.substring(1, part.length());
            String[] partList = part.split(",");
            for (int j = 0; j < partList.length; j++) {
                String partList1 = partList[j];
                String[] keyValue = partList1.split(":");
                Integer value = Integer.parseInt(keyValue[1]);
                if (keyValue[0].equals("nbEnfant")) {
                    objectRoom.put("nbEnfant", value);
                } else if (keyValue[0].equals("qteChb")) {
                    objectRoom.put("qteChb", value);
                } else if (keyValue[0].equals("nbAdulte")) {
                    objectRoom.put("nbAdulte", value);
                }
            }
            arrayList.add(objectRoom);
        }

        return arrayList;
    }

    private static void ventilationNoteCreation(Integer entitieId, String roomList) {
        JSONArray roomListArray = stringToJSONArrayRoomList(roomList);
        ResteasyClient ventillation = new ResteasyClientBuilder().build();
        JSONObject ventillationObject = new JSONObject();
        ventillationObject.put("pmsNoteEnteteId", entitieId);
        ventillationObject.put("roomList", roomListArray);
        ResteasyWebTarget target = ventillation.target(Constant.WS_CREATE_VENTILLATION_NOTE);
        Response response = target.request().header("Content-Type", "application/json").header("x-api-key", "CD19FD5E87DB2FB0056168D58D24753B42CC4B9B75894632242A2E2BA257402E").header("Authorization", "Bearer 5edc790b914878af26afd0f7cc56715028420006401f2a9f4d8d238b5c2beae7").post(Entity.json(ventillationObject));
        //Read output in string format
        String value = response.readEntity(String.class);
        response.close();
    }

    private static JSONObject createJSONObject(String jsonString) {
        JSONObject jsonObject = new JSONObject();
        JSONParser jsonParser = new JSONParser();
        if ((jsonString != null) && !(jsonString.isEmpty())) {
            try {
                jsonObject = (JSONObject) jsonParser.parse(jsonString);
            } catch (org.json.simple.parser.ParseException e) {
                e.printStackTrace();
            }
        }
        return jsonObject;
    }
}
