/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pritient.forward;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.pritient.bean.Product;
import com.pritient.bean.RawMaterialBean;
import com.pritient.bean.SubProduct;
import com.pritient.bean.dao.InvoiceDao;
import com.pritient.bean.dao.ProductDao;
import com.pritient.bean.dao.RawMaterialDao;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.codehaus.jackson.map.ObjectMapper;

/**
 *
 * @author nishant.vibhute
 */
public class RawMaterialAction extends ActionSupport implements ModelDriven {

    RawMaterialBean rawMaterialBean = new RawMaterialBean();
    List<SubProduct> subProductList = new ArrayList<>();
    List<SubProduct> rawProductList = new ArrayList<>();
    RawMaterialDao rawMaterialDao = new RawMaterialDao();
    InvoiceDao invoiceDao = new InvoiceDao();
    ProductDao productDao = new ProductDao();
    private InputStream inputStream;
    public int prodId;
    String successMessage = "";
    String errorMessage = "";

    @Override
    public String execute() {

        rawProductList = rawMaterialDao.getRawProducts();
        subProductList = productDao.getAllProducts();
        return ActionSupport.SUCCESS;
    }

    public String getUOMandQty() {

        try {
            int id = this.getProdId();
            Product product = invoiceDao.getUOMAndHSN(id);

            ObjectMapper mapper = new ObjectMapper();
            String res = mapper.writeValueAsString(product);
            inputStream = new ByteArrayInputStream(res.getBytes(StandardCharsets.UTF_8));

        } catch (Exception ex) {
            Logger.getLogger(AddressBookAction.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ActionSupport.SUCCESS;
    }

    public String saveRawMaterial() {

        try {

            int id = rawMaterialDao.saveRawMaterial(this.getRawMaterialBean());

            if (id == 0) {
                errorMessage = "Failed To add raw material";
            } else {
                successMessage = "Raw Material Updated Successfully";
            }

        } catch (Exception ex) {
            Logger.getLogger(AddressBookAction.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ActionSupport.SUCCESS;
    }

    public int getProdId() {
        return prodId;
    }

    public void setProdId(int prodId) {
        this.prodId = prodId;
    }

    public List<SubProduct> getSubProductList() {
        return subProductList;
    }

    public void setSubProductList(List<SubProduct> subProductList) {
        this.subProductList = subProductList;
    }

    public InputStream getInputStream() {
        return inputStream;
    }

    public void setInputStream(InputStream inputStream) {
        this.inputStream = inputStream;
    }

    public String getSuccessMessage() {
        return successMessage;
    }

    public void setSuccessMessage(String successMessage) {
        this.successMessage = successMessage;
    }

    public String getErrorMessage() {
        return errorMessage;
    }

    public void setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
    }

    public List<SubProduct> getRawProductList() {
        return rawProductList;
    }

    public void setRawProductList(List<SubProduct> rawProductList) {
        this.rawProductList = rawProductList;
    }

    public RawMaterialBean getRawMaterialBean() {
        return rawMaterialBean;
    }

    public void setRawMaterialBean(RawMaterialBean rawMaterialBean) {
        this.rawMaterialBean = rawMaterialBean;
    }

    @Override
    public Object getModel() {
        return rawMaterialBean;
    }

}
