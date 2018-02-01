/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pritient.bean.dao;

import com.pritient.bean.RawMaterialBean;
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
public class RawMaterialDao extends DBUtil {

    Connection conn;
    static final org.apache.log4j.Logger errorLog = org.apache.log4j.Logger.getLogger("errorLogger");
    static final org.apache.log4j.Logger infoLog = org.apache.log4j.Logger.getLogger("infoLogger");

    public List<SubProduct> getRawProducts() {
        List<SubProduct> productList = new ArrayList<>();
        try {
            conn = getConnection();
            PreparedStatement ps = conn.prepareStatement("Call getRawProducts()");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                SubProduct sp = new SubProduct();
                sp.setSubProductId(rs.getInt("id"));
                sp.setSubProductName(rs.getString("product_name"));
                productList.add(sp);
            }
            closeConnection(conn);
        } catch (SQLException ex) {
            errorLog.error("RawMaterialDao : " + ex);
        }
        return productList;
    }

    public int saveRawMaterial(RawMaterialBean rawMaterialBean) {
        int id = 0;
        try {
            conn = getConnection();

            PreparedStatement ps = conn.prepareStatement("Call deleteProduct(?,?)");
            ps.setInt(1, rawMaterialBean.getProductId());
            ps.setInt(2, rawMaterialBean.getQty());

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                id = rs.getInt(1);
            }

            if (id != 0) {

                for (SubProduct subProd : rawMaterialBean.getSubProduct()) {
                    if (subProd != null) {
                        PreparedStatement ps2 = conn.prepareStatement("Call addProduct(?,?)");
                        ps2.setInt(1, subProd.getSubProductId());
                        ps2.setInt(2, subProd.getQty());
                        ps2.executeUpdate();
                    }
                }
            }

            closeConnection(conn);

        } catch (SQLException ex) {
            errorLog.error("RawMaterialDao : " + ex);
        }
        return id;

    }

}
