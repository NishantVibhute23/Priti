/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pritient.bean.dao;

import com.pritient.bean.CompanyBean;
import com.pritient.bean.StateBean;
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
public class CompanyAddressDao extends DBUtil {

    static final org.apache.log4j.Logger errorLog = org.apache.log4j.Logger.getLogger("errorLogger");
    static final org.apache.log4j.Logger infoLog = org.apache.log4j.Logger.getLogger("infoLogger");

    Connection conn;

    public int insertCompanyAddress(String compName, String compAdd, String compGST,
            String email, String phone1, String phone2, String phone3,
            int stateId, String compBankName, String compBankIFSC, String compBankAccountNo) {
        int id = 0;
        try {
            conn = getConnection();
            PreparedStatement ps = conn.prepareStatement("Call addCompanyAddress(?,?,?,?,?,?,?,?,?,?,?)");
            ps.setString(1, compName);
            ps.setString(2, compAdd);
            ps.setString(3, compGST);
            ps.setString(4, email);
            ps.setString(5, phone1);
            ps.setString(6, phone2);
            ps.setString(7, phone3);
            ps.setInt(8, stateId);
            ps.setString(9, compBankName);
            ps.setString(10, compBankIFSC);
            ps.setString(11, compBankAccountNo);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                id = rs.getInt(1);
            }

            closeConnection(conn);
        } catch (SQLException ex) {
            errorLog.error("CompanyAddressDao : " + ex);
        }

        return id;
    }

    public List<CompanyBean> getCompanyList() {
        List<CompanyBean> compList = new ArrayList<>();
        try {
            conn = getConnection();
            PreparedStatement ps = conn.prepareStatement("Call getCompanyList()");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                CompanyBean cb = new CompanyBean();
                cb.setCompanyId(rs.getInt(1));
                cb.setCompanyName(rs.getString(2));
                cb.setCompanyAddress(rs.getString(3));
                cb.setCompanyGSTIN(rs.getString(4));
                cb.setCompanyEmailId(rs.getString(5));
                cb.setCompanyPhoneNo1(rs.getString(6));
                cb.setCompanyPhoneNo2(rs.getString(7));
                cb.setCompanyPhoneNo3(rs.getString(8));
                cb.setCompanyState(rs.getString(9));
                cb.setCompanyBankName(rs.getString(12));
                cb.setCompanyBankIFSC(rs.getString(13));
                cb.setCompanyBankAccountNo(rs.getString(14));

                compList.add(cb);
            }

            closeConnection(conn);

        } catch (SQLException ex) {
            errorLog.error("CompanyAddressDao : " + ex);
        }
        return compList;
    }

    public List<StateBean> getStateList() {
        List<StateBean> stateList = new ArrayList<>();
        try {
            conn = getConnection();
            PreparedStatement ps = conn.prepareStatement("Call getStateList()");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                StateBean cb = new StateBean();
                cb.setStateId(rs.getInt(1));
                cb.setStateName(rs.getString(2));
                cb.setStateCode(rs.getString(3));

                stateList.add(cb);
            }

            closeConnection(conn);

        } catch (SQLException ex) {
            errorLog.error("CompanyAddressDao : " + ex);
        }
        return stateList;
    }

    public CompanyBean getCompanyDetails(int id) {
        CompanyBean cb = new CompanyBean();
        try {
            conn = getConnection();
            PreparedStatement ps = conn.prepareStatement("Call getCompanyDetails(?)");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                cb.setCompanyId(rs.getInt(1));
                cb.setCompanyName(rs.getString(2));
                cb.setCompanyAddress(rs.getString(3));
                cb.setCompanyGSTIN(rs.getString(4));
                cb.setCompanyEmailId(rs.getString(5));
                cb.setCompanyPhoneNo1(rs.getString(6));
                cb.setCompanyPhoneNo2(rs.getString(7));
                cb.setCompanyPhoneNo3(rs.getString(8));
                cb.setCompanyState(rs.getString(9));
                cb.setCompanyStateCode(rs.getString(10));
                cb.setCompanyStateId("" + rs.getInt(11));
                cb.setCompanyBankName(rs.getString(12));
                cb.setCompanyBankIFSC(rs.getString(13));
                cb.setCompanyBankAccountNo(rs.getString(14));
            }

            closeConnection(conn);

        } catch (SQLException ex) {
            errorLog.error("CompanyAddressDao : " + ex);
        }
        return cb;
    }

    public int updateCompanyDetails(CompanyBean cb) {
        int count = 0;
        try {
            conn = getConnection();
            PreparedStatement ps = conn.prepareStatement("Call updateCompanyDetails(?,?,?,?,?,?,?,?,?,?,?,?)");
            ps.setInt(1, cb.getCompanyId());
            ps.setString(2, cb.getCompanyName());
            ps.setString(3, cb.getCompanyAddress());
            ps.setString(4, cb.getCompanyGSTIN());
            ps.setString(5, cb.getCompanyEmailId());
            ps.setString(6, cb.getCompanyPhoneNo1());
            ps.setString(7, cb.getCompanyPhoneNo2());
            ps.setString(8, cb.getCompanyPhoneNo3());
            ps.setString(9, cb.getCompanyStateId());
            ps.setString(10, cb.getCompanyBankName());
            ps.setString(11, cb.getCompanyBankIFSC());
            ps.setString(12, cb.getCompanyBankAccountNo());
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                count = rs.getInt(1);

            }

            closeConnection(conn);

        } catch (SQLException ex) {
            errorLog.error("CompanyAddressDao : " + ex);
        }
        return count;
    }

}
