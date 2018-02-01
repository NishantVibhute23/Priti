/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pritient.bean.dao;

import com.pritient.bean.LedgerBean;
import com.pritient.bean.LedgerRowBean;
import com.pritient.util.CommonUtil;
import com.pritient.util.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author nishant.vibhute
 */
public class LedgerDao extends DBUtil {

    static final org.apache.log4j.Logger errorLog = org.apache.log4j.Logger.getLogger("errorLogger");
    static final org.apache.log4j.Logger infoLog = org.apache.log4j.Logger.getLogger("infoLogger");

    Connection conn;

    public LedgerBean getLedger(String dateFrom, String dateTo) {
        LedgerBean ledgerBean = new LedgerBean();
        List<LedgerRowBean> ledger = new ArrayList<>();
        double debitTotal = 0, creditTotal = 0;
        try {

            conn = getConnection();
            PreparedStatement ps = conn.prepareStatement("Call getLedgerDetails(?,?)");
            ps.setString(1, CommonUtil.convertDate(dateFrom));
            ps.setString(2, CommonUtil.convertDate(dateTo));
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                LedgerRowBean ledgerRowBean = new LedgerRowBean();
                ledgerRowBean.setId(rs.getInt("id"));
                ledgerRowBean.setPaymentMode(rs.getString("payment_mode"));

                ledgerRowBean.setChequeNo(rs.getString("cheque_no"));
                ledgerRowBean.setChequeDate(rs.getString("cheque_date"));
                ledgerRowBean.setBankName(rs.getString("bank_name"));
                ledgerRowBean.setPaymentAmount(rs.getString("payment_amount"));
                ledgerRowBean.setPaymentDate(rs.getString("payment_date"));
                ledgerRowBean.setUtrNo(rs.getString("utr_no"));
                ledgerRowBean.setIfscCode(rs.getString("ifsc_code"));
                ledgerRowBean.setType(rs.getString("invoice_type"));
                if (rs.getString("invoice_type").equals("1")) {
                    creditTotal = creditTotal + Double.parseDouble(rs.getString("payment_amount"));
                } else {
                    debitTotal = debitTotal + Double.parseDouble(rs.getString("payment_amount"));
                }

                ledgerRowBean.setInvoiceId(rs.getString("invoice_num"));
                ledgerRowBean.setCompanyName(rs.getString("company_name"));
                ledger.add(ledgerRowBean);

            }
            ledgerBean.setLedgerRow(ledger);
            ledgerBean.setDebitTotal(debitTotal);
            ledgerBean.setCreditTotal(creditTotal);
            closeConnection(conn);
        } catch (SQLException ex) {
            errorLog.error("LedgerDao : " + ex);
        }

        return ledgerBean;
    }

}
