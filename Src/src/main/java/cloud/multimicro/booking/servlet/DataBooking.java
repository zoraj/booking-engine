/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package cloud.multimicro.booking.servlet;

import java.util.List;
/**
 *
 * @author Naly
 */

public class DataBooking {
    private Integer qteDispo;
    private String typeChambre;
    private Integer qteTotal;
    private Integer pmsTypeChambreId;
    private Integer nbChild;
    private Integer persMin;
    private Integer persMax;
    private Integer typeTarifId;
    private String typeTarifLibelle;
    private Double amount;
    private Integer pmsTarifGrilleDetailId;
    private List<String> listePhotoByRoomType;
    private Integer base;

    public DataBooking() {
        
    }

    public DataBooking(DataBooking data) {
        this.qteDispo = data.getQteDispo();
        this.typeChambre = data.getTypeChambre();
        this.qteTotal = data.getQteTotal();
        this.pmsTypeChambreId = data.getPmsTypeChambreId();
        this.nbChild = data.getNbChild();
        this.persMin = data.getPersMin();
        this.persMax = data.getPersMax();
        this.listePhotoByRoomType = data.getListePhotoByRoomType();
    }
    
    public Integer getPmsTypeChambreId() {
        return pmsTypeChambreId;
    }

    public void setPmsTypeChambreId(Integer pmsTypeChambreId) {
        this.pmsTypeChambreId = pmsTypeChambreId;
    }    

    public String getTypeChambre() {
        return typeChambre;
    }

    public void setTypeChambre(String typeChambre) {
        this.typeChambre = typeChambre;
    }    

    public Integer getQteDispo() {
        return qteDispo;
    }

    public void setQteDispo(Integer qteDispo) {
        this.qteDispo = qteDispo;
    }

    public Integer getQteTotal() {
        return qteTotal;
    }

    public void setQteTotal(Integer qteTotal) {
        this.qteTotal = qteTotal;
    }

    public int getNbChild() {
        return nbChild;
    }

    public void setNbChild(Integer nbChild) {
        this.nbChild = nbChild;
    }
    
    public int getPersMin() {
        return persMin;
    }

    public void setPersMin(Integer persMin) {
        this.persMin = persMin;
    }

    public Integer getPersMax() {
        return persMax;
    }

    public void setPersMax(Integer persMax) {
        this.persMax = persMax;
    }


    public int getTypeTarifId() {
        return typeTarifId;
    }

    public void setTypeTarifId(Integer typeTarifId) {
        this.typeTarifId = typeTarifId;
    }
    
    public String getTypeTarifLibelle() {
        return typeTarifLibelle;
    }

    public void setTypeTarifLibelle(String typeTarifLibelle) {
        this.typeTarifLibelle = typeTarifLibelle;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    public Integer getPmsTarifGrilleDetailId(){
        return pmsTarifGrilleDetailId;
    }

    public void setPmsTarifGrilleDetailId(Integer pmsTarifGrilleDetailId){
        this.pmsTarifGrilleDetailId = pmsTarifGrilleDetailId;
    }

    public List<String> getListePhotoByRoomType() {
        return listePhotoByRoomType;
    }

    public void setListePhotoByRoomType(List<String> listePhotoByRoomType) {
        this.listePhotoByRoomType = listePhotoByRoomType;
    }

    public Integer getBase() {
        return base;
    }

    public void setBase(Integer base) {
        this.base = base;
    }
    
}
