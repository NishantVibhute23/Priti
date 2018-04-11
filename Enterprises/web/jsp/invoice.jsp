<%--
    Document   : purchase
    Created on : Jul 19, 2017, 1:39:05 PM
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
        <script type="text/javascript" src="js/invoice.js"></script>
        <!--<script type="text/javascript" src="js/bootstrap-datepicker.min.js"></script>-->
        <script type="text/javascript" src="https://cdn.datatables.net/r/bs-3.3.5/jqc-1.11.3,dt-1.10.8/datatables.min.js"></script>
        <script type="text/javascript" src="js/jquery-ui-1.12.1.js"></script>


        <script type="text/javascript" src="js/bootstrap.js"></script>

        <link href="css/jquery-ui.css" rel="stylesheet">


        <title>JSP Page</title>
        <style>

        </style>
        <script>

            $(document).ready(function() {

//    $("#reports").addClass("active");
                $("#dashboard").removeClass("active");

                $("#Invoice").addClass("active");
                $("#invoiceId").show()
                $("#InvoiceNew").addClass("highlight");
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
                $("#Bills").removeClass("active");

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
            function getCompanyInfoBillTo()
            {

                var id = $("#billToCompSelect").val();
                $("#hiddenBillToName").val($("#billToCompSelect option:selected").text());
                $.ajax({
                    url: 'getCompanyDetails?id=' + id,
                    type: "POST",
                    dataType: 'json'
                }).success(function(response) {

//                    map = {};
                    $("#companyId").val(response.companyId);
                    $("#billToAddress").val(response.companyAddress);
                    $("#billToGSTIN").val(response.companyGSTIN);
                    $("#billToState").val(response.companyState);
                    $("#billToCode").val(response.companyStateCode);



//                    $.each(response.productList, function(index, value) {
//                        $.each(value.subProductList, function(index1, value1) {
//                            map[value1.subProductId] = value1.price;
//
//                        });
//
//                    });



                });


            }
            function getCompanyInfoShipTo()
            {
                var id = $("#shipToCompSelect").val();
                $("#hiddenShipToName").val($("#shipToCompSelect option:selected").text());
                $.ajax({
                    url: 'getCompanyDetails?id=' + id,
                    type: "POST",
                    dataType: 'json'
                }).success(function(response) {


                    $("#companyId").val(response.companyId);
                    $("#shipToAddress").val(response.companyAddress);
                    $("#shipToGSTIN").val(response.companyGSTIN);
                    $("#shipToState").val(response.companyState);
                    $("#shipToCode").val(response.companyStateCode);
                });
            }


            function viewBill()
            {
                $('#invoiceModal').modal('show');
                var formData = $("#invoiceForm").serialize();
                $.ajax({
                    url: 'printInvoice',
                    type: "POST",
                    data: formData
                }).success(function(response) {

                    $("#spinner").hide();
                    $('#invoiceModal').find('.modal-body').text("");
                    $('#invoiceModal').find('.modal-body').append("<iframe width='100%' height='700px' id='iFramePdf' src='" + response + "/getPdfFile'  ></iframe>");
                    $('#invoiceModal').modal('show');
                });
            }


            function setValue(val)
            {
                if (val === "cgst")
                {
                    if ($("#cgstCheckBox").is(':checked')) {
                        $("#cgstPerc0").val("9");
                        $("#cgstPercFinal").val("9");

                    } else {
                        $("#cgstPerc0").val("0");
                        $("#cgstPercFinal").val("0");
                    }
                }
                if (val === "sgst")
                {
                    if ($("#sgstCheckBox").is(':checked')) {
                        $("#sgstPerc0").val("9");
                        $("#sgstPercFinal").val("9");
                    } else {
                        $("#sgstPerc0").val("0");
                        $("#sgstPercFinal").val("0");
                    }
                }
                if (val === "igst")
                {
                    if ($("#igstCheckBox").is(':checked')) {
                        $("#igstPerc0").val("18");
                        $("#igstPercFinal").val("18");
                    } else {
                        $("#igstPerc0").val("0");
                        $("#igstPercFinal").val("0");
                    }
                }

            }

            function setProduct(val)
            {
                $("#hsn" + val).val("");
                $("#uom" + val).val("");
                $("#price" + val).val("");
                var bill = $("#billToCompSelect").val();
                if (($("#cgstCheckBox").is(':checked') && $("#sgstCheckBox").is(':checked')) || $("#igstCheckBox").is(':checked'))
                {

                    if (bill !== "")
                    {
                        var id = $("#productSelect" + val + " option:selected").val()

                        $.ajax({
                            url: 'getHSNUOMPRICE?prodId=' + id + "&compId=" + bill,
                            type: "POST",
                            dataType: 'json'
                        }).success(function(response) {
                            $("#productType" + val).val(response.mainProductType);
                            $("#hsn" + val).val(response.mainProductHSN);
                            $("#uom" + val).val(response.mainProductUOM);
                            $("#price" + val).val(response.price);

                        });



                        $("#productId" + val).val($("#productSelect" + val + " option:selected").text());
                    } else {
                        alert("Please Select Company");
                        $("#productSelect" + val).val(0);
                    }
                } else {
                    alert("Please Select GST Type");
                    $("#productSelect" + val).val(0);
                }
            }



            function printDiv(divName) {
                var printContents = document.getElementById(divName).innerHTML;
                var originalContents = document.body.innerHTML;
                document.body.innerHTML = printContents;
                window.print();
                document.body.innerHTML = originalContents;
            }

            function resetInvoiceNumber()
            {
                $("#invoiceNo").val(1);
                var d = new Date();
                var n = d.getFullYear();
                $("#invoiceNum").val(1 + "/" + n + "-" + (n + 1));
            }


        </script>
        <style>
            table, th, td {
                border: 0px solid #ddd;
                /*text-align: center;*/
                padding: 1px !important;

            }



            .form-control {
                padding: 1px 1px !important;
            }


        </style>
    </head>
    <body>
        <div id="page-wrapper">

            <div class="container-fluid">
                <!-- Page Heading -->

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
                        <h3 class="page-header">
                            Invoice New <input type="button"  class="btn btn-primary col-xs-2" style="float: right" onclick="resetInvoiceNumber()"  value="Reset Invoice Number" />
                        </h3>

                    </div>
                </div>


                <div class="panel panel-default">
                    <div class="panel-heading text-center"><b>Tax Invoice</b></div>
                    <div class="panel-body"><form  id="invoiceForm" action="saveInvoice" method="post">

                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="row">
                                        <div class="col-md-6 well">

                                            <div class="form-group row">
                                                <label for="lgFormGroupInput" class="col-sm-3 col-form-label col-form-label-lg">Invoice No.</label>
                                                <div class="col-sm-9">
                                                    <input type="hidden" id="count" value="1"/>
                                                    <input type="hidden"  class="form-control" id="invoiceNo" name="invoiceNo" value="<s:property value = 'latestInvoiceNumber'/>"/>
                                                    <input type="text" readonly  class="form-control" id ="invoiceNum" name="invoiceNumber" value="<s:property value = 'latestInvoiceNum'/>"/>

                                                </div>
                                            </div>

                                            <div class="form-group row">
                                                <label for="lgFormGroupInput" class="col-sm-3 col-form-label col-form-label-lg">Invoice Date.</label>
                                                <div class="col-sm-9">
                                                    <input type="text" required class="form-control" id="datepicker"  style="background-color: #fff !important"  name="date" />
                                                </div>
                                            </div>

                                            <div class="form-group row">
                                                <label for="lgFormGroupInput" class="col-sm-3 col-form-label col-form-label-lg">Reverse Charge</label>
                                                <div class="col-sm-9">
                                                    <select name="reverseCharge" class="form-control">
                                                        <option selected value="no">NO</option>
                                                        <option value="yes">YES</option>

                                                    </select>
                                                </div>
                                            </div>

                                            <div class="form-group row">

                                                <s:iterator value="myProfileList">
                                                    <label class="col-sm-3 control-label">State </label>
                                                    <div class="col-sm-5">
                                                        <input type="text" style="background-color: #fff !important"  readonly  value="<s:property value = 'companyState'/>" class="form-control" name="state" />
                                                    </div>
                                                    <label class="col-sm-1 control-label">Code </label>
                                                    <div class="col-sm-3">
                                                        <input type="text" style="background-color: #fff !important"  readonly  value="<s:property value = 'companyStateCode'/>" class="form-control" name="code" />
                                                    </div>
                                                </s:iterator>


                                            </div>
                                        </div>

                                        <div class="col-md-6 well">
                                            <div class="form-group row">
                                                <label for="lgFormGroupInput" class="col-sm-3 col-form-label col-form-label-lg">Transport Mode</label>
                                                <div class="col-sm-9">
                                                    <input type="text" class="form-control" name="transportMode" />
                                                </div>
                                            </div>

                                            <div class="form-group row">
                                                <label for="lgFormGroupInput" class="col-sm-3 col-form-label col-form-label-lg">Vehicle No.</label>
                                                <div class="col-sm-9">
                                                    <input type="text" class="form-control" name="vehicleNo" />
                                                </div>
                                            </div>

                                            <div class="form-group row">
                                                <label for="lgFormGroupInput" class="col-sm-3 col-form-label col-form-label-lg">Date Of Supply</label>
                                                <div class="col-sm-9">
                                                    <input type="text" class="form-control" id="datepicker1" style="background-color: #fff !important" readonly name="dateOfSupply" />
                                                </div>
                                            </div>

                                            <div class="form-group row">
                                                <label for="lgFormGroupInput" class="col-sm-3 col-form-label col-form-label-lg">Place Of Supply</label>
                                                <div class="col-sm-9">
                                                    <input type="text" class="form-control" name="placeOfSupply" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6 well">
                                            <div class="form-group row">
                                                <label for="lgFormGroupInput" class="col-sm-12 col-form-label col-form-label-lg text-center ">Bill to Party</label>

                                            </div>

                                            <div class="form-group row">
                                                <label for="lgFormGroupInput" class="col-sm-3 col-form-label col-form-label-lg">Name</label>
                                                <input type="hidden" id="hiddenBillToName" name="billToName"/>
                                                <div class="col-sm-9">
                                                    <select id="billToCompSelect" required class="form-control" name="billTO"  onchange="getCompanyInfoBillTo()">
                                                        <option value="">Select</option>
                                                        <s:iterator value="companyList">
                                                            <option value="<s:property value = 'companyId'/>"><s:property value = 'companyName'/></option>
                                                        </s:iterator>
                                                    </select>
                                                </div>
                                            </div>

                                            <div class="form-group row">
                                                <label for="lgFormGroupInput" class="col-sm-3 col-form-label col-form-label-lg">Address</label>
                                                <div class="col-sm-9">
                                                    <textarea style="height:80px" id="billToAddress" resize="none" name="billToAddress" class="form-control"> </textarea>
                                                </div>
                                            </div>

                                            <div class="form-group row">
                                                <label for="lgFormGroupInput" class="col-sm-3 col-form-label col-form-label-lg">GSTIN</label>
                                                <div class="col-sm-9">
                                                    <input type="text" class="form-control" id="billToGSTIN"  name="billToGSTIN" />
                                                </div>
                                            </div>

                                            <div class="form-group row">

                                                <label class="col-xs-3 control-label">State </label>
                                                <div class="col-xs-5">
                                                    <input type="text" class="form-control" id="billToState" name="billToState" />
                                                </div>
                                                <label class="col-xs-1 control-label">Code </label>
                                                <div class="col-xs-3">
                                                    <input type="text" class="form-control"  id="billToCode" name="billToCode" />
                                                </div>


                                            </div>

                                        </div>
                                        <div class="col-md-6 well">
                                            <div class="form-group row">
                                                <label for="lgFormGroupInput" class="col-sm-12 col-form-label col-form-label-lg text-center ">Ship to Party</label>

                                            </div>
                                            <div class="form-group row">
                                                <label for="lgFormGroupInput" class="col-sm-3 col-form-label col-form-label-lg">Name</label>
                                                <input type="hidden" id="hiddenShipToName" name="shipToName"/>
                                                <div class="col-sm-9">
                                                    <select id="shipToCompSelect"  class="form-control" name="shipTo" onchange="getCompanyInfoShipTo()">
                                                        <option value="0">Select</option>
                                                        <s:iterator value="companyList">
                                                            <option value="<s:property value = 'companyId'/>"><s:property value = 'companyName'/></option>
                                                        </s:iterator>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label for="lgFormGroupInput" class="col-sm-3 col-form-label col-form-label-lg">Address</label>
                                                <div class="col-sm-9">
                                                    <textarea style="height:80px" id="shipToAddress" resize="none" name="shipToAddress" class="form-control"> </textarea>
                                                </div>
                                            </div>

                                            <div class="form-group row">
                                                <label for="lgFormGroupInput" class="col-sm-3 col-form-label col-form-label-lg">GSTIN</label>
                                                <div class="col-sm-9">
                                                    <input type="text" class="form-control" id="shipToGSTIN" name="shipToGSTIN" />
                                                </div>
                                            </div>

                                            <div class="form-group row">

                                                <label class="col-xs-3 control-label">State </label>
                                                <div class="col-xs-5">
                                                    <input type="text" class="form-control" id="shipToState" name="shipToState" />
                                                </div>
                                                <label class="col-xs-1 control-label">Code </label>
                                                <div class="col-xs-3">
                                                    <input type="text" class="form-control" id="shipToCode" name="shipToCode" />
                                                </div>


                                            </div>


                                        </div>
                                    </div>






                                </div><!--/col-12-->

                            </div><!--/row-->

                            <div class="row">

                                <div class="col-sm-12 well">
                                    <div class="checkbox">
                                        <label><input type="checkbox" id="cgstCheckBox" onchange="setValue('cgst')"/>CGST</label>
                                    </div>
                                    <div class="checkbox">
                                        <label><input type="checkbox" id="sgstCheckBox" onchange="setValue('sgst')"/>SGST</label>
                                    </div>
                                    <div class="checkbox disabled">
                                        <label><input type="checkbox" id="igstCheckBox" onchange="setValue('igst')"/>IGST</label>
                                    </div>
                                    <table id="myTable" class="myt table order-list" style="border:1px solid #ddd" >

                                        <thead>
                                            <tr style="text-align: center">
                                                <th style="text-align: center;border:1px solid #ddd"  width="28%" rowspan="2">Name</th>
                                                <th style="text-align: center;border:1px solid #ddd" width="8%" rowspan="2">HSN</th>
                                                <th style="text-align: center;border:1px solid #ddd" width="5%" rowspan="2">UOM</th>
                                                <th style="text-align: center;border:1px solid #ddd" width="5%" rowspan="2">QTY</th>

                                                <th style="text-align: center;border:1px solid #ddd" width="5%" rowspan="2">PRICE</th>
                                                <th style="text-align: center;border:1px solid #ddd" width="7%" rowspan="2">AMOUNT</th>
                                                <th style="text-align: center;border:1px solid #ddd" width="10%" colspan="2"> CGST </th>

                                                <th style="text-align: center;border:1px solid #ddd" width="10%" colspan="2"> SGST</th>

                                                <th style="text-align: center;border:1px solid #ddd" width="10%" colspan="2"> IGST </th>

                                                <th style="text-align: center;border:1px solid #ddd" width="8%" rowspan="2">TOTAL AMOUNT</th>
                                            </tr>
                                            <tr align="center">

                                                <th style="text-align: center" width="3%">PERC</th>
                                                <th  style="text-align: center;border:1px solid #ddd" width="7%">AMOUNT</th>
                                                <th style="text-align: center" width="3%">PERC</th>
                                                <th style="text-align: center;border:1px solid #ddd" width="7%">AMOUNT</th>
                                                <th style="text-align: center" width="3%">PERC</th>
                                                <th style="text-align: center;border:1px solid #ddd" width="7%">AMOUNT</th>

                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>

                                                <td >
                                                    <input type="hidden" id="productId0" name="invoiceDetails[0].productName"/>
                                                    <input type="hidden" id="productType0" name="invoiceDetails[0].productType"/>
                                                    <select id="productSelect0" required name="invoiceDetails[0].productId" class="form-control" onchange="setProduct(0)">
                                                        <option value="">Select</option>
                                                        <s:iterator value="subProductList">
                                                            <option value="<s:property value = 'subProductId'/>"><s:property value = 'subProductName'/></option>
                                                        </s:iterator>
                                                    </select>
                                                </td>
                                                <td >
                                                    <input required style="text-align: center;background-color: #fff !important" tabindex="-1"  readonly  required type="text" name="invoiceDetails[0].hsn" id="hsn0"   class="form-control"/>
                                                </td>
                                                <td >
                                                    <input required style="text-align: center;background-color: #fff !important" tabindex="-1" readonly  required   type="text" name="invoiceDetails[0].uom" id="uom0"    class="form-control"/>
                                                </td>
                                                <td >
                                                    <input required style="text-align: center"  required  type="text" name="invoiceDetails[0].qty" id="qty0" onblur="calculateRowGSTTotal('0')" class="form-control"/>
                                                </td>

                                                <td >
                                                    <input required style="text-align: center"  required  type="text" tabindex="-1" name="invoiceDetails[0].price" id="price0"  onblur="calculateRowGSTTotal('0')"  class="form-control"/>
                                                </td>

                                                <td >
                                                    <input required style="text-align: center;background-color: #fff !important" tabindex="-1" readonly  required  type="text" name="invoiceDetails[0].amount" id="amount0"  class="form-control"/>
                                                </td>
                                                <td >
                                                    <input required style="text-align: center;background-color: #fff !important" tabindex="-1"    required  type="text" name="invoiceDetails[0].cgstPerc" id="cgstPerc0" onblur="calculateRowGSTTotal('0')" value="0" class="form-control"/>
                                                </td>
                                                <td >
                                                    <input required style="text-align: center;background-color: #fff !important" tabindex="-1" readonly   required  type="text" name="invoiceDetails[0].cgstAmount" id="cgstAmt0" class="form-control"/>
                                                </td>
                                                <td >
                                                    <input required style="text-align: center;background-color: #fff !important" tabindex="-1"    required  type="text" name="invoiceDetails[0].sgstPerc" id="sgstPerc0" onblur="calculateRowGSTTotal('0')"  value="0" class="form-control"/>
                                                </td>
                                                <td >
                                                    <input required style="text-align: center;background-color: #fff !important" tabindex="-1"   readonly   required  type="text" name="invoiceDetails[0].sgstAmount"  id="sgstAmt0" class="form-control"/>
                                                </td>
                                                <td >
                                                    <input required style="text-align: center;background-color: #fff !important" tabindex="-1"    required  type="text" name="invoiceDetails[0].igstPerc" id="igstPerc0" onblur="calculateRowGSTTotal('0')" value="0" class="form-control"/>
                                                </td>
                                                <td >
                                                    <input required style="text-align: center;background-color: #fff !important" tabindex="-1" readonly   required  type="text" name="invoiceDetails[0].igstAmount"  id="igstAmt0" class="form-control"/>
                                                </td>
                                                <td >
                                                    <input required style="text-align: center;background-color: #fff !important" tabindex="-1" readonly   required  type="text" name="invoiceDetails[0].totalAmountAfterTax" id="totalAmountAfterTax0" class="form-control"/>
                                                </td>


                                                <td ><a class="deleteRow"></a>

                                                </td>
                                            </tr>
                                        </tbody>
                                        <tfoot>
                                            <tr>
                                                <td colspan="14" style="text-align: left;">
                                                    <input type="button" class="btn btn-lg btn-block " id="addrow" value="Add Row" />
                                                </td>
                                            </tr>
                                            <tr>

                                                <td style="text-align: right" colspan="5">
                                                    <label class="col-xs-12 control-label">TOTAL </label>
                                                </td>
                                                <td class="">
                                                    <input  style="text-align: center;background-color: #fff !important" tabindex="-1" readonly   type="text" name="" id="TotalTatalAmount"  value="0" class="form-control"/>
                                                </td>
                                                <td class="">

                                                </td>
                                                <td class="">
                                                    <input style="text-align: center;background-color: #fff !important" tabindex="-1" readonly   type="text" name="" id="TotalTatalCGST" value="0" class="form-control"/>
                                                </td>
                                                <td class="">

                                                </td>
                                                <td class="">
                                                    <input  style="text-align: center;background-color: #fff !important" tabindex="-1" readonly   type="text" name=""  id="TotalTatalSGST" value="0" class="form-control"/>
                                                </td>
                                                <td class="">

                                                </td>
                                                <td class="">
                                                    <input style="text-align: center;background-color: #fff !important" tabindex="-1" readonly   type="text" name=""  id="TotalTatalIGST" value="0" class="form-control"/>
                                                </td>
                                                <td class="">
                                                    <input style="text-align: center;background-color: #fff !important" tabindex="-1" readonly   type="text" name="" id="TotalTotalAmountAfterTax" value="0" class="form-control"/>
                                                </td>


                                                <td class=""><a class="deleteRow"></a>

                                                </td>
                                            </tr>
                                        </tfoot>
                                    </table>
                                </div>


                            </div>

                            <div class="row">
                                <div class="col-sm-12 ">
                                    <div class="row">
                                        <div class="col-md-5 well">
                                            <div class="form-group row">
                                                <label for="lgFormGroupInput" class="col-sm-12 col-form-label col-form-label-lg text-center">Total Invoice amount in words</label>

                                            </div>

                                            <div class="form-group row">
                                                <div class="col-sm-12">
                                                    <input type="text" class="form-control" style="text-align: center;background-color: #fff !important" tabindex="-1" readonly  name="totalAmountInWords" id="amountInwords"/>
                                                </div>


                                            </div>

                                        </div>
                                        <div class="col-md-7 well">
                                            <div class="form-group row">
                                                <label for="lgFormGroupInput" class="col-sm-4 col-form-label col-form-label-lg">Total Amount Before Tax</label>
                                                <input type="hidden" id="companyId"/>
                                                <div class="col-sm-8">
                                                    <input type="text" class="form-control" style="text-align: right;background-color: #fff !important" tabindex="-1" readonly name="totalAmountBeforeTax" id="totalAmountFinal">
                                                </div>
                                            </div>

                                            <div class="form-group row">
                                                <label class="control-label col-xs-1 " for="inputSuccess">CGST%</label>
                                                <div class="col-xs-2 ">
                                                    <input type="text" class="form-control" style="text-align: center;background-color: #fff !important" tabindex="-1"  onblur="calculateAllAmount()" name="cgstPerc" id="cgstPercFinal" VALUE="0">
                                                </div>
                                                <label class="control-label col-xs-1" for="inputWarning">Amount</label>
                                                <div class="col-xs-8">
                                                    <input type="text" class="form-control" style="text-align: right;background-color: #fff !important" tabindex="-1" readonly name="cgstAmount" id="cgstAmountFinal">
                                                </div>
                                            </div>

                                            <div class="form-group row">
                                                <label class="control-label col-xs-1 " for="inputSuccess">SGST%</label>
                                                <div class="col-xs-2 ">
                                                    <input type="text" class="form-control"  style="text-align: center;background-color: #fff !important" tabindex="-1"  onblur="calculateAllAmount()" name="sgstPerc" id="sgstPercFinal" VALUE="0">
                                                </div>
                                                <label class="control-label col-xs-1" for="inputWarning">Amount</label>
                                                <div class="col-xs-8">
                                                    <input type="text" class="form-control" style="text-align: right;background-color: #fff !important" tabindex="-1" readonly name="sgstAmount" id="sgstAmountFinal">
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="control-label col-xs-1 " for="inputSuccess">IGST%</label>
                                                <div class="col-xs-2 ">
                                                    <input type="text" class="form-control" style="text-align: center;background-color: #fff !important" tabindex="-1" onblur="calculateAllAmount()"  name="igstPerc" id="igstPercFinal" VALUE="0">
                                                </div>
                                                <label class="control-label col-xs-1" for="inputWarning">Amount</label>
                                                <div class="col-xs-8">
                                                    <input type="text" class="form-control" style="text-align: right;background-color: #fff !important" tabindex="-1" readonly name="igstAmount" id="igstAmountFinal">
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label for="lgFormGroupInput" class="col-sm-4 col-form-label col-form-label-lg">Total Amount on GST</label>
                                                <input type="hidden" id="companyId"/>
                                                <div class="col-sm-8">
                                                    <input type="text" class="form-control"  style="text-align: right;background-color: #fff !important" tabindex="-1" readonly name="totalAmountGST" id="totalAmountGST">
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label for="lgFormGroupInput" class="col-sm-4 col-form-label col-form-label-lg">Total Amount After Tax</label>
                                                <input type="hidden" id="companyId"/>
                                                <div class="col-sm-8">
                                                    <input type="text" class="form-control" style="text-align: right;background-color: #fff !important" tabindex="-1" readonly  name="totalAmountATax" id="totalAmountAfterTaxFinal">
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label for="lgFormGroupInput" class="col-sm-4 col-form-label col-form-label-lg">Round off</label>
                                                <input type="hidden" id="companyId"/>
                                                <div class="col-sm-8">
                                                    <input type="text" class="form-control" style="text-align: right;background-color: #fff !important" tabindex="-1" readonly name="roundOff" id="roubndOffAmountFinal">
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label for="lgFormGroupInput" class="col-sm-4 col-form-label col-form-label-lg">Total Amount</label>
                                                <input type="hidden" id="companyId"/>
                                                <div class="col-sm-8">
                                                    <input type="text" class="form-control" style="text-align: right;background-color: #fff !important" tabindex="-1" readonly readonly  name="totalAmount" id="FinalAmount">
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label for="lgFormGroupInput" class="col-sm-4 col-form-label col-form-label-lg">Gst On Reverse Charge</label>
                                                <input type="hidden" id="companyId"/>
                                                <div class="col-sm-8">
                                                    <input type="text" value="0.00"  class="form-control" style="text-align: right;background-color: #fff !important" name="gstOnReverseCharge" id="gstOnReverseCharge">
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>

                            </div>




                            <div class="form-group">
                                <div class="col-xs-12 col-xs-offset-4">

                                    <input type="button"  class="btn btn-primary col-xs-2" onclick="viewBill()"  value="VIEW" />
                                    <input type="submit" class="btn btn-default col-xs-2"  value="SAVE" />


                                </div>

                                <!--                            <input type="button" class="btn btn-lg btn-block btn-primary" onclick="viewBill()"  value="VIEW" />
                                                            <input type="submit" class="btn btn-lg btn-block btn-primary"  value="SAVE" />-->

                        </form> </div>
                </div>


            </div>
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




        </div>
        <!-- /.container-fluid -->

    </div>
    <!-- /#page-wrapper -->

</div>
<!-- /#wrapper -->

</body>
</html>
