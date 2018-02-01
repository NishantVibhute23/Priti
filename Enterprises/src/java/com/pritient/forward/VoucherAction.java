/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pritient.forward;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.pritient.bean.CompanyBean;
import com.pritient.bean.PaymentBean;
import com.pritient.bean.dao.CompanyAddressDao;
import com.pritient.bean.dao.PaymentDao;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.codehaus.jackson.map.ObjectMapper;

/**
 *
 * @author nishant.vibhute
 */
public class VoucherAction extends ActionSupport implements ModelDriven {

    String val;
    List<PaymentBean> purchase = new ArrayList<>();
    List<PaymentBean> invoice = new ArrayList<>();
    PaymentDao paymentDao = new PaymentDao();
    String successMessage = "";
    String errorMessage = "";
    PaymentBean paymentBean = new PaymentBean();
    List<CompanyBean> companyList = new ArrayList<>();
    CompanyAddressDao companyAddressDao = new CompanyAddressDao();
    static final org.apache.log4j.Logger errorLog = org.apache.log4j.Logger.getLogger("errorLogger");
    static final org.apache.log4j.Logger infoLog = org.apache.log4j.Logger.getLogger("infoLogger");

    private InputStream inputStream;

    @Override
    public String execute() {

        companyList = companyAddressDao.getCompanyList();

        return ActionSupport.SUCCESS;
    }

    public String getPendingInvoice() {
        try {

            this.invoice = paymentDao.getPendingInvoice(Integer.parseInt(val));
            ObjectMapper mapper = new ObjectMapper();
            String res = mapper.writeValueAsString(invoice);
            inputStream = new ByteArrayInputStream(res.getBytes(StandardCharsets.UTF_8));

        } catch (IOException ex) {
            errorLog.error("VoucherAction : " + ex);
        }
        return ActionSupport.SUCCESS;
    }

    public String getPendingPurchase() {
        try {

            HttpSession session = ServletActionContext.getRequest().getSession(false);

            if (session == null || session.getAttribute("logined") == null) {
                return "failed";
            }
            this.invoice = paymentDao.getPendingPurchase(Integer.parseInt(val));
            ObjectMapper mapper = new ObjectMapper();
            String res = mapper.writeValueAsString(invoice);
            inputStream = new ByteArrayInputStream(res.getBytes(StandardCharsets.UTF_8));

        } catch (IOException ex) {
            errorLog.error("VoucherAction : " + ex);
        }
        return ActionSupport.SUCCESS;
    }

    public String updateVoucher() {
        String ret = null;
        int count = 0;

        if (this.getPaymentBean().getType().equals("p")) {
            count = paymentDao.updatePaymentPurchase(paymentBean);
            ret = "purchase";
        } else {
            count = paymentDao.updatePaymentInvoice(paymentBean);
            ret = "invoice";
        }

        if (count == 0) {
            errorMessage = "Failed to Update Voucher";
        } else {
            successMessage = "Voucher Updated Successfully";
        }
        return ret;
    }

    public List<PaymentBean> getPurchase() {
        return purchase;
    }

    public void setPurchase(List<PaymentBean> purchase) {
        this.purchase = purchase;
    }

    public List<PaymentBean> getInvoice() {
        return invoice;
    }

    public void setInvoice(List<PaymentBean> invoice) {
        this.invoice = invoice;
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

    public PaymentBean getPaymentBean() {
        return paymentBean;
    }

    public void setPaymentBean(PaymentBean paymentBean) {
        this.paymentBean = paymentBean;
    }

    @Override
    public Object getModel() {
        return this.getPaymentBean();
    }

    public List<CompanyBean> getCompanyList() {
        return companyList;
    }

    public void setCompanyList(List<CompanyBean> companyList) {
        this.companyList = companyList;
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

}
