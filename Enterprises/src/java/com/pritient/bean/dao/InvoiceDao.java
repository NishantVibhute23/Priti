/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pritient.bean.dao;

import com.pritient.bean.Invoice;
import com.pritient.bean.InvoiceDetails;
import com.pritient.bean.PaymentBean;
import com.pritient.bean.Product;
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
public class InvoiceDao extends DBUtil {

    Connection conn;
    static final org.apache.log4j.Logger errorLog = org.apache.log4j.Logger.getLogger("errorLogger");
    static final org.apache.log4j.Logger infoLog = org.apache.log4j.Logger.getLogger("infoLogger");

    public int insertInvoice(Invoice invoice) {
        int id = 0;
        try {
            conn = getConnection();

            PreparedStatement ps = conn.prepareStatement("Call insertInvoice(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
            ps.setString(1, CommonUtil.convertDate(invoice.getDate()));
            ps.setString(2, invoice.getReverseCharge());
            ps.setString(3, invoice.getState());
            ps.setInt(4, invoice.getCode());
            ps.setString(5, invoice.getTransportMode());
            ps.setString(6, invoice.getVehicleNo());
            ps.setString(7, invoice.getDateOfSupply().isEmpty() ? null : CommonUtil.convertDate(invoice.getDateOfSupply()));
            ps.setString(8, invoice.getPlaceOfSupply());
            ps.setInt(9, invoice.getBillTO());
            ps.setInt(10, invoice.getShipTo());
            ps.setDouble(11, invoice.getTotalAmountBeforeTax());
            ps.setDouble(12, invoice.getCgstPerc());
            ps.setDouble(13, invoice.getCgstAmount());
            ps.setDouble(14, invoice.getSgstPerc());
            ps.setDouble(15, invoice.getSgstAmount());
            ps.setDouble(16, invoice.getIgstPerc());
            ps.setDouble(17, invoice.getIgstAmount());
            ps.setDouble(18, invoice.getTotalAmountATax());
            ps.setDouble(19, invoice.getRoundOff());
            ps.setDouble(20, invoice.getTotalAmount());
            ps.setString(21, invoice.getTotalAmountInWords());
            ps.setDouble(22, invoice.getTotalAmountGST());
            ps.setDouble(23, invoice.getGstOnReverseCharge());
            ps.setInt(24, Integer.parseInt(invoice.getInvoiceNo()));
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                id = rs.getInt(1);
            }

            if (id != 0) {

                for (InvoiceDetails ids : invoice.getInvoiceDetails()) {
                    if (ids != null) {
                        PreparedStatement ps1 = conn.prepareStatement("Call insertInvoiceDetails(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
                        ps1.setInt(1, ids.getProductId());
                        ps1.setInt(2, ids.getQty());
                        ps1.setDouble(3, ids.getPrice());
                        ps1.setDouble(4, ids.getAmount());
                        ps1.setDouble(5, ids.getCgstPerc());
                        ps1.setDouble(6, ids.getCgstAmount());
                        ps1.setDouble(7, ids.getSgstPerc());
                        ps1.setDouble(8, ids.getSgstAmount());
                        ps1.setDouble(9, ids.getIgstPerc());
                        ps1.setDouble(10, ids.getIgstAmount());
                        ps1.setDouble(11, ids.getTotalAmountAfterTax());
                        ps1.setInt(12, id);
                        ps1.setString(13, ids.getHsn());
                        ps1.setString(14, ids.getUom());
                        ps1.executeUpdate();

                        PreparedStatement ps2 = conn.prepareStatement("Call deleteProduct(?,?)");
                        ps2.setInt(1, ids.getProductId());
                        ps2.setInt(2, ids.getQty());
                        ps2.executeUpdate();
                    }
                }
            }

            closeConnection(conn);

        } catch (SQLException ex) {
            errorLog.error("InvoiceDao : " + ex);
        }
        return id;

    }

    public int updateInvoice(Invoice invoice) {
        int id = 0;
        try {
            conn = getConnection();

            PreparedStatement ps = conn.prepareStatement("Call updateInvoice(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
            ps.setString(1, CommonUtil.convertDate(invoice.getDate()));
            ps.setString(2, invoice.getReverseCharge());
            ps.setString(3, invoice.getState());
            ps.setInt(4, invoice.getCode());
            ps.setString(5, invoice.getTransportMode());
            ps.setString(6, invoice.getVehicleNo());
            ps.setString(7, invoice.getDateOfSupply().isEmpty() ? null : CommonUtil.convertDate(invoice.getDateOfSupply()));
            ps.setString(8, invoice.getPlaceOfSupply());
            ps.setInt(9, invoice.getBillTO());
            ps.setInt(10, invoice.getShipTo());
            ps.setDouble(11, invoice.getTotalAmountBeforeTax());
            ps.setDouble(12, invoice.getCgstPerc());
            ps.setDouble(13, invoice.getCgstAmount());
            ps.setDouble(14, invoice.getSgstPerc());
            ps.setDouble(15, invoice.getSgstAmount());
            ps.setDouble(16, invoice.getIgstPerc());
            ps.setDouble(17, invoice.getIgstAmount());
            ps.setDouble(18, invoice.getTotalAmountATax());
            ps.setDouble(19, invoice.getRoundOff());
            ps.setDouble(20, invoice.getTotalAmount());
            ps.setString(21, invoice.getTotalAmountInWords());
            ps.setDouble(22, invoice.getTotalAmountGST());
            ps.setDouble(23, invoice.getGstOnReverseCharge());
            ps.setInt(24, invoice.getId());
            ps.setInt(25, Integer.parseInt(invoice.getInvoiceNo()));
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                id = rs.getInt(1);
            }

            if (id != 0) {

                PreparedStatement ps1 = conn.prepareStatement("Call getInvoiceDetails(?)");
                ps1.setInt(1, invoice.getId());
                ResultSet rs1 = ps1.executeQuery();
                while (rs1.next()) {
                    PreparedStatement ps3 = conn.prepareStatement("Call deleteInvoiceDetails(?)");
                    ps3.setInt(1, rs1.getInt("id"));
                    id = ps3.executeUpdate();
                    if (id != 0) {
                        ps3 = conn.prepareStatement("Call addProduct(?,?)");
                        ps3.setInt(1, rs1.getInt("product_id"));
                        ps3.setInt(2, rs1.getInt("qty"));
                        id = ps3.executeUpdate();
                    }

                }

                for (InvoiceDetails ids : invoice.getInvoiceDetails()) {
                    if (ids != null) {

                        ps1 = conn.prepareStatement("Call insertInvoiceDetails(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
                        ps1.setInt(1, ids.getProductId());
                        ps1.setInt(2, ids.getQty());
                        ps1.setDouble(3, ids.getPrice());
                        ps1.setDouble(4, ids.getAmount());
                        ps1.setDouble(5, ids.getCgstPerc());
                        ps1.setDouble(6, ids.getCgstAmount());
                        ps1.setDouble(7, ids.getSgstPerc());
                        ps1.setDouble(8, ids.getSgstAmount());
                        ps1.setDouble(9, ids.getIgstPerc());
                        ps1.setDouble(10, ids.getIgstAmount());
                        ps1.setDouble(11, ids.getTotalAmountAfterTax());
                        ps1.setInt(12, invoice.getId());
                        ps1.setString(13, ids.getHsn());
                        ps1.setString(14, ids.getUom());
                        ps1.executeUpdate();

                        PreparedStatement ps2 = conn.prepareStatement("Call deleteProduct(?,?)");
                        ps2.setInt(1, ids.getProductId());
                        ps2.setInt(2, ids.getQty());
                        ps2.executeUpdate();

                    }
                }
            }

            closeConnection(conn);

        } catch (SQLException ex) {
            errorLog.error("InvoiceDao : " + ex);
        }
        return id;

    }

    public List<PaymentBean> getAllInvoice() {
        List<PaymentBean> invoice = new ArrayList<>();
        try {
            conn = getConnection();
            PreparedStatement ps = conn.prepareStatement("Call getInvoiceList()");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                PaymentBean pb = new PaymentBean();
                pb.setId(rs.getInt("id"));
                pb.setInvoiceId("" + rs.getInt("invoiceId"));
                pb.setCompanyName(rs.getString("company_name"));
                pb.setAmount(rs.getDouble("bill_amount"));
                pb.setDate(CommonUtil.convertDateToNormal(rs.getString("date")));
                pb.setIsPaymentDone(rs.getInt("isPaymentDone"));
                pb.setIsLast(rs.getInt("isLast"));
                invoice.add(pb);
            }

            closeConnection(conn);

        } catch (SQLException ex) {
            errorLog.error("InvoiceDao : " + ex);
        }
        return invoice;
    }

    public Invoice getInvoiceDetails(int id) {
        Invoice in = new Invoice();
        try {
            conn = getConnection();
            PreparedStatement ps = conn.prepareStatement("Call getInvoice(?)");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                in.setId(rs.getInt("id"));
                in.setInvoiceNo("" + rs.getInt("invoiceId"));
                in.setDate(CommonUtil.convertDateToNormal(rs.getString("date")));
                in.setReverseCharge(rs.getString("reverse_charge"));
                in.setState(rs.getString("state"));
                in.setCode(rs.getInt("code"));
                in.setTransportMode(rs.getString("transport_mode"));
                in.setVehicleNo(rs.getString("vehicle_no"));
                in.setDateOfSupply(rs.getString("date_of_supply") == null ? "" : CommonUtil.convertDateToNormal(rs.getString("date_of_supply")));
                in.setPlaceOfSupply(rs.getString("place_of_supply"));

                in.setBillTO(rs.getInt("bill_to_party"));
                in.setShipTo(rs.getInt("ship_to_party"));
                in.setTotalAmountBeforeTax(rs.getDouble("total_amount_before_tax"));
                in.setCgstPerc(rs.getDouble("cgst_perc"));
                in.setCgstAmount(rs.getDouble("cgst_amount"));
                in.setSgstPerc(rs.getDouble("sgst_perc"));
                in.setSgstAmount(rs.getDouble("sgst_amount"));
                in.setIgstPerc(rs.getDouble("igst_perc"));
                in.setIgstAmount(rs.getDouble("igst_amount"));
                in.setTotalAmountATax(rs.getDouble("total_amount_after_tax"));
                in.setRoundOff(rs.getDouble("round_off"));
                in.setTotalAmount(rs.getDouble("bill_amount"));
                in.setTotalAmountInWords(rs.getString("bill_amount_in_words"));
                in.setTotalAmountGST(rs.getDouble("total_amount_gst"));
                in.setGstOnReverseCharge(rs.getDouble("gst_on_reverse_charge"));
            }

            List<InvoiceDetails> invoiceDetails = new ArrayList<>();
            PreparedStatement ps1 = conn.prepareStatement("Call getInvoiceDetails(?)");
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

            PreparedStatement ps3 = conn.prepareStatement("Call getCompanyDetails(?)");
            ps3.setInt(1, in.getShipTo());
            ResultSet rs3 = ps3.executeQuery();
            while (rs3.next()) {

                in.setShipToName(rs3.getString(2));
                in.setShipToAddress(rs3.getString(3));
                in.setShipToGSTIN(rs3.getString(4));
                in.setShipToState(rs3.getString(9));
                in.setShipToCode(rs3.getString(10));
            }

            PreparedStatement ps4 = conn.prepareStatement("Call getInvoicePaymentDetails(?)");
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
            errorLog.error("InvoiceDao : " + ex);
        }

        return in;
    }

    public int getLatestInvoiceNumber() {
        int count = 0;
        try {

            conn = getConnection();
            PreparedStatement ps = conn.prepareStatement("Call getLatestInvoiceNumber()");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                count = rs.getInt(1);
            }

            if (count == 0) {
                count = 1;
            }

            closeConnection(conn);
        } catch (SQLException ex) {
            errorLog.error("InvoiceDao : " + ex);
        }

        return count;
    }

    public Product getUOMAndHSN(int id) {
        Product p = new Product();

        try {

            conn = getConnection();
            PreparedStatement ps = conn.prepareStatement("Call getUOMAndHSN(?)");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                p.setMainProductHSN(rs.getString(1));
                p.setMainProductUOM(rs.getString(2));
                p.setMainProductType(rs.getString(3));
                p.setQty(rs.getString(4));
            }

            closeConnection(conn);
        } catch (SQLException ex) {
            errorLog.error("InvoiceDao : " + ex);
        }

        return p;
    }

    public Product getUOMAndHSNAndPrice(int id, int companyId) {
        Product p = new Product();

        try {

            conn = getConnection();
            PreparedStatement ps = conn.prepareStatement("Call getUOMAndHSNAndPrice(?,?)");
            ps.setInt(1, id);
            ps.setInt(2, companyId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                p.setMainProductHSN(rs.getString(1));
                p.setMainProductUOM(rs.getString(2));
                p.setMainProductType(rs.getString(3));
                p.setQty(rs.getString(4));
                p.setPrice(rs.getDouble(5));

            }

            closeConnection(conn);
        } catch (SQLException ex) {
            errorLog.error("InvoiceDao : " + ex);
        }

        return p;
    }

    public int deleteInvoice(int id) {
        int count = 0;
        try {
            conn = getConnection();
            PreparedStatement ps1 = conn.prepareStatement("Call getInvoiceDetails(?)");
            ps1.setInt(1, id);
            ResultSet rs1 = ps1.executeQuery();
            while (rs1.next()) {
                PreparedStatement ps3 = conn.prepareStatement("Call deleteInvoiceDetails(?)");
                ps3.setInt(1, rs1.getInt("id"));
                count = ps3.executeUpdate();
                if (count != 0) {
                    ps3 = conn.prepareStatement("Call addProduct(?,?)");
                    ps3.setInt(1, rs1.getInt("product_id"));
                    ps3.setInt(2, rs1.getInt("qty"));
                    count = ps3.executeUpdate();
                }

            }

            if (count != 0) {
                ps1 = conn.prepareStatement("Call deleteInvoice(?)");
                ps1.setInt(1, id);
                count = ps1.executeUpdate();
            }

        } catch (SQLException ex) {
            errorLog.error("InvoiceDao : " + ex);
        }
        return count;
    }

}
