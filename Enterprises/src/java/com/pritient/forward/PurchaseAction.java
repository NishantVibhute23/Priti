/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pritient.forward;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.pritient.bean.CompanyBean;
import com.pritient.bean.Invoice;
import com.pritient.bean.MyProfile;
import com.pritient.bean.PaymentBean;
import com.pritient.bean.SubProduct;
import com.pritient.bean.dao.CompanyAddressDao;
import com.pritient.bean.dao.InvoiceDao;
import com.pritient.bean.dao.MyProfileDao;
import com.pritient.bean.dao.ProductDao;
import com.pritient.bean.dao.PurchaseDao;
import com.pritient.util.CommonUtil;
import com.pritient.util.ConvertToPdf;
import java.io.ByteArrayInputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
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
public class PurchaseAction extends ActionSupport implements ModelDriven {

    List<CompanyBean> companyList = new ArrayList<>();
    List<SubProduct> subProductList = new ArrayList<>();
    Invoice invoice = new Invoice();
    CompanyAddressDao companyAddressDao = new CompanyAddressDao();
    ProductDao productDao = new ProductDao();
    PurchaseDao purchaseDao = new PurchaseDao();
    String successMessage = "";
    String errorMessage = "";
    private InputStream inputStream;
    String val;
    List<PaymentBean> purchaseList = new ArrayList<>();
    InvoiceDao invoiceDao = new InvoiceDao();
    MyProfileDao myProfileDao = new MyProfileDao();
    private String fileName;

    public PurchaseAction() {
    }

    public String execute() throws Exception {

        companyList = companyAddressDao.getCompanyList();
        subProductList = productDao.getAllProducts();
        return ActionSupport.SUCCESS;
    }

    public String savePurchase() throws Exception {

        int id = purchaseDao.savePurchase(this.getInvoice());

        if (id == 0) {
            errorMessage = "Failed To add Purchase Details";
        } else {
            successMessage = "Purchase Details Added Successfully";
        }
        return ActionSupport.SUCCESS;
    }

    public String deletePurchase() {

        int id = purchaseDao.deletePurchase(Integer.parseInt(val));
        if (id == 0) {
            errorMessage = "Failed To Delete Purchase";
        } else {
            successMessage = "Purchase Deleted Successfully";
        }
        return ActionSupport.SUCCESS;
    }

    public String updatePurchase() throws Exception {

        int id = purchaseDao.updatePurchase(this.getInvoice());

        if (id == 0) {
            errorMessage = "Failed To Update Purchase Details";
        } else {
            successMessage = "Purchase Details Update Successfully";
        }
        return ActionSupport.SUCCESS;
    }

    public String getPurchase() throws Exception {

        companyList = companyAddressDao.getCompanyList();
        subProductList = productDao.getAllProducts();
        this.purchaseList = purchaseDao.getAllPurchase();
        return ActionSupport.SUCCESS;
    }

    public String getPurchaseDetailsInfo() {

        try {
            Invoice invoice = purchaseDao.getPurchaseDetails(Integer.parseInt(val));
            ObjectMapper mapper = new ObjectMapper();
            String res = mapper.writeValueAsString(invoice);
            inputStream = new ByteArrayInputStream(res.getBytes(StandardCharsets.UTF_8));
        } catch (Exception ex) {
            Logger.getLogger(PurchaseAction.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ActionSupport.SUCCESS;
    }

    public String printPurchasePDF() {
        try {

            MyProfile myProfile = myProfileDao.getprofileDetails();
            Invoice invoice = purchaseDao.getPurchaseDetails(Integer.parseInt(val));
            CompanyBean companyBean = companyAddressDao.getCompanyDetails(invoice.getBillTO());
            String out = ConvertToPdf.convertPurchase(invoice, myProfile, companyBean);
            String path = CommonUtil.getResourceProperties("application.address");
            inputStream = new ByteArrayInputStream(path.getBytes(StandardCharsets.UTF_8));

        } catch (Exception ex) {
            Logger.getLogger(AddressBookAction.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ActionSupport.SUCCESS;
    }

    public String getPurchasePdfFile() {
        try {

            this.setFileName("File.pdf");
//            inputStream = new FileInputStream(CommonUtil.getPath() + "\\pdf.pdf");
            inputStream = new FileInputStream(CommonUtil.directoryPath + "pdf.pdf");
        } catch (FileNotFoundException ex) {
            Logger.getLogger(InvoiceAction.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ActionSupport.SUCCESS;
    }

    public List<CompanyBean> getCompanyList() {
        return companyList;
    }

    public void setCompanyList(List<CompanyBean> companyList) {
        this.companyList = companyList;
    }

    public List<SubProduct> getSubProductList() {
        return subProductList;
    }

    public void setSubProductList(List<SubProduct> subProductList) {
        this.subProductList = subProductList;
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

    public Invoice getInvoice() {
        return invoice;
    }

    public void setInvoice(Invoice invoice) {
        this.invoice = invoice;
    }

    public List<PaymentBean> getPurchaseList() {
        return purchaseList;
    }

    public void setPurchaseList(List<PaymentBean> purchaseList) {
        this.purchaseList = purchaseList;
    }

    public InputStream getInputStream() {
        return inputStream;
    }

    public void setInputStream(InputStream inputStream) {
        this.inputStream = inputStream;
    }

    public String getVal() {
        return val;
    }

    public void setVal(String val) {
        this.val = val;
    }

    @Override
    public Object getModel() {
        return invoice;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

}
