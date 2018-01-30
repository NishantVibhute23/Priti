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
        <script type="text/javascript" src="js/jquery-ui-1.12.1.js"></script>
        <link href="css/jquery-ui.css" rel="stylesheet">
        <title>JSP Page</title>
        <script>
            $(document).ready(function() {
                $("#details").hide();
                $("#detailsP").hide();
                $('#invoiceTable').DataTable();

            });
            $(function() {
                $("#datepicker").datepicker({changeMonth: true,
                    changeYear: true,
                    showAnim: "slideDown",
                    dateFormat: "dd/mm/yy"
                });

            });

            function hideShow()
            {
                var val = $("#modeSelect").val();

                if (val === "cheque")
                {
                    $("#details").show();

                }
                else {
                    $("#details").hide();
                }
            }
            
            function hideShowP()
            {
                var val = $("#modeSelectP").val();

                if (val === "cheque")
                {
                    $("#detailsP").show();

                }
                else {
                    $("#detailsP").hide();
                }
            }

            function setValue(va)
            {
                if ($("#checkId" + va).is(':checked')) {
                    $("#hiddenInvoice" + va).val(va);

                } else {
                    $("#hiddenInvoice" + va).val("0");
                }
            }

            function getPendingInvoice()
            {
                var id = $("#pendingInvoice").val();
                $("#invoiceTableDiv").text("");
                $.ajax({
                    url: 'getPendingInvoiceList?val=' + id,
                    type: "POST",
                    dataType: 'json'
                }).success(function(response) {
                    $(function() {
                        var i = 0;

                        var a = "<table id='invoiceTable' class='table table-bordered table-striped'><thead><tr><th>Invoice No</th><th>Invoice Date</th><th>Amount</th><th>Paid</th></tr></thead><tbody id=''>";


                        $.each(response, function(i, item) {

                            a = a + '<tr><input type="hidden" name="invId[' + i + ']" value="0" id="hiddenInvoice' + item.invoiceId + '" /><td>' + item.invoiceId + '</td><td>' + item.date + '</td><td>' + item.amount + '</td>\n\
                    <td><input type="checkbox" id="checkId' + item.invoiceId + '" onclick="setValue(' + item.invoiceId + ')"</td></tr>';

                            i++;
//                $('<tr class="even" role="row">').append(
//                                    $('<td>').text(item.invoiceId),
//                                    $('<td>').text(item.date),
//                                    $('<td>').text(item.companyName)
//                                    );


                        });
                        a = a + ("</tbody></table>");

                        $("#invoiceTableDiv").append(a);

                    });
                    $('#invoiceTable').DataTable();
                });
            }
            
            
            function getPendingPurchase()
            {
                var id = $("#pendingPurchase").val();
                $("#paymentTableDiv").text("");
                $.ajax({
                    url: 'getPendingPurchaseList?val=' + id,
                    type: "POST",
                    dataType: 'json'
                }).success(function(response) {
                    $(function() {
                        var i = 0;

                        var a = "<table id='paymenyTable' class='table table-bordered table-striped'><thead><tr><th>Invoice No</th><th>Invoice Date</th><th>Amount</th><th>Paid</th></tr></thead><tbody id=''>";


                        $.each(response, function(i, item) {

                            a = a + '<tr><input type="hidden" name="invId[' + i + ']" value="0" id="hiddenInvoice' + item.invoiceId + '" /><td>' + item.invoiceId + '</td><td>' + item.date + '</td><td>' + item.amount + '</td>\n\
                    <td><input type="checkbox" id="checkId' + item.invoiceId + '" onclick="setValue(' + item.invoiceId + ')"</td></tr>';

                            i++;
//                $('<tr class="even" role="row">').append(
//                                    $('<td>').text(item.invoiceId),
//                                    $('<td>').text(item.date),
//                                    $('<td>').text(item.companyName)
//                                    );


                        });
                        a = a + ("</tbody></table>");

                        $("#paymentTableDiv").append(a);

                    });
                    $('#paymenyTable').DataTable();
                });
            }
            

        </script>
    </head>


    <!-- The form which is used to populate the item data -->
    <form id="userForm" method="post" class="form-horizontal" style="display: none;" action="updateVoucher">
        <div class="form-group">
            <label class="col-xs-3 control-label">Invoice ID</label>
            <div class="col-xs-3">
                <input type="hidden" name="type"  />
                <input type="text" class="form-control" name="invoiceId"  readonly/>
            </div>
        </div>

        <div class="form-group">
            <label class="col-xs-3 control-label">Company Name</label>
            <div class="col-xs-5">
                <input type="text" class="form-control" name="companyName" readonly/>
            </div>
        </div>

        <div class="form-group">
            <label class="col-xs-3 control-label">Date</label>
            <div class="col-xs-5">
                <input type="text" class="form-control" name="date" readonly/>
            </div>
        </div>

        <div class="form-group">
            <label class="col-xs-3 control-label">Amount</label>
            <div class="col-xs-5">
                <input type="text" class="form-control" name="amount" readonly/>
            </div>
        </div>
        <div class="form-group">

            <label class="col-xs-12 text-center">Payment Details</label>
        </div>


        <div class="form-group">
            <div class="col-xs-5 col-xs-offset-3">
                <button type="submit" class="btn btn-default">Save</button>
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
                            Voucher
                        </h3    >


                        <ol class="breadcrumb">
                            <li >
                                <i class="fa fa-dashboard"></i> Dashboard
                            </li>
                            <li class="active">
                                <i class="fa fa-product-hunt"></i> Voucher
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

                <div class="row" style="height: 600px">

                    <div id="exTab3">
                        <ul  class="nav nav-pills nav-justified">
                            <li class="active" >
                                <a  href="#1b" data-toggle="tab" style="padding: 10px 100px !important">Payment</a>
                            </li>
                            <li><a href="#2b" data-toggle="tab" style="padding: 10px 100px !important">Receipt</a>
                            </li>

                        </ul>


                        <div class="tab-content clearfix">
                            <br>
                            
                            <!--invoice-->
                            <div class="tab-pane active" id="1b">
                                <form action="updateVoucher">
                                    <input type="hidden" id="" name="type" value="i"/>
                                    <div class="row">
                                        <div class="form-group">
                                            <label class="col-xs-2 control-label">Select Company</label>

                                            <div class="col-xs-9">
                                                <select id="pendingInvoice" class="form-control"  onchange="getPendingInvoice()">
                                                    <option value="0">Select</option>
                                                    <s:iterator value="companyList">
                                                        <option value="<s:property value = 'companyId'/>"><s:property value = 'companyName'/></option>
                                                    </s:iterator>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <br>
                                    <div class="row">
                                        
                                        <div class="form-group">
                                            <label class="col-xs-2 control-label">Date</label>
                                            <div class="col-xs-3">
                                                <input type="text" id="datepicker" class="form-control" name="paymentDate" />
                                            </div>

                                            <label class="col-xs-2 control-label">Mode</label>

                                            <div class="col-xs-3">
                                                <select id="modeSelect" name="mode" class="form-control"  onchange="hideShow()">
                                                    <option selected value="cash">Cash</option>
                                                    <option value="cheque">Cheque</option>

                                                </select>
                                            </div>
                                        </div>

                                    </div>
                                    <div id="details" >
                                        <br>
                                        <div class="row">

                                            <div class="form-group">
                                                <label class="col-xs-2 control-label">Cheque No.</label>
                                                <div class="col-xs-3">
                                                    <input type="text" class="form-control" name="chequeNo" />
                                                </div>

                                                <label class="col-xs-2 control-label">Cheque Date</label>
                                                <div class="col-xs-3">
                                                    <input type="text" class="form-control" name="date" />
                                                </div>
                                            </div>
                                        </div>
                                        <br>
                                        <div class="row">

                                            <div class="form-group">
                                                <label class="col-xs-2 control-label">Bank Name</label>
                                                <div class="col-xs-3">
                                                    <input type="text" class="form-control" name="bankName" />
                                                </div>


                                            </div>

                                        </div>

                                    </div>
                                    <br>

                                    <div class="row">
                                        <div class="form-group">
                                            <label class="col-xs-2 control-label">Pay Amount</label>
                                            <div class="col-xs-3">
                                                <input type="text" class="form-control" name="paymentAmount" />
                                            </div>
                                        </div>
                                    </div>            
                                    <hr>
                                    <div class="table-responsive" id="invoiceTableDiv">

                                    </div>
                                    <input type="submit" value="SAVE"/>
                                </form>
                            </div>
                            
                            
                            
                            <!--purchase-->
                            
                            <div class="tab-pane" id="2b">
                                <form action="updateVoucher">
                                    <input type="hidden" id="" name="type" value="p"/>
                                    <div class="row">
                                        <div class="form-group">
                                            <label class="col-xs-2 control-label">Select Company</label>

                                            <div class="col-xs-9">
                                                <select id="pendingPurchase" class="form-control"  onchange="getPendingPurchase()">
                                                    <option value="0">Select</option>
                                                    <s:iterator value="companyList">
                                                        <option value="<s:property value = 'companyId'/>"><s:property value = 'companyName'/></option>
                                                    </s:iterator>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <br>
                                    <div class="row">
                                        <div class="form-group">
                                            <label class="col-xs-2 control-label">Date</label>
                                            <div class="col-xs-3">
                                                <input type="text" id="datepicker" class="form-control" name="paymentDate" />
                                            </div>

                                            <label class="col-xs-2 control-label">Mode</label>

                                            <div class="col-xs-3">
                                                <select id="modeSelectP" name="mode" class="form-control"  onchange="hideShowP()">
                                                    <option selected value="cash">Cash</option>
                                                    <option value="cheque">Cheque</option>

                                                </select>
                                            </div>
                                        </div>

                                    </div>
                                    <div id="detailsP" >
                                        <br>
                                        <div class="row">

                                            <div class="form-group">
                                                <label class="col-xs-2 control-label">Cheque No.</label>
                                                <div class="col-xs-3">
                                                    <input type="text" class="form-control" name="chequeNo" />
                                                </div>

                                                <label class="col-xs-2 control-label">Cheque Date</label>
                                                <div class="col-xs-3">
                                                    <input type="text" class="form-control" name="date" />
                                                </div>
                                            </div>
                                        </div>
                                        <br>
                                        <div class="row">

                                            <div class="form-group">
                                                <label class="col-xs-2 control-label">Bank Name</label>
                                                <div class="col-xs-3">
                                                    <input type="text" class="form-control" name="bankName" />
                                                </div>


                                            </div>

                                        </div>

                                    </div>
                                    <br>

                                    <div class="row">
                                        <div class="form-group">
                                            <label class="col-xs-2 control-label">Pay Amount</label>
                                            <div class="col-xs-3">
                                                <input type="text" class="form-control" name="paymentAmount" />
                                            </div>
                                        </div>
                                    </div>            
                                    <hr>
                                    <div class="table-responsive" id="paymentTableDiv">

                                    </div>
                            </div>

                        </div>
                    </div>
                    <!-- /.container-fluid -->

                </div>
                <!-- /#page-wrapper -->

            </div>
            <!-- /#wrapper -->



            <script>



                

            </script>


    </body>

</html>
