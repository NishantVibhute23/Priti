/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pritient.forward;

import com.opensymphony.xwork2.ActionSupport;
import com.pritient.bean.CompanyBean;
import com.pritient.bean.LedgerBean;
import com.pritient.bean.MyProfile;
import com.pritient.bean.dao.CompanyAddressDao;
import com.pritient.bean.dao.LedgerDao;
import com.pritient.bean.dao.MyProfileDao;
import com.pritient.util.CommonUtil;
import com.pritient.util.LedgerPdf;
import java.io.ByteArrayInputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author nishant.vibhute
 */
public class LedgerAction extends ActionSupport {

    List<CompanyBean> companyList = new ArrayList<>();
    CompanyAddressDao companyAddressDao = new CompanyAddressDao();
    String successMessage = "";
    String errorMessage = "";
    String dateFrom = "";
    String dateTo = "";
    LedgerDao ledgerDao = new LedgerDao();
    MyProfileDao myProfileDao = new MyProfileDao();
    private InputStream inputStream;
    private String fileName;
    static final org.apache.log4j.Logger errorLog = org.apache.log4j.Logger.getLogger("errorLogger");
    static final org.apache.log4j.Logger infoLog = org.apache.log4j.Logger.getLogger("infoLogger");

    @Override
    public String execute() {
        companyList = companyAddressDao.getCompanyList();
        return ActionSupport.SUCCESS;
    }

    public String getLedger() {
        String dateFrom = this.getDateFrom();
        String dateTo = this.getDateTo();
        LedgerBean ledger = ledgerDao.getLedger(dateFrom, dateTo);
        MyProfile myProfile = myProfileDao.getprofileDetails();
        LedgerPdf.convert(ledger, myProfile, dateFrom, dateTo);
        String path = CommonUtil.getResourceProperties("application.address");
        inputStream = new ByteArrayInputStream(path.getBytes(StandardCharsets.UTF_8));
        return ActionSupport.SUCCESS;
    }

    public String getLedgerPdf() {
        try {

            this.setFileName("Ledger.pdf");
//            inputStream = new FileInputStream(CommonUtil.getPath() + "\\pdf.pdf");
            inputStream = new FileInputStream(CommonUtil.directoryPath + "ledger.pdf");
        } catch (FileNotFoundException ex) {
            errorLog.error("LedgerAction : " + ex);
        }
        return ActionSupport.SUCCESS;
    }

    public List<CompanyBean> getCompanyList() {

        return companyList;
    }

    public void setCompanyList(List<CompanyBean> companyList) {
        this.companyList = companyList;
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

    public String getDateFrom() {
        return dateFrom;
    }

    public void setDateFrom(String dateFrom) {
        this.dateFrom = dateFrom;
    }

    public String getDateTo() {
        return dateTo;
    }

    public void setDateTo(String dateTo) {
        this.dateTo = dateTo;
    }

    public InputStream getInputStream() {
        return inputStream;
    }

    public void setInputStream(InputStream inputStream) {
        this.inputStream = inputStream;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

}
