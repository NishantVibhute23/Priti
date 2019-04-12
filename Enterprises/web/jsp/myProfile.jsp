<%--
    Document   : addressbook
    Created on : Jul 19, 2017, 1:55:58 PM
    Author     : nishant.vibhute
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/jsp/include/includeSideMenu.jsp"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <script type="text/javascript" src="js/jquery-2.2.4.min.js"></script>
        <script type="text/javascript" src="js/bootstrap.js"></script>
        <script type="text/javascript" src="js/formValidation.min.js"></script>

        <script type="text/javascript" src="js/framework/bootstrap.min.js"></script>
        <script type="text/javascript" src="js/bootbox.min.js"></script>
        <link href="css/dataTables.bootstrap.min.css" rel="stylesheet">
        <script type="text/javascript" src="js/datatables.min.js"></script>
        <script type="text/javascript" src="https://cdn.datatables.net/r/bs-3.3.5/jqc-1.11.3,dt-1.10.8/datatables.min.js"></script>
        <title>JSP Page</title>

    </head>


    <body style="padding-right: 0px !important">
        <div id="page-wrapper">

            <div class="container-fluid">
                <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12">
                        <h3 class="page-header">
                            Profile
                        </h3>
                        <ol class="breadcrumb">
                           <li >
                                <i class="fa fa-dashboard"></i> Dashboard
                            </li>
                            <li class="active">
                                <i class="fa fa-user"></i>My Profile
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->

                <s:if test="successMessage!=''">
                    <div class="alert alert-success">
                        <strong><s:property value = 'successMessage'/></strong>
                    </div>
                </s:if>

                <s:if test="errorMessage!=''">
                    <div class="alert alert-danger">
                        <strong><s:property value = 'errorMessage'/></strong>
                    </div>
                </s:if>

                <div class="row">
                    <div class="col-lg-12">

                    </div>
                </div>
                <!-- /.row -->

                <div class="row" >
                    <div class="table-responsive">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content ">
                                <s:iterator value="myProfileList">
                                    <div class="modal-body">
                                        <!-- The form is placed inside the body of modal -->
                                        <form id="loginForm" method="post" class="form-horizontal" action="updateDetails">
                                            <div class="form-group">
                                                <label class="col-xs-3 control-label">Company Name</label>
                                                <div class="col-xs-8">

                                                    <input type="text" class="form-control" name="companyName" value="<s:property value="companyName"/>" />
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-xs-3 control-label">GSTIN</label>
                                                <div class="col-xs-8">
                                                    <input type="text" class="form-control" name="companyGSTIN"  value="<s:property value="companyGSTIN"/>" />
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label class="col-xs-3 control-label">Address</label>
                                                <div class="col-xs-8">
                                                    <textarea name="companyAddress" class="form-control"><s:property value="companyAddress"/></textarea>
                                                    <!--<input type="text" class="form-control" name="companyAddress" />-->
                                                </div>
                                            </div>


                                            <div class="form-group">
                                                <label class="col-xs-3 control-label">State</label>
                                                <input type="hidden" id="stateid" value="<s:property value = 'companyStateId'/>"/>
                                                <div class="col-xs-8">
                                                    <select id="stateList" name="companyStateId" class="form-control" >
                                                        <option value="0">Select</option>
                                                        <s:iterator value="stateList">
                                                            <option value="<s:property value = 'StateId'/>"><s:property value = 'StateName'/></option>
                                                        </s:iterator>
                                                    </select>      
                                                </div>
                                            </div>



                                            <div class="form-group">
                                                <label class="col-xs-3 control-label">Email ID:</label>
                                                <div class="col-xs-8">

                                                    <input type="text" class="form-control" name="companyEmailId" value="<s:property value="companyEmailId"/>" />
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label class="col-xs-3 control-label">Phone No 1:</label>
                                                <div class="col-xs-8">

                                                    <input type="text" class="form-control" name="companyPhoneNo1" value="<s:property value="companyPhoneNo1"/>"/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-xs-3 control-label">Phone No 2:</label>
                                                <div class="col-xs-8">

                                                    <input type="text" class="form-control" name="companyPhoneNo2" value="<s:property value="companyPhoneNo2"/>"/>
                                                </div>
                                            </div><div class="form-group">
                                                <label class="col-xs-3 control-label">Phone No 3:</label>
                                                <div class="col-xs-8">

                                                    <input type="text" class="form-control" name="companyPhoneNo3" value="<s:property value="companyPhoneNo3"/>"/>
                                                </div>
                                            </div>
                                                <hr><div class="form-group">
                                                 <label class="col-xs-7 control-label ">Bank Details</label>
                                                </div>
                                                 <div class="form-group">
                            <label class="col-xs-3 control-label">Bank Name:</label>
                            <div class="col-xs-8">
                                
                                <input type="text" class="form-control" name="companyBankName" value="<s:property value="companyBankName"/>"/>
                            </div>
                        </div>
                             <div class="form-group">
                            <label class="col-xs-3 control-label">Bank Branch Name:</label>
                            <div class="col-xs-8">
                                
                                <input type="text" class="form-control" name="companyBankBranch" value="<s:property value="companyBankBranch"/>"/>
                            </div>
                        </div>
                            
                             <div class="form-group">
                            <label class="col-xs-3 control-label">Account No:</label>
                            <div class="col-xs-8">
                                
                                <input type="text" class="form-control" name="companyBankAccountNo" value="<s:property value="companyBankAccountNo"/>"/>
                            </div>
                        </div>
                            
                             <div class="form-group">
                            <label class="col-xs-3 control-label">Bank IFSC:</label>
                            <div class="col-xs-8">
                                
                                <input type="text" class="form-control" name="companyBankIFSC" value="<s:property value="companyBankIFSC"/>"/>
                            </div>
                        </div>
                            
                            <hr><div class="form-group">
                                                 <label class="col-xs-7 control-label ">Terms & Conditions</label>
                                                </div>
                                                 <div class="form-group">
                            <label class="col-xs-3 control-label">1:</label>
                            <div class="col-xs-8">
                                
                                <input type="text" class="form-control" name="termsCondition1" value="<s:property value="termsCondition1"/>"/>
                            </div>
                        </div>
                            
                             <div class="form-group">
                            <label class="col-xs-3 control-label">2:</label>
                            <div class="col-xs-8">
                                
                                <input type="text" class="form-control" name="termsCondition2" value="<s:property value="termsCondition2"/>"/>
                            </div>
                        </div>
                            
                             <div class="form-group">
                            <label class="col-xs-3 control-label">3:</label>
                            <div class="col-xs-8">
                                
                                <input type="text" class="form-control" name="termsCondition3" value="<s:property value="termsCondition3"/>"/>
                            </div>
                        </div>



                                        </s:iterator>


                                        <div class="form-group">
                                            <div class="col-xs-5 col-xs-offset-3">
                                                <button type="submit" class="btn btn-primary">Save</button>
                                                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>


                    </div>
                    <!-- /.row -->




                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- /#page-wrapper -->

        </div>
        <!-- /#wrapper -->



        <script>
            $(document).ready(function() {

                $("#stateList").val($("#stateid").val());
            });




        </script>


    </body>

</html>
