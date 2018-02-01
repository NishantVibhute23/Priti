/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pritient.util;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 *
 * @author nishant.vibhute
 */
public class DBUtil {

    static final org.apache.log4j.Logger errorLog = org.apache.log4j.Logger.getLogger("errorLogger");
    static final org.apache.log4j.Logger infoLog = org.apache.log4j.Logger.getLogger("infoLogger");
    Connection con;
    String url;

    public Connection getConnection() {
        try {

            url = CommonUtil.getResourceProperties("db.url");
            String id = CommonUtil.getResourceProperties("db.username");
            String pass = CommonUtil.getResourceProperties("db.password");

            Class.forName("com.mysql.jdbc.Driver");
            this.con = DriverManager.getConnection(url, id, pass);
            return con;

        } catch (Exception e) {
            errorLog.error("DBUtil : " + e);
        }
        return null;

    }

    public void closeConnection(Connection con) {
        try {
            if (con != null) {
                con.close();
            }

        } catch (Exception e) {
            System.out.println(e);
        }
    }

}
