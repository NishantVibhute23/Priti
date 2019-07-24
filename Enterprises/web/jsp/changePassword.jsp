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

                

                <div class="row" >
                    <div class="table-responsive">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content ">
                                
                                    <div class="modal-body">
                                        <!-- The form is placed inside the body of modal -->
                                        <form id="changePassword" method="post" class="form-horizontal" action="changePassword">
                                            <div class="form-group">
                                                <label class="col-xs-3 control-label">New Password</label>
                                                <div class="col-xs-8">

                                                    <input type="password" class="form-control" name="newpassword"/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-xs-3 control-label">Confirm Password</label>
                                                <div class="col-xs-8">
                                                    <input type="password" class="form-control" name="confirmPassword"  />
                                                </div>
                                            </div>
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




    </body>

</html>
