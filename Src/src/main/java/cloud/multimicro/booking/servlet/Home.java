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
import javax.ws.rs.core.Response;
import org.jboss.resteasy.client.jaxrs.ResteasyClient;
import org.jboss.resteasy.client.jaxrs.ResteasyClientBuilder;
import org.jboss.resteasy.client.jaxrs.ResteasyWebTarget;
import cloud.multimicro.booking.util.Jwt;
import cloud.multimicro.booking.servlet.DataBooking;
import javax.ws.rs.client.Entity;
import java.io.StringReader;
import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonReader;
import javax.json.JsonArray;
import javax.json.JsonNumber;
import java.util.*;
import java.math.BigDecimal;
import javax.json.stream.JsonParsingException;

/**
 *
 * @author zo
 */
@WebServlet(name = "Home", urlPatterns = {"/home"})
public class Home extends HttpServlet {

    private static String apiKey;
    private static String token;

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
        response.setContentType("text/html;charset=UTF-8");
        getServletConfig().getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
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
        String codeSite = request.getParameter("code");
        apiKey = getApiKeyBySite(codeSite);
        Home.setApiKey(apiKey);
        System.out.println(" codeSite : " + codeSite);

    }

    private static String getApiKeyBySite(String codeSite) {
        ResteasyClient client = new ResteasyClientBuilder().build();
        ResteasyWebTarget target = client.target(Constant.WS_GET_CODE_SITE + codeSite);
        String bearerToken = Jwt.generateToken();
        Home.setToken(bearerToken);
        Response response = target.request().header("Authorization", "Bearer " + bearerToken).get();
        //Read output in string format
        String value = response.readEntity(String.class);
        System.out.println("value : " + value);
        response.close();
        return value;
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
        String roomRequested = request.getParameter("room-requested");
        System.out.println(" roomRequested : " + roomRequested);

        if ("".equals(roomRequested)) {
            getServletConfig().getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
            return;
        }

        String value = postRoomAvailability(roomRequested);
        if (value != "") {
            value = "{\"Availability\":" + value + "}";

            JsonObject jsonObj = null;
            JsonReader jsonR = Json.createReader(new StringReader(value));
            try {
                jsonObj = jsonR.readObject();
                jsonR.close();
            } catch (JsonParsingException e) {

            }

            // Transformer JSONObject en Array  
            JsonArray jsonArray = jsonObj.getJsonArray("Availability");

            List<DataBooking> rooms = new ArrayList<DataBooking>();
            for (int i = 0; i < jsonArray.size(); i++) {
                JsonObject jsonLigne = jsonArray.getJsonObject(i);

                JsonObject jsonTypeChambre = jsonLigne.getJsonObject("pmsTypeChambre");
                Integer id = jsonTypeChambre.getInt("id");
                String libTypeChambre = jsonTypeChambre.getString("libelle");
                Integer persMax = jsonTypeChambre.getInt("persMax");
                Integer nbEnfant = jsonTypeChambre.getInt("nbEnfant");

                JsonObject jsonModeleTarif = jsonLigne.getJsonObject("pmsModelTarif");
                JsonNumber jsonPrixDefaut = jsonModeleTarif.getJsonNumber("prixParDefaut");
                BigDecimal prixDefaut = BigDecimal.valueOf(jsonPrixDefaut.doubleValue());

                JsonArray jsonTarifOptionArray = jsonLigne.getJsonArray("pmsTarifOption");

                List<String> tarifOption = new ArrayList<String>();
                for (int j = 0; j < jsonTarifOptionArray.size(); j++) {
                    JsonObject jsonTarifOption = jsonTarifOptionArray.getJsonObject(j);
                    if (jsonTarifOption.getBoolean("checked") == true) {
                        String option = jsonTarifOption.getString("libelle");
                        tarifOption.add(option);
                    }
                }

                Integer totalRoom = jsonLigne.getInt("totalRoom");
                Integer availableRoom = jsonLigne.getInt("availableRoom");

                DataBooking room = new DataBooking();
                room.setIdTypeChambre(id);
                room.setTypeChambreLibelle(libTypeChambre);
                room.setAvailableRoom(availableRoom);
                room.setPrixParDefaut(prixDefaut);
                room.setTotalRoom(totalRoom);
                room.setNbAdulte(persMax);
                room.setNbEnfant(nbEnfant);
                room.setTarifOptionLibelle(tarifOption);
                rooms.add(room);
            }

            request.setAttribute("listRooms", rooms);
        }

        getServletConfig().getServletContext().getRequestDispatcher("/rooms").forward(request, response);
    }

    private String postRoomAvailability(String availableString) {
        JsonObject availableObject = stringToJsonObject(availableString);
        ResteasyClient client = new ResteasyClientBuilder().build();
        ResteasyWebTarget target = client.target(Constant.WS_SEARCH_AVAILABILITY);
        System.out.println(Entity.json(availableObject));
        String bearerToken = Jwt.generateToken();
        Response response = target.request().header("Content-Type", "application/json").header("x-api-key", apiKey).header("Authorization", "Bearer " + bearerToken).post(Entity.json(availableObject));
        //Read output in string format
        String value = response.readEntity(String.class);
        System.out.println("value disponibilite  retourné : " + value);
        response.close();
        return value;
    }

    private static JsonObject stringToJsonObject(String jsonString) {
        JsonReader jsonReader = Json.createReader(new StringReader(jsonString));
        JsonObject object = jsonReader.readObject();
        jsonReader.close();
        return object;
    }

    public static String getApiKey() {
        return apiKey;
    }

    public static void setApiKey(String value) {
        apiKey = value;
    }

    public static String getToken() {
        return token;
    }

    public static void setToken(String value) {
        token = value;
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
