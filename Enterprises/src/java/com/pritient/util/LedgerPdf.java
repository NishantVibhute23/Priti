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
import com.pritient.bean.LedgerBean;
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

/**
 *
 * @author nishant.vibhute
 */
public class LedgerPdf {

    static final org.apache.log4j.Logger errorLog = org.apache.log4j.Logger.getLogger("errorLogger");
    static final org.apache.log4j.Logger infoLog = org.apache.log4j.Logger.getLogger("infoLogger");

    public static String convert(LedgerBean ledger, MyProfile myProfile, String fromDate, String toDate) {
        Writer out = null;
        try {
            Configuration cfg = new Configuration();
            String templatePath = System.getenv("OPENSHIFT_DATA_DIR");
            if (CommonUtil.getResourceProperties("template.path").equalsIgnoreCase("yes")) {
                templatePath = CommonUtil.directoryPath;
            } else {
                templatePath = CommonUtil.getResourceProperties("template.path");
            }

            String outputPath = CommonUtil.directoryPath + "ledger.html";
            String pdfPath = CommonUtil.directoryPath + "ledger.pdf";
            //
            cfg.setDirectoryForTemplateLoading(new File(templatePath));

            Template template = cfg.getTemplate("ledger.ftl");

            // Build the data-model
            Map<String, Object> data = new HashMap<>();
            data.put("companyHeaderName", myProfile.getCompanyName());
            data.put("companyHeaderAddress", myProfile.getCompanyAddress());
            data.put("companyHeaderGSTIN", myProfile.getCompanyGSTIN());
            data.put("fromDate", fromDate);
            data.put("toDate", toDate);

            data.put("ledgerDetails", ledger.getLedgerRow());
            data.put("debitTotal", ledger.getDebitTotal());
            data.put("creditTotal", ledger.getCreditTotal());

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
            errorLog.error("LedgerPdf : " + ex);
        }

        return out.toString();
    }

}
