<%-- 
    Document   : success
    Created on : Jul 17, 2017, 6:46:38 PM
    Author     : nishant.vibhute
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/jsp/include/includeSideMenu.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
        <script type="text/javascript" src="js/jquery-2.2.4.min.js"></script>
        <script type="text/javascript" src="js/dashboard.js"></script>
        
        
        <!--<script type="text/javascript" src="js/bootstrap-datepicker.min.js"></script>-->
        <script type="text/javascript" src="https://cdn.datatables.net/r/bs-3.3.5/jqc-1.11.3,dt-1.10.8/datatables.min.js"></script>
        <script type="text/javascript" src="js/jquery-ui-1.12.1.js"></script>


        <script type="text/javascript" src="js/bootstrap.js"></script>

        <link href="css/jquery-ui.css" rel="stylesheet">
        <title>JSP Page</title>
        
        <script>
            $( document ).ready(function() {
//    $("#reports").addClass("active");
$("#dashboard").addClass("active");

$("#Invoice").removeClass("active");
//$("#invoiceId").show()
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



});
            
        </script>
    </head>
    <body>
        <div id="page-wrapper">

            <div class="container-fluid">
        <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            Dashboard <small>Statistics Overview</small>
                        </h1>
                        <ol class="breadcrumb">
                            <li class="active">
                                <i class="fa fa-dashboard"></i> Dashboard
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->

                              
              

                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"><i class="fa fa-bar-chart-o fa-fw"></i>Statistics</h3>
                            </div>
                            <div class="panel-body">
                                <div>
                                    <input type="text" placeholder="From" id="datepickerStatsFrom" size="16" style="background-color: #fff !important"  readonly name="date" /> 
                                    <input type="text" placeholder="To" id="datepickerSatsTo" size="16" style="background-color: #fff !important"  readonly name="date" />
                                    <input type="button" id="statsReport" value="Go">
                                </div>
                                <hr>
                                
                                <div id="morris-area-chart"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.row -->

                <div class="row">
                    <div class="col-lg-4">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"><i class="fa fa-long-arrow-right fa-fw"></i> Purchase</h3>
                            </div>
                            <div class="panel-body">
                                <div>
                                    <input placeholder="From" type="text" id="datepickerPurchaseFrom" size="10" style="background-color: #fff !important"  readonly name="date" /> 
                                    <input placeholder="To" type="text"  id="datepickerPurchaseTo" size="10" style="background-color: #fff !important"  readonly name="date" />
                                    <input type="button" id="purchaseReport" value="Go">
                                </div>
                                <hr>
                                <div id="purchase-report"></div>
                               
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"><i class="fa fa-long-arrow-right fa-fw"></i> Sales </h3>
                            </div>
                            <div class="panel-body">
                                <div>
                                   <input placeholder="From" type="text" id="datepickerSalesFrom" size="10" style="background-color: #fff !important"  readonly name="date" /> 
                                    <input placeholder="To" type="text"  id="datepickerSalesTo" size="10" style="background-color: #fff !important"  readonly name="date" />
                                    <input type="button" id="salesReport" value="Go">
                                </div>
                                <hr>
                                <div id="sales-report"></div>
                               
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"><i class="fa fa-long-arrow-right fa-fw"></i> Profit/Loss </h3>
                            </div>
                            <div class="panel-body">
                                <div>
                                    <input type="text" placeholder="From" id="datepickerPlFrom" size="10" style="background-color: #fff !important"  readonly name="date" /> 
                                    <input type="text" placeholder="To"  id="datepickerPlTo" size="10" style="background-color: #fff !important"  readonly name="date" />
                                    <input type="button" id="plReport" value="Go">
                                </div>
                                <hr>
                                <div id="pl-report"></div>
                               
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
