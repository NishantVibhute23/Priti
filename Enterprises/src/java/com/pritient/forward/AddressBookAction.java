/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pritient.forward;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.pritient.bean.CompanyBean;
import com.pritient.bean.StateBean;
import com.pritient.bean.dao.CompanyAddressDao;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import org.apache.log4j.Logger;
import org.codehaus.jackson.map.ObjectMapper;

/**
 *
 * @author nishant.vibhute
 */
public class AddressBookAction extends ActionSupport implements ModelDriven {

    CompanyBean companyBean = new CompanyBean();
    CompanyAddressDao companyAddressDao = new CompanyAddressDao();
    List<CompanyBean> companyList = new ArrayList<>();
    List<StateBean> stateList = new ArrayList<>();

    private InputStream inputStream;
    int id;
    String successMessage = "";
    String errorMessage = "";
    static final Logger errorLog = Logger.getLogger("errorLogger");
    static final Logger infoLog = Logger.getLogger("infoLogger");

    public AddressBookAction() {
    }

    public String execute() throws Exception {

        companyList = companyAddressDao.getCompanyList();
        stateList = companyAddressDao.getStateList();

        return ActionSupport.SUCCESS;
    }

    public String addCompanyAddress() {

        String compName = companyBean.getCompanyName();
        String compAdd = companyBean.getCompanyAddress();
        String compGST = companyBean.getCompanyGSTIN();
        String compEmail = companyBean.getCompanyEmailId() == null ? "" : companyBean.getCompanyEmailId();
        String compPhone1 = companyBean.getCompanyPhoneNo1();
        String compPhone2 = companyBean.getCompanyPhoneNo2();
        String compPhone3 = companyBean.getCompanyPhoneNo3();
        String compBankName = companyBean.getCompanyBankName();
        String compBankIFSC = companyBean.getCompanyBankIFSC();
        String compBankAccountNo = companyBean.getCompanyBankAccountNo();
        int stateId = Integer.parseInt(companyBean.getCompanyStateId());
        int id = companyAddressDao.insertCompanyAddress(compName, compAdd, compGST, compEmail, compPhone1, compPhone2, compPhone3, stateId, compBankName, compBankIFSC, compBankAccountNo);

        if (id == 0) {
            errorMessage = "Failed To add Company";
        } else {
            successMessage = "Company Added Successfully";
        }
        return ActionSupport.SUCCESS;
    }

    public String getCompanyDetails() {
        try {

            int id = this.getId();
            CompanyBean companyBean = companyAddressDao.getCompanyDetails(id);

            ObjectMapper mapper = new ObjectMapper();
            String res = mapper.writeValueAsString(companyBean);
            inputStream = new ByteArrayInputStream(res.getBytes(StandardCharsets.UTF_8));
        } catch (IOException ex) {
            errorLog.error("AddressBookAction : " + ex);
        }
        return ActionSupport.SUCCESS;
    }

    public String updateCompanyDetails() {

        int count = companyAddressDao.updateCompanyDetails(this.getCompanyBean());

        if (count == 0) {
            errorMessage = "Failed Update Company";
        } else {
            successMessage = "Company Updated Successfully";
        }
        return ActionSupport.SUCCESS;
    }

    public CompanyBean getCompanyBean() {
        return companyBean;
    }

    public void setCompanyBean(CompanyBean companyBean) {
        this.companyBean = companyBean;
    }

    @Override
    public Object getModel() {
        return companyBean;
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

    public List<CompanyBean> getCompanyList() {
        return companyList;
    }

    public void setCompanyList(List<CompanyBean> companyList) {
        this.companyList = companyList;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public InputStream getInputStream() {
        return inputStream;
    }

    public void setInputStream(InputStream inputStream) {
        this.inputStream = inputStream;
    }

    public List<StateBean> getStateList() {
        return stateList;
    }

    public void setStateList(List<StateBean> stateList) {
        this.stateList = stateList;
    }

}
