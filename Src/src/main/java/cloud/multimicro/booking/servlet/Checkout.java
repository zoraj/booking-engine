/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cloud.multimicro.booking.servlet;

import com.google.gson.Gson;
import com.google.gson.annotations.SerializedName;
import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.PaymentIntent;
import com.stripe.param.PaymentIntentCreateParams;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.stream.Collectors;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.jboss.logging.Logger;

/**
 *
 * @author Tsiory-PC
 */
@WebServlet(name = "Checkout", urlPatterns = {"/create-payment-intent"})
public class Checkout extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(Checkout.class);
    
    private static Gson gson = new Gson();

    static class CreatePayment {
      @SerializedName("items")
      Object[] items;

      public Object[] getItems() {
        return items;
      }
    }

    static class CreatePaymentResponse {
      private String clientSecret;
      public CreatePaymentResponse(String clientSecret) {
        this.clientSecret = clientSecret;
      }
    }

    static int calculateOrderAmount(Object[] items) {
      // Replace this constant with a calculation of the order's amount
      // Calculate the order total on the server to prevent
      // people from directly manipulating the amount on the client
      return 0;
    }
  
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //response.setContentType("text/html;charset=UTF-8");
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
        try { 
            //Stripe.apiKey = "sk_test_51Kxp7TCm1ZvhCV0Apzl31cqHgsg3DIF8p9TOYKSw2EyvEpFcuEZ6rUJB1ltY4wnPl2FFe5AaFJsVoIhy9weE3g9v00YXIeb4pl";
            Stripe.apiKey = Home.getPrivateApiKeyStripe();
            String montant = Payment.getMontantTTC();
            int amount = Integer.parseInt(montant);
            //CreatePayment postBody = gson.fromJson(request.getReader().lines().collect(Collectors.joining(System.lineSeparator())), CreatePayment.class);
            CreatePayment postBody = gson.fromJson("{\"items\":[{\"id\":\"xl-tshirt\"}]}", CreatePayment.class);
            int sumAmount = (amount * 100) + calculateOrderAmount(postBody.getItems());
            PaymentIntentCreateParams params =
                    PaymentIntentCreateParams.builder()
                            .setAmount(new Long(sumAmount))
                            .setCurrency("usd")
                            .setAutomaticPaymentMethods(
                                    PaymentIntentCreateParams.AutomaticPaymentMethods
                                            .builder()
                                            .setEnabled(true)
                                            .build()
                            )
                            .build();
            // Create a PaymentIntent with the order amount and currency
            PaymentIntent paymentIntent = PaymentIntent.create(params);
            CreatePaymentResponse paymentResponse = new CreatePaymentResponse(paymentIntent.getClientSecret());
            PrintWriter out = response.getWriter();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            out.print(gson.toJson(paymentResponse));
            out.flush();
        } catch (StripeException ex) {
            LOGGER.info(ex);
        }
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
