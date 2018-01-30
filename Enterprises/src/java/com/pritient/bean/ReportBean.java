/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pritient.bean;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author nishant.vibhute
 */
public class ReportBean {

    public String type;
    public List<ReportRowBean> reportList = new ArrayList<>();

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public List<ReportRowBean> getReportList() {
        return reportList;
    }

    public void setReportList(List<ReportRowBean> reportList) {
        this.reportList = reportList;
    }

}
