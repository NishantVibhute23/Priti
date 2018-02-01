/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pritient.forward;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.pritient.bean.Product;
import com.pritient.bean.ProductTypeBean;
import com.pritient.bean.UOMBean;
import com.pritient.bean.dao.ProductDao;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.apache.struts2.dispatcher.SessionMap;
import org.apache.struts2.interceptor.SessionAware;
import org.codehaus.jackson.map.ObjectMapper;

/**
 *
 * @author nishant.vibhute
 */
public class ProductAction extends ActionSupport implements ModelDriven, SessionAware {

    Product product = new Product();
    ProductDao productDao = new ProductDao();
    static final org.apache.log4j.Logger errorLog = org.apache.log4j.Logger.getLogger("errorLogger");
    static final org.apache.log4j.Logger infoLog = org.apache.log4j.Logger.getLogger("infoLogger");

    private InputStream inputStream;

    List<UOMBean> uomBeanList = new ArrayList<>();
    List<ProductTypeBean> productTypeBeanList = new ArrayList<>();
    List<Product> productList = new ArrayList<>();
    int threshold;
    SessionMap<String, Object> session;

    String val;

    public ProductAction() {
    }

    public String execute() throws Exception {

        Product pr = this.getProduct();
        productDao.insertProduct(pr);
        return "success";
    }

    public String updateProduct() throws Exception {

        Product pr = this.getProduct();
        productDao.updateProduct(pr);

        System.out.println("here");
        return "success";
    }

    public String getProducts() {

        productList = productDao.getProductList();
        session.put("productList", productList);
        uomBeanList = productDao.getAllUOM();
        productTypeBeanList = productDao.getAllProductType();
        return "success";
    }

    public String updateProductThreashold() {

        productDao.updateProductThreshold(threshold);
        session.put("productThreshold", threshold);
        return "success";
    }

    public String getProductInfo() {
        try {

            this.product = productDao.getProductInfo(Integer.parseInt(val));
            ObjectMapper mapper = new ObjectMapper();
            String res = mapper.writeValueAsString(product);
            inputStream = new ByteArrayInputStream(res.getBytes(StandardCharsets.UTF_8));

        } catch (IOException ex) {
            errorLog.error("ProductAction : " + ex);
        }
        return "success";
    }

    public String saveProducts() {

//        Product p = this.getProduct();
        return "success";
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public List<UOMBean> getUomBeanList() {
        return uomBeanList;
    }

    public void setUomBeanList(List<UOMBean> uomBeanList) {
        this.uomBeanList = uomBeanList;
    }

    public List<ProductTypeBean> getProductTypeBeanList() {
        return productTypeBeanList;
    }

    public void setProductTypeBeanList(List<ProductTypeBean> productTypeBeanList) {
        this.productTypeBeanList = productTypeBeanList;
    }

    public List<Product> getProductList() {
        return productList;
    }

    public void setProductList(List<Product> productList) {
        this.productList = productList;
    }

    public String getVal() {
        return val;
    }

    public void setVal(String val) {
        this.val = val;
    }

    public InputStream getInputStream() {
        return inputStream;
    }

    public void setInputStream(InputStream inputStream) {
        this.inputStream = inputStream;
    }

    public int getThreshold() {
        return threshold;
    }

    public void setThreshold(int threshold) {
        this.threshold = threshold;
    }

    @Override
    public Object getModel() {
        return this.product;
    }

    @Override
    public void setSession(Map<String, Object> map) {
        this.session = (SessionMap<String, Object>) map;
    }
}
