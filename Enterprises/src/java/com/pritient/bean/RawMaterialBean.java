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
public class RawMaterialBean {

    int productId;
    int qty;

    List<SubProduct> subProduct;

    public List<SubProduct> getSubProduct() {
        return subProduct;
    }

    public void setSubProduct(List<SubProduct> subProduct) {
        this.subProduct = subProduct;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getQty() {
        return qty;
    }

    public void setQty(int qty) {
        this.qty = qty;
    }

}
