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
        <script>
            $(document).ready(function() {
                $('#addressTable').DataTable();


//                $('#productTable').DataTable();


//    $("#reports").addClass("active");
                $("#dashboard").removeClass("active");

                $("#Invoice").removeClass("active");
//$("#invoiceId").show()
                $("#InvoiceNew").removeClass("highlight");
                $("#InvoiceDetails").removeClass("highlight");
                $("#InvoicePayment").addClass("highlight");


                $("#Purchase").removeClass("active");
                $("#PurchaseNew").removeClass("highlight");
                $("#PurchaseDetails").removeClass("highlight");

                $("#Products").removeClass("active");
                $("#AddressBook").addClass("active");
                $("#RawMaterial").removeClass("active");

                $("#Ledger").removeClass("active");

                $("#Bills").removeClass("active");

            });

        </script>
    </head>
    <!--modal starts-->
    <div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="Login" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content ">
                <div class="modal-header">
                    <s:set name="theme" value="'simple'" scope="page" />


                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>

                    <ul  class="nav nav-pills">
                        <li class="active" >
                            <a  href="#1b" data-toggle="tab" style="padding: 10px 100px !important">Company</a>
                        </li>
                        <li><a href="#2b" data-toggle="tab" style="padding: 10px 100px !important">Products</a>
                        </li>


                    </ul>
                </div>



                <div class="modal-body">

                    <form id="loginForm" method="post" class="form-horizontal" action="saveCompany">
                        <div class="panel-body">
                            <div class="tab-content">

                                <div class="tab-pane fade in active" id="1b">

                                    <div class="form-group">
                                        <label class="col-xs-3 control-label">Company Name *</label>
                                        <div class="col-xs-8">
                                            <input type="text" required class="form-control" name="companyName" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-xs-3 control-label">GSTIN  *</label>
                                        <div class="col-xs-8">
                                            <input type="text" required class="form-control" name="companyGSTIN" />
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-xs-3 control-label">Address  *</label>
                                        <div class="col-xs-8">
                                            <textarea name="companyAddress" required class="form-control"></textarea>
                                            <!--<input type="text" class="form-control" name="companyAddress" />-->
                                        </div>
                                    </div>


                                    <div class="form-group">
                                        <label class="col-xs-3 control-label">State  *</label>
                                        <div class="col-xs-8">
                                            <select required id="stateList" name="companyStateId" class="form-control" >
                                                <option value="">Select</option>
                                                <s:iterator value="stateList">
                                                    <option value="<s:property value = 'StateId'/>"><s:property value = 'StateName'/></option>
                                                </s:iterator>
                                            </select>
                                        </div>
                                    </div>

                       
                        <div class="form-group">
                            <label class="col-xs-3 control-label">Email ID </label>
                            <div class="col-xs-8">

                            
                                <input type="email" class="form-control" name="companyEmailId" />
                            </div>
                        </div>

                                    <div class="form-group">
                                        <label class="col-xs-3 control-label">Email ID  *</label>
                                        <div class="col-xs-8">

                                            <input type="email" required class="form-control" name="companyEmailId" />
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-xs-3 control-label">Phone No 1  *</label>
                                        <div class="col-xs-8">

                                            <input type="text" required class="form-control" name="companyPhoneNo1" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-xs-3 control-label">Phone No 2 </label>
                                        <div class="col-xs-8">

                                            <input type="text" class="form-control" name="companyPhoneNo2" />
                                        </div>
                                    </div><div class="form-group">
                                        <label class="col-xs-3 control-label">Phone No 3 </label>
                                        <div class="col-xs-8">

                                            <input type="text" class="form-control" name="companyPhoneNo3" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-xs-3 control-label">Bank Name </label>
                                        <div class="col-xs-8">

                                            <input type="text" class="form-control" name="companyBankName" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-xs-3 control-label">IFSC Code </label>
                                        <div class="col-xs-8">

                                            <input type="text" class="form-control" name="companyBankIFSC" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-xs-3 control-label">Account No </label>
                                        <div class="col-xs-8">

                                            <input type="text" class="form-control" name="companyBankAccountNo" />
                                        </div>
                                    </div>





                                </div>
                                <div class="tab-pane fade in " id="2b">
                                    <table id='productTable' class="table table-bordered"  width="100%">
                                        <thead>
                                            <tr>
                                                <th>Product Name</th>
                                                <th>Sub Product Name</th>
                                                <th>Price</th>

                                            </tr>
                                        </thead>
                                        <s:iterator value="productList" status="incr">
                                            <tr >
                                                <td style='vertical-align: middle !important' rowspan="<s:property value = 'subProductList.size()'/>" ><s:property value = 'mainProductName'/></td>
                                                <td  ><s:property value = 'subProductList[0].subProductName'/></td>


                                                <td align="center" ><s:hidden name="productList[%{#incr.index}].subProductList[0].subProductId"/>
                                                    <s:textfield name="productList[%{#incr.index}].subProductList[0].price"/></td>


                                            </tr>
                                            <s:if test="subProductList.size() > 0">
                                                <s:iterator value="subProductList" begin="1" status="incr1">
                                                    <tr >
                                                        <td  ><s:property value = 'subProductName'/>
                                                        </td>

                                                        <td align="center" class="" >
                                                            <s:hidden name="productList[%{#incr.index}].subProductList[%{#incr1.index+1}].subProductId"/>
                                                            <s:textfield name="productList[%{#incr.index}].subProductList[%{#incr1.index+1}].price"/>
                                                        </td>


                                                    </tr>
                                                </s:iterator>
                                            </s:if>
                                        </s:iterator>
                                    </table>
                                    <div class="form-group">
                                        <div class="col-xs-5 col-xs-offset-3">
                                            <button type="submit" class="btn btn-primary">Save</button>
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                                        </div>
                                    </div>

                                </div>

                            </div>

                        </div>
                    </form>

                    <!-- The form is placed inside the body of modal -->

                </div>
            </div>
        </div>
    </div>
    <!--modal ends-->

    <!-- The form which is used to populate the item data -->
    <form id="userForm" method="post" class="form-horizontal" style="display: none;" action="updateCompany">
        <div class="form-group">
            <label class="col-xs-3 control-label">ID</label>
            <div class="col-xs-3">
                <input type="text" class="form-control" name="companyId"  readonly/>
            </div>
        </div>

        <div class="form-group">
            <label class="col-xs-3 control-label">Full name</label>
            <div class="col-xs-8">
                <input type="text" class="form-control" required name="companyName" />
            </div>
        </div>

        <div class="form-group">
            <label class="col-xs-3 control-label">GSTIN</label>
            <div class="col-xs-8">
                <input type="text" class="form-control" required name="companyGSTIN" />
            </div>
        </div>


        <div class="form-group">
            <label class="col-xs-3 control-label">Address</label>
            <div class="col-xs-8">
                <textarea name="companyAddress" required class="form-control"></textarea>
            </div>
        </div>


        <div class="form-group">
            <label class="col-xs-3 control-label">State</label>
            <div class="col-xs-8">
                <select required id="stateList" name="companyStateId" class="form-control" >
                    <option value="">Select</option>
                    <s:iterator value="stateList">
                        <option value="<s:property value = 'StateId'/>"><s:property value = 'StateName'/></option>
                    </s:iterator>
                </select>
            </div>
        </div>

        <div class="form-group">
            <label class="col-xs-3 control-label">Email ID</label>
            <div class="col-xs-8">
                <input type="email" class="form-control" name="companyEmailId" />
            </div>
        </div>

        <div class="form-group">
            <label class="col-xs-3 control-label">Phone No 1:</label>
            <div class="col-xs-8">
                <input type="text" required class="form-control" name="companyPhoneNo1" />
            </div>
        </div>

        <div class="form-group">
            <label class="col-xs-3 control-label">Phone No 2:</label>
            <div class="col-xs-8">
                <input type="text" class="form-control" name="companyPhoneNo2" />
            </div>
        </div>

        <div class="form-group">
            <label class="col-xs-3 control-label">Phone No 3:</label>
            <div class="col-xs-8">
                <input type="text" class="form-control" name="companyPhoneNo3" />
            </div>
        </div>
        <div class="form-group">
            <label class="col-xs-3 control-label">Bank Name:</label>
            <div class="col-xs-8">

                <input type="text" class="form-control" name="companyBankName" />
            </div>
        </div>
        <div class="form-group">
            <label class="col-xs-3 control-label">IFSC Code:</label>
            <div class="col-xs-8">

                <input type="text" class="form-control" name="companyBankIFSC" />
            </div>
        </div>
        <div class="form-group">
            <label class="col-xs-3 control-label">Account No:</label>
            <div class="col-xs-8">

                <input type="text" class="form-control" name="companyBankAccountNo" />
            </div>
        </div>

        <table id='productTableEdit' class="table table-bordered"  width="100%">
            <thead>
                <tr>
                    <th>Product Name</th>
                    <th>Sub Product Name</th>
                    <th>Price</th>

                </tr>
            </thead>
            <tbody>
            </tbody>

        </table>


        <div class="form-group">
            <div class="col-xs-5 col-xs-offset-3">
                <button type="submit" class="btn btn-primary">Save</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
            </div>
        </div>
    </form>
    <!--edit form ends-->

    <body style="padding-right: 0px !important">
        <div id="page-wrapper">

            <div class="container-fluid">
                <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12">
                        <h3 class="page-header">
                            Address Book  <button class="btn btn-primary" data-toggle="modal" data-target="#loginModal">NEW</button>
                        </h3>



                    </div>
                </div>
                <!-- /.row -->
                <p class="text-center">

                </p>

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

                <div class="row breadcrumb" >
                    <div class="table-responsive">
                        <table id="addressTable" class="table table-bordered table-striped">
                            <thead>
                                <tr>
                                    <th>Sr No.</th>
                                    <th>Company name</th>
                                    <th>GSTIN</th>
                                    <th>Company Address</th>
                                    <th>Company State</th>

                                    <th>Email ID</th>
                                    <th>Phone No. 1</th>
                                    <th>Phone No. 2</th>
                                    <th>Phone No. 3</th>
                                    <th>Bank Name</th>
                                    <th>IFSC Code</th>
                                    <th>Account No.</th>
                                    <th>Edit</th>
                                </tr>
                            </thead>
                            <tbody>
                                <s:iterator value="companyList">
                                    <tr>
                                        <td><s:property value = 'companyId'/></td>
                                        <td><s:property value = 'companyName'/></td>
                                        <td><s:property value = 'companyGSTIN'/></td>
                                        <td><s:property value = 'companyAddress'/></td>
                                        <td><s:property value = 'companyState'/></td>
                                        <td><s:property value = 'companyEmailId'/></td>
                                        <td><s:property value = 'companyPhoneNo1'/></td>
                                        <td><s:property value = 'companyPhoneNo2'/></td>
                                        <td><s:property value = 'companyPhoneNo3'/></td>
                                        <td><s:property value = 'companyBankName'/></td>
                                        <td><s:property value = 'companyBankIFSC'/></td>
                                        <td><s:property value = 'companyBankAccountNo'/></td>
                                        <td><button type="button" data-id="<s:property value = 'companyId'/>" class="btn btn-default editButton">Edit</button></td>
                                    </tr>
                                </s:iterator>
                            </tbody>
                        </table>

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
                $('#loginForm').formValidation({
                    framework: 'bootstrap',
                    excluded: ':disabled',
                    icon: {
                        valid: 'glyphicon glyphicon-ok',
                        invalid: 'glyphicon glyphicon-remove',
                        validating: 'glyphicon glyphicon-refresh'
                    },
                    fields: {
                        companyName: {
                            validators: {
                                notEmpty: {
                                    message: 'Company Name is required'
                                }
                            }
                        },
                        companyAddress: {
                            validators: {
                                notEmpty: {
                                    message: 'Company Address is required'
                                }
                            }
                        },
                        companyGSTIN: {
                            validators: {
                                notEmpty: {
                                    message: 'Company GSTIN is required'
                                }
                            }
                        }
                    }
                });
            });

            $('#loginModal').on('hidden.bs.modal', function() {
                $('#loginForm').formValidation('resetForm', true);
            });

            $('.editButton').on('click', function() {

                // Get the record's ID via attribute
                var id = $(this).attr('data-id');

                $.ajax({
                    url: 'getCompanyDetails?id=' + id,
                    type: "POST",
                    dataType: 'json'
                }).success(function(response) {

                    // Populate the form fields with the data returned from server
                    $('#userForm')
                            .find('[name="companyId"]').val(response.companyId).end()
                            .find('[name="companyName"]').val(response.companyName).end()
                            .find('[name="companyAddress"]').val(response.companyAddress).end()
                            .find('[name="companyGSTIN"]').val(response.companyGSTIN).end()
                            .find('[name="companyEmailId"]').val(response.companyEmailId).end()
                            .find('[name="companyPhoneNo1"]').val(response.companyPhoneNo1).end()
                            .find('[name="companyPhoneNo2"]').val(response.companyPhoneNo2).end()
                            .find('[name="companyPhoneNo3"]').val(response.companyPhoneNo3).end()
                            .find('[name="companyStateId"]').val(response.companyStateId).end()
                            .find('[name="companyBankName"]').val(response.companyBankName).end()
                            .find('[name="companyBankIFSC"]').val(response.companyBankIFSC).end()
                            .find('[name="companyBankAccountNo"]').val(response.companyBankAccountNo).end();

                    $.each(response.productList, function(index, value) {
                        $.each(value.subProductList, function(index1, value1) {
                            $("#productTableEdit").find('tbody').append("<tr><td>" + value.mainProductName + "</td>\n\
                    <td>" + value1.subProductName + "</td>\n\
<td><input type='hidden' name='productList[" + index + "].subProductList[" + index1 + "].subProductId' value='" + value1.subProductId + "'/>\n\
<input type='text' name='productList[" + index + "].subProductList[" + index1 + "].price' value='" + value1.price + "'/></td></tr>");

                        });

                    });


                    // Show the dialog
                    bootbox
                            .dialog({
                                title: 'Edit the user profile',
                                message: $('#userForm'),
                                show: false // We will show it manually later
                            })
                            .on('shown.bs.modal', function() {
                                $('#userForm')
                                        .show()                             // Show the login form
                                        .formValidation('resetForm'); // Reset form
                            })
                            .on('hide.bs.modal', function(e) {
                                // Bootbox will remove the modal (including the body which contains the login form)
                                // after hiding the modal
                                // Therefor, we need to backup the form
                                $('#userForm').hide().appendTo('body');
                            })
                            .modal('show');
                });
            });


            $('#userForm')
                    .formValidation({
                        framework: 'bootstrap',
                        excluded: ':disabled',
                        icon: {
                            valid: 'glyphicon glyphicon-ok',
                            invalid: 'glyphicon glyphicon-remove',
                            validating: 'glyphicon glyphicon-refresh'
                        },
                        fields: {
                            companyName: {
                                validators: {
                                    notEmpty: {
                                        message: 'Company Name is required'
                                    }
                                }
                            },
                            companyAddress: {
                                validators: {
                                    notEmpty: {
                                        message: 'Company Address is required'
                                    }
                                }
                            },
                            companyGSTIN: {
                                validators: {
                                    notEmpty: {
                                        message: 'Company GSTIN is required'
                                    }
                                }
                            }
                        }
                    });


        </script>


    </body>

</html>
