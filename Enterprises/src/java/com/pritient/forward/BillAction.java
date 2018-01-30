/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pritient.forward;

import com.opensymphony.xwork2.ActionSupport;
import com.pritient.bean.dao.BillDao;
import com.pritient.util.CommonUtil;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

/**
 *
 * @author Nishant
 */
public class BillAction extends ActionSupport {

    BillDao billDao = new BillDao();
    String fromDate, toDate;
    private InputStream fileInputStream;
    private String fileName;
    ExcelAction excelAction = new ExcelAction();

    String successMessage = "";
    String errorMessage = "";

    @Override
    public String execute() {
        return ActionSupport.SUCCESS;
    }

    public String download() {
        ZipOutputStream out = null;
        File inFolder = null, outFolder = null;
        String fileNameZip = null;
        try {
            fileNameZip = "Bills_From-" + CommonUtil.convertDateToHyphen(fromDate) + "_To_" + CommonUtil.convertDateToHyphen(toDate) + ".zip";
            String path = CommonUtil.directoryPath + "/Bills_From-" + CommonUtil.convertDateToHyphen(fromDate) + "_To_" + CommonUtil.convertDateToHyphen(toDate);
            new File(path).mkdirs();

            List<Integer> invoices = billDao.getInvoicesOfDates(fromDate, toDate);
            List<Integer> purchases = billDao.getPurchasesOfDates(fromDate, toDate);
            for (int i : invoices) {
                excelAction.createInvoices("" + i, path);
            }
            for (int i : purchases) {
                excelAction.createPurchase("" + i, path);
            }

            inFolder = new File(path);
            outFolder = new File(path + ".zip");
            out = new ZipOutputStream(new BufferedOutputStream(new FileOutputStream(outFolder)));
            BufferedInputStream in = null;
            byte[] data = new byte[1000];
            String files[] = inFolder.list();
            for (String file : files) {
                in = new BufferedInputStream(new FileInputStream(inFolder.getPath() + "/" + file), 1000);
                out.putNextEntry(new ZipEntry(file));
                int count;
                while ((count = in.read(data, 0, 1000)) != -1) {
                    out.write(data, 0, count);
                }
                out.closeEntry();
            }
            out.flush();
            out.close();

        } catch (Exception ex) {
            Logger.getLogger(BillAction.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                fileInputStream = new FileInputStream(outFolder);
                this.setFileName(fileNameZip);

                out.close();
                outFolder.delete();
                inFolder.delete();
            } catch (IOException ex) {
                Logger.getLogger(BillAction.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return ActionSupport.SUCCESS;
    }

    public String getFromDate() {
        return fromDate;
    }

    public void setFromDate(String fromDate) {
        this.fromDate = fromDate;
    }

    public String getToDate() {
        return toDate;
    }

    public void setToDate(String toDate) {
        this.toDate = toDate;
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

    public String getSuccessMessage() {
        return successMessage;
    }

    public void setSuccessMessage(String successMessage) {
        this.successMessage = successMessage;
    }

    public String getErrorMessage() {
        return errorMessage;
    }

    public void setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
    }

}
