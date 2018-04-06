/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pritient.bean;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author nishant.vibhute
 */
public class CompanyBean {

    private int companyId;

    private String companyName;

    private String companyState;

    private String companyStateCode;

    private String companyStateId;

    private String companyAddress;

    private String companyGSTIN;

    private String companyEmailId;

    private String companyPhoneNo1;

    private String companyPhoneNo2;

    private String companyPhoneNo3;
    private String companyBankName;
    private String companyBankIFSC;
    private String companyBankAccountNo;

    List<Product> productList = new ArrayList<>();

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getCompanyAddress() {
        return companyAddress;
    }

    public void setCompanyAddress(String companyAddress) {
        this.companyAddress = companyAddress;
    }

    public String getCompanyGSTIN() {
        return companyGSTIN;
    }

    public void setCompanyGSTIN(String companyGSTIN) {
        this.companyGSTIN = companyGSTIN;
    }

    public int getCompanyId() {
        return companyId;
    }

    public void setCompanyId(int companyId) {
        this.companyId = companyId;
    }

    public String getCompanyEmailId() {
        return companyEmailId;
    }

    public void setCompanyEmailId(String companyEmailId) {
        this.companyEmailId = companyEmailId;
    }

    public String getCompanyPhoneNo1() {
        return companyPhoneNo1;
    }

    public void setCompanyPhoneNo1(String companyPhoneNo1) {
        this.companyPhoneNo1 = companyPhoneNo1;
    }

    public String getCompanyPhoneNo2() {
        return companyPhoneNo2;
    }

    public void setCompanyPhoneNo2(String companyPhoneNo2) {
        this.companyPhoneNo2 = companyPhoneNo2;
    }

    public String getCompanyPhoneNo3() {
        return companyPhoneNo3;
    }

    public void setCompanyPhoneNo3(String companyPhoneNo3) {
        this.companyPhoneNo3 = companyPhoneNo3;
    }

    public String getCompanyState() {
        return companyState;
    }

    public void setCompanyState(String companyState) {
        this.companyState = companyState;
    }

    public String getCompanyStateCode() {
        return companyStateCode;
    }

    public void setCompanyStateCode(String companyStateCode) {
        this.companyStateCode = companyStateCode;
    }

    public String getCompanyStateId() {
        return companyStateId;
    }

    public void setCompanyStateId(String companyStateId) {
        this.companyStateId = companyStateId;
    }

    public String getCompanyBankName() {
        return companyBankName;
    }

    public void setCompanyBankName(String companyBankName) {
        this.companyBankName = companyBankName;
    }

    public String getCompanyBankIFSC() {
        return companyBankIFSC;
    }

    public void setCompanyBankIFSC(String companyBankIFSC) {
        this.companyBankIFSC = companyBankIFSC;
    }

    public String getCompanyBankAccountNo() {
        return companyBankAccountNo;
    }

    public void setCompanyBankAccountNo(String companyBankAccountNo) {
        this.companyBankAccountNo = companyBankAccountNo;
    }

    public List<Product> getProductList() {
        return productList;
    }

    public void setProductList(List<Product> productList) {
        this.productList = productList;
    }

}
