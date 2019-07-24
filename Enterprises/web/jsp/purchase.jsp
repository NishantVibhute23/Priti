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
        <script type="text/javascript" src="js/purchase.js"></script>
        <!--<script type="text/javascript" src="js/bootstrap-datepicker.min.js"></script>-->
        <script type="text/javascript" src="js/jquery-ui-1.12.1.js"></script>

        <link href="css/jquery-ui.css" rel="stylesheet">
        <title>JSP Page</title>

        <script>

            $(document).ready(function() {


                $("#dashboard").removeClass("active");

                $("#Invoice").removeClass("active");
//$("#invoiceId").show()
                $("#InvoiceNew").removeClass("highlight");
                $("#InvoiceDetails").removeClass("highlight");
                $("#InvoicePayment").addClass("highlight");

                $("#purchaseId").show()
                $("#Purchase").addClass("active");
                $("#PurchaseNew").addClass("highlight");
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

            });
            
            $(function() {
                $("#datepicker1").datepicker({changeMonth: true,
                    changeYear: true,
                    showAnim: "slideDown",
                    dateFormat: "dd/mm/yy"
                });

            });
            function getCompanyInfo()
            {
                var id = $("#compSelect").val();
                $.ajax({
                    url: 'getCompanyDetails?id=' + id,
                    type: "POST",
                    dataType: 'json'
                }).success(function(response) {


                    $("#companyId").val(response.companyId);
                    $("#companyAddress").val(response.companyAddress);
                    $("#companyGSTIN").val(response.companyGSTIN);
                    $("#compState").val(response.companyState);
                    $("#compCode").val(response.companyStateCode);
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
                if (($("#cgstCheckBox").is(':checked') && $("#sgstCheckBox").is(':checked')) || $("#igstCheckBox").is(':checked'))
                {
                    var id = $("#productSelect" + val + " option:selected").val()

                    $.ajax({
                        url: 'getHSNUOM?prodId=' + id,
                        type: "POST",
                        dataType: 'json'
                    }).success(function(response) {

                        $("#hsn" + val).val(response.mainProductHSN);
                        $("#uom" + val).val(response.mainProductUOM);

                    });
                    $("#productId" + val).val($("#productSelect" + val + " option:selected").text());
                } else {
                    alert("Please Select GST Type");
                    $("#productSelect" + val).val(0);
                }
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
            <div class="container-fluid">
                <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12">
                        <h3 class="page-header">
                            Purchase New
                        </h3>

                    </div>
                </div>
                <!-- /.row -->

                <div class="row">
                    <div class="col-lg-12">
                        <form role="form" action="savePurchase" method="post" >


                            <div class="panel panel-default">
                                <div class="panel-heading text-center"><b>Tax Invoice</b></div>
                                <div class="panel-body"><form  id="invoiceForm" action="saveInvoice">

                                        <div class="row">
                                            <div class="col-sm-12">
                                                <div class="row">
                                                    <div class="col-md-6 well">

                                                        <div class="form-group row">
                                                            <label class="col-xs-3 ">Company Name</label>
                                                            <div class="col-xs-9 ">
                                                                <select id="compSelect" required name="companyId" class="form-control"  onchange="getCompanyInfo()">
                                                                    <option value="">Select</option>
                                                                    <s:iterator value="companyList">
                                                                        <option value="<s:property value = 'companyId'/>"><s:property value = 'companyName'/></option>
                                                                    </s:iterator>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <input type="hidden" id="companyId"/>

                                                            <label class="col-xs-3 control-label">Address</label>
                                                            <div style="height:80px" class="col-xs-9">
                                                                <textarea  required style="height:80px" id="companyAddress" resize="none" name="billToAddress" class="form-control"> </textarea>

                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <label class="control-label col-xs-3" for="inputWarning">GSTIN</label>
                                                            <div class="col-xs-9">
                                                                <input required type="text" class="form-control" id="companyGSTIN">
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <label class="col-xs-3 ">State</label>
                                                            <div class="col-xs-5">
                                                                <input required type="text" class="form-control" id="compState" name=""  readonly/>
                                                            </div>

                                                            <label class="col-xs-2 control-label">Code</label>
                                                            <div class="col-xs-2">
                                                                <input required type="text" class="form-control" id="compCode" name="" />
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="col-md-6 well">
                                                        <div class="form-group row">
                                                            <label class="col-xs-4 control-label">Invoice No.</label>
                                                            <div class="col-xs-8">
                                                                <input type="hidden" id="count" value="1"/>
                                                                <input required type="text" class="form-control" name="invoiceNo" />
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <label class="col-xs-4 ">Date</label>
                                                            <div class="col-xs-8">
                                                                <input type="text" required class="form-control" id="datepicker" name="date"  />
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <label for="lgFormGroupInput" class="col-sm-4 col-form-label col-form-label-lg">Transport Mode</label>
                                                            <div class="col-sm-8">
                                                                <input type="text" class="form-control" name="transportMode" />
                                                            </div>
                                                        </div>

                                                        <div class="form-group row">
                                                            <label for="lgFormGroupInput" class="col-sm-4 col-form-label col-form-label-lg">Vehicle No.</label>
                                                            <div class="col-sm-8">
                                                                <input type="text" class="form-control" name="vehicleNo" />
                                                            </div>
                                                        </div>

                                                        <div class="form-group row">
                                                            <label for="lgFormGroupInput" class="col-sm-4 col-form-label col-form-label-lg">Date Of Supply</label>
                                                            <div class="col-sm-8">
                                                                <input type="text" class="form-control" id="datepicker1" style="background-color: #fff !important" readonly name="dateOfSupply" />
                                                            </div>
                                                        </div>

                                                        <div class="form-group row">
                                                            <label for="lgFormGroupInput" class="col-sm-4 col-form-label col-form-label-lg">Place Of Supply</label>
                                                            <div class="col-sm-8">
                                                                <input type="text" class="form-control" name="placeOfSupply" />
                                                            </div>
                                                        </div>



                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12 well">
                                                        <div class="form-group row">
                                                            <table id="myTable" class="myt table order-list" style="border:1px solid #ddd" >
                                                                <div class="checkbox">
                                                                    <label><input type="checkbox" id="cgstCheckBox" onchange="setValue('cgst')"/>CGST</label>
                                                                </div>
                                                                <div class="checkbox">
                                                                    <label><input type="checkbox" id="sgstCheckBox" onchange="setValue('sgst')"/>SGST</label>
                                                                </div>
                                                                <div class="checkbox disabled">
                                                                    <label><input type="checkbox" id="igstCheckBox" onchange="setValue('igst')"/>IGST</label>
                                                                </div>
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
                                                                        <th  style="text-align: center;border:1px solid #ddd"width="7%">AMOUNT</th>
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
                                                                            <select required id="productSelect0" name="invoiceDetails[0].productId" class="form-control" onchange="setProduct(0)">
                                                                                <option value="">Select</option>
                                                                                <s:iterator value="subProductList">
                                                                                    <option value="<s:property value = 'subProductId'/>"><s:property value = 'subProductName'/></option>
                                                                                </s:iterator>
                                                                            </select>
                                                                        </td>
                                                                        <td >
                                                                            <input style="text-align: center;background-color: #fff !important" tabindex="-1" readonly required type="text" name="invoiceDetails[0].hsn" id="hsn0"   class="form-control"/>
                                                                        </td>
                                                                        <td >
                                                                            <input style="text-align: center;background-color: #fff !important" tabindex="-1" readonly required   type="text" name="invoiceDetails[0].uom" id="uom0"    class="form-control"/>
                                                                        </td>
                                                                        <td >
                                                                            <input style="text-align: center"  type="text" name="invoiceDetails[0].qty" id="qty0" required class="form-control"/>
                                                                        </td>

                                                                        <td >
                                                                            <input style="text-align: center"  type="text" name="invoiceDetails[0].price" id="price0" required onblur="calculateRowGSTTotal('0')"  class="form-control"/>
                                                                        </td>

                                                                        <td >
                                                                            <input style="text-align: center;background-color: #fff !important"tabindex="-1"   readonly required   type="text" name="invoiceDetails[0].amount" id="amount0"  class="form-control"/>
                                                                        </td>
                                                                        <td >
                                                                            <input style="text-align: center;background-color: #fff !important" tabindex="-1"  required   type="text" name="invoiceDetails[0].cgstPerc" id="cgstPerc0" onblur="calculateRowGSTTotal('0')" value="0" class="form-control"/>
                                                                        </td>
                                                                        <td >
                                                                            <input style="text-align: center;background-color: #fff !important" tabindex="-1" readonly required   type="text" name="invoiceDetails[0].cgstAmount" id="cgstAmt0" class="form-control"/>
                                                                        </td>
                                                                        <td >
                                                                            <input style="text-align: center;background-color: #fff !important" tabindex="-1"  required   type="text" name="invoiceDetails[0].sgstPerc" id="sgstPerc0" onblur="calculateRowGSTTotal('0')"  value="0" class="form-control"/>
                                                                        </td>
                                                                        <td >
                                                                            <input style="text-align: center;background-color: #fff !important" tabindex="-1" readonly required   type="text" name="invoiceDetails[0].sgstAmount"  id="sgstAmt0" class="form-control"/>
                                                                        </td>
                                                                        <td >
                                                                            <input style="text-align: center;background-color: #fff !important" tabindex="-1"  required   type="text" name="invoiceDetails[0].igstPerc" id="igstPerc0" onblur="calculateRowGSTTotal('0')" value="0" class="form-control"/>
                                                                        </td>
                                                                        <td >
                                                                            <input style="text-align: center;background-color: #fff !important" tabindex="-1" readonly required   type="text" name="invoiceDetails[0].igstAmount"  id="igstAmt0" class="form-control"/>
                                                                        </td>
                                                                        <td >
                                                                            <input style="text-align: center;background-color: #fff !important" tabindex="-1" readonly required   type="text" name="invoiceDetails[0].totalAmountAfterTax" id="totalAmountAfterTax0" class="form-control"/>
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
                                                                            <input  style="text-align: center;background-color: #fff !important" tabindex="-1" readonly    type="text" name="" id="TotalTatalAmount"  value="0" class="form-control"/>
                                                                        </td>
                                                                        <td class="">

                                                                        </td>
                                                                        <td class="">
                                                                            <input  style="text-align: center;background-color: #fff !important" tabindex="-1" readonly    type="text" name="" id="TotalTatalCGST" value="0" class="form-control"/>
                                                                        </td>
                                                                        <td class="">

                                                                        </td>
                                                                        <td class="">
                                                                            <input   style="text-align: center;background-color: #fff !important" tabindex="-1" readonly    type="text" name=""  id="TotalTatalSGST" value="0" class="form-control"/>
                                                                        </td>
                                                                        <td class="">

                                                                        </td>
                                                                        <td class="">
                                                                            <input  style="text-align: center;background-color: #fff !important" tabindex="-1" readonly    type="text" name=""  id="TotalTatalIGST" value="0" class="form-control"/>
                                                                        </td>
                                                                        <td class="">
                                                                            <input  style="text-align: center;background-color: #fff !important" tabindex="-1" readonly    type="text" name="" id="TotalTotalAmountAfterTax" value="0" class="form-control"/>
                                                                        </td>


                                                                        <td class=""><a class="deleteRow"></a>

                                                                        </td>
                                                                    </tr>
                                                                </tfoot>
                                                            </table>

                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-6 well">
                                                        <div class="form-group row">
                                                            <label class="control-label col-xs-12 text-center" for="inputSuccess">Total Invoice amount in words</label>
                                                        </div>
                                                        <div class="form-group row">
                                                            <input type="text" class="form-control" style="text-align: center;background-color: #fff !important" tabindex="-1" readonly  name="totalAmountInWords" id="amountInwords"/>
                                                        </div>

                                                    </div>
                                                    <div class="col-md-6 well">
                                                        <div class="form-group row">
                                                            <input type="hidden" id="companyId"/>
                                                            <label class="control-label col-xs-6 " for="inputSuccess">Total Amount Before Tax</label>
                                                            <div class="col-xs-6 ">
                                                                <input type="text" class="form-control" style="text-align: right;background-color: #fff !important"tabindex="-1"  readonly  name="totalAmountBeforeTax" id="totalAmountFinal">
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <label class="control-label col-xs-2 " for="inputSuccess">CGST %</label>
                                                            <div class="col-xs-2 ">
                                                                <input type="text" class="form-control" style="text-align: center;background-color: #fff !important" tabindex="-1" onblur="calculateAllAmount()"  name="cgstPerc" id="cgstPercFinal" VALUE="0">
                                                            </div>
                                                            <label class="control-label col-xs-2" for="inputWarning">Amount</label>
                                                            <div class="col-xs-6">
                                                                <input type="text" class="form-control" style="text-align: right;background-color: #fff !important" tabindex="-1" readonly name="cgstAmount" id="cgstAmountFinal">
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <label class="control-label col-xs-2 " for="inputSuccess">SGST %</label>
                                                            <div class="col-xs-2 ">
                                                                <input type="text" class="form-control" style="text-align: center;background-color: #fff !important" tabindex="-1" onblur="calculateAllAmount()"  name="sgstPerc" id="sgstPercFinal" VALUE="0">
                                                            </div>
                                                            <label class="control-label col-xs-2" for="inputWarning">Amount</label>
                                                            <div class="col-xs-6">
                                                                <input type="text" class="form-control" style="text-align: right;background-color: #fff !important" tabindex="-1" readonly name="sgstAmount" id="sgstAmountFinal">
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <label class="control-label col-xs-2 " for="inputSuccess">IGST %</label>
                                                            <div class="col-xs-2 ">
                                                                <input type="text" class="form-control"  style="text-align: center;background-color: #fff !important" tabindex="-1" onblur="calculateAllAmount()" name="igstPerc" id="igstPercFinal" VALUE="0">
                                                            </div>
                                                            <label class="control-label col-xs-2" for="inputWarning">Amount</label>
                                                            <div class="col-xs-6">
                                                                <input type="text" class="form-control" style="text-align: right;background-color: #fff !important" tabindex="-1" readonly name="igstAmount" id="igstAmountFinal">
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <input type="hidden" id="companyId"/>
                                                            <label class="control-label col-xs-6 " for="inputSuccess">Total Amount on GST</label>
                                                            <div class="col-xs-6 ">
                                                                <input type="text" class="form-control" style="text-align: right;background-color: #fff !important" tabindex="-1" readonly name="totalAmountGST" id="totalAmountGST">
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <input type="hidden" id="companyId"/>
                                                            <label class="control-label col-xs-6 " for="inputSuccess">Total Amount After Tax</label>
                                                            <div class="col-xs-6 ">
                                                                <input type="text" class="form-control" style="text-align: right;background-color: #fff !important" tabindex="-1" readonly name="totalAmountATax" id="totalAmountAfterTaxFinal">
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <input type="hidden" id="companyId"/>
                                                            <label class="control-label col-xs-6 " for="inputSuccess">Round off</label>
                                                            <div class="col-xs-6 ">
                                                                <input type="text" class="form-control" style="text-align: right;background-color: #fff !important" tabindex="-1" readonly name="roundOff" id="roubndOffAmountFinal">
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <input type="hidden" id="companyId"/>
                                                            <label class="control-label col-xs-6 " for="inputSuccess">Total Amount</label>
                                                            <div class="col-xs-6 ">
                                                                <input type="text" class="form-control" style="text-align: right;background-color: #fff !important" tabindex="-1" readonly name="totalAmount" id="FinalAmount">
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <input type="hidden" id="companyId"/>
                                                            <label class="control-label col-xs-6 " for="inputSuccess">Gst On Reverse Charge</label>
                                                            <div class="col-xs-6 ">
                                                                <input type="text" value="0.00" class="form-control" style="text-align: right;background-color: #fff !important" name="gstOnReverseCharge" id="gstOnReverseCharge">
                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="col-xs-12 col-xs-offset-5">

                                                        <!--<input type="button"  class="btn btn-primary col-xs-2" onclick="viewBill()"  value="VIEW" />-->
                                                        <input type="submit" class="btn btn-primary col-xs-2"  value="SAVE" />


                                                    </div>

                                                </div>
                                           

                                        </div>
                                </div>
                            </div>








                        </form>
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
