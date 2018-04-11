/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pritient.bean.dao;

import com.pritient.bean.CompanyBean;
import com.pritient.bean.Product;
import com.pritient.bean.ProductTypeBean;
import com.pritient.bean.SubProduct;
import com.pritient.bean.UOMBean;
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
public class ProductDao extends DBUtil {

    Connection conn;
    static final org.apache.log4j.Logger errorLog = org.apache.log4j.Logger.getLogger("errorLogger");
    static final org.apache.log4j.Logger infoLog = org.apache.log4j.Logger.getLogger("infoLogger");
    CompanyAddressDao companyAddressDao = new CompanyAddressDao();

    public int insertProduct(Product product) {
        int id = 0;
        try {
            List<CompanyBean> companyList = companyAddressDao.getCompanyList();

            conn = getConnection();

            PreparedStatement ps = conn.prepareStatement("Call insertMainProduct(?,?,?,?)");
            ps.setString(1, product.getMainProductName());
            ps.setString(2, product.getMainProductHSN());
            ps.setInt(3, Integer.parseInt(product.getMainProductUOM()));
            ps.setInt(4, Integer.parseInt(product.getMainProductType()));

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                id = rs.getInt(1);
            }

            if (id != 0) {
                int idProd = 0;
                for (SubProduct sb : product.getSubProductList()) {
                    if (sb != null) {
                        PreparedStatement ps1 = conn.prepareStatement("Call insertSubProduct(?,?,?,?)");
                        ps1.setString(1, sb.getSubProductName());
                        ps1.setString(2, sb.getSubProductName());
                        ps1.setInt(3, id);
                        ps1.setInt(4, 0);
                        ResultSet rs2 = ps1.executeQuery();

                        while (rs2.next()) {
                            idProd = rs2.getInt(1);
                        }

                        if (!companyList.isEmpty()) {
                            for (CompanyBean cb : companyList) {
                                PreparedStatement ps2 = conn.prepareStatement("Call addCompnyProductPrice(?,?,?)");
                                ps2.setInt(1, cb.getCompanyId());
                                ps2.setInt(2, idProd);
                                ps2.setDouble(3, 0);
                                ps2.executeQuery();
                            }
                        }
                    }
                }
            }

            closeConnection(conn);

        } catch (SQLException ex) {
            errorLog.error("ProductDao : " + ex);
        }
        return id;
    }

    public int updateProduct(Product product) {
        int id = product.getId();
        int cnt = 0;
        try {
            conn = getConnection();

            PreparedStatement ps = conn.prepareStatement("Call updateMainProduct(?,?,?,?,?)");
            ps.setString(1, product.getMainProductName());
            ps.setString(2, product.getMainProductHSN());
            ps.setInt(3, Integer.parseInt(product.getMainProductUOM()));
            ps.setInt(4, Integer.parseInt(product.getMainProductType()));
            ps.setInt(5, product.getId());

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                cnt = rs.getInt(1);
            }

            if (cnt != 0) {

                for (SubProduct sb : product.getSubProductList()) {
                    if (sb != null) {
                        PreparedStatement ps1 = conn.prepareStatement("Call updateSubProduct(?,?,?,?,?)");
                        ps1.setInt(1, sb.getSubProductId());
                        ps1.setString(2, sb.getSubProductName());
                        ps1.setInt(3, sb.getQty());
                        ps1.setInt(4, id);
                        ps1.setInt(5, sb.getIsDeleted());
                        ps1.executeUpdate();
                    }
                }
            }

            closeConnection(conn);

        } catch (SQLException ex) {
            errorLog.error("ProductDao : " + ex);
        }
        return id;
    }

    public List<SubProduct> getAllProducts() {
        List<SubProduct> productList = new ArrayList<>();
        try {
            conn = getConnection();
            PreparedStatement ps = conn.prepareStatement("Call getAllProducts()");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                SubProduct sp = new SubProduct();
                sp.setSubProductId(rs.getInt("id"));
                sp.setSubProductName(rs.getString("product_name"));
                sp.setSubProductCode(rs.getString("product_shotform"));
                productList.add(sp);
            }
            closeConnection(conn);
        } catch (SQLException ex) {
            errorLog.error("ProductDao : " + ex);
        }
        return productList;
    }

    public List<UOMBean> getAllUOM() {
        List<UOMBean> UOMBeanList = new ArrayList<>();
        try {
            conn = getConnection();
            PreparedStatement ps = conn.prepareStatement("Call getAllUOM()");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                UOMBean sp = new UOMBean();
                sp.setId(rs.getInt("id"));
                sp.setName(rs.getString("uom"));
                UOMBeanList.add(sp);
            }
            closeConnection(conn);
        } catch (SQLException ex) {
            errorLog.error("ProductDao : " + ex);
        }
        return UOMBeanList;
    }

    public List<ProductTypeBean> getAllProductType() {
        List<ProductTypeBean> ProductTypeBeanList = new ArrayList<>();
        try {
            conn = getConnection();
            PreparedStatement ps = conn.prepareStatement("Call getAllProductType()");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ProductTypeBean sp = new ProductTypeBean();
                sp.setId(rs.getInt("id"));
                sp.setName(rs.getString("type_name"));
                ProductTypeBeanList.add(sp);
            }
            closeConnection(conn);
        } catch (SQLException ex) {
            errorLog.error("ProductDao : " + ex);
        }
        return ProductTypeBeanList;
    }

    public List<Product> getProductList() {
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

                    PreparedStatement ps1 = conn.prepareStatement("Call getSubProducts(?)");
                    ps1.setInt(1, id);
                    ResultSet rs1 = ps1.executeQuery();
                    while (rs1.next()) {
                        SubProduct sp = new SubProduct();
                        if (rs1.getInt(4) == 0) {
                            sp.setSubProductId(rs1.getInt(1));
                            sp.setSubProductName(rs1.getString(2));
                            sp.setQty(rs1.getInt(3));
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

    public Product getProductInfo(int prodId) {
        Product product = new Product();
        try {
            conn = getConnection();
            PreparedStatement ps = conn.prepareStatement("Call getMainProductsInfo(?)");
            ps.setInt(1, prodId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

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

                    PreparedStatement ps1 = conn.prepareStatement("Call getSubProducts(?)");
                    ps1.setInt(1, id);
                    ResultSet rs1 = ps1.executeQuery();
                    while (rs1.next()) {
                        SubProduct sp = new SubProduct();
                        sp.setSubProductId(rs1.getInt(1));
                        sp.setSubProductName(rs1.getString(2));
                        sp.setQty(rs1.getInt(3));
                        sp.setIsDeleted(rs1.getInt(4));
                        subProductList.add(sp);
                    }
                    product.setSubProductList(subProductList);
                }

            }
            closeConnection(conn);
        } catch (SQLException ex) {
            errorLog.error("ProductDao : " + ex);
        }
        return product;
    }

    public int getProductThreashold() {
        int num = 0;
        try {
            conn = getConnection();
            PreparedStatement ps = conn.prepareStatement("Call getProductThreshold()");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                num = rs.getInt(1);
            }
            closeConnection(conn);
        } catch (SQLException ex) {
            errorLog.error("ProductDao : " + ex);
        }
        return num;
    }

    public void updateProductThreshold(int num) {

        try {
            conn = getConnection();
            PreparedStatement ps = conn.prepareStatement("Call updateProductThreshold(?)");
            ps.setInt(1, num);
            ps.executeUpdate();

            closeConnection(conn);
        } catch (SQLException ex) {
            errorLog.error("ProductDao : " + ex);
        }

    }

}
