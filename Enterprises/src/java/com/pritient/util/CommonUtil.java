/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pritient.util;

import com.pritient.bean.ReportRowBean;
import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Properties;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author nishant.vibhute
 */
public class CommonUtil {

    public HttpServletRequest request;
    static Properties prop = new Properties();
    static InputStream input = null;
    static String path;
    public static String directoryPath;
    static final org.apache.log4j.Logger errorLog = org.apache.log4j.Logger.getLogger("errorLogger");
    static final org.apache.log4j.Logger infoLog = org.apache.log4j.Logger.getLogger("infoLogger");

    public CommonUtil(String path) {

        try {
            this.path = path;
//            input = new FileInputStream(path + "WEB-INF\\classes\\com\\pritient\\properties\\resource.properties");
            input = new FileInputStream("/home/ec2-user/PritiEnterprises/Properties/resource.properties");
            prop.load(input);
            directoryPath = CommonUtil.getResourceProperties("directory.path");

        } catch (Exception ex) {
            errorLog.error("CommonUtil : " + ex);
        }
    }

    public static String getResourceProperties(String name) {
        String value = prop.getProperty(name);
        return value;

    }

    public static String convertDate(String date) {
        String newDate = "";
        try {
            String sDate1 = date;
            Date date1 = new SimpleDateFormat("dd/MM/yyyy").parse(sDate1);
            java.text.SimpleDateFormat sdf
                    = new java.text.SimpleDateFormat("yyyy-MM-dd");

            newDate = sdf.format(date1);

        } catch (ParseException ex) {
            errorLog.error("CommonUtil : " + ex);
        }
        return newDate;
    }

    public static String convertDateToHyphen(String date) {
        String newDate = "";
        try {
            String sDate1 = date;
            Date date1 = new SimpleDateFormat("dd/MM/yyyy").parse(sDate1);
            java.text.SimpleDateFormat sdf
                    = new java.text.SimpleDateFormat("dd-MM-yyyy");

            newDate = sdf.format(date1);

        } catch (ParseException ex) {
            errorLog.error("CommonUtil : " + ex);
        }
        return newDate;
    }

    public static String convertDateToNormal(String date) {
        String newDate = "";
        try {
            String sDate1 = date;
            Date date1 = new SimpleDateFormat("yyyy-MM-dd").parse(sDate1);
            java.text.SimpleDateFormat sdf
                    = new java.text.SimpleDateFormat("dd/MM/yyyy");

            newDate = sdf.format(date1);

        } catch (ParseException ex) {
            errorLog.error("CommonUtil : " + ex);
        }
        return newDate;
    }

    public static String getPath() {
        return path;
    }

    public static void setPath(String path) {
        CommonUtil.path = path;
    }

    public static String getStringFromInputStream(InputStream is) {

        BufferedReader br = null;
        StringBuilder sb = new StringBuilder();

        String line;
        try {

            br = new BufferedReader(new InputStreamReader(is));
            while ((line = br.readLine()) != null) {
                sb.append(line);
            }

        } catch (IOException e) {
            errorLog.error("CommonUtil : " + e);
        } finally {
            if (br != null) {
                try {
                    br.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }

        return sb.toString();

    }

    public static LinkedHashMap<String, ReportRowBean> getMonthsBetweenDate(String fromDate, String toDate) {
        LinkedHashMap<String, ReportRowBean> monthlyMap = new LinkedHashMap<>();
        String date1 = fromDate;
        String date2 = toDate;

        DateFormat formater = new SimpleDateFormat("dd/MM/yyyy");

        DateFormat formater2 = new SimpleDateFormat("MMM yyyy");

        Calendar beginCalendar = Calendar.getInstance();
        Calendar finishCalendar = Calendar.getInstance();

        try {
            beginCalendar.setTime(formater.parse(date1));
            finishCalendar.setTime(formater.parse(date2));
        } catch (ParseException e) {
            errorLog.error("CommonUtil : " + e);
        }

        while (beginCalendar.before(finishCalendar)) {
            // add one month to date per loop
            String date = formater2.format(beginCalendar.getTime());
            ReportRowBean rr = new ReportRowBean();
            rr.setDate(date);
            rr.setAmountTotal(Double.parseDouble("0"));
            rr.setAmountPaid(Double.parseDouble("0"));
            rr.setAmountUnpaid(Double.parseDouble("0"));
            monthlyMap.put(date, rr);
            beginCalendar.add(Calendar.MONTH, 1);
        }

        return monthlyMap;
    }

    public static String yearMonth(String dateIn) {
        String convertedDate = null;
        try {
            DateFormat formater = new SimpleDateFormat("yyyy-MM");

            DateFormat formater2 = new SimpleDateFormat("MMM yyyy");

            Date date = formater2.parse(dateIn);
            convertedDate = formater.format(date);
        } catch (ParseException ex) {
            errorLog.error("CommonUtil : " + ex);
        }
        return convertedDate;
    }

}
