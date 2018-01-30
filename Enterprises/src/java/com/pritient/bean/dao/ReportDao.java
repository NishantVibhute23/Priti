/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pritient.bean.dao;

import com.pritient.bean.ReportAllBean;
import com.pritient.bean.ReportRowBean;
import com.pritient.util.CommonUtil;
import com.pritient.util.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author nishant.vibhute
 */
public class ReportDao extends DBUtil {

    Connection conn;

    public List<ReportRowBean> getPurchaseReport(String fromDate, String toDate) {

        LinkedHashMap<String, Double> purchaseMap = CommonUtil.getMonthsBetweenDate(fromDate, toDate);

        List<ReportRowBean> reportList = new ArrayList<>();
        try {
            conn = getConnection();
            PreparedStatement ps = conn.prepareStatement("Call getPurchaseMonthWise(?,?)");
            ps.setString(1, CommonUtil.convertDate(fromDate));
            ps.setString(2, CommonUtil.convertDate(toDate));
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                purchaseMap.put(rs.getString("date"), rs.getDouble("amount"));

            }
            Iterator it = purchaseMap.entrySet().iterator();
            while (it.hasNext()) {
                Map.Entry pair = (Map.Entry) it.next();

                ReportRowBean rrb = new ReportRowBean();
                rrb.setDate("" + pair.getKey());
                rrb.setAmount(Double.parseDouble("" + pair.getValue()));
                reportList.add(rrb);
                it.remove(); // avoids a ConcurrentModificationException
            }

            closeConnection(conn);
        } catch (SQLException ex) {
            Logger.getLogger(LoginDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return reportList;
    }

    public List<ReportRowBean> getSalesReport(String fromDate, String toDate) {

        LinkedHashMap<String, Double> salesMap = CommonUtil.getMonthsBetweenDate(fromDate, toDate);

        List<ReportRowBean> reportList = new ArrayList<>();
        try {
            conn = getConnection();
            PreparedStatement ps = conn.prepareStatement("Call getSalesMonthWise(?,?)");
            ps.setString(1, CommonUtil.convertDate(fromDate));
            ps.setString(2, CommonUtil.convertDate(toDate));
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                salesMap.put(rs.getString("date"), rs.getDouble("amount"));

            }
            Iterator it = salesMap.entrySet().iterator();
            while (it.hasNext()) {
                Map.Entry pair = (Map.Entry) it.next();

                ReportRowBean rrb = new ReportRowBean();
                rrb.setDate("" + pair.getKey());
                rrb.setAmount(Double.parseDouble("" + pair.getValue()));
                reportList.add(rrb);
                it.remove(); // avoids a ConcurrentModificationException
            }

            closeConnection(conn);
        } catch (SQLException ex) {
            Logger.getLogger(LoginDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return reportList;
    }

    public List<ReportRowBean> getProfitLossReport(String fromDate, String toDate) {
        LinkedHashMap<String, Double> purchaseMap = CommonUtil.getMonthsBetweenDate(fromDate, toDate);
        LinkedHashMap<String, Double> salesMap = CommonUtil.getMonthsBetweenDate(fromDate, toDate);

        List<ReportRowBean> reportList = new ArrayList<>();
        try {
            conn = getConnection();
            PreparedStatement ps = conn.prepareStatement("Call getSalesMonthWise(?,?)");
            ps.setString(1, CommonUtil.convertDate(fromDate));
            ps.setString(2, CommonUtil.convertDate(toDate));
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                salesMap.put(rs.getString("date"), rs.getDouble("amount"));

            }
            PreparedStatement ps1 = conn.prepareStatement("Call getPurchaseMonthWise(?,?)");
            ps1.setString(1, CommonUtil.convertDate(fromDate));
            ps1.setString(2, CommonUtil.convertDate(toDate));
            ResultSet rs1 = ps1.executeQuery();

            while (rs1.next()) {
                purchaseMap.put(rs1.getString("date"), rs1.getDouble("amount"));

            }

            Iterator it = purchaseMap.entrySet().iterator();
            while (it.hasNext()) {
                Map.Entry pair = (Map.Entry) it.next();

                double purchaseVal = Double.parseDouble("" + purchaseMap.get(pair.getKey()));

                double sale = Double.parseDouble("" + salesMap.get(pair.getKey()));

                double pl = sale - purchaseVal;

                ReportRowBean rrb = new ReportRowBean();
                rrb.setDate("" + pair.getKey());
                rrb.setAmount(Double.parseDouble("" + pl));
                reportList.add(rrb);
                it.remove(); // avoids a ConcurrentModificationException
            }

            closeConnection(conn);
        } catch (SQLException ex) {
            Logger.getLogger(LoginDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return reportList;
    }

    public List<ReportAllBean> getPurchaseSalePLReport(String fromDate, String toDate) {
        LinkedHashMap<String, Double> purchaseMap = CommonUtil.getMonthsBetweenDate(fromDate, toDate);
        LinkedHashMap<String, Double> salesMap = CommonUtil.getMonthsBetweenDate(fromDate, toDate);

        List<ReportAllBean> reportList = new ArrayList<>();
        try {
            conn = getConnection();
            PreparedStatement ps = conn.prepareStatement("Call getSalesMonthWise(?,?)");
            ps.setString(1, CommonUtil.convertDate(fromDate));
            ps.setString(2, CommonUtil.convertDate(toDate));
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                salesMap.put(rs.getString("date"), rs.getDouble("amount"));

            }
            PreparedStatement ps1 = conn.prepareStatement("Call getPurchaseMonthWise(?,?)");
            ps1.setString(1, CommonUtil.convertDate(fromDate));
            ps1.setString(2, CommonUtil.convertDate(toDate));
            ResultSet rs1 = ps1.executeQuery();

            while (rs1.next()) {
                purchaseMap.put(rs1.getString("date"), rs1.getDouble("amount"));

            }

            Iterator it = purchaseMap.entrySet().iterator();
            while (it.hasNext()) {
                Map.Entry pair = (Map.Entry) it.next();
                double purchaseVal = Double.parseDouble("" + purchaseMap.get(pair.getKey()));
                double sale = Double.parseDouble("" + salesMap.get(pair.getKey()));
                double pl = sale - purchaseVal;

                it.remove(); // avoids a ConcurrentModificationException

                ReportAllBean reportAllBean = new ReportAllBean();
                reportAllBean.setDate(CommonUtil.yearMonth("" + pair.getKey()));
                reportAllBean.setPurchase(purchaseVal);
                reportAllBean.setSale(sale);
                reportAllBean.setProfit(pl);
                reportList.add(reportAllBean);
            }

            closeConnection(conn);
        } catch (SQLException ex) {
            Logger.getLogger(LoginDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return reportList;
    }

}
