/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pritient.bean.dao;

import com.pritient.bean.MyProfile;
import com.pritient.util.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author nishant.vibhute
 */
public class MyProfileDao extends DBUtil {

    Connection conn;

    public MyProfile getprofileDetails() {

        MyProfile myProfile = new MyProfile();
        try {

            conn = getConnection();
            PreparedStatement ps = conn.prepareStatement("Call getMyProfileDetails()");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                myProfile.setId(rs.getInt(1));
                myProfile.setCompanyName(rs.getString(2));
                myProfile.setCompanyAddress(rs.getString(3));
                myProfile.setCompanyGSTIN(rs.getString(4));
                myProfile.setCompanyEmailId(rs.getString(5));
                myProfile.setCompanyPhoneNo1(rs.getString(6));
                myProfile.setCompanyPhoneNo2(rs.getString(7));
                myProfile.setCompanyPhoneNo3(rs.getString(8));
                myProfile.setCompanyStateId(rs.getString(9));
                myProfile.setCompanyBankName(rs.getString(10));
                myProfile.setCompanyBankIFSC(rs.getString(11));
                myProfile.setCompanyBankAccountNo(rs.getString(12));
                myProfile.setCompanyLogo(rs.getString(13));
                myProfile.setCompanyState(rs.getString(14));
                myProfile.setCompanyStateCode(rs.getString(15));
                myProfile.setTermsCondition1(rs.getString(16));
                myProfile.setTermsCondition2(rs.getString(17));
                myProfile.setTermsCondition3(rs.getString(18));

            }

            closeConnection(conn);
        } catch (SQLException ex) {
            Logger.getLogger(LoginDao.class.getName()).log(Level.SEVERE, null, ex);
        }

        return myProfile;
    }

    public int updateProfileDetails(MyProfile cb) {
        int count = 0;
        try {
            conn = getConnection();
            PreparedStatement ps = conn.prepareStatement("Call updateMyProfileDetails(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
            ps.setInt(1, cb.getId());
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
            ps.setString(13, cb.getCompanyLogo());
            ps.setString(14, cb.getTermsCondition1());
            ps.setString(15, cb.getTermsCondition2());
            ps.setString(16, cb.getTermsCondition3());

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                count = rs.getInt(1);

            }

            closeConnection(conn);

        } catch (SQLException ex) {
            Logger.getLogger(LoginDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

}
