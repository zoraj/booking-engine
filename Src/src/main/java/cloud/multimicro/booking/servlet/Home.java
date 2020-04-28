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

import javax.ws.rs.client.Entity;
import java.io.StringReader;
import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonReader;
/**
 *
 * @author zo
 */
@WebServlet(name = "Home", urlPatterns = {"/home"})
public class Home extends HttpServlet {

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
        Home.getApiKeyBySite(codeSite);
        System.out.println(" codeSite : "+codeSite);
       
    }
    
    private static void getApiKeyBySite(String codeSite){
        ResteasyClient client = new ResteasyClientBuilder().build();
        ResteasyWebTarget target = client.target("http://localhost:8080/e/api/sites/?code="+codeSite);
        String bearerToken = Jwt.generateToken();
        Response response = target.request().header("Authorization", "Bearer " + bearerToken).get();
        //Read output in string format
        String value = response.readEntity(String.class);
        System.out.println("value : "+value);
        response.close();
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
         System.out.println(" roomRequested : ");
        System.out.println(" roomRequested : "+roomRequested);
        Home.postRoomAvailability(roomRequested);
        processRequest(request, response);
    }
    
    private static void postRoomAvailability(String availableString) {
        JsonObject availableObject = stringToJsonObject(availableString);
        ResteasyClient client = new ResteasyClientBuilder().build();
        ResteasyWebTarget target = client.target(Constant.WS_SEARCH_AVAILABILITY);
        System.out.println(Entity.json(availableObject));
        Response response = target.request().header("Content-Type", "application/json").header("x-api-key", "CD19FD5E87DB2FB0056168D58D24753B42CC4B9B75894632242A2E2BA257402E").header("Authorization", "Bearer 5edc790b914878af26afd0f7cc56715028420006401f2a9f4d8d238b5c2beae7").post(Entity.json(availableObject));
        //Read output in string format
        String value = response.readEntity(String.class);
        System.out.println("value disponibilite  retourné ****************: "+value);
        response.close();
    }

    private static JsonObject stringToJsonObject(String jsonString) {
        JsonReader jsonReader = Json.createReader(new StringReader(jsonString));
        JsonObject object = jsonReader.readObject();
        jsonReader.close();
        return object;
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
