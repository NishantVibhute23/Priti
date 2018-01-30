/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pritient.bean.dao;

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
 * @author Nishant
 */
public class BillDao extends DBUtil {

    Connection conn;

    public List<Integer> getInvoicesOfDates(String fromDate, String toDate) {
        List<Integer> invoices = new ArrayList<>();
        try {
            conn = getConnection();
            PreparedStatement ps = conn.prepareStatement("Call getInvoiceListBetweenDates(?,?)");
            ps.setString(1, CommonUtil.convertDate(fromDate));
            ps.setString(2, CommonUtil.convertDate(toDate));
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                invoices.add(rs.getInt(1));
            }

        } catch (SQLException ex) {
            Logger.getLogger(BillDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return invoices;
    }

    public List<Integer> getPurchasesOfDates(String fromDate, String toDate) {
        List<Integer> invoices = new ArrayList<>();
        try {
            conn = getConnection();
            PreparedStatement ps = conn.prepareStatement("Call getPurchaseListBetweenDates(?,?)");
            ps.setString(1, CommonUtil.convertDate(fromDate));
            ps.setString(2, CommonUtil.convertDate(toDate));
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                invoices.add(rs.getInt(1));
            }

        } catch (SQLException ex) {
            Logger.getLogger(BillDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return invoices;
    }

}
