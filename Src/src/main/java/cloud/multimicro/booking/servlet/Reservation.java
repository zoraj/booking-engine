/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cloud.multimicro.booking.servlet;
import org.jboss.resteasy.client.jaxrs.ResteasyClient;
import org.jboss.resteasy.client.jaxrs.ResteasyClientBuilder;
import org.jboss.resteasy.client.jaxrs.ResteasyWebTarget;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.client.Entity;
import javax.ws.rs.core.Response;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.codehaus.jettison.json.JSONArray;

/**
 *
 * @author zo
 */
@WebServlet(name = "Reservation", urlPatterns = {"/reservation"})
public class Reservation extends HttpServlet {

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
        getServletConfig().getServletContext().getRequestDispatcher("/reservation.jsp").forward(request, response);
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
        String roomData = request.getParameter("room-list-id");
        String resaData = request.getParameter("reservation-id");
       // Reservation.postReservation(resaData, roomData);
        Reservation.postRoomVentillation(1, roomData);
        processRequest(request, response);
    }

    private static JSONArray stringToJsonArray(String value) {
        JSONArray jsonArray = null;
        try {
            jsonArray = new JSONArray(value);
        } catch (JSONException ex) {
            Logger.getLogger(Reservation.class.getName()).log(Level.SEVERE, null, ex);
        }
        return jsonArray;
    }

    private static JSONObject stringToJsonObject(String value){
        JSONObject jsonObject = null;
        try {
            jsonObject = new JSONObject(value);
        } catch (JSONException ex) {
            Logger.getLogger(Reservation.class.getName()).log(Level.SEVERE, null, ex);
        }
        return jsonObject;
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

    private static void postReservation(String resa, String roomListArray) {
        System.out.println(" string " + resa);
        JSONObject resaJSONObject = Reservation.stringToJsonObject(resa);
        ResteasyClient reservation = new ResteasyClientBuilder().build();
        ResteasyWebTarget target = reservation.target("http://localhost:8080/api/notes/pms/header");
        System.out.println(" json " + Entity.json(resaJSONObject));
        Response response = target.request().header("Content-Type", "application/json").header("x-api-key", "CD19FD5E87DB2FB0056168D58D24753B42CC4B9B75894632242A2E2BA257402E").header("Authorization", "Bearer 5edc790b914878af26afd0f7cc56715028420006401f2a9f4d8d238b5c2beae7").post(Entity.json(resaJSONObject));
        //Read output in string format
        String value = response.readEntity(String.class);
        JSONObject noteEntete = null;
        try {
            noteEntete = new JSONObject(value);
        } catch (JSONException ex) {
            Logger.getLogger(Reservation.class.getName()).log(Level.SEVERE, null, ex);
        }
       Reservation.postRoomVentillation(entitieId, roomListArray);
        response.close();

    }

    private static void postRoomVentillation(Integer entitieId, String roomList) {
        JSONArray roomListArray = stringToJsonArray(roomList);
        ResteasyClient ventillation = new ResteasyClientBuilder().build();
        JSONObject ventillationObject = new JSONObject();
        try {
            ventillationObject.put("pmsNoteEnteteId", entitieId);
        } catch (JSONException ex) {
            Logger.getLogger(Reservation.class.getName()).log(Level.SEVERE, null, ex);
        }
        try {
            ventillationObject.put("roomList", roomListArray);
        } catch (JSONException ex) {
            Logger.getLogger(Reservation.class.getName()).log(Level.SEVERE, null, ex);
        }
        ResteasyWebTarget target = ventillation.target("http://localhost:8080/api/notes/pms/room-ventillation");
        System.out.println(" ventillationObject " + Entity.json(ventillationObject));
        Response response = target.request().header("Content-Type", "application/json").header("x-api-key", "CD19FD5E87DB2FB0056168D58D24753B42CC4B9B75894632242A2E2BA257402E").header("Authorization", "Bearer 5edc790b914878af26afd0f7cc56715028420006401f2a9f4d8d238b5c2beae7").post(Entity.json(ventillationObject));
        //Read output in string format
        String value = response.readEntity(String.class);
        response.close();

    }
}
