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
        <script type="text/javascript" src="https://cdn.datatables.net/r/bs-3.3.5/jqc-1.11.3,dt-1.10.8/datatables.min.js"></script>
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
                $("#detailsN").hide();
                $('#invoiceTable').DataTable();

                $("#dashboard").removeClass("active");

                $("#Invoice").removeClass("active");
//                $("#invoiceId").show()
                $("#InvoiceNew").removeClass("highlight");
                $("#InvoiceDetails").removeClass("highlight");
                $("#InvoicePayment").removeClass("highlight");
                $("#purchaseId").show()
                $("#Purchase").addClass("active");
                $("#PurchaseNew").removeClass("highlight");
                $("#PurchaseDetails").removeClass("highlight");
                $("#PurchasePayment").addClass("highlight");
                $("#Products").removeClass("active");
                $("#AddressBook").removeClass("active");
                $("#RawMaterial").removeClass("active");
                $("#Ledger").removeClass("active");
            });
            $(function() {
                $("#datepicker").datepicker({changeMonth: true,
                    changeYear: true,
                    showAnim: "slideDown",
                    dateFormat: "dd/mm/yy"
                });

                $("#datepicker1").datepicker({changeMonth: true,
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
                    $("#detailsN").hide();

                } else if (val === "neft") {
                    $("#detailsP").hide();
                    $("#detailsN").show();
                }
                else {
                    $("#detailsP").hide();
                    $("#detailsN").hide();
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
                $("#countAmtRow").val(0);
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

                            a = a + '<tr><input type="hidden" name="invId[' + i + ']" value="' + item.id + '" id="hiddenInvoice' + item.invoiceId + '" /><td>' + item.invoiceId + '</td><td>' + item.date + '</td>\n\
                    <td><input type="hidden"  value="' + item.amount + '" id="amount' + i + '" />' + item.amount + '</td>\n\
                    <td><input type="checkbox" id="checkId' + item.invoiceId + '" onclick="setValue(' + item.invoiceId + ')"</td></tr>';

                            i++;

//                $('<tr class="even" role="row">').append(
//                                    $('<td>').text(item.invoiceId),
//                                    $('<td>').text(item.date),
//                                    $('<td>').text(item.companyName)
//                                    );
                            $("#countAmtRow").val(i);

                        });
                        a = a + ("</tbody></table>");

                        $("#paymentTableDiv").append(a);


                    });
                    $('#paymenyTable').DataTable();

                    var sum = 0;

                    for (var j = 0; j < $("#countAmtRow").val(); j++) {
                        sum = parseFloat(sum) + parseFloat($("#amount" + j).val());
                    }
//                    alert(sum);
                    $("#totalPendingAmt").val(sum);


                });
            }


        </script>
    </head>




    <body style="padding-right: 0px !important">
        <div id="page-wrapper">

            <div class="container-fluid">
                <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12">
                        <h3 class="page-header">
                            Purchase Payment
                        </h3>

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


                <div class="row" style="height: 600px">

                    <form action="updateVoucher">

                        <div class="panel panel-default">
                            <div class="panel-heading text-center"><b>PURCHASE</b></div>
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class=" form-group row">
                                            <input type="hidden" id="" name="type" value="p"/>
                                            <label class="col-sm-2 col-form-label col-form-label-lg">Select Company</label>

                                            <div class="col-sm-10">
                                                <select required id="pendingPurchase" class="form-control"  onchange="getPendingPurchase()">
                                                    <option value="">Select</option>
                                                    <s:iterator value="companyList">
                                                        <option value="<s:property value = 'companyId'/>"><s:property value = 'companyName'/></option>
                                                    </s:iterator>
                                                </select>
                                            </div>

                                        </div>
                                        <div class="form-group row">
                                            <label class="col-xs-2 control-label">Pending Amount</label>
                                            <div class="col-xs-3">
                                                <input type="text" required class="form-control" name="" id="totalPendingAmt" value="0" />
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-xs-2 control-label">Date</label>
                                            <div class="col-xs-3">
                                                <input type="text" required id="datepicker" class="form-control" name="paymentDate" />
                                            </div>

                                            <label class="col-xs-2 control-label">Mode</label>

                                            <div class="col-xs-3">
                                                <select required id="modeSelectP" name="mode" class="form-control"  onchange="hideShowP()">
                                                    <option selected value="cash">Cash</option>
                                                    <option value="cheque">Cheque</option>
                                                    <option value="neft">NEFT</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div id="detailsP" >



                                            <div class="form-group row">
                                                <label class="col-xs-2 control-label">Cheque No.</label>
                                                <div class="col-xs-3">
                                                    <input type="text" class="form-control" name="chequeNo" />
                                                </div>

                                                <label class="col-xs-2 control-label">Cheque Date</label>
                                                <div class="col-xs-3">
                                                    <input type="text" class="form-control" id="datepicker1" name="date" />
                                                </div>
                                            </div>


                                            <div class="form-group row">
                                                <label class="col-xs-2 control-label">Bank Name</label>
                                                <div class="col-xs-3">
                                                    <input type="text" class="form-control" name="bankName" />
                                                </div>


                                            </div>



                                        </div>
                                        <div id="detailsN" >


                                            <div class="form-group row">
                                                <label class="col-xs-2 control-label">UTR No.</label>
                                                <div class="col-xs-3">
                                                    <input type="text" class="form-control" name="utrNo" />
                                                </div>

                                                <label class="col-xs-2 control-label">IFSC Code</label>
                                                <div class="col-xs-3">
                                                    <input type="text" class="form-control" name="ifscCode" />
                                                </div>
                                            </div>



                                        </div>
                                        <div class="form-group row">
                                            <label class="col-xs-2 control-label">Pay Amount</label>
                                            <div class="col-xs-3">
                                                <input type="text" required class="form-control" name="paymentAmount" />
                                            </div>
                                        </div>


                                        <div class="form-group row">
                                            <div class="col-xs-12 well">
                                                <input type="hidden" id="countAmtRow" />
                                                <div class="table-responsive" id="paymentTableDiv"></div>
                                            </div>
                                        </div>

                                        <div class="form-group row">
                                            <div class="col-xs-3">
                                                <button type="submit" class="btn btn-primary">Save</button>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>








                <!--purchase-->




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
