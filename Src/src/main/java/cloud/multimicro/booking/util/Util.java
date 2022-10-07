/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package cloud.multimicro.booking.util;

import java.io.StringReader;
import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonReader;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;


/**
 *
 * @author zo 
 */
public class Util {
   public static String getContextVar(String lookupString) {
      String contextVar = null;
      try {
         Context context = new InitialContext();
         Context env = (Context) context.lookup("java:comp/env");
         contextVar = (String) env.lookup(lookupString);
      }
      catch(NamingException e) {
         e.printStackTrace();
      }
      return contextVar;  
   }
   
    public static String getEnvString(String key) {
        String result = "";
        try {
            Context context = new InitialContext();
            Context env = (Context) context.lookup("java:comp/env");

            result = (String) env.lookup(key);
            return result;
        } catch (NamingException e) {
            //todo: handle exception
        }
        return result;
    }
    
    public static JsonObject stringToJsonObject(String jsonString) {
        JsonReader jsonReader = Json.createReader(new StringReader(jsonString));
        JsonObject object = jsonReader.readObject();
        jsonReader.close();
        return object;
    }    
}


