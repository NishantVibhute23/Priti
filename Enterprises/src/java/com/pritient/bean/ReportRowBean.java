/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pritient.bean;

/**
 *
 * @author nishant.vibhute
 */
public class ReportRowBean {

    public String date;
    public double amountTotal;
    public double amountPaid;
    public double amountUnpaid;

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public double getAmountTotal() {
        return amountTotal;
    }

    public void setAmountTotal(double amountTotal) {
        this.amountTotal = amountTotal;
    }

    public double getAmountPaid() {
        return amountPaid;
    }

    public void setAmountPaid(double amountPaid) {
        this.amountPaid = amountPaid;
    }

    public double getAmountUnpaid() {
        return amountUnpaid;
    }

    public void setAmountUnpaid(double amountUnpaid) {
        this.amountUnpaid = amountUnpaid;
    }

}
