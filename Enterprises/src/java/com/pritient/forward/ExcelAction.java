/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pritient.forward;

import com.opensymphony.xwork2.ActionSupport;
import com.pritient.bean.CompanyBean;
import com.pritient.bean.Invoice;
import com.pritient.bean.InvoiceDetails;
import com.pritient.bean.MyProfile;
import com.pritient.bean.dao.CompanyAddressDao;
import com.pritient.bean.dao.InvoiceDao;
import com.pritient.bean.dao.MyProfileDao;
import com.pritient.bean.dao.PurchaseDao;
import com.pritient.util.CommonUtil;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.CellUtil;

/**
 *
 * @author nishant.vibhute
 */
public class ExcelAction extends ActionSupport {

    static final org.apache.log4j.Logger errorLog = org.apache.log4j.Logger.getLogger("errorLogger");
    static final org.apache.log4j.Logger infoLog = org.apache.log4j.Logger.getLogger("infoLogger");
    InvoiceDao invoiceDao = new InvoiceDao();
    public String val;
    MyProfileDao myProfileDao = new MyProfileDao();
    private InputStream fileInputStream;
    private String fileName;
    PurchaseDao purchaseDao = new PurchaseDao();
    CompanyAddressDao companyAddressDao = new CompanyAddressDao();
    String path = "";

    public void createInvoices(String id, String path) {
        this.val = id;
        this.path = path;
        createExcel();
    }

    public void createPurchase(String id, String path) {
        this.val = id;
        this.path = path;
        createExcelForPurchase();
    }

    public String createExcel() {
        try {

            FileOutputStream out = null;
            MyProfile myProfile = myProfileDao.getprofileDetails();
            Invoice invoice = invoiceDao.getInvoiceDetails(Integer.parseInt(val));

            int row = 0;

            HSSFWorkbook workbook = new HSSFWorkbook();
            HSSFFont fontLarge = workbook.createFont();
            HSSFFont fontMedium = workbook.createFont();
            HSSFFont fontSmall = workbook.createFont();
            HSSFCellStyle styleLarge = workbook.createCellStyle();
            HSSFCellStyle styleMedium = workbook.createCellStyle();
            HSSFCellStyle styleSmall = workbook.createCellStyle();

            fontLarge.setFontHeightInPoints((short) 20);
            fontLarge.setFontName("Calibri");
            styleLarge.setFont(fontLarge);

            fontMedium.setFontHeightInPoints((short) 10);
            fontMedium.setFontName("Calibri");
            styleMedium.setFont(fontMedium);
            styleMedium.setWrapText(true);
            styleMedium.setVerticalAlignment(HSSFCellStyle.VERTICAL_TOP);
            fontSmall.setFontHeightInPoints((short) 8);
            fontSmall.setFontName("Calibri");
            styleSmall.setFont(fontSmall);

            Map<String, Object> properties = new HashMap<String, Object>();

// create property set for vertical borders
            properties.put(CellUtil.BORDER_LEFT, CellStyle.BORDER_MEDIUM);
            properties.put(CellUtil.BORDER_RIGHT, CellStyle.BORDER_MEDIUM);

            DataFormat format = workbook.createDataFormat();
            Cell cell;
            int totalCol = 19;
            int leftCol = 11;

            HSSFSheet invoiceSheet;

            invoiceSheet = workbook.createSheet("Invoice");

            cell = invoiceSheet.createRow(row).createCell(0);
            cell.setCellStyle(styleLarge);
            invoiceSheet.addMergedRegion(new CellRangeAddress(0, 0, 0, totalCol));
            invoiceSheet.getRow(row).getCell(0).setCellValue(myProfile.getCompanyName());
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);
            CellUtil.setCellStyleProperty(cell, workbook, CellUtil.BORDER_RIGHT, CellStyle.BORDER_MEDIUM);

            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, ++row, 0, totalCol));
            invoiceSheet.getRow(row - 1).getCell(0).setCellValue(myProfile.getCompanyAddress());
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 0, totalCol));
            invoiceSheet.getRow(row).getCell(0).setCellValue("Tel : " + myProfile.getCompanyPhoneNo1());
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 0, totalCol));
            invoiceSheet.getRow(row).getCell(0).setCellValue("GSTIN : " + myProfile.getCompanyGSTIN());
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            invoiceSheet.getRow(row).getCell(0).setCellValue("");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 0, totalCol));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.createRow(++row).createCell(0);
            HSSFCellStyle style = workbook.createCellStyle();
            style.setFillForegroundColor(HSSFColor.SKY_BLUE.index);
            style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
            style.setFont(fontLarge);
            cell.setCellStyle(style);
            invoiceSheet.getRow(row).getCell(0).setCellValue("Tax Invoice");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, ++row, 0, totalCol));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

//            invoice row start
            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            invoiceSheet.getRow(row).getCell(0).setCellValue("Invoice No. : " + invoice.getInvoiceNo());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 0, leftCol));

            cell = invoiceSheet.getRow(row).createCell(12);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Transport Mode : " + (invoice.getTransportMode() == null ? "" : invoice.getTransportMode()));
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 12, totalCol));

            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            invoiceSheet.getRow(row).getCell(0).setCellValue("Invoice Date : " + invoice.getDate());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 0, leftCol));

            cell = invoiceSheet.getRow(row).createCell(12);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Vehicle Number : " + (invoice.getVehicleNo() == null ? "" : invoice.getVehicleNo()));
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 12, totalCol));

            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            invoiceSheet.getRow(row).getCell(0).setCellValue("Reverse Charge (Y/N) : " + (invoice.getReverseCharge() == null ? "" : invoice.getReverseCharge()));
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 0, leftCol));

            cell = invoiceSheet.getRow(row).createCell(12);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Date of Supply : " + (invoice.getDateOfSupply() == null ? "" : invoice.getDateOfSupply()));
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 12, totalCol));

            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            invoiceSheet.getRow(row).getCell(0).setCellValue("State : " + invoice.getState());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 0, 9));

            cell = invoiceSheet.getRow(row).createCell(10);
            cell.setCellStyle(styleMedium);
            invoiceSheet.getRow(row).getCell(10).setCellValue("Code : " + invoice.getCode());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 10, leftCol));

            cell = invoiceSheet.getRow(row).createCell(12);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Place of Supply : " + (invoice.getPlaceOfSupply() == null ? "" : invoice.getPlaceOfSupply()));
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 12, totalCol));

            //            invoice row ends
            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 0, totalCol));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

//            bill to row starts
            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            invoiceSheet.getRow(row).getCell(0).setCellValue("Bill to Party ");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 0, leftCol));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);
            cell = invoiceSheet.getRow(row).createCell(12);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Ship to Party ");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 12, totalCol));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            invoiceSheet.getRow(row).getCell(0).setCellValue("Name : " + invoice.getBillToName());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 0, leftCol));

            cell = invoiceSheet.getRow(row).createCell(12);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Name : " + invoice.getShipToName());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 12, totalCol));

            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            invoiceSheet.getRow(row).getCell(0).setCellValue("Address : " + invoice.getBillToAddress());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row + 3, 0, leftCol));

            cell = invoiceSheet.getRow(row).createCell(12);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Address : " + invoice.getShipToAddress());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row + 3, 12, totalCol));

            row = row + 3;

            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            invoiceSheet.getRow(row).getCell(0).setCellValue("GSTIN : " + invoice.getBillToGSTIN());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 0, leftCol));

            cell = invoiceSheet.getRow(row).createCell(12);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("GSTIN : " + invoice.getShipToGSTIN());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 12, totalCol));

            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            invoiceSheet.getRow(row).getCell(0).setCellValue("State : " + invoice.getBillToState());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 0, 9));

            cell = invoiceSheet.getRow(row).createCell(10);
            cell.setCellStyle(styleMedium);
            invoiceSheet.getRow(row).getCell(10).setCellValue("Code : " + invoice.getBillToCode());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 10, leftCol));

            cell = invoiceSheet.getRow(row).createCell(12);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("State : " + invoice.getShipToState());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 12, 16));

            cell = invoiceSheet.getRow(row).createCell(17);
            cell.setCellStyle(styleMedium);
            invoiceSheet.getRow(row).getCell(17).setCellValue("Code : " + invoice.getShipToCode());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 17, totalCol));

            //            bill to row ends
            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            invoiceSheet.getRow(row).getCell(0).setCellValue("");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 0, totalCol));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

//            details bill start
            int cellNo = 0;
            cell = invoiceSheet.createRow(++row).createCell(cellNo);
            cell.setCellStyle(styleSmall);
            cell.setCellValue("Sr No. ");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row + 1, cellNo, cellNo));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.getRow(row).createCell(++cellNo);
            cell.setCellStyle(styleSmall);
            cell.setCellValue("Product Description ");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row + 1, cellNo, cellNo + 6));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cellNo = cellNo + 6;
            cell = invoiceSheet.getRow(row).createCell(++cellNo);
            cell.setCellStyle(styleSmall);
            cell.setCellValue("HSN");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row + 1, cellNo, cellNo));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.getRow(row).createCell(++cellNo);
            cell.setCellStyle(styleSmall);
            cell.setCellValue("UOM");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row + 1, cellNo, cellNo));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.getRow(row).createCell(++cellNo);
            cell.setCellStyle(styleSmall);
            cell.setCellValue("QTY");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row + 1, cellNo, cellNo));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.getRow(row).createCell(++cellNo);
            cell.setCellStyle(styleSmall);
            cell.setCellValue("Rate");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row + 1, cellNo, cellNo));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.getRow(row).createCell(++cellNo);
            cell.setCellStyle(styleSmall);
            cell.setCellValue("AMOUNT");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row + 1, cellNo, cellNo));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.getRow(row).createCell(++cellNo);
            cell.setCellStyle(styleSmall);
            cell.setCellValue("CGST");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, cellNo, cellNo + 1));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            int r = row + 1;
            cell = invoiceSheet.createRow(r).createCell(cellNo);
            cell.setCellStyle(styleSmall);
            cell.setCellValue("Rate");
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.getRow(r).createCell(++cellNo);
            cell.setCellStyle(styleSmall);
            cell.setCellValue("Discount");
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.getRow(row).createCell(++cellNo);
            cell.setCellStyle(styleSmall);
            cell.setCellValue("SGST");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, cellNo, cellNo + 1));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.getRow(r).createCell(cellNo);
            cell.setCellStyle(styleSmall);
            cell.setCellValue("Rate");
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.getRow(r).createCell(++cellNo);
            cell.setCellStyle(styleSmall);
            cell.setCellValue("Discount");
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.getRow(row).createCell(++cellNo);
            cell.setCellStyle(styleSmall);
            cell.setCellValue("IGST");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, cellNo, cellNo + 1));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.getRow(r).createCell(cellNo);
            cell.setCellStyle(styleSmall);
            cell.setCellValue("Rate");
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.getRow(r).createCell(++cellNo);
            cell.setCellStyle(styleSmall);
            cell.setCellValue("Discount");
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.getRow(row).createCell(++cellNo);
            cell.setCellStyle(styleSmall);
            cell.setCellValue("TOTAL");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row + 1, cellNo, cellNo));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);
            row = row + 1;
            List<InvoiceDetails> idList = invoice.getInvoiceDetails();
            int cnt = 0;
            for (int i = 0; i < idList.size(); i++) {
                InvoiceDetails id = idList.get(i);
                cnt++;
                if (id != null) {
                    String srNo = "" + (i + 1);
                    String prodDesc = id.getProductName();
                    String hsn = id.getHsn();
                    String qty = "" + id.getQty();
                    String UOM = "" + id.getUom();
                    String rate = "" + id.getPrice();
                    String amount = "" + id.getAmount();
                    String cgstPerc = "" + id.getCgstPerc();
                    String cgstAmt = "" + id.getCgstAmount();
                    String sgstPerc = "" + id.getSgstPerc();
                    String sgstAmt = "" + id.getSgstAmount();
                    String igstPerc = "" + id.getIgstPerc();
                    String igstAmt = "" + id.getIgstAmount();
                    String totalAmt = "" + id.getTotalAmountAfterTax();

                    int cellNo1 = 0;
                    cell = invoiceSheet.createRow(++row).createCell(cellNo1);
                    cell.setCellStyle(styleSmall);
                    cell.setCellValue(srNo);

                    CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

                    cell = invoiceSheet.getRow(row).createCell(++cellNo1);
                    cell.setCellStyle(styleSmall);
                    cell.setCellValue(prodDesc);
                    invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, cellNo1, cellNo1 + 6));
                    CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

                    cellNo1 = cellNo1 + 6;
                    cell = invoiceSheet.getRow(row).createCell(++cellNo1);
                    cell.setCellStyle(styleSmall);
                    cell.setCellValue(hsn);

                    CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

                    cell = invoiceSheet.getRow(row).createCell(++cellNo1);
                    cell.setCellStyle(styleSmall);
                    cell.setCellValue(UOM);

                    CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

                    cell = invoiceSheet.getRow(row).createCell(++cellNo1);
                    cell.setCellStyle(styleSmall);
                    cell.setCellValue(qty);

                    CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

                    cell = invoiceSheet.getRow(row).createCell(++cellNo1);
                    cell.setCellStyle(styleSmall);
                    cell.setCellValue(rate);

                    CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

                    cell = invoiceSheet.getRow(row).createCell(++cellNo1);
                    cell.setCellStyle(styleSmall);
                    cell.setCellValue(amount);

                    CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

                    cell = invoiceSheet.getRow(row).createCell(++cellNo1);
                    cell.setCellStyle(styleSmall);
                    cell.setCellValue(cgstPerc);
                    CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

                    cell = invoiceSheet.getRow(row).createCell(++cellNo1);
                    cell.setCellStyle(styleSmall);
                    cell.setCellValue(cgstAmt);
                    CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

                    cell = invoiceSheet.getRow(row).createCell(++cellNo1);
                    cell.setCellStyle(styleSmall);
                    cell.setCellValue(sgstPerc);
                    CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

                    cell = invoiceSheet.getRow(row).createCell(++cellNo1);
                    cell.setCellStyle(styleSmall);
                    cell.setCellValue(sgstAmt);
                    CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

                    cell = invoiceSheet.getRow(row).createCell(++cellNo1);
                    cell.setCellStyle(styleSmall);
                    cell.setCellValue(igstPerc);
                    CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

                    cell = invoiceSheet.getRow(row).createCell(++cellNo1);
                    cell.setCellStyle(styleSmall);
                    cell.setCellValue(igstAmt);
                    CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

                    cell = invoiceSheet.getRow(row).createCell(++cellNo1);
                    cell.setCellStyle(styleSmall);
                    cell.setCellValue(totalAmt);

                    CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);
                }
            }

            for (int m = cnt + 1; m <= 10; m++) {
                int cellNo1 = 0;
                cell = invoiceSheet.createRow(++row).createCell(cellNo1);
                cell.setCellValue("" + m);
                CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);
                for (int k = 1; k < 19; k++) {
                    cell = invoiceSheet.getRow(row).createCell(k);
                    cell.setCellValue("");
                }

                invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 1, 7));

            }

            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Total");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 0, leftCol - 1));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_RIGHT);

            cell = invoiceSheet.getRow(row).createCell(12);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("" + invoice.getTotalAmountBeforeTax());
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.getRow(row).createCell(14);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("" + invoice.getCgstAmount());
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.getRow(row).createCell(16);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("" + invoice.getSgstAmount());
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.getRow(row).createCell(18);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("" + invoice.getIgstAmount());
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.getRow(row).createCell(19);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("" + invoice.getTotalAmountATax());

            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

//            detail bill end
            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 0, totalCol));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

//            bill amount details starts
            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Total Invoice Amount in words");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 0, leftCol));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.getRow(row).createCell(12);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Total Amount Before Tax: ");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 12, 17));

            cell = invoiceSheet.getRow(row).createCell(18);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("" + invoice.getTotalAmountBeforeTax());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 18, 19));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_RIGHT);
            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("" + invoice.getTotalAmountInWords());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 0, leftCol));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.getRow(row).createCell(12);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Add : CGST " + invoice.getCgstPerc() + "%");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 12, 17));

            cell = invoiceSheet.getRow(row).createCell(18);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("" + invoice.getCgstAmount());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 18, 19));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_RIGHT);

            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Bank Details");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 0, leftCol));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);
            cell = invoiceSheet.createRow(row).createCell(12);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Add : SGST " + invoice.getSgstPerc() + "%");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 12, 17));

            cell = invoiceSheet.getRow(row).createCell(18);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("" + invoice.getSgstAmount());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 18, 19));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_RIGHT);

            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Bank Name : " + myProfile.getCompanyBankName());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 0, leftCol));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_LEFT);
            cell = invoiceSheet.getRow(row).createCell(12);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Add : IGST " + invoice.getIgstPerc() + "%");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 12, 17));

            cell = invoiceSheet.getRow(row).createCell(18);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("" + invoice.getIgstAmount());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 18, 19));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_RIGHT);

            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Bank Branch : " + myProfile.getCompanyBankBranch());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 0, leftCol));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_LEFT);

            cell = invoiceSheet.getRow(row).createCell(12);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Total Tax Amount: ");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 12, 17));

            cell = invoiceSheet.getRow(row).createCell(18);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("" + invoice.getTotalAmountGST());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 18, 19));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_RIGHT);
            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Bank A/C : " + myProfile.getCompanyBankAccountNo());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 0, leftCol));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_LEFT);

            cell = invoiceSheet.getRow(row).createCell(12);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Total Amount After Tax: ");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 12, 17));

            cell = invoiceSheet.getRow(row).createCell(18);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("" + invoice.getTotalAmountATax());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 18, 19));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_RIGHT);
            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Bank IFSC : " + myProfile.getCompanyBankIFSC());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 0, leftCol));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_LEFT);

            cell = invoiceSheet.getRow(row).createCell(12);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Round Off: ");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 12, 17));

            cell = invoiceSheet.getRow(row).createCell(18);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("" + invoice.getRoundOff());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 18, 19));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_RIGHT);
            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Terms & Condition ");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 0, 6));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.getRow(row).createCell(7);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row + 7, 7, leftCol));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.getRow(row).createCell(12);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Final Amount: ");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 12, 17));

            cell = invoiceSheet.getRow(row).createCell(18);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("" + invoice.getTotalAmount());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 18, 19));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_RIGHT);

            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            cell.setCellValue(myProfile.getTermsCondition1() + "\n" + myProfile.getTermsCondition2() + "\n" + myProfile.getTermsCondition3());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row + 7, 0, 6));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_LEFT);

            cell = invoiceSheet.getRow(row).createCell(12);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("GST on Reverse Charge: ");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 12, 17));

            cell = invoiceSheet.getRow(row).createCell(18);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("" + invoice.getGstOnReverseCharge());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 18, 19));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_RIGHT);
            cell = invoiceSheet.createRow(++row).createCell(12);
            cell.setCellStyle(styleSmall);
            cell.setCellValue("Ceritified that the particulars given above are true and correct");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 12, totalCol));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.createRow(++row).createCell(12);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("For " + myProfile.getCompanyName());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 12, totalCol));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.createRow(++row).createCell(12);
            cell.setCellStyle(styleSmall);
            cell.setCellValue("");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row + 3, 12, totalCol));

            row = row + 3;

            cell = invoiceSheet.createRow(++row).createCell(7);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Receiver Signature");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 7, leftCol));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.getRow(row).createCell(12);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Authorised signatory");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 12, totalCol));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

//            for (int i = 0; i < 53; i++) {
//                CellRangeAddress mergedRegions = invoiceSheet.getMergedRegion(i);
//                RegionUtil.setBorderTop(CellStyle.BORDER_THIN, mergedRegions, invoiceSheet, workbook);
//                RegionUtil.setBorderLeft(CellStyle.BORDER_THIN, mergedRegions, invoiceSheet, workbook);
//                RegionUtil.setBorderRight(CellStyle.BORDER_THIN, mergedRegions, invoiceSheet, workbook);
//                RegionUtil.setBorderBottom(CellStyle.BORDER_THIN, mergedRegions, invoiceSheet, workbook);
//            }
//            for (int i = 0; i < 20; i++) {
//                invoiceSheet.autoSizeColumn(i);
//            }
            invoiceSheet.setColumnWidth(0, 1500);
            invoiceSheet.setColumnWidth(1, 1000);
            invoiceSheet.setColumnWidth(2, 1000);
            invoiceSheet.setColumnWidth(3, 1000);
            invoiceSheet.setColumnWidth(4, 1000);
            invoiceSheet.setColumnWidth(5, 1000);
            invoiceSheet.setColumnWidth(6, 1000);
            invoiceSheet.setColumnWidth(7, 1000);
            invoiceSheet.setColumnWidth(8, 2000);
            invoiceSheet.setColumnWidth(9, 1500);
            invoiceSheet.setColumnWidth(10, 1500);
            invoiceSheet.setColumnWidth(11, 1500);
            invoiceSheet.setColumnWidth(12, 2000);
            invoiceSheet.setColumnWidth(13, 1000);
            invoiceSheet.setColumnWidth(14, 2000);
            invoiceSheet.setColumnWidth(15, 1000);
            invoiceSheet.setColumnWidth(16, 2000);
            invoiceSheet.setColumnWidth(17, 1000);
            invoiceSheet.setColumnWidth(18, 2000);
            invoiceSheet.setColumnWidth(19, 2000);

//           bill amount details  ends
            String fileName = "Invoice_" + invoice.getInvoiceNo() + "_" + invoice.getBillToName() + ".xls";

            if (path.equals("")) {
                File file = new File(CommonUtil.getResourceProperties("directory.path") + fileName);
                out = new FileOutputStream(file);
                workbook.write(out);
                out.close();
                fileInputStream = new FileInputStream(file);
                this.setFileName(fileName);
                file.delete();
            } else {

                File file = new File(this.path + "/" + fileName);
                out = new FileOutputStream(file);
                workbook.write(out);
                out.close();

            }
//            File file = new File(System.getenv("OPENSHIFT_DATA_DIR") + fileName);

        } catch (Exception ex) {
            errorLog.error("ExcelAction : " + ex);
        }
        return ActionSupport.SUCCESS;
    }

    public String createExcelForPurchase() {
        try {

            FileOutputStream out = null;
            MyProfile myProfile = myProfileDao.getprofileDetails();
            Invoice invoice = purchaseDao.getPurchaseDetails(Integer.parseInt(val));
            CompanyBean companyBean = companyAddressDao.getCompanyDetails(invoice.getBillTO());
            int row = 0;

            HSSFWorkbook workbook = new HSSFWorkbook();
            HSSFFont fontLarge = workbook.createFont();
            HSSFFont fontMedium = workbook.createFont();
            HSSFFont fontSmall = workbook.createFont();
            HSSFCellStyle styleLarge = workbook.createCellStyle();
            HSSFCellStyle styleMedium = workbook.createCellStyle();
            HSSFCellStyle styleSmall = workbook.createCellStyle();

            fontLarge.setFontHeightInPoints((short) 20);
            fontLarge.setFontName("Calibri");
            styleLarge.setFont(fontLarge);

            fontMedium.setFontHeightInPoints((short) 10);
            fontMedium.setFontName("Calibri");
            styleMedium.setFont(fontMedium);
            styleMedium.setWrapText(true);
            styleMedium.setVerticalAlignment(HSSFCellStyle.VERTICAL_TOP);
            fontSmall.setFontHeightInPoints((short) 8);
            fontSmall.setFontName("Calibri");
            styleSmall.setFont(fontSmall);

            Map<String, Object> properties = new HashMap<String, Object>();

// create property set for vertical borders
            properties.put(CellUtil.BORDER_LEFT, CellStyle.BORDER_MEDIUM);
            properties.put(CellUtil.BORDER_RIGHT, CellStyle.BORDER_MEDIUM);

            DataFormat format = workbook.createDataFormat();
            Cell cell;
            int totalCol = 19;
            int leftCol = 11;

            HSSFSheet invoiceSheet;

            invoiceSheet = workbook.createSheet("Invoice");

            cell = invoiceSheet.createRow(row).createCell(0);
            cell.setCellStyle(styleLarge);
            invoiceSheet.addMergedRegion(new CellRangeAddress(0, 0, 0, totalCol));
            invoiceSheet.getRow(row).getCell(0).setCellValue(companyBean.getCompanyName());
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);
            CellUtil.setCellStyleProperty(cell, workbook, CellUtil.BORDER_RIGHT, CellStyle.BORDER_MEDIUM);

            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, ++row, 0, totalCol));
            invoiceSheet.getRow(row - 1).getCell(0).setCellValue(companyBean.getCompanyAddress());
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 0, totalCol));
            invoiceSheet.getRow(row).getCell(0).setCellValue("Tel : " + companyBean.getCompanyPhoneNo1());
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 0, totalCol));
            invoiceSheet.getRow(row).getCell(0).setCellValue("GSTIN : " + companyBean.getCompanyGSTIN());
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            invoiceSheet.getRow(row).getCell(0).setCellValue("");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 0, totalCol));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.createRow(++row).createCell(0);
            HSSFCellStyle style = workbook.createCellStyle();
            style.setFillForegroundColor(HSSFColor.SKY_BLUE.index);
            style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
            style.setFont(fontLarge);
            cell.setCellStyle(style);
            invoiceSheet.getRow(row).getCell(0).setCellValue("Tax Invoice");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, ++row, 0, totalCol));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

//            invoice row start
            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            invoiceSheet.getRow(row).getCell(0).setCellValue("Invoice No. : " + invoice.getInvoiceNo());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 0, leftCol));

            cell = invoiceSheet.getRow(row).createCell(12);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Transport Mode : " + (invoice.getTransportMode() == null ? "" : invoice.getTransportMode()));
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 12, totalCol));

            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            invoiceSheet.getRow(row).getCell(0).setCellValue("Invoice Date : " + invoice.getDate());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 0, leftCol));

            cell = invoiceSheet.getRow(row).createCell(12);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Vehicle Number : " + (invoice.getVehicleNo() == null ? "" : invoice.getVehicleNo()));
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 12, totalCol));

            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            invoiceSheet.getRow(row).getCell(0).setCellValue("Reverse Charge (Y/N) : " + (invoice.getReverseCharge() == null ? "" : invoice.getReverseCharge()));
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 0, leftCol));

            cell = invoiceSheet.getRow(row).createCell(12);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Date of Supply : " + (invoice.getDateOfSupply() == null ? "" : invoice.getDateOfSupply()));
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 12, totalCol));

            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            invoiceSheet.getRow(row).getCell(0).setCellValue("State : " + companyBean.getCompanyState());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 0, 9));

            cell = invoiceSheet.getRow(row).createCell(10);
            cell.setCellStyle(styleMedium);
            invoiceSheet.getRow(row).getCell(10).setCellValue("Code : " + companyBean.getCompanyStateCode());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 10, leftCol));

            cell = invoiceSheet.getRow(row).createCell(12);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Place of Supply : " + (invoice.getPlaceOfSupply() == null ? "" : invoice.getPlaceOfSupply()));
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 12, totalCol));

            //            invoice row ends
            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 0, totalCol));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

//            bill to row starts
            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            invoiceSheet.getRow(row).getCell(0).setCellValue("Bill to Party ");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 0, leftCol));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);
            cell = invoiceSheet.getRow(row).createCell(12);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Ship to Party ");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 12, totalCol));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            invoiceSheet.getRow(row).getCell(0).setCellValue("Name : " + myProfile.getCompanyName());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 0, leftCol));

            cell = invoiceSheet.getRow(row).createCell(12);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Name : " + invoice.getShipToName());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 12, totalCol));

            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            invoiceSheet.getRow(row).getCell(0).setCellValue("Address : " + myProfile.getCompanyAddress());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row + 3, 0, leftCol));

            cell = invoiceSheet.getRow(row).createCell(12);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Address : " + invoice.getShipToAddress());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row + 3, 12, totalCol));

            row = row + 3;

            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            invoiceSheet.getRow(row).getCell(0).setCellValue("GSTIN : " + myProfile.getCompanyGSTIN());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 0, leftCol));

            cell = invoiceSheet.getRow(row).createCell(12);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("GSTIN : " + invoice.getShipToGSTIN());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 12, totalCol));

            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            invoiceSheet.getRow(row).getCell(0).setCellValue("State : " + myProfile.getCompanyState());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 0, 9));

            cell = invoiceSheet.getRow(row).createCell(10);
            cell.setCellStyle(styleMedium);
            invoiceSheet.getRow(row).getCell(10).setCellValue("Code : " + myProfile.getCompanyStateCode());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 10, leftCol));

            cell = invoiceSheet.getRow(row).createCell(12);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("State : " + invoice.getShipToState());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 12, 16));

            cell = invoiceSheet.getRow(row).createCell(17);
            cell.setCellStyle(styleMedium);
            invoiceSheet.getRow(row).getCell(17).setCellValue("Code : " + invoice.getShipToCode());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 17, totalCol));

            //            bill to row ends
            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            invoiceSheet.getRow(row).getCell(0).setCellValue("");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 0, totalCol));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

//            details bill start
            int cellNo = 0;
            cell = invoiceSheet.createRow(++row).createCell(cellNo);
            cell.setCellStyle(styleSmall);
            cell.setCellValue("Sr No. ");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row + 1, cellNo, cellNo));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.getRow(row).createCell(++cellNo);
            cell.setCellStyle(styleSmall);
            cell.setCellValue("Product Description ");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row + 1, cellNo, cellNo + 6));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cellNo = cellNo + 6;
            cell = invoiceSheet.getRow(row).createCell(++cellNo);
            cell.setCellStyle(styleSmall);
            cell.setCellValue("HSN");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row + 1, cellNo, cellNo));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.getRow(row).createCell(++cellNo);
            cell.setCellStyle(styleSmall);
            cell.setCellValue("UOM");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row + 1, cellNo, cellNo));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.getRow(row).createCell(++cellNo);
            cell.setCellStyle(styleSmall);
            cell.setCellValue("QTY");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row + 1, cellNo, cellNo));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.getRow(row).createCell(++cellNo);
            cell.setCellStyle(styleSmall);
            cell.setCellValue("Rate");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row + 1, cellNo, cellNo));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.getRow(row).createCell(++cellNo);
            cell.setCellStyle(styleSmall);
            cell.setCellValue("AMOUNT");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row + 1, cellNo, cellNo));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.getRow(row).createCell(++cellNo);
            cell.setCellStyle(styleSmall);
            cell.setCellValue("CGST");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, cellNo, cellNo + 1));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            int r = row + 1;
            cell = invoiceSheet.createRow(r).createCell(cellNo);
            cell.setCellStyle(styleSmall);
            cell.setCellValue("Rate");
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.getRow(r).createCell(++cellNo);
            cell.setCellStyle(styleSmall);
            cell.setCellValue("Discount");
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.getRow(row).createCell(++cellNo);
            cell.setCellStyle(styleSmall);
            cell.setCellValue("SGST");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, cellNo, cellNo + 1));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.getRow(r).createCell(cellNo);
            cell.setCellStyle(styleSmall);
            cell.setCellValue("Rate");
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.getRow(r).createCell(++cellNo);
            cell.setCellStyle(styleSmall);
            cell.setCellValue("Discount");
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.getRow(row).createCell(++cellNo);
            cell.setCellStyle(styleSmall);
            cell.setCellValue("IGST");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, cellNo, cellNo + 1));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.getRow(r).createCell(cellNo);
            cell.setCellStyle(styleSmall);
            cell.setCellValue("Rate");
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.getRow(r).createCell(++cellNo);
            cell.setCellStyle(styleSmall);
            cell.setCellValue("Discount");
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.getRow(row).createCell(++cellNo);
            cell.setCellStyle(styleSmall);
            cell.setCellValue("TOTAL");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row + 1, cellNo, cellNo));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);
            row = row + 1;
            List<InvoiceDetails> idList = invoice.getInvoiceDetails();
            int cnt = 0;
            for (int i = 0; i < idList.size(); i++) {
                InvoiceDetails id = idList.get(i);
                cnt++;
                if (id != null) {
                    String srNo = "" + (i + 1);
                    String prodDesc = id.getProductName();
                    String hsn = id.getHsn();
                    String qty = "" + id.getQty();
                    String UOM = "" + id.getUom();
                    String rate = "" + id.getPrice();
                    String amount = "" + id.getAmount();
                    String cgstPerc = "" + id.getCgstPerc();
                    String cgstAmt = "" + id.getCgstAmount();
                    String sgstPerc = "" + id.getSgstPerc();
                    String sgstAmt = "" + id.getSgstAmount();
                    String igstPerc = "" + id.getIgstPerc();
                    String igstAmt = "" + id.getIgstAmount();
                    String totalAmt = "" + id.getTotalAmountAfterTax();

                    int cellNo1 = 0;
                    cell = invoiceSheet.createRow(++row).createCell(cellNo1);
                    cell.setCellStyle(styleSmall);
                    cell.setCellValue(srNo);

                    CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

                    cell = invoiceSheet.getRow(row).createCell(++cellNo1);
                    cell.setCellStyle(styleSmall);
                    cell.setCellValue(prodDesc);
                    invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, cellNo1, cellNo1 + 6));
                    CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

                    cellNo1 = cellNo1 + 6;
                    cell = invoiceSheet.getRow(row).createCell(++cellNo1);
                    cell.setCellStyle(styleSmall);
                    cell.setCellValue(hsn);

                    CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

                    cell = invoiceSheet.getRow(row).createCell(++cellNo1);
                    cell.setCellStyle(styleSmall);
                    cell.setCellValue(UOM);

                    CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

                    cell = invoiceSheet.getRow(row).createCell(++cellNo1);
                    cell.setCellStyle(styleSmall);
                    cell.setCellValue(qty);

                    CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

                    cell = invoiceSheet.getRow(row).createCell(++cellNo1);
                    cell.setCellStyle(styleSmall);
                    cell.setCellValue(rate);

                    CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

                    cell = invoiceSheet.getRow(row).createCell(++cellNo1);
                    cell.setCellStyle(styleSmall);
                    cell.setCellValue(amount);

                    CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

                    cell = invoiceSheet.getRow(row).createCell(++cellNo1);
                    cell.setCellStyle(styleSmall);
                    cell.setCellValue(cgstPerc);
                    CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

                    cell = invoiceSheet.getRow(row).createCell(++cellNo1);
                    cell.setCellStyle(styleSmall);
                    cell.setCellValue(cgstAmt);
                    CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

                    cell = invoiceSheet.getRow(row).createCell(++cellNo1);
                    cell.setCellStyle(styleSmall);
                    cell.setCellValue(sgstPerc);
                    CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

                    cell = invoiceSheet.getRow(row).createCell(++cellNo1);
                    cell.setCellStyle(styleSmall);
                    cell.setCellValue(sgstAmt);
                    CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

                    cell = invoiceSheet.getRow(row).createCell(++cellNo1);
                    cell.setCellStyle(styleSmall);
                    cell.setCellValue(igstPerc);
                    CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

                    cell = invoiceSheet.getRow(row).createCell(++cellNo1);
                    cell.setCellStyle(styleSmall);
                    cell.setCellValue(igstAmt);
                    CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

                    cell = invoiceSheet.getRow(row).createCell(++cellNo1);
                    cell.setCellStyle(styleSmall);
                    cell.setCellValue(totalAmt);

                    CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);
                }
            }

            for (int m = cnt + 1; m <= 10; m++) {
                int cellNo1 = 0;
                cell = invoiceSheet.createRow(++row).createCell(cellNo1);
                cell.setCellValue("" + m);
                CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);
                for (int k = 1; k < 19; k++) {
                    cell = invoiceSheet.getRow(row).createCell(k);
                    cell.setCellValue("");
                }

                invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 1, 7));

            }

            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Total");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 0, leftCol - 1));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_RIGHT);

            cell = invoiceSheet.getRow(row).createCell(12);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("" + invoice.getTotalAmountBeforeTax());
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.getRow(row).createCell(14);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("" + invoice.getCgstAmount());
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.getRow(row).createCell(16);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("" + invoice.getSgstAmount());
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.getRow(row).createCell(18);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("" + invoice.getIgstAmount());
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.getRow(row).createCell(19);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("" + invoice.getTotalAmountATax());

            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

//            detail bill end
            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 0, totalCol));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

//            bill amount details starts
            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Total Invoice Amount in words");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 0, leftCol));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.getRow(row).createCell(12);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Total Amount Before Tax: ");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 12, 17));

            cell = invoiceSheet.getRow(row).createCell(18);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("" + invoice.getTotalAmountBeforeTax());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 18, 19));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_RIGHT);
            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("" + invoice.getTotalAmountInWords());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row + 1, 0, leftCol));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.getRow(row).createCell(12);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Add : CGST " + invoice.getCgstPerc() + "%");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 12, 17));

            cell = invoiceSheet.getRow(row).createCell(18);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("" + invoice.getCgstAmount());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 18, 19));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_RIGHT);
            cell = invoiceSheet.createRow(++row).createCell(12);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Add : SGST " + invoice.getSgstPerc() + "%");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 12, 17));

            cell = invoiceSheet.getRow(row).createCell(18);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("" + invoice.getSgstAmount());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 18, 19));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_RIGHT);

            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Bank Details");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 0, leftCol));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);
            cell = invoiceSheet.getRow(row).createCell(12);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Add : IGST " + invoice.getIgstPerc() + "%");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 12, 17));

            cell = invoiceSheet.getRow(row).createCell(18);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("" + invoice.getIgstAmount());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 18, 19));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_RIGHT);

            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Bank A/C : " + companyBean.getCompanyBankName());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 0, leftCol));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_LEFT);

            cell = invoiceSheet.getRow(row).createCell(12);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Total Tax Amount: ");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 12, 17));

            cell = invoiceSheet.getRow(row).createCell(18);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("" + invoice.getTotalAmountGST());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 18, 19));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_RIGHT);
            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Bank A/C : " + companyBean.getCompanyBankAccountNo());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 0, leftCol));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_LEFT);

            cell = invoiceSheet.getRow(row).createCell(12);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Total Amount After Tax: ");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 12, 17));

            cell = invoiceSheet.getRow(row).createCell(18);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("" + invoice.getTotalAmountATax());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 18, 19));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_RIGHT);
            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Bank IFSC : " + companyBean.getCompanyBankIFSC());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 0, leftCol));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_LEFT);

            cell = invoiceSheet.getRow(row).createCell(12);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Round Off: ");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 12, 17));

            cell = invoiceSheet.getRow(row).createCell(18);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("" + invoice.getRoundOff());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 18, 19));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_RIGHT);
            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Terms & Condition ");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 0, 6));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.getRow(row).createCell(7);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row + 7, 7, leftCol));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.getRow(row).createCell(12);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Final Amount: ");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 12, 17));

            cell = invoiceSheet.getRow(row).createCell(18);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("" + invoice.getTotalAmount());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 18, 19));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_RIGHT);

            cell = invoiceSheet.createRow(++row).createCell(0);
            cell.setCellStyle(styleMedium);
            cell.setCellValue(myProfile.getTermsCondition1() + "\n" + myProfile.getTermsCondition2() + "\n" + myProfile.getTermsCondition3());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row + 7, 0, 6));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_LEFT);

            cell = invoiceSheet.getRow(row).createCell(12);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("GST on Reverse Charge: ");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 12, 17));

            cell = invoiceSheet.getRow(row).createCell(18);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("" + invoice.getGstOnReverseCharge());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 18, 19));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_RIGHT);
            cell = invoiceSheet.createRow(++row).createCell(12);
            cell.setCellStyle(styleSmall);
            cell.setCellValue("Ceritified that the particulars given above are true and correct");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 12, totalCol));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.createRow(++row).createCell(12);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("For " + companyBean.getCompanyName());
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 12, totalCol));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.createRow(++row).createCell(12);
            cell.setCellStyle(styleSmall);
            cell.setCellValue("");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row + 3, 12, totalCol));

            row = row + 3;

            cell = invoiceSheet.createRow(++row).createCell(7);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Receiver Signature");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 7, leftCol));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

            cell = invoiceSheet.getRow(row).createCell(12);
            cell.setCellStyle(styleMedium);
            cell.setCellValue("Authorised signatory");
            invoiceSheet.addMergedRegion(new CellRangeAddress(row, row, 12, totalCol));
            CellUtil.setAlignment(cell, workbook, CellStyle.ALIGN_CENTER);

//            for (int i = 0; i < 53; i++) {
//                CellRangeAddress mergedRegions = invoiceSheet.getMergedRegion(i);
//                RegionUtil.setBorderTop(CellStyle.BORDER_THIN, mergedRegions, invoiceSheet, workbook);
//                RegionUtil.setBorderLeft(CellStyle.BORDER_THIN, mergedRegions, invoiceSheet, workbook);
//                RegionUtil.setBorderRight(CellStyle.BORDER_THIN, mergedRegions, invoiceSheet, workbook);
//                RegionUtil.setBorderBottom(CellStyle.BORDER_THIN, mergedRegions, invoiceSheet, workbook);
//            }
//            for (int i = 0; i < 20; i++) {
//                invoiceSheet.autoSizeColumn(i);
//            }
            invoiceSheet.setColumnWidth(0, 1500);
            invoiceSheet.setColumnWidth(1, 1000);
            invoiceSheet.setColumnWidth(2, 1000);
            invoiceSheet.setColumnWidth(3, 1000);
            invoiceSheet.setColumnWidth(4, 1000);
            invoiceSheet.setColumnWidth(5, 1000);
            invoiceSheet.setColumnWidth(6, 1000);
            invoiceSheet.setColumnWidth(7, 1000);
            invoiceSheet.setColumnWidth(8, 2000);
            invoiceSheet.setColumnWidth(9, 1500);
            invoiceSheet.setColumnWidth(10, 1500);
            invoiceSheet.setColumnWidth(11, 1500);
            invoiceSheet.setColumnWidth(12, 2000);
            invoiceSheet.setColumnWidth(13, 1000);
            invoiceSheet.setColumnWidth(14, 2000);
            invoiceSheet.setColumnWidth(15, 1000);
            invoiceSheet.setColumnWidth(16, 2000);
            invoiceSheet.setColumnWidth(17, 1000);
            invoiceSheet.setColumnWidth(18, 2000);
            invoiceSheet.setColumnWidth(19, 2000);

//           bill amount details  ends
            String fileName = "Purchase_" + invoice.getInvoiceNo() + "_" + companyBean.getCompanyName() + ".xls";
//            File file = new File(System.getenv("OPENSHIFT_DATA_DIR") + fileName);
            if (path.equals("")) {
                File file = new File(CommonUtil.getResourceProperties("directory.path") + fileName);
                out = new FileOutputStream(file);
                workbook.write(out);
                out.close();
                fileInputStream = new FileInputStream(file);
                this.setFileName(fileName);
                file.delete();
            } else {

                File file = new File(this.path + "/" + fileName);
                out = new FileOutputStream(file);
                workbook.write(out);
                out.close();

            }

        } catch (Exception ex) {
            errorLog.error("ExcelAction : " + ex);
        }
        return ActionSupport.SUCCESS;
    }

    public String getVal() {
        return val;
    }

    public void setVal(String val) {
        this.val = val;
    }

    public InputStream getFileInputStream() {
        return fileInputStream;
    }

    public void setFileInputStream(InputStream fileInputStream) {
        this.fileInputStream = fileInputStream;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

}
