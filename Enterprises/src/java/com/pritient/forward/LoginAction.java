/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pritient.forward;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.pritient.bean.LoginBean;
import com.pritient.bean.MyProfile;
import com.pritient.bean.Product;
import com.pritient.bean.dao.LoginDao;
import com.pritient.bean.dao.MyProfileDao;
import com.pritient.bean.dao.ProductDao;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.dispatcher.SessionMap;
import org.apache.struts2.interceptor.SessionAware;

/**
 *
 * @author nishant.vibhute
 */
public class LoginAction extends ActionSupport implements ModelDriven, SessionAware {

    LoginBean loginBean = new LoginBean();
    HttpServletRequest request;
    LoginDao loginDao = new LoginDao();
    String message;
    SessionMap<String, Object> session;
    MyProfileDao myProfileDao = new MyProfileDao();
    ProductDao productDao = new ProductDao();
    List<Product> productList;
    static final org.apache.log4j.Logger errorLog = org.apache.log4j.Logger.getLogger("errorLogger");
    static final org.apache.log4j.Logger infoLog = org.apache.log4j.Logger.getLogger("infoLogger");
    String successMessage = "", errorMessage = "";
    String newpassword, confirmPassword;

    public LoginAction() {

    }

    public String execute() throws Exception {
        String userName = loginBean.getUserName();
        String password = loginBean.getPassword();
        int count = loginDao.checkLogin(userName, password);

        if (count == 1) {
            MyProfile mp = myProfileDao.getprofileDetails();
            productList = productDao.getProductList();
            int num = productDao.getProductThreashold();
            session.put("productThreshold", num);
            session.put("productList", productList);
            session.put("logined", "true");
            session.put("userName", userName);
            session.put("companyName", mp.getCompanyName());

            return "success";

        } else {
            message = "failed";
            return "failed";
        }

    }

    public String redirectChangePassword() {
        return "success";
    }

    public String changePassword() {
        if (!newpassword.equals(confirmPassword)) {
            errorMessage = "Password does not matched";
        } else {
            int count = loginDao.changePassword("" + session.get("userName"), newpassword);
            if (count != 0) {
                successMessage = "Password Changed successfully";
            } else {
                errorMessage = "Failed to update password";
            }
        }
        return "success";
    }

    public String logout() {

        HttpSession session = ServletActionContext.getRequest().getSession(false);
        if (session != null) {
            session.invalidate();
        }
        return "success";
    }

    public LoginBean getLoginBean() {
        return loginBean;
    }

    public void setLoginBean(LoginBean loginBean) {
        this.loginBean = loginBean;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public List<Product> getProductList() {
        return productList;
    }

    public void setProductList(List<Product> productList) {
        this.productList = productList;
    }

    @Override
    public Object getModel() {
        return loginBean;
    }

    @Override
    public void setSession(Map<String, Object> map) {
        this.session = (SessionMap<String, Object>) map;
    }

    public String getSuccessMessage() {
        return successMessage;
    }

    public void setSuccessMessage(String successMessage) {
        this.successMessage = successMessage;
    }

    public String getErrorMessage() {
        return errorMessage;
    }

    public void setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
    }

    public String getNewpassword() {
        return newpassword;
    }

    public void setNewpassword(String newpassword) {
        this.newpassword = newpassword;
    }

    public String getConfirmPassword() {
        return confirmPassword;
    }

    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }

}
