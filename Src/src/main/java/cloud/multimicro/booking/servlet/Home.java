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
import cloud.multimicro.booking.util.Util;
import javax.ws.rs.client.Entity;
import java.io.StringReader;
import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonReader;
import javax.json.JsonArray;
import java.util.*;
import javax.json.stream.JsonParsingException;
import javax.servlet.http.HttpSession;

/**
 *
 * @author zo
 */
@WebServlet(name = "Home", urlPatterns = {"/"})
public class Home extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        getServletConfig().getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
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
        HttpSession session = request.getSession(true);
        String establishmentName = request.getServletPath();
        //session.setAttribute("establishmentName", establishmentName);
        if (establishmentName != null) {
            request.setAttribute("establishmentName", establishmentName);
        }
        try {
            apiKey = getApiKeyBySiteName(establishmentName);
            JsonObject apikeyObject = Util.stringToJsonObject(apiKey);
            apiKey = apikeyObject.getString("apiKey");
            session.setAttribute("api-key", apiKey);
        } catch (Exception ex) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
        
        String publicApiKeyStripe = getSettingsStripePublicKey();
        JsonObject publicApikeyObject = Util.stringToJsonObject(publicApiKeyStripe);
        publicApiKeyStripe = publicApikeyObject.getString("valeur");
        session.setAttribute("publicApiKeyStripe", publicApiKeyStripe);

        processRequest(request, response);

    }

    private static String getApiKeyBySiteName(String establishmentName) throws Exception {
        System.out.println("Jwt.generateToken()" + Jwt.generateToken());
        ResteasyClient client = new ResteasyClientBuilder().build();
        ResteasyWebTarget target = client.target(Util.getContextVar("e-api-url").concat(Constant.WS_GET_NAME_SITE + establishmentName));
        System.out.println("target_target" + target);
        String bearerToken = Jwt.generateToken();
        Response response = target.request().header("Authorization", "Bearer " + bearerToken).get();
        // Read output in string format
        if(response.getStatus()!= Response.Status.OK.getStatusCode()){
            throw new Exception("Establishment Not Found.");
        }
        String value = response.readEntity(String.class);
        System.out.println("value : " + value);
        response.close();
        return value;
    }
    
    private String getSettingsStripePublicKey() {
        final String urlBooking = Util.getContextVar("api-url").concat(Constant.WS_GET_SETTINGS_STRIPE_PUBLIC_KEY);
        String bearerToken = Jwt.generateToken();
        ResteasyClient cuisson = new ResteasyClientBuilder().build();
        ResteasyWebTarget target = cuisson.target(urlBooking);
        Response response = target.request().header("Content-Type", "application/json").header("x-api-key", apiKey).header("Authorization", "Bearer " + bearerToken).get();
        // Read output in string format
        String value = response.readEntity(String.class);
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
        
        // verification validité code promo
        String codepromo = request.getParameter("codepromo");
        boolean isCodePromoValid = false;
        if (codepromo != null && !codepromo.equals("")) {
            final String urlVerifCodePromo = Util.getContextVar("api-url").concat(Constant.WS_GET_CODEPROMO_VALIDITY).concat("/").concat(codepromo);
            String bearerToken = Jwt.generateToken();
            ResteasyClient httpClient = new ResteasyClientBuilder().build();
            ResteasyWebTarget target = httpClient.target(urlVerifCodePromo);
            Response responseVerif = target.request().header("Content-Type", "application/json").header("x-api-key", apiKey).header("Authorization", "Bearer " + bearerToken).get();
            isCodePromoValid = responseVerif.readEntity(Boolean.class);
            responseVerif.close();
            if (isCodePromoValid) {
                final String urlGetCodePromoObj = Util.getContextVar("api-url").concat(Constant.WS_GET_CODEPROMO_BY_CODE).concat("/").concat(codepromo);
                target = httpClient.target(urlGetCodePromoObj);
                Response responseCodepromo = target.request().header("Content-Type", "application/json").header("x-api-key", apiKey).header("Authorization", "Bearer " + bearerToken).get();
                codepromo = responseCodepromo.readEntity(String.class);
            }
        } else {
            request.setAttribute("codepromoObjStr", "NOT_SPECIFIED");
        }
        
        String roomRequested = request.getParameter("room-requested");

        if ("".equals(roomRequested)) {
            getServletConfig().getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
            return;
        }
        
        String value = postRoomAvailability(roomRequested);
        
        if (!value.equals("")) {
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
            System.out.println("value  jsonArray = "+jsonArray);
            List<DataBooking> rooms = new ArrayList<DataBooking>();
            //List<RoomsPhotoData> photoData = new ArrayList<RoomsPhotoData>();
            for (int i = 0; i < jsonArray.size(); i++) {
                System.out.println("jsonArray.size = "+jsonArray.size());
                DataBooking dataBooking = new DataBooking();

                JsonObject jsonLigne = jsonArray.getJsonObject(i);
                dataBooking.setPmsTypeChambreId(jsonLigne.getInt("pmsTypeChambreId"));
                dataBooking.setPersMin(jsonLigne.getInt("persMin"));
                dataBooking.setPersMax(jsonLigne.getInt("persMax"));
                dataBooking.setTypeChambre(jsonLigne.getString("typeChambre"));
                dataBooking.setNbChild(jsonLigne.getInt("nbChild"));
                dataBooking.setQteTotal(jsonLigne.getInt("qteTotal"));
                dataBooking.setQteDispo(jsonLigne.getInt("qteDispo"));
                dataBooking.setMmcModeEncaissementId(jsonLigne.getInt("mmcModeEncaissementId"));
                dataBooking.setMmcClientId(jsonLigne.getInt("mmcClientId"));
                dataBooking.setPmsTarifGrilleId(jsonLigne.getInt("pmsTarifGrilleId"));
                
                JsonArray jsonPhotoArray = jsonLigne.getJsonArray("roomPhoto");  
                List<String> listPhoto = new ArrayList<String>(); 
                String photo = "";
                for (int k = 0; k < jsonPhotoArray.size(); k++) {                
                    JsonObject jsonPhoto = jsonPhotoArray.getJsonObject(k);
                    String dataSrc = jsonPhoto.getString("data");
                    if (k == 0){
                        photo = "<div class='item active'><img src='"+dataSrc+"' height = '400' width = '400'></div>";
                    }else {
                        photo = "<div class='item'><img src='"+dataSrc+"' height = '400' width = '400'></div>";
                    }                     
                    listPhoto.add(photo);
                }
                if(jsonPhotoArray.isEmpty()){
                    photo = "<div class='item active'><img src='assets/img/photo-non-dispo.png' height = '400' width = '400'></div>";
                    listPhoto.add(photo);
                }
                dataBooking.setListePhotoByRoomType(listPhoto); 
                JsonArray jsonTarifArray = jsonLigne.getJsonArray("tarif");
                for (int j = 0; j < jsonTarifArray.size(); j++) {
                    DataBooking data = new DataBooking(dataBooking);
                    JsonObject jsonTarif = jsonTarifArray.getJsonObject(j);
                    data.setTypeTarifId(jsonTarif.getInt("typeTarifId"));
                    data.setAmount(Double.parseDouble(jsonTarif.get("amount").toString()));
                    data.setTypeTarifLibelle(jsonTarif.getString("typeTarifLibelle"));
                    data.setPmsTarifGrilleDetailId(jsonTarif.getInt("pmsTarifGrilleDetailId"));
                    data.setBase(jsonTarif.getInt("base"));
                    rooms.add(data);
                }
                System.out.println("----------- value  rooms = "+rooms);
            }

            if (!rooms.isEmpty()) {
                System.out.println("rooms not empty------------------- ");
                request.setAttribute("listRooms", rooms);
                // mise en session du symbole du devise principal
                final String urlDevisePpal = Util.getContextVar("api-url").concat(Constant.WS_GET_SETTINGS_DEVISE_PPAL_SYMBOLE);
                String bearerToken = Jwt.generateToken();
                ResteasyClient httpClient = new ResteasyClientBuilder().build();
                ResteasyWebTarget target = httpClient.target(urlDevisePpal);
                Response responseDevisePpal = target.request().header("Content-Type", "application/json").header("x-api-key", apiKey).header("Authorization", "Bearer " + bearerToken).get();
                String devisePpalSymbole = responseDevisePpal.readEntity(String.class);
                request.setAttribute("devisePpalSymbole", devisePpalSymbole);
                responseDevisePpal.close();
                if (isCodePromoValid) {
                    request.setAttribute("codepromoObjStr", codepromo);
                }
                //request.setAttribute("listePhotoByRoomType", photoData);                
                getServletConfig().getServletContext().getRequestDispatcher("/rooms").forward(request, response);
            } else {
                System.out.println("rooms empty------------------- ");
                /*String message = "<span><h3 style = 'text-align: center;'>Désolé. Les tarif ne sont pas encore prêt pour ces dates.</h3></span>";
                request.setAttribute("message", message);*/
                //request.setAttribute("backgroundImage", Home.getBackgroundimage());
                getServletConfig().getServletContext().getRequestDispatcher("/erreur_info.jsp").forward(request, response);
            }
        } else {
            /*String message = "<span><h3 style = 'text-align: center;'>Désolé. Aucune chambre disponible correspond à vos critères.</h3></span>";
            request.setAttribute("message", message);*/
            //request.setAttribute("backgroundImage", Home.getBackgroundimage());
            getServletConfig().getServletContext().getRequestDispatcher("/erreur_tarif_info.jsp").forward(request, response);

        }
    }

    private String postRoomAvailability(String availableString) {
        final String urlAvailability = Util.getContextVar("api-url").concat(Constant.WS_SEARCH_AVAILABILITY);
        JsonObject availableObject = Util.stringToJsonObject(availableString);
        ResteasyClient client = new ResteasyClientBuilder().build();
        ResteasyWebTarget target = client.target(urlAvailability);
        System.out.println(Entity.json(availableObject));
        String bearerToken = Jwt.generateToken();
        Response response = target.request().header("Content-Type", "application/json").header("x-api-key", apiKey)
                .header("Authorization", "Bearer " + bearerToken).post(Entity.json(availableObject));
        // Read output in string format
        String value = response.readEntity(String.class);
        response.close();
        return value;
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
