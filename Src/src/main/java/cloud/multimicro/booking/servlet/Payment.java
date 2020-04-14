/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cloud.multimicro.booking.servlet;

import static com.sun.corba.se.spi.presentation.rmi.StubAdapter.request;
import org.json.simple.JSONObject;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.ws.rs.client.Entity;
import javax.ws.rs.core.Response;
import org.jboss.resteasy.client.jaxrs.ResteasyClient;
import org.jboss.resteasy.client.jaxrs.ResteasyClientBuilder;
import org.jboss.resteasy.client.jaxrs.ResteasyWebTarget;

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
        
        HttpSession session = request.getSession();
        session.setAttribute("mmcModeEncaissementId", "1");
        session.setAttribute("pmsNoteEnteteId", "1");
        session.setAttribute("mmcUserId", "1");
        session.setAttribute("montant", "2.3");
        
        JSONObject paiment = new JSONObject();
        paiment.put("mmcModeEncaissementId", (String) session.getAttribute("mmcModeEncaissementId"));
        paiment.put("pmsNoteEnteteId", (String) session.getAttribute("pmsNoteEnteteId"));
        paiment.put("mmcUserId", (String) session.getAttribute("mmcUserId"));
        paiment.put("montant", (String) session.getAttribute("montant"));

        Payment.postPayment(paiment);
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
        ResteasyWebTarget target = client.target("http://localhost:8080/api/cashing/pms");
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
        clientObject.put("code", "009");
        clientObject.put("nom", nom);
        clientObject.put("prenom", prenom);
        clientObject.put("adresse", adresse);
        clientObject.put("ville", ville);
        clientObject.put("codePostal", codePostal);
        clientObject.put("telephone", telephone);
        clientObject.put("email", email);
        clientObject.put("pays", pays);

        ResteasyWebTarget target = client.target("http://localhost:8080/api/clients");
        Response response = target.request().header("Content-Type", "application/json").header("x-api-key", "CD19FD5E87DB2FB0056168D58D24753B42CC4B9B75894632242A2E2BA257402E").header("Authorization", "Bearer 5edc790b914878af26afd0f7cc56715028420006401f2a9f4d8d238b5c2beae7").post(Entity.json(clientObject));
        //Read output in string format
        String value = response.readEntity(String.class);
        response.close();
    }
}
