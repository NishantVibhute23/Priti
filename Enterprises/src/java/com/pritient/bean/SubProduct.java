/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pritient.bean;

/**
 *
 * @author nishant.vibhute
 */
public class SubProduct {

    int subProductId;
    String subProductName;
    String subProductCode;
    int qty;

    public String getSubProductName() {
        return subProductName;
    }

    public void setSubProductName(String subProductName) {
        this.subProductName = subProductName;
    }

    public String getSubProductCode() {
        return subProductCode;
    }

    public void setSubProductCode(String subProductCode) {
        this.subProductCode = subProductCode;
    }

    public int getSubProductId() {
        return subProductId;
    }

    public void setSubProductId(int subProductId) {
        this.subProductId = subProductId;
    }

    public int getQty() {
        return qty;
    }

    public void setQty(int qty) {
        this.qty = qty;
    }

}
