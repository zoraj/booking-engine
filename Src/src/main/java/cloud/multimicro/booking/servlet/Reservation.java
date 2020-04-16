/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cloud.multimicro.booking.servlet;

import org.jboss.resteasy.client.jaxrs.ResteasyClient;
import org.jboss.resteasy.client.jaxrs.ResteasyClientBuilder;
import org.jboss.resteasy.client.jaxrs.ResteasyWebTarget;
import org.json.simple.JSONObject;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.client.Entity;
import javax.ws.rs.core.Response;
import org.json.simple.JSONArray;


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
        Reservation.postReservation();
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

    private static void postReservation() {
        ResteasyClient reservation = new ResteasyClientBuilder().build();
        ResteasyWebTarget target = reservation.target("http://localhost:8080/api/notes/pms/header");

        JSONObject resa = new JSONObject();
        resa.put("dateArrivee", "2020-05-11");
        resa.put("dateDepart", "2020-05-15");
        resa.put("description", "descript");
        resa.put("nbPax", "4");
        resa.put("nbChambre", "2");
        resa.put("nbEnfant", "3");
        resa.put("mmcClientId", "1");
        resa.put("nomNote", "resa");
        resa.put("numeroReservation", "00132");
        resa.put("pmsServiceId", "1");
        resa.put("pmsReservationTypeId", "1");
        resa.put("posActivitePosteId", "1");
        resa.put("origine", "BOOKING");

        System.out.println(Entity.json(resa));
        Response response = target.request().header("Content-Type", "application/json").header("x-api-key", "CD19FD5E87DB2FB0056168D58D24753B42CC4B9B75894632242A2E2BA257402E").header("Authorization", "Bearer 5edc790b914878af26afd0f7cc56715028420006401f2a9f4d8d238b5c2beae7").post(Entity.json(resa));
        //Read output in string format
        String value = response.readEntity(String.class);
        
        int entitieId = 1;
        JSONArray roomListArray = new JSONArray();
        JSONObject roomOne = new JSONObject();
        roomOne.put("qteChb", 3);
        roomOne.put("nbAdulte", 3);
        roomOne.put("nbEnfant", 3);
        roomListArray.add(roomOne);

        JSONObject roomTwo = new JSONObject();
        roomTwo.put("qteChb", 3);
        roomTwo.put("nbAdulte", 3);
        roomTwo.put("nbEnfant", 3);
        roomListArray.add(roomOne);

        JSONObject roomThree = new JSONObject();
        roomThree.put("qteChb", 3);
        roomThree.put("nbAdulte", 3);
        roomThree.put("nbEnfant", 3);
        roomListArray.add(roomThree);

        Reservation.postRoomVentillation(entitieId,roomListArray);
        response.close();
    }

    private static void postRoomVentillation(int entitieId,JSONArray roomListArray) {
        ResteasyClient ventillation = new ResteasyClientBuilder().build();
        JSONObject ventillationObject = new JSONObject();
        ventillationObject.put("pmsNoteEnteteId",entitieId);
        ventillationObject.put("roomList", roomListArray);
        ResteasyWebTarget target = ventillation.target("http://localhost:8080/api/notes/pms/room-ventillation");
        System.out.println(Entity.json(ventillationObject));
        Response response = target.request().header("Content-Type", "application/json").header("x-api-key", "CD19FD5E87DB2FB0056168D58D24753B42CC4B9B75894632242A2E2BA257402E").header("Authorization", "Bearer 5edc790b914878af26afd0f7cc56715028420006401f2a9f4d8d238b5c2beae7").post(Entity.json(ventillationObject));
        //Read output in string format
        String value = response.readEntity(String.class);
        response.close();
    }
}
