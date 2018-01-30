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
public class LedgerBean {

    List<LedgerRowBean> ledgerRow = new ArrayList<>();
    double debitTotal;
    double creditTotal;

    public List<LedgerRowBean> getLedgerRow() {
        return ledgerRow;
    }

    public void setLedgerRow(List<LedgerRowBean> ledgerRow) {
        this.ledgerRow = ledgerRow;
    }

    public double getDebitTotal() {
        return debitTotal;
    }

    public void setDebitTotal(double debitTotal) {
        this.debitTotal = debitTotal;
    }

    public double getCreditTotal() {
        return creditTotal;
    }

    public void setCreditTotal(double creditTotal) {
        this.creditTotal = creditTotal;
    }

}
