/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pritient.bean.dao;

import com.pritient.bean.PaymentBean;
import com.pritient.util.CommonUtil;
import com.pritient.util.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author nishant.vibhute
 */
public class PaymentDao extends DBUtil {

    Connection conn;

    public List<PaymentBean> getPendingPurchase(int id) {
        List<PaymentBean> payment = new ArrayList<>();
        try {
            conn = getConnection();
            PreparedStatement ps = conn.prepareStatement("Call getPendingPurchase(?)");
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                PaymentBean pb = new PaymentBean();
                pb.setId(rs.getInt("id"));
                pb.setInvoiceId(rs.getString("invoice_num"));
                pb.setCompanyName(rs.getString("company_name"));
                pb.setAmount(rs.getDouble("totalAmountAfterTax"));
                pb.setDate(CommonUtil.convertDateToNormal(rs.getString("invoice_date")));
                payment.add(pb);
            }

            closeConnection(conn);

        } catch (SQLException ex) {
            Logger.getLogger(LoginDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return payment;
    }

    public List<PaymentBean> getPendingInvoice(int id) {
        List<PaymentBean> invoice = new ArrayList<>();
        try {
            conn = getConnection();
            PreparedStatement ps = conn.prepareStatement("Call getPendingInvoice(?)");
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                PaymentBean pb = new PaymentBean();
//                pb.setId(id);
                pb.setInvoiceId("" + rs.getInt("id"));
                pb.setCompanyName(rs.getString("company_name"));
                pb.setAmount(rs.getDouble("bill_amount"));
                pb.setDate(CommonUtil.convertDateToNormal(rs.getString("date")));
                invoice.add(pb);
            }

            closeConnection(conn);

        } catch (SQLException ex) {
            Logger.getLogger(LoginDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return invoice;
    }

    public int updatePaymentPurchase(PaymentBean paymentBean) {
        int id = 0;
        try {
            conn = getConnection();
            PreparedStatement ps = conn.prepareStatement("Call insertInvoicePayment(?,?,?,?,?,?,?,?,?)");
            ps.setString(1, CommonUtil.convertDate(paymentBean.getPaymentDate()));
            ps.setString(2, paymentBean.getMode());
            ps.setString(3, paymentBean.getChequeNo().equals("") ? null : paymentBean.getChequeNo());
            ps.setString(4, paymentBean.getDate().equals("") ? null : CommonUtil.convertDate(paymentBean.getDate()));
            ps.setString(5, paymentBean.getBankName().equals("") ? null : paymentBean.getBankName());
            ps.setString(6, paymentBean.getPaymentAmount());
            ps.setString(7, paymentBean.getUtrNo().equals("") ? null : paymentBean.getUtrNo());
            ps.setString(8, paymentBean.getIfscCode().equals("") ? null : paymentBean.getIfscCode());
            ps.setInt(9, 2);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                id = rs.getInt(1);

            }

            if (id != 0) {

                for (String ids : paymentBean.getInvId()) {
                    if (!ids.equals("0")) {
                        PreparedStatement ps1 = conn.prepareStatement("Call insertPurchasePaymentDetails(?,?)");
                        ps1.setInt(1, id);
                        ps1.setInt(2, Integer.parseInt(ids));

                        ps1.executeUpdate();
                    }

                }
            }

            closeConnection(conn);

        } catch (SQLException ex) {
            Logger.getLogger(LoginDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return id;

    }

    public int updatePaymentInvoice(PaymentBean paymentBean) {
        int id = 0;
        try {
            conn = getConnection();
            PreparedStatement ps = conn.prepareStatement("Call insertInvoicePayment(?,?,?,?,?,?,?,?,?)");
            ps.setString(1, CommonUtil.convertDate(paymentBean.getPaymentDate()));
            ps.setString(2, paymentBean.getMode());
            ps.setString(3, paymentBean.getChequeNo().equals("") ? null : paymentBean.getChequeNo());
            ps.setString(4, paymentBean.getDate().equals("") ? null : CommonUtil.convertDate(paymentBean.getDate()));
            ps.setString(5, paymentBean.getBankName().equals("") ? null : paymentBean.getBankName());
            ps.setString(6, paymentBean.getPaymentAmount());
            ps.setString(7, paymentBean.getUtrNo().equals("") ? null : paymentBean.getUtrNo());
            ps.setString(8, paymentBean.getIfscCode().equals("") ? null : paymentBean.getIfscCode());
            ps.setInt(9, 1);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                id = rs.getInt(1);

            }

            if (id != 0) {

                for (String ids : paymentBean.getInvId()) {
                    if (!ids.equals("0")) {
                        PreparedStatement ps1 = conn.prepareStatement("Call insertInvoicePaymentDetails(?,?)");
                        ps1.setInt(1, id);
                        ps1.setInt(2, Integer.parseInt(ids));

                        ps1.executeUpdate();
                    }

                }
            }

            closeConnection(conn);

        } catch (SQLException ex) {
            Logger.getLogger(LoginDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return id;
    }

}
