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
        <script type="text/javascript" src="https://cdn.datatables.net/r/bs-3.3.5/jqc-1.11.3,dt-1.10.8/datatables.min.js"></script>
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
                $("#detailsN").hide();
                $('#invoiceTable').DataTable();

                $("#dashboard").removeClass("active");

                $("#Invoice").removeClass("active");
//                $("#invoiceId").show()
                $("#InvoiceNew").removeClass("highlight");
                $("#InvoiceDetails").removeClass("highlight");
                $("#InvoicePayment").removeClass("highlight");
//$("#purchaseId").show()
                $("#Purchase").removeClass("active");
                $("#PurchaseNew").removeClass("highlight");
                $("#PurchaseDetails").removeClass("highlight");

                $("#Products").removeClass("active");
                $("#AddressBook").removeClass("active");
                $("#RawMaterial").removeClass("active");
                $("#Ledger").removeClass("active");
                $("#Bills").addClass("active");
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
            
            
            
            
            
            function download()
            {
                $('#download').modal('show');
                var formData = $("#billForm").serialize();
                $.ajax({
                    url: 'downloadBills',
                    type: "POST",
                    data: formData
                }).success(function(response) {
                    $("#spinner").hide();
                    $('#invoiceModal').find('.modal-body').text("");
                    $('#invoiceModal').find('.modal-body').append("<iframe width='100%' height='700px' id='iFramePdf' src='" + response + "/getLedgerFile'  ></iframe>");
                    $('#invoiceModal').modal('show');
                });
            }
            
            
            
            
            
            
                    </script>
    </head>


    <body style="padding-right: 0px !important">
        <div id="page-wrapper">

            <div class="container-fluid">
                <!-- Page Heading -->
                <!-- /.row -->
                <div class="row">
                    <div class="col-lg-12">
                        <h3 class="page-header">
                            Bills
                        </h3>
                        
                    </div>
                </div>
                <!-- /.row -->

                <div class="row col-sm-4" style="height: 600px">
                    
                    <!--invoice-->

                    <form id="billForm" action="downloadBills">
                        <div class="panel panel-default">
                            <div class="panel-heading text-center"><b>Bill</b></div>
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="row">
                                            <div class="col-md-12 well">
                                                <div class="form-group row">
                                                    <label for="lgFormGroupInput" class="col-sm-2 col-form-label col-form-label-lg">From</label>
                                                    <div class="col-sm-10">
                                                        <input type="text" id="datepicker" class="form-control" required name="fromDate" />

                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <label for="lgFormGroupInput" class="col-sm-2 col-form-label col-form-label-lg">To</label>
                                                    <div class="col-sm-10">
                                                        <input type="text" id="datepicker1" class="form-control" required name="toDate" />

                                                    </div>
                                                </div>
                                                <div class="form-group row text-center">
                                                    <input type="submit"  class="btn btn-primary col-xs-6 col-xs-offset-3" value="Download" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                        </div>
                                        
                        </div>
                    </form>
                    <!-- /.container-fluid -->

            </div>
            <!-- /#page-wrapper -->

        </div>
        <!-- /#wrapper -->

<div id="invoiceModal" class="modal fade" role="dialog">
                    <div class="modal-dialog modal-lg">

                        <!-- Modal content-->
                        <div class="modal-content">
                            <div style="width: 100%;height: 700px;" id="spinner"><center><div  style="margin-top: 300px"><img src="images/ajax-loader.gif"/></br>Loading... Please Wait</div></center></div>
                            <div class="modal-body" id="printableDiv1">

                            </div>
                            <div class="modal-footer">
                                <!--<input type="button" value="Print" onclick="printTrigger('iFramePdf');" />-->
                                <!--<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>-->
                                <center> <button type="button" class="btn btn-default" data-dismiss="modal">Close</button></center>

                            </div>
                        </div>

                    </div>

                </div>

        <script>





        </script>


    </body>

</html>
