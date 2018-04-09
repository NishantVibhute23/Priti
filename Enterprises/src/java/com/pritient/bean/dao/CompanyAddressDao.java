/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pritient.bean.dao;

import com.pritient.bean.CompanyBean;
import com.pritient.bean.Product;
import com.pritient.bean.StateBean;
import com.pritient.bean.SubProduct;
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
            int stateId, String compBankName, String compBankIFSC, String compBankAccountNo, List<Product> productList) {
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

            if (id != 0) {
                for (Product pr : productList) {
                    for (SubProduct sb : pr.getSubProductList()) {
                        PreparedStatement ps1 = conn.prepareStatement("Call addCompnyProductPrice(?,?,?)");
                        ps1.setInt(1, id);
                        ps1.setInt(2, sb.getSubProductId());
                        ps1.setDouble(3, sb.getPrice());

                        ResultSet rs1 = ps1.executeQuery();
                    }
                }
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

    public List<Product> getCompanyProductList(int companyId) {
        List<Product> productList = new ArrayList<>();
        try {
            conn = getConnection();
            PreparedStatement ps = conn.prepareStatement("Call getMainProducts()");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                int id = rs.getInt(1);
                product.setId(id);
                product.setMainProductName(rs.getString(2));
                product.setMainProductHSN(rs.getString(3));
                product.setMainProductUOM(rs.getString(4));
                product.setMainProductUOMName(rs.getString(5));
                product.setMainProductType(rs.getString(6));
                product.setMainProductTypeName(rs.getString(7));

                if (id != 0) {
                    List<SubProduct> subProductList = new ArrayList<>();

                    PreparedStatement ps1 = conn.prepareStatement("Call getCompanyProductsPrice(?,?)");
                    ps1.setInt(1, id);
                    ps1.setInt(2, companyId);
                    ResultSet rs1 = ps1.executeQuery();
                    while (rs1.next()) {
                        SubProduct sp = new SubProduct();
                        if (rs1.getInt(4) == 0) {
                            sp.setSubProductId(rs1.getInt(1));
                            sp.setSubProductName(rs1.getString(2));
                            sp.setPrice(rs1.getInt(3));
                            subProductList.add(sp);
                        }
                    }
                    product.setSubProductList(subProductList);
                }

                productList.add(product);
            }
            closeConnection(conn);
        } catch (SQLException ex) {
            errorLog.error("ProductDao : " + ex);
        }
        return productList;
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

            if (count != 0) {
                for (Product pr : cb.getProductList()) {
                    for (SubProduct sb : pr.getSubProductList()) {
                        PreparedStatement ps1 = conn.prepareStatement("Call updateCompnyProductPrice(?,?,?)");
                        ps1.setInt(1, cb.getCompanyId());
                        ps1.setInt(2, sb.getSubProductId());
                        ps1.setDouble(3, sb.getPrice());

                        ResultSet rs1 = ps1.executeQuery();
                    }
                }
            }

            closeConnection(conn);

        } catch (SQLException ex) {
            errorLog.error("CompanyAddressDao : " + ex);
        }
        return count;
    }

}
