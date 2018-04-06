/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pritient.bean;

import java.util.List;

/**
 *
 * @author nishant.vibhute
 */
public class Product {

    int id;
    String mainProductName;
    String mainProductHSN;
    String mainProductUOM;
    String mainProductUOMName;
    String mainProductType;
    String mainProductTypeName;
    double price;
    String qty;

    List<SubProduct> subProductList;

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getMainProductName() {
        return mainProductName;
    }

    public void setMainProductName(String mainProductName) {
        this.mainProductName = mainProductName;
    }

    public List<SubProduct> getSubProductList() {
        return subProductList;
    }

    public void setSubProductList(List<SubProduct> subProductList) {
        this.subProductList = subProductList;
    }

    public String getMainProductHSN() {
        return mainProductHSN;
    }

    public void setMainProductHSN(String mainProductHSN) {
        this.mainProductHSN = mainProductHSN;
    }

    public String getMainProductType() {
        return mainProductType;
    }

    public void setMainProductType(String mainProductType) {
        this.mainProductType = mainProductType;
    }

    public String getMainProductUOM() {
        return mainProductUOM;
    }

    public void setMainProductUOM(String mainProductUOM) {
        this.mainProductUOM = mainProductUOM;
    }

    public String getMainProductUOMName() {
        return mainProductUOMName;
    }

    public void setMainProductUOMName(String mainProductUOMName) {
        this.mainProductUOMName = mainProductUOMName;
    }

    public String getMainProductTypeName() {
        return mainProductTypeName;
    }

    public void setMainProductTypeName(String mainProductTypeName) {
        this.mainProductTypeName = mainProductTypeName;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getQty() {
        return qty;
    }

    public void setQty(String qty) {
        this.qty = qty;
    }

}
