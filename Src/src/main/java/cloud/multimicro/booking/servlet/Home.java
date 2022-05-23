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
import javax.json.JsonNumber;
import java.util.*;
import java.math.BigDecimal;
import javax.json.stream.JsonParsingException;
import javax.servlet.http.HttpSession;

/**
 *
 * @author zo
 */
@WebServlet(name = "Home", urlPatterns = {"/"})
public class Home extends HttpServlet {

    private static String apiKey;
    private static String token;
    private static String backgroundimage;
    private String roomRequested;

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

        apiKey = getApiKeyBySiteName(establishmentName);
        JsonObject apikeyObject = stringToJsonObject(apiKey);
        apiKey = apikeyObject.getString("apiKey");
        Home.setApiKey(apiKey);

        //String backgroundImage = getBackGroundImage();
        //JsonObject backgroundImageObject = stringToJsonObject(backgroundImage);
        //Home.setBackgroundimage(backgroundImageObject.getString("valeur"));
        //request.setAttribute("backgroundImage", backgroundImageObject.getString("valeur"));
        processRequest(request, response);

    }

    private static String getApiKeyBySiteName(String establishmentName) {
        System.out.println("Jwt.generateToken()" + Jwt.generateToken());
        ResteasyClient client = new ResteasyClientBuilder().build();
        ResteasyWebTarget target = client.target(Util.getContextVar("e-api-url").concat(Constant.WS_GET_NAME_SITE + establishmentName));
        System.out.println("target_target" + target);
        //System.out.println("Jwt.generateToken()"+Jwt.generateToken());
        String bearerToken = Jwt.generateToken();

        Home.setToken(bearerToken);
        Response response = target.request().header("Authorization", "Bearer " + bearerToken).get();
        // Read output in string format
        String value = response.readEntity(String.class);
        System.out.println("value : " + value);
        response.close();
        return value;
    }

    private static String getBackGroundImage() {
        final String urlgetbackgroundimage = Util.getContextVar("api-url").concat(Constant.WS_GET_BACKGROUND_IMAGE);
        ResteasyClient client = new ResteasyClientBuilder().build();
        ResteasyWebTarget target = client.target(urlgetbackgroundimage);
        String bearerToken = Jwt.generateToken();
        Response response = target.request().header("Content-Type", "application/json").header("x-api-key", apiKey)
                .header("Authorization", "Bearer " + bearerToken).get();
        // Read output in string format
        String value = response.readEntity(String.class);
        System.out.println("value Image retourné : " + value);
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
            List<RoomsPhotoData> photoData = new ArrayList<RoomsPhotoData>();
            for (int i = 0; i < jsonArray.size(); i++) {
                DataBooking dataBooking = new DataBooking();

                JsonObject jsonLigne = jsonArray.getJsonObject(i);
                dataBooking.setPmsTypeChambreId(jsonLigne.getInt("pmsTypeChambreId"));
                dataBooking.setPersMin(jsonLigne.getInt("persMin"));
                dataBooking.setPersMax(jsonLigne.getInt("persMax"));
                dataBooking.setTypeChambre(jsonLigne.getString("typeChambre"));
                dataBooking.setNbChild(jsonLigne.getInt("nbChild"));
                dataBooking.setQteTotal(jsonLigne.getInt("qteTotal"));
                dataBooking.setQteDispo(jsonLigne.getInt("qteDispo"));
                JsonArray jsonTarifArray = jsonLigne.getJsonArray("tarif");
                for (int j = 0; j < jsonTarifArray.size(); j++) {
                    DataBooking data = new DataBooking(dataBooking);
                    JsonObject jsonTarif = jsonTarifArray.getJsonObject(j);
                    data.setTypeTarifId(jsonTarif.getInt("typeTarifId"));
                    data.setAmount(Double.parseDouble(jsonTarif.get("amount").toString()));
                    data.setTypeTarifLibelle(jsonTarif.getString("typeTarifLibelle"));
                    data.setPmsTarifGrilleDetailId(jsonTarif.getInt("pmsTarifGrilleDetailId"));
                    rooms.add(data);
                }
                JsonArray jsonPhotoArray = jsonLigne.getJsonArray("roomPhoto");
                for (int k = 0; k < jsonPhotoArray.size(); k++) {
                    String listPhoto = "";                    
                    JsonObject jsonPhoto = jsonPhotoArray.getJsonObject(k);
                    String dataSrc = jsonPhoto.getString("data");
                    if (k == 0){
                        listPhoto += "<div class='item active'><img src='"+dataSrc+"' height = '400' width = '400'></div>";
                    }else {
                        listPhoto += "<div class='item'><img src='"+dataSrc+"' height = '400' width = '400'></div>";
                    }
                    RoomsPhotoData img = new RoomsPhotoData();
                    img.setListePhotoByRoomType(listPhoto);
                    photoData.add(img);
                }
            }

            if (rooms.size() > 0) {
                request.setAttribute("listRooms", rooms);
                request.setAttribute("listePhotoByRoomType", photoData);
                getServletConfig().getServletContext().getRequestDispatcher("/rooms").forward(request, response);
            } else {
                /*String message = "<span><h3 style = 'text-align: center;'>Désolé. Les tarif ne sont pas encore prêt pour ces dates.</h3></span>";
                request.setAttribute("message", message);*/
                request.setAttribute("backgroundImage", Home.getBackgroundimage());
                getServletConfig().getServletContext().getRequestDispatcher("/erreur_info.jsp").forward(request, response);
            }
        } else {
            /*String message = "<span><h3 style = 'text-align: center;'>Désolé. Aucune chambre disponible correspond à vos critères.</h3></span>";
            request.setAttribute("message", message);*/
            request.setAttribute("backgroundImage", Home.getBackgroundimage());
            getServletConfig().getServletContext().getRequestDispatcher("/erreur_tarif_info.jsp").forward(request, response);

        }
    }

    private String postRoomAvailability(String availableString) {
        final String urlAvailability = Util.getContextVar("api-url").concat(Constant.WS_SEARCH_AVAILABILITY);
        JsonObject availableObject = stringToJsonObject(availableString);
        ResteasyClient client = new ResteasyClientBuilder().build();
        ResteasyWebTarget target = client.target(urlAvailability);
        System.out.println(Entity.json(availableObject));
        String bearerToken = Jwt.generateToken();
        Response response = target.request().header("Content-Type", "application/json").header("x-api-key", apiKey)
                .header("Authorization", "Bearer " + bearerToken).post(Entity.json(availableObject));
        // Read output in string format
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

    public static String getBackgroundimage() {
        return backgroundimage;
    }

    public static void setBackgroundimage(String value) {
        backgroundimage = value;
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
