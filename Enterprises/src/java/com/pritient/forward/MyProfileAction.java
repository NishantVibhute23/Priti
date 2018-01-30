/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pritient.forward;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.pritient.bean.MyProfile;
import com.pritient.bean.StateBean;
import com.pritient.bean.dao.CompanyAddressDao;
import com.pritient.bean.dao.MyProfileDao;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;

/**
 *
 * @author nishant.vibhute
 */
public class MyProfileAction extends ActionSupport implements ModelDriven {

    List<MyProfile> myProfileList = new ArrayList<>();
    MyProfile myProfile = new MyProfile();
    CompanyAddressDao companyAddressDao = new CompanyAddressDao();
    MyProfileDao myProfileDao = new MyProfileDao();
    List<StateBean> stateList = new ArrayList<>();

    String successMessage = "";
    String errorMessage = "";

    public String execute() throws Exception {
        HttpSession session = ServletActionContext.getRequest().getSession(false);

        if (session == null || session.getAttribute("logined") == null) {
            return "failed";
        }
        stateList = companyAddressDao.getStateList();
        myProfile = myProfileDao.getprofileDetails();
        myProfileList.add(myProfile);
        return ActionSupport.SUCCESS;
    }

    public String updateMyDetails() throws Exception {

        int count = myProfileDao.updateProfileDetails(this.getMyProfile());

        if (count == 0) {
            errorMessage = "Failed Update Details";
        } else {
            successMessage = "Details Updated Successfully";
        }
        return ActionSupport.SUCCESS;
    }

    @Override
    public Object getModel() {
        return myProfile;
    }

    public MyProfile getMyProfile() {
        return myProfile;
    }

    public void setMyProfile(MyProfile myProfile) {
        this.myProfile = myProfile;
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

    public List<StateBean> getStateList() {
        return stateList;
    }

    public void setStateList(List<StateBean> stateList) {
        this.stateList = stateList;
    }

    public List<MyProfile> getMyProfileList() {
        return myProfileList;
    }

    public void setMyProfileList(List<MyProfile> myProfileList) {
        this.myProfileList = myProfileList;
    }

}
