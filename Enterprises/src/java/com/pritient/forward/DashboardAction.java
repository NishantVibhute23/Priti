/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pritient.forward;

import com.opensymphony.xwork2.ActionSupport;
import com.pritient.bean.ReportAllBean;
import com.pritient.bean.ReportRowBean;
import com.pritient.bean.dao.ReportDao;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.Calendar;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.codehaus.jackson.map.ObjectMapper;

/**
 *
 * @author nishant.vibhute
 */
public class DashboardAction extends ActionSupport {

    ReportDao reportDao = new ReportDao();
    private InputStream inputStream;
    String fromDate = "";
    String toDate = "";

    public String execute() throws Exception {

        return ActionSupport.SUCCESS;
    }

    public String getPurchaseList() {

        if (fromDate.isEmpty() || toDate.isEmpty()) {
            Calendar now = Calendar.getInstance();
            int year = now.get(Calendar.YEAR);
            int month = now.get(Calendar.MONTH) + 1; // Note: zero based!

            fromDate = "01/" + month + "/" + year;
            toDate = "31/" + month + "/" + year;
        }

        try {
            List<ReportRowBean> reportList = reportDao.getPurchaseReport(fromDate, toDate);
            ObjectMapper mapper = new ObjectMapper();

            String res = mapper.writeValueAsString(reportList);
            inputStream = new ByteArrayInputStream(res.getBytes(StandardCharsets.UTF_8));
        } catch (IOException ex) {
            Logger.getLogger(AddressBookAction.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ActionSupport.SUCCESS;
    }

    public String getSalesReport() {
        if (fromDate.isEmpty() || toDate.isEmpty()) {
            Calendar now = Calendar.getInstance();
            int year = now.get(Calendar.YEAR);
            int month = now.get(Calendar.MONTH) + 1; // Note: zero based!

            fromDate = "01/" + month + "/" + year;
            toDate = "31/" + month + "/" + year;
        }

        try {
            List<ReportRowBean> reportList = reportDao.getSalesReport(fromDate, toDate);
            ObjectMapper mapper = new ObjectMapper();

            String res = mapper.writeValueAsString(reportList);
            inputStream = new ByteArrayInputStream(res.getBytes(StandardCharsets.UTF_8));
        } catch (IOException ex) {
            Logger.getLogger(AddressBookAction.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ActionSupport.SUCCESS;
    }

    public String getPLReport() {
        if (fromDate.isEmpty() || toDate.isEmpty()) {
            Calendar now = Calendar.getInstance();
            int year = now.get(Calendar.YEAR);
            int month = now.get(Calendar.MONTH) + 1; // Note: zero based!

            fromDate = "01/" + month + "/" + year;
            toDate = "31/" + month + "/" + year;
        }

        try {
            List<ReportRowBean> reportList = reportDao.getProfitLossReport(fromDate, toDate);
            ObjectMapper mapper = new ObjectMapper();

            String res = mapper.writeValueAsString(reportList);
            inputStream = new ByteArrayInputStream(res.getBytes(StandardCharsets.UTF_8));
        } catch (IOException ex) {
            Logger.getLogger(AddressBookAction.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ActionSupport.SUCCESS;
    }

    public String getPurchaseSalePlReport() {
        if (fromDate.isEmpty() || toDate.isEmpty()) {
            Calendar now = Calendar.getInstance();
            int year = now.get(Calendar.YEAR);
            int month = now.get(Calendar.MONTH) + 1; // Note: zero based!
            fromDate = "01/01/" + year;
            toDate = "31/"+month+"/" + year;
        }

        try {
            List<ReportAllBean> reportList = reportDao.getPurchaseSalePLReport(fromDate, toDate);
            ObjectMapper mapper = new ObjectMapper();

            String res = mapper.writeValueAsString(reportList);
            inputStream = new ByteArrayInputStream(res.getBytes(StandardCharsets.UTF_8));
        } catch (IOException ex) {
            Logger.getLogger(AddressBookAction.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ActionSupport.SUCCESS;
    }

    public InputStream getInputStream() {
        return inputStream;
    }

    public void setInputStream(InputStream inputStream) {
        this.inputStream = inputStream;
    }

    public String getFromDate() {
        return fromDate;
    }

    public void setFromDate(String fromDate) {
        this.fromDate = fromDate;
    }

    public String getToDate() {
        return toDate;
    }

    public void setToDate(String toDate) {
        this.toDate = toDate;
    }

}
