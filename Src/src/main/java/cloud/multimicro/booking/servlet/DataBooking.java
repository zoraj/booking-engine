/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package cloud.multimicro.booking.servlet;

import java.math.BigDecimal;
import java.util.List;
/**
 *
 * @author Naly
 */
public class DataBooking {
    
    private String typeChambreLibelle;
    private Integer availableRoom;
    private Integer totalRoom;
    private Integer nbAdulte;
    private BigDecimal prixParDefaut;
    private List<String> tarifOptionLibelle;

    public DataBooking() {
        
    }
    
    public String getTypeChambreLibelle() {
        return typeChambreLibelle;
    }

    public void setTypeChambreLibelle(String typeChambreLibelle) {
        this.typeChambreLibelle = typeChambreLibelle;
    }

    public int getAvailableRoom() {
        return availableRoom;
    }

    public void setAvailableRoom(int availableRoom) {
        this.availableRoom = availableRoom;
    }

    public BigDecimal getPrixParDefaut() {
        return prixParDefaut;
    }

    public void setPrixParDefaut(BigDecimal prixParDefaut) {
        this.prixParDefaut = prixParDefaut;
    }

    public int getTotalRoom() {
        return totalRoom;
    }

    public void setTotalRoom(int totalRoom) {
        this.totalRoom = totalRoom;
    }

    public int getNbAdulte() {
        return nbAdulte;
    }

    public void setNbAdulte(int nbAdulte) {
        this.nbAdulte = nbAdulte;
    }

    public List<String> getTarifOptionLibelle() {
        return tarifOptionLibelle;
    }

    public void setTarifOptionLibelle(List<String> tarifOptionLibelle) {
        this.tarifOptionLibelle = tarifOptionLibelle;
    }

}
