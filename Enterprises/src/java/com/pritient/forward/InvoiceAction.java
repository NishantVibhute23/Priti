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
import com.pritient.bean.Product;
import com.pritient.bean.SubProduct;
import com.pritient.bean.dao.CompanyAddressDao;
import com.pritient.bean.dao.InvoiceDao;
import com.pritient.bean.dao.MyProfileDao;
import com.pritient.bean.dao.ProductDao;
import com.pritient.util.CommonUtil;
import com.pritient.util.ConvertToPdf;
import java.io.ByteArrayInputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import org.codehaus.jackson.map.ObjectMapper;

/**
 *
 * @author nishant.vibhute
 */
public class InvoiceAction extends ActionSupport implements ModelDriven {

    Invoice invoice = new Invoice();
    private InputStream fileInputStream;
    private String fileName;

    String successMessage = "";
    String errorMessage = "";

    List<CompanyBean> companyList = new ArrayList<>();
    List<SubProduct> subProductList = new ArrayList<>();
    CompanyAddressDao companyAddressDao = new CompanyAddressDao();
    ProductDao productDao = new ProductDao();
    InvoiceDao invoiceDao = new InvoiceDao();
    MyProfileDao myProfileDao = new MyProfileDao();
    List<MyProfile> myProfileList = new ArrayList<>();
    List<PaymentBean> invoiceList = new ArrayList<>();
    String val;
    int latestInvoiceNumber;
    String latestInvoiceNum;
    String filePath;
    int prodId;
    int docId;
    int compId;
    private InputStream inputStream;
    static final org.apache.log4j.Logger errorLog = org.apache.log4j.Logger.getLogger("errorLogger");
    static final org.apache.log4j.Logger infoLog = org.apache.log4j.Logger.getLogger("infoLogger");

    public String execute() throws Exception {

        companyList = companyAddressDao.getCompanyList();
        subProductList = productDao.getAllProducts();
        MyProfile myProfile = myProfileDao.getprofileDetails();
        myProfileList.add(myProfile);

        latestInvoiceNumber = invoiceDao.getLatestInvoiceNumber();
        int year = Calendar.getInstance().get(Calendar.YEAR);
//        latestInvoiceNum = latestInvoiceNumber + "/" + year + "-" + (year + 1);
        latestInvoiceNum = latestInvoiceNumber + "";
        return ActionSupport.SUCCESS;
    }

    public String saveInvoiceAction() throws Exception {

//        MyProfile myProfile = myProfileDao.getprofileDetails();
//        String out = ConvertToPdf.convert(invoice, myProfile);
//        inputStream = new ByteArrayInputStream(out.getBytes(StandardCharsets.UTF_8));
        int id = invoiceDao.insertInvoice(this.getInvoice());
        if (id == 0) {
            errorMessage = "Failed To add Invoice";
        } else {
            successMessage = "Invoice Added Successfully";
        }
        return ActionSupport.SUCCESS;
    }

    public String updateInvoiceAction() throws Exception {

//        MyProfile myProfile = myProfileDao.getprofileDetails();
//        String out = ConvertToPdf.convert(invoice, myProfile);
//        inputStream = new ByteArrayInputStream(out.getBytes(StandardCharsets.UTF_8));
        int id = invoiceDao.updateInvoice(this.getInvoice());
        if (id == 0) {
            errorMessage = "Failed To update Invoice";
        } else {
            successMessage = "Invoice Updated Successfully";
        }
        return ActionSupport.SUCCESS;
    }

    public String getInvoices() {

//        Invoice invoice = invoiceDao.getInvoiceDetails(1);
        companyList = companyAddressDao.getCompanyList();
        subProductList = productDao.getAllProducts();
        this.invoiceList = invoiceDao.getAllInvoice();

        return ActionSupport.SUCCESS;
    }

    public String deleteInvoice() {

        int id = invoiceDao.deleteInvoice(Integer.parseInt(val));
        if (id == 0) {
            errorMessage = "Failed To Delete Invoice";
        } else {
            successMessage = "Invoice Deleted Successfully";
        }
        return ActionSupport.SUCCESS;
    }

    public String getInvoiceDetailsInfo() {
        try {

            Invoice invoice = invoiceDao.getInvoiceDetails(Integer.parseInt(val));
            ObjectMapper mapper = new ObjectMapper();
            String res = mapper.writeValueAsString(invoice);
            inputStream = new ByteArrayInputStream(res.getBytes(StandardCharsets.UTF_8));

        } catch (IOException ex) {
            errorLog.error("InvoiceAction : " + ex);
        }
        return ActionSupport.SUCCESS;
    }

    public String printInvoice() {
        try {

            MyProfile myProfile = myProfileDao.getprofileDetails();

            String out = ConvertToPdf.convert(invoice, myProfile);
            String path = CommonUtil.getResourceProperties("application.address");
            inputStream = new ByteArrayInputStream(path.getBytes(StandardCharsets.UTF_8));

        } catch (Exception ex) {
            errorLog.error("InvoiceAction : " + ex);
        }
        return ActionSupport.SUCCESS;
    }

    public String printInvoicePDF() {
        try {

            MyProfile myProfile = myProfileDao.getprofileDetails();
            Invoice invoice = invoiceDao.getInvoiceDetails(Integer.parseInt(val));
            String out = ConvertToPdf.convert(invoice, myProfile);
            String path = CommonUtil.getResourceProperties("application.address");
            inputStream = new ByteArrayInputStream(path.getBytes(StandardCharsets.UTF_8));

        } catch (Exception ex) {
            errorLog.error("InvoiceAction : " + ex);
        }
        return ActionSupport.SUCCESS;
    }

    public String getPdf() {
        try {

            this.setFileName("File.pdf");
//            inputStream = new FileInputStream(CommonUtil.getPath() + "\\pdf.pdf");
            inputStream = new FileInputStream(CommonUtil.directoryPath + "pdf.pdf");
        } catch (FileNotFoundException ex) {
            errorLog.error("InvoiceAction : " + ex);
        }
        return ActionSupport.SUCCESS;
    }

    public String getUOMandHSN() {
        try {

            int id = this.getProdId();
            Product product = invoiceDao.getUOMAndHSN(id);

            ObjectMapper mapper = new ObjectMapper();
            String res = mapper.writeValueAsString(product);
            inputStream = new ByteArrayInputStream(res.getBytes(StandardCharsets.UTF_8));

        } catch (Exception ex) {
            errorLog.error("InvoiceAction : " + ex);
        }
        return ActionSupport.SUCCESS;
    }

    public String getUOMandHSNAndPrice() {
        try {

            int id = this.getProdId();
            int compId = this.getCompId();

            Product product = invoiceDao.getUOMAndHSNAndPrice(id, compId);

            ObjectMapper mapper = new ObjectMapper();
            String res = mapper.writeValueAsString(product);
            inputStream = new ByteArrayInputStream(res.getBytes(StandardCharsets.UTF_8));

        } catch (Exception ex) {
            errorLog.error("InvoiceAction : " + ex);
        }
        return ActionSupport.SUCCESS;
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

    public int getDocId() {
        return docId;
    }

    public void setDocId(int docId) {
        this.docId = docId;
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

    public InputStream getInputStream() {
        return inputStream;
    }

    public void setInputStream(InputStream inputStream) {
        this.inputStream = inputStream;
    }

    public InputStream getFileInputStream() {
        return fileInputStream;
    }

    public void setFileInputStream(InputStream fileInputStream) {
        this.fileInputStream = fileInputStream;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public List<MyProfile> getMyProfileList() {
        return myProfileList;
    }

    public void setMyProfileList(List<MyProfile> myProfileList) {
        this.myProfileList = myProfileList;
    }

    public int getLatestInvoiceNumber() {
        return latestInvoiceNumber;
    }

    public void setLatestInvoiceNumber(int latestInvoiceNumber) {
        this.latestInvoiceNumber = latestInvoiceNumber;
    }

    public List<PaymentBean> getInvoiceList() {
        return invoiceList;
    }

    public void setInvoiceList(List<PaymentBean> invoiceList) {
        this.invoiceList = invoiceList;
    }

    public String getVal() {
        return val;
    }

    public void setVal(String val) {
        this.val = val;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public Invoice getInvoice() {
        return invoice;
    }

    public void setInvoice(Invoice invoice) {
        this.invoice = invoice;
    }

    public int getProdId() {
        return prodId;
    }

    public void setProdId(int prodId) {
        this.prodId = prodId;
    }

    @Override
    public Object getModel() {
        return invoice;
    }

    public int getCompId() {
        return compId;
    }

    public void setCompId(int compId) {
        this.compId = compId;
    }

    public String getLatestInvoiceNum() {
        return latestInvoiceNum;
    }

    public void setLatestInvoiceNum(String latestInvoiceNum) {
        this.latestInvoiceNum = latestInvoiceNum;
    }

}
