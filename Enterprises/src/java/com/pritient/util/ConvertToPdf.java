/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pritient.util;

import com.itextpdf.text.Document;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.tool.xml.XMLWorkerHelper;
import com.pritient.bean.CompanyBean;
import com.pritient.bean.Invoice;
import com.pritient.bean.MyProfile;
import freemarker.template.Configuration;
import freemarker.template.Template;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.StringWriter;
import java.io.Writer;
import java.nio.charset.Charset;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author nishant.vibhute
 */
public class ConvertToPdf {

    public static String convert(Invoice in, MyProfile myProfile) {
        Writer out = null;
        try {
            Configuration cfg = new Configuration();
            String templatePath = System.getenv("OPENSHIFT_DATA_DIR");
            if (CommonUtil.getResourceProperties("template.path").equalsIgnoreCase("yes")) {
                templatePath = CommonUtil.directoryPath;
            } else {

                templatePath = CommonUtil.path + CommonUtil.getResourceProperties("template.path");
//                templatePath = CommonUtil.getResourceProperties("template.path");
            }

            String outputPath = CommonUtil.directoryPath + "index.html";
            String pdfPath = CommonUtil.directoryPath + "pdf.pdf";
            //
            cfg.setDirectoryForTemplateLoading(new File(templatePath));

            Template template = cfg.getTemplate("index.ftl");

            // Build the data-model
            Map<String, Object> data = new HashMap<>();
            data.put("companyHeaderName", myProfile.getCompanyName());
            data.put("companyHeaderAddress", myProfile.getCompanyAddress());
            data.put("companyHeaderGSTIN", myProfile.getCompanyGSTIN());
            data.put("companyHeaderTelNo1", myProfile.getCompanyPhoneNo1());
            data.put("companyHeaderTelNo2", myProfile.getCompanyPhoneNo2());
            data.put("companyHeaderEmail", myProfile.getCompanyEmailId());

            data.put("invoiceNo", in.getId());
            data.put("invoiceDate", in.getDate());
            data.put("isReverse", in.getReverseCharge());
            data.put("invoiceState", in.getState());
            data.put("invoiceCode", in.getCode());

            data.put("transMode", in.getTransportMode());
            data.put("vehicleNo", in.getVehicleNo());
            data.put("dateOFSupply", in.getDateOfSupply());
            data.put("placeOfSupply", in.getPlaceOfSupply());

            data.put("totalAmountBeforeTax", in.getTotalAmountBeforeTax());
            data.put("cgstPerc", in.getCgstPerc());
            data.put("cgstAmount", in.getCgstAmount());
            data.put("sgstPerc", in.getSgstPerc());
            data.put("sgstAmount", in.getSgstAmount());
            data.put("igstPerc", in.getIgstPerc());
            data.put("igstAmount", in.getIgstAmount());
            data.put("roundOff", in.getRoundOff());
            data.put("totalAmountAfterTax", in.getTotalAmountATax());
            data.put("billamount", in.getTotalAmount());
            data.put("amountInwords", in.getTotalAmountInWords());

            data.put("invoiceDetails", in.getInvoiceDetails());

            data.put("BillToName", in.getBillToName());
            data.put("BillToAddress", in.getBillToAddress());
            data.put("BillToGSTIN", in.getBillToGSTIN());
            data.put("BillToState", in.getBillToState());
            data.put("BillToCode", in.getBillToCode());

            data.put("ShipToName", in.getShipToName());
            data.put("ShipToAddress", in.getShipToAddress());
            data.put("ShipToGSTIN", in.getShipToGSTIN());
            data.put("ShipToState", in.getShipToState());
            data.put("ShipToCode", in.getShipToCode());

            data.put("TotalAmountGST", in.getTotalAmountGST());
            data.put("GstOnReverseCharge", in.getGstOnReverseCharge());

            data.put("companyBankName", myProfile.getCompanyBankName());
            data.put("companyBankAccount", myProfile.getCompanyBankAccountNo());
            data.put("companyBankIFSC", myProfile.getCompanyBankIFSC());

            data.put("termCond1", myProfile.getTermsCondition1());
            data.put("termCond2", myProfile.getTermsCondition2());
            data.put("termCond3", myProfile.getTermsCondition3());

            // Console output
            out = new StringWriter();
            template.process(data, out);
            out.flush();

            // File output
            Writer file = new FileWriter(new File(outputPath));
            template.process(data, file);
            file.flush();
            file.close();
            // step 1
            Document document = new Document(PageSize.A4, 50, 30, 50, 30);
//            // step 2
            PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(pdfPath));

//            // step 3
            document.open();
//            // step 4

            XMLWorkerHelper.getInstance().parseXHtml(writer, document,
                    new FileInputStream(outputPath), Charset.forName("cp1252"));

            //step 5
            document.close();
        } catch (Exception ex) {
            Logger.getLogger(ConvertToPdf.class.getName()).log(Level.SEVERE, null, ex);
        }

        return out.toString();
    }

    public static String convertPurchase(Invoice in, MyProfile myProfile, CompanyBean cb) {
        Writer out = null;
        try {
            Configuration cfg = new Configuration();
            String templatePath = System.getenv("OPENSHIFT_DATA_DIR");
            if (CommonUtil.getResourceProperties("template.path").equalsIgnoreCase("yes")) {
                templatePath = CommonUtil.directoryPath;
            } else {
                templatePath = CommonUtil.getResourceProperties("template.path");
            }

            String outputPath = CommonUtil.directoryPath + "index.html";
            String pdfPath = CommonUtil.directoryPath + "pdf.pdf";
            //
            cfg.setDirectoryForTemplateLoading(new File(templatePath));

            Template template = cfg.getTemplate("index.ftl");

            // Build the data-model
            Map<String, Object> data = new HashMap<>();
            data.put("companyHeaderName", cb.getCompanyName());
            data.put("companyHeaderAddress", cb.getCompanyAddress());
            data.put("companyHeaderGSTIN", cb.getCompanyGSTIN());
            data.put("companyHeaderTelNo1", cb.getCompanyPhoneNo1());
            data.put("companyHeaderTelNo2", cb.getCompanyPhoneNo2());
            data.put("companyHeaderEmail", cb.getCompanyEmailId());

            data.put("invoiceNo", in.getInvoiceNo());
            data.put("invoiceDate", in.getDate());
            data.put("isReverse", in.getReverseCharge() == null ? "" : in.getReverseCharge());
            data.put("invoiceState", in.getBillToState() == null ? "" : in.getBillToState());
            data.put("invoiceCode", in.getBillToCode() == null ? "" : in.getBillToCode());

            data.put("transMode", in.getTransportMode() == null ? "" : in.getTransportMode());
            data.put("vehicleNo", in.getVehicleNo() == null ? "" : in.getVehicleNo());
            data.put("dateOFSupply", in.getDateOfSupply() == null ? "" : in.getDateOfSupply());
            data.put("placeOfSupply", in.getPlaceOfSupply() == null ? "" : in.getPlaceOfSupply());

            data.put("totalAmountBeforeTax", in.getTotalAmountBeforeTax());
            data.put("cgstPerc", in.getCgstPerc());
            data.put("cgstAmount", in.getCgstAmount());
            data.put("sgstPerc", in.getSgstPerc());
            data.put("sgstAmount", in.getSgstAmount());
            data.put("igstPerc", in.getIgstPerc());
            data.put("igstAmount", in.getIgstAmount());
            data.put("roundOff", in.getRoundOff());
            data.put("totalAmountAfterTax", in.getTotalAmountATax());
            data.put("billamount", in.getTotalAmount());
            data.put("amountInwords", in.getTotalAmountInWords());

            data.put("invoiceDetails", in.getInvoiceDetails());

            data.put("BillToName", myProfile.getCompanyName());
            data.put("BillToAddress", myProfile.getCompanyAddress());
            data.put("BillToGSTIN", myProfile.getCompanyGSTIN());
            data.put("BillToState", myProfile.getCompanyState());
            data.put("BillToCode", myProfile.getCompanyStateCode());

            data.put("ShipToName", in.getShipToName());
            data.put("ShipToAddress", in.getShipToAddress());
            data.put("ShipToGSTIN", in.getShipToGSTIN());
            data.put("ShipToState", in.getShipToState());
            data.put("ShipToCode", in.getShipToCode());

            data.put("TotalAmountGST", in.getTotalAmountGST());
            data.put("GstOnReverseCharge", in.getGstOnReverseCharge());

            data.put("companyBankName", cb.getCompanyBankName() == null ? "" : cb.getCompanyBankName());
            data.put("companyBankAccount", cb.getCompanyBankAccountNo() == null ? "" : cb.getCompanyBankName());
            data.put("companyBankIFSC", cb.getCompanyBankIFSC() == null ? "" : cb.getCompanyBankName());

            data.put("termCond1", myProfile.getTermsCondition1());
            data.put("termCond2", myProfile.getTermsCondition2());
            data.put("termCond3", myProfile.getTermsCondition3());

            // Console output
            out = new StringWriter();
            template.process(data, out);
            out.flush();

            // File output
            Writer file = new FileWriter(new File(outputPath));
            template.process(data, file);
            file.flush();
            file.close();
            // step 1
            Document document = new Document(PageSize.A4, 50, 30, 50, 30);
//            // step 2
            PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(pdfPath));

//            // step 3
            document.open();
//            // step 4

            XMLWorkerHelper.getInstance().parseXHtml(writer, document,
                    new FileInputStream(outputPath), Charset.forName("cp1252"));

            //step 5
            document.close();
        } catch (Exception ex) {
            Logger.getLogger(ConvertToPdf.class.getName()).log(Level.SEVERE, null, ex);
        }

        return out.toString();
    }

}
