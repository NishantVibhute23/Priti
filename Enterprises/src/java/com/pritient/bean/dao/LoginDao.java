/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pritient.bean.dao;

import com.pritient.util.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author nishant.vibhute
 */
public class LoginDao extends DBUtil {

    static final org.apache.log4j.Logger errorLog = org.apache.log4j.Logger.getLogger("errorLogger");
    static final org.apache.log4j.Logger infoLog = org.apache.log4j.Logger.getLogger("infoLogger");
    Connection conn;

    public int checkLogin(String userName, String password) {
        int count = 0;
        try {

            conn = getConnection();
            PreparedStatement ps = conn.prepareStatement("Call checkLogin(?,?)");
            ps.setString(1, userName);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                count = rs.getInt(1);
            }

            closeConnection(conn);
        } catch (Exception ex) {
            errorLog.error("LoginDao : " + ex);
        }

        return count;
    }

}
