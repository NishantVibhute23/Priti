/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pritient.bean.dao;

import com.pritient.bean.Invoice;
import com.pritient.bean.InvoiceDetails;
import com.pritient.bean.PaymentBean;
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
public class PurchaseDao extends DBUtil {

    Connection conn;
    static final org.apache.log4j.Logger errorLog = org.apache.log4j.Logger.getLogger("errorLogger");
    static final org.apache.log4j.Logger infoLog = org.apache.log4j.Logger.getLogger("infoLogger");

    public int savePurchase(Invoice invoice) {
        int id = 0;
        try {
            conn = getConnection();

            PreparedStatement ps = conn.prepareStatement("Call insertPurchase(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
            ps.setString(1, CommonUtil.convertDate(invoice.getDate()));
            ps.setString(2, invoice.getInvoiceNo());
            ps.setDouble(3, invoice.getTotalAmountBeforeTax());
            ps.setDouble(4, invoice.getCgstPerc());
            ps.setDouble(5, invoice.getCgstAmount());
            ps.setDouble(6, invoice.getSgstPerc());
            ps.setDouble(7, invoice.getSgstAmount());
            ps.setDouble(8, invoice.getIgstPerc());
            ps.setDouble(9, invoice.getIgstAmount());
            ps.setDouble(10, invoice.getTotalAmountATax());
            ps.setInt(11, invoice.getCompanyId());
            ps.setDouble(12, invoice.getRoundOff());
            ps.setDouble(13, invoice.getTotalAmount());
            ps.setString(14, invoice.getTotalAmountInWords());
            ps.setDouble(15, invoice.getTotalAmountGST());
            ps.setDouble(16, invoice.getGstOnReverseCharge());

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                id = rs.getInt(1);
            }

            if (id != 0) {

                for (InvoiceDetails pp : invoice.getInvoiceDetails()) {
                    if (pp != null) {
                        PreparedStatement ps1 = conn.prepareStatement("Call insertPurchaseDetails(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
                        ps1.setInt(1, pp.getProductId());
                        ps1.setInt(2, pp.getQty());
                        ps1.setDouble(3, pp.getPrice());
                        ps1.setDouble(4, pp.getAmount());
                        ps1.setDouble(5, pp.getCgstPerc());
                        ps1.setDouble(6, pp.getCgstAmount());
                        ps1.setDouble(7, pp.getSgstPerc());
                        ps1.setDouble(8, pp.getSgstAmount());
                        ps1.setDouble(9, pp.getIgstPerc());
                        ps1.setDouble(10, pp.getIgstAmount());
                        ps1.setDouble(11, pp.getTotalAmountAfterTax());
                        ps1.setInt(12, id);
                        ps1.setString(13, pp.getHsn());
                        ps1.setString(14, pp.getUom());

                        ps1.executeUpdate();

                        PreparedStatement ps2 = conn.prepareStatement("Call addProduct(?,?)");
                        ps2.setInt(1, pp.getProductId());
                        ps2.setInt(2, pp.getQty());
                        ps2.executeUpdate();
                    }
                }
            }

            closeConnection(conn);

        } catch (SQLException ex) {
            errorLog.error("PurchaseDao : " + ex);
        }
        return id;

    }

    public int updatePurchase(Invoice invoice) {
        int id = 0;
        try {
            conn = getConnection();

            PreparedStatement ps = conn.prepareStatement("Call updatePurchase(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
            ps.setString(1, CommonUtil.convertDate(invoice.getDate()));
            ps.setString(2, invoice.getInvoiceNo());
            ps.setDouble(3, invoice.getTotalAmountBeforeTax());
            ps.setDouble(4, invoice.getCgstPerc());
            ps.setDouble(5, invoice.getCgstAmount());
            ps.setDouble(6, invoice.getSgstPerc());
            ps.setDouble(7, invoice.getSgstAmount());
            ps.setDouble(8, invoice.getIgstPerc());
            ps.setDouble(9, invoice.getIgstAmount());
            ps.setDouble(10, invoice.getTotalAmountATax());
            ps.setInt(11, invoice.getCompanyId());
            ps.setDouble(12, invoice.getRoundOff());
            ps.setDouble(13, invoice.getTotalAmount());
            ps.setString(14, invoice.getTotalAmountInWords());
            ps.setDouble(15, invoice.getTotalAmountGST());
            ps.setDouble(16, invoice.getGstOnReverseCharge());
            ps.setInt(17, invoice.getId());

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                id = rs.getInt(1);
            }

            if (id != 0) {
                PreparedStatement ps1 = conn.prepareStatement("Call getPurchaseDetails(?)");
                ps1.setInt(1, invoice.getId());
                ResultSet rs1 = ps1.executeQuery();
                while (rs1.next()) {
                    PreparedStatement ps3 = conn.prepareStatement("Call deletePurchaseDetails(?)");
                    ps3.setInt(1, rs1.getInt("id"));
                    id = ps3.executeUpdate();
                    if (id != 0) {
                        ps3 = conn.prepareStatement("Call deleteProduct(?,?)");
                        ps3.setInt(1, rs1.getInt("product_id"));
                        ps3.setInt(2, rs1.getInt("qty"));
                        id = ps3.executeUpdate();
                    }

                }

                for (InvoiceDetails pp : invoice.getInvoiceDetails()) {
                    if (pp != null) {
                        PreparedStatement ps4 = conn.prepareStatement("Call insertPurchaseDetails(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
                        ps4.setInt(1, pp.getProductId());
                        ps4.setInt(2, pp.getQty());
                        ps4.setDouble(3, pp.getPrice());
                        ps4.setDouble(4, pp.getAmount());
                        ps4.setDouble(5, pp.getCgstPerc());
                        ps4.setDouble(6, pp.getCgstAmount());
                        ps4.setDouble(7, pp.getSgstPerc());
                        ps4.setDouble(8, pp.getSgstAmount());
                        ps4.setDouble(9, pp.getIgstPerc());
                        ps4.setDouble(10, pp.getIgstAmount());
                        ps4.setDouble(11, pp.getTotalAmountAfterTax());
                        ps4.setInt(12, invoice.getId());
                        ps4.setString(13, pp.getHsn());
                        ps4.setString(14, pp.getUom());

                        ps4.executeUpdate();

                        PreparedStatement ps2 = conn.prepareStatement("Call addProduct(?,?)");
                        ps2.setInt(1, pp.getProductId());
                        ps2.setInt(2, pp.getQty());
                        ps2.executeUpdate();
                    }
                }
            }

            closeConnection(conn);

        } catch (SQLException ex) {
            errorLog.error("PurchaseDao : " + ex);
        }
        return id;

    }

    public List<PaymentBean> getAllPurchase() {
        List<PaymentBean> purchase = new ArrayList<>();
        try {
            conn = getConnection();
            PreparedStatement ps = conn.prepareStatement("Call getPurchaseList()");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                PaymentBean pb = new PaymentBean();
                pb.setId(rs.getInt("id"));
                pb.setInvoiceId(rs.getString("invoice_num"));
                pb.setCompanyName(rs.getString("company_name"));
                pb.setAmount(rs.getDouble("bill_amount"));
                pb.setDate(CommonUtil.convertDateToNormal(rs.getString("date")));
                pb.setIsPaymentDone(rs.getInt("isPaymentDone"));
                pb.setIsLast(rs.getInt("isLast"));
                purchase.add(pb);
            }

            closeConnection(conn);

        } catch (SQLException ex) {
            errorLog.error("PurchaseDao : " + ex);
        }
        return purchase;
    }

    public Invoice getPurchaseDetails(int id) {
        Invoice in = new Invoice();
        try {
            conn = getConnection();
            PreparedStatement ps = conn.prepareStatement("Call getPurchase(?)");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                in.setId(rs.getInt("id"));
                in.setInvoiceNo(rs.getString("invoice_num"));
                in.setDate(CommonUtil.convertDateToNormal(rs.getString("date")));
                in.setBillTO(rs.getInt("client_id"));
                in.setTotalAmountBeforeTax(rs.getDouble("totalamount"));
                in.setCgstPerc(rs.getDouble("cgst_perc"));
                in.setCgstAmount(rs.getDouble("cgst_amount"));
                in.setSgstPerc(rs.getDouble("sgst_perc"));
                in.setSgstAmount(rs.getDouble("sgst_amount"));
                in.setIgstPerc(rs.getDouble("igst_perc"));
                in.setIgstAmount(rs.getDouble("igst_amount"));
                in.setTotalAmountATax(rs.getDouble("totalAmountAfterTax"));
                in.setRoundOff(rs.getDouble("round_off"));
                in.setTotalAmount(rs.getDouble("bill_amount"));
                in.setTotalAmountInWords(rs.getString("bill_amount_in_words"));
                in.setTotalAmountGST(rs.getDouble("total_amount_gst"));
                in.setGstOnReverseCharge(rs.getDouble("gst_on_reverse_charge"));
            }

            List<InvoiceDetails> invoiceDetails = new ArrayList<>();
            PreparedStatement ps1 = conn.prepareStatement("Call getPurchaseDetails(?)");
            ps1.setInt(1, id);
            ResultSet rs1 = ps1.executeQuery();
            while (rs1.next()) {
                InvoiceDetails ind = new InvoiceDetails();
                ind.setProductName(rs1.getString("product_name"));
                ind.setQty(rs1.getInt("qty"));
                ind.setAmount(rs1.getDouble("total_amount"));
                ind.setPrice(rs1.getDouble("amount"));
                ind.setCgstPerc(rs1.getInt("cgst_perc"));
                ind.setCgstAmount(rs1.getDouble("cgst_amount"));
                ind.setSgstPerc(rs1.getInt("sgst_perc"));
                ind.setSgstAmount(rs1.getDouble("sgst_amount"));
                ind.setIgstPerc(rs1.getInt("igst_perc"));
                ind.setIgstAmount(rs1.getDouble("igst_amount"));
                ind.setTotalAmountAfterTax(rs1.getDouble("totalAmountAfterTax"));
                ind.setHsn(rs1.getString("hsn"));
                ind.setUom(rs1.getString("uom"));
                ind.setProductId(rs1.getInt("product_id"));
                ind.setId(rs1.getInt("id"));
                invoiceDetails.add(ind);
            }

            in.setInvoiceDetails(invoiceDetails);

            PreparedStatement ps2 = conn.prepareStatement("Call getCompanyDetails(?)");
            ps2.setInt(1, in.getBillTO());
            ResultSet rs2 = ps2.executeQuery();
            while (rs2.next()) {

                in.setBillToName(rs2.getString(2));
                in.setBillToAddress(rs2.getString(3));
                in.setBillToGSTIN(rs2.getString(4));
                in.setBillToState(rs2.getString(9));
                in.setBillToCode(rs2.getString(10));
            }

            PreparedStatement ps4 = conn.prepareStatement("Call getPurchasePaymentDetails(?)");
            ps4.setInt(1, id);
            ResultSet rs4 = ps4.executeQuery();

            boolean isGet = false;
            while (rs4.next()) {

                if (rs4.getInt("isPaymentDone") == 1) {
                    isGet = true;
                    in.setStatus("Paid");
                    in.setPaymentDate(CommonUtil.convertDateToNormal(rs4.getString("payment_date")));
                    if (rs4.getString("payment_mode").equalsIgnoreCase("Cash")) {
                        in.setDescription("by Cash");
                    } else if (rs4.getString("payment_mode").equalsIgnoreCase("Cheque")) {
                        in.setDescription("by Cheque : " + rs4.getString("bank_name") + " Cheque No : " + rs4.getString("cheque_no") + " Dated : " + rs4.getString("cheque_date"));
                    } else if (rs4.getString("payment_mode").equalsIgnoreCase("neft")) {
                        in.setDescription("by NEFT : IFSC Code" + rs4.getString("ifsc_code") + " UTR No : " + rs4.getString("utr_no"));

                    }
                }

            }
            if (!isGet) {
                in.setStatus("Not Paid");
                in.setPaymentDate("");
                in.setDescription("");
            }

            closeConnection(conn);

        } catch (SQLException ex) {
            errorLog.error("PurchaseDao : " + ex);
        }

        return in;
    }

    public int deletePurchase(int id) {
        int count = 0;
        try {
            conn = getConnection();
            PreparedStatement ps1 = conn.prepareStatement("Call getPurchaseDetails(?)");
            ps1.setInt(1, id);
            ResultSet rs1 = ps1.executeQuery();
            while (rs1.next()) {
                PreparedStatement ps3 = conn.prepareStatement("Call deletePurchaseDetails(?)");
                ps3.setInt(1, rs1.getInt("id"));
                count = ps3.executeUpdate();
                if (count != 0) {
                    ps3 = conn.prepareStatement("Call deleteProduct(?,?)");
                    ps3.setInt(1, rs1.getInt("product_id"));
                    ps3.setInt(2, rs1.getInt("qty"));
                    count = ps3.executeUpdate();
                }

            }

            if (count != 0) {
                ps1 = conn.prepareStatement("Call deletePurchasee(?)");
                ps1.setInt(1, id);
                count = ps1.executeUpdate();
            }

        } catch (SQLException ex) {
            errorLog.error("PurchaseDao : " + ex);
        }
        return count;
    }

}
