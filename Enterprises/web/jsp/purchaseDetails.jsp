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
        <script type="text/javascript" src="js/purchase.js"></script>
        <script type="text/javascript" src="https://cdn.datatables.net/r/bs-3.3.5/jqc-1.11.3,dt-1.10.8/datatables.min.js"></script>
         <link href="css/datatable.css" rel="stylesheet">
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
                $("#PurchaseNew").removeClass("highlight");
                $("#PurchaseDetails").addClass("highlight");

                $("#Products").removeClass("active");
                $("#AddressBook").removeClass("active");
                $("#RawMaterial").removeClass("active");
$("#Ledger").removeClass("active");
$("#Bills").removeClass("active");
                $('#invoiceTable').DataTable({
                                                                    'paging': true,
                                                        'lengthChange': true,
                                                        'searching': true,
                                                        'ordering': true,
                                                        'info': true,
                                                        'autoWidth': false,
                                                        'aaSorting': []});

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
            
            function createExcel(idIn)
            {

                var id = idIn;


                $.ajax({
                    url: 'createExcel?val=' + id,
                    type: "POST",
                    dataType: 'json'
                }).success(function(response) {
                });

            }

            function getCompanyInfoBillTo()
            {
                var id = $("#billToCompSelect").val();
                $("#hiddenBillToName").val($("#billToCompSelect option:selected").text());
                $.ajax({
                    url: 'getCompanyDetails?id=' + id,
                    type: "POST",
                    dataType: 'json'
                }).success(function(response) {
                    $("#companyId").val(response.companyId);
                    $("#billToAddress").val(response.companyAddress);
                    $("#billToGSTIN").val(response.companyGSTIN);
                    $("#billToState").val(response.companyState);
                    $("#billToCode").val(response.companyStateCode);
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
                    $("#compState").val(response.companyState);
                    $("#compCode").val(response.companyStateCode);
                });
            }

            function getPurchaseDetails(idIn)
            {

                var id = idIn;


                $.ajax({
                    url: 'getPurchaseDetailsInfo?val=' + id,
                    type: "POST",
                    dataType: 'json'
                }).success(function(response) {

                    $('.nav-tabs a[href="#2b"]').tab('show');
                    
                    $("#paystatus").val(response.status);
                    
                    if(response.status === 'Not Paid')
                    {
                        $("#payDiv").hide();
                        
                    }
                    
                    $("#paydate").val(response.paymentDate);
                    $("#paydesc").val(response.description);
                    
                    $("#invoiceNo").val(response.invoiceNo);

                    $("#purchaseId1").val(response.id);
                    $("#datepicker").val(response.date);



                    $("#compSelect").val(response.billTO);

                    $("#companyAddress").val(response.billToAddress);

                    $("#companyGSTIN").val(response.billToGSTIN);

                    $("#compState").val(response.billToState);
                    $("#compCode").val(response.billToCode);




                    $("#TotalTatalAmount").val(response.totalAmountBeforeTax);
                    $("#TotalTatalCGST").val(response.cgstAmount);
                    $("#TotalTatalSGST").val(response.sgstAmount);
                    $("#TotalTatalIGST").val(response.igstAmount);
                    $("#TotalTotalAmountAfterTax").val(response.totalAmountATax);
                    $("#totalAmountFinal").val(response.totalAmountBeforeTax);
                    $("#cgstPercFinal").val(response.cgstPerc);
                    $("#cgstAmountFinal").val(response.cgstAmount);
                    $("#sgstPercFinal").val(response.sgstPerc);
                    $("#sgstAmountFinal").val(response.sgstAmount);
                    $("#igstPercFinal").val(response.igstPerc);
                    $("#igstAmountFinal").val(response.igstAmount);
                    $("#totalAmountGST").val(response.totalAmountGST);
                    $("#totalAmountAfterTaxFinal").val(response.totalAmountATax);
                    $("#roubndOffAmountFinal").val(response.roundOff);

                    $("#FinalAmount").val(response.totalAmount);
                    $("#gstOnReverseCharge").val(response.gstOnReverseCharge);
                    $("#amountInwords").val(response.totalAmountInWords);



                    if (response.cgstPerc === 0)
                    {
                        $('#cgstCheckBox').prop('checked', false);
                    }
                    else {
                        $('#cgstCheckBox').prop('checked', true);
                    }

                    if (response.sgstPerc === 0)
                    {
                        $('#sgstCheckBox').prop('checked', false);
                    }
                    else {
                        $('#sgstCheckBox').prop('checked', true);
                    }

                    if (response.igstPerc === 0)
                    {
                        $('#igstCheckBox').prop('checked', false);
                    }
                    else {
                        $('#igstCheckBox').prop('checked', true);
                    }





                    var counter = 0;
                    $.each(response.invoiceDetails, function(i, val) {
                        var $options = $("#productSelect > option").clone();

//                        alert(" - " + val.subProductId);
                        var newRow = $("<tr>");
                        var cols = "";


                        cols += '<td ><input type="hidden" id="id' + counter + '" value="' + val.id + '" name="invoiceDetails[' + counter + '].id"/><input type="hidden" id="oldProductId' + counter + '"  value="' + val.productId + '" name="invoiceDetails[' + counter + '].oldProductId"/><input type="hidden" id="productId' + counter + '"  value="' + val.productName + '" name="invoiceDetails[' + counter + '].productName"/><select  id="productSelect' + counter + '" name="invoiceDetails[' + counter + '].productId" class="form-control" onchange="setProduct(' + counter + ')"></select></td>';
                        cols += '<td><input type="text" style="text-align: center;background-color: #fff !important" tabindex="-1" readonly class="form-control" value="' + val.hsn + '" name="invoiceDetails[' + counter + '].hsn" id="hsn' + counter + '"/></td>';
                        cols += '<td> <input type="text" style="text-align: center;background-color: #fff !important" tabindex="-1" readonly class="form-control" value="' + val.uom + '" name="invoiceDetails[' + counter + '].uom" id="uom' + counter + '"/></td>';
                        cols += '<td>\n\
\n\
<input type="hidden" style="text-align: center;" class="form-control" value="' + val.qty + '" name="invoiceDetails[' + counter + '].oldQty" id="oldQty' + counter + '"/><input type="text" style="text-align: center;" class="form-control" value="' + val.qty + '" name="invoiceDetails[' + counter + '].qty" id="qty' + counter + '"/></td>';

                        cols += '<td><input type="text" style="text-align: center;" class="form-control" value="' + val.price + '" name="invoiceDetails[' + counter + '].price" id="price' + counter + '" onblur="calculateRowGSTTotal(' + counter + ')"/></td>';
                        cols += '<td><input type="text" style="text-align: center;background-color: #fff !important" tabindex="-1" readonly class="form-control" value="' + val.amount + '" name="invoiceDetails[' + counter + '].amount" id="amount' + counter + '" /></td>';
                        cols += '<td><input type="text" style="text-align: center;background-color: #fff !important" tabindex="-1"  class="form-control" value="' + val.cgstPerc + '" name="invoiceDetails[' + counter + '].cgstPerc" id="cgstPerc' + counter + '" onblur="calculateRowGSTTotal(' + counter + ')" /></td>';
                        cols += '<td><input type="text"  style="text-align: center;background-color: #fff !important" tabindex="-1" readonly class="form-control" value="' + val.cgstAmount + '" name="invoiceDetails[' + counter + '].cgstAmount" id="cgstAmt' + counter + '"/></td>';
                        cols += '<td><input type="text" style="text-align: center;background-color: #fff !important" tabindex="-1"  class="form-control" value="' + val.sgstPerc + '" name="invoiceDetails[' + counter + '].sgstPerc" id="sgstPerc' + counter + '" onblur="calculateRowGSTTotal(' + counter + ')"  /></td>';
                        cols += '<td><input type="text" style="text-align: center;background-color: #fff !important" tabindex="-1" readonly class="form-control" value="' + val.sgstAmount + '" name="invoiceDetails[' + counter + '].sgstAmount"  id="sgstAmt' + counter + '" /></td>';
                        cols += '<td><input type="text" style="text-align: center;background-color: #fff !important" tabindex="-1"  class="form-control" value="' + val.igstPerc + '" name="invoiceDetails[' + counter + '].igstPerc" id="igstPerc' + counter + '" onblur="calculateRowGSTTotal(' + counter + ')" /></td>';
                        cols += '<td><input type="text" style="text-align: center;background-color: #fff !important" tabindex="-1" readonly class="form-control" value="' + val.igstAmount + '" name="invoiceDetails[' + counter + '].igstAmount" id="igstAmt' + counter + '" /></td>';
                        cols += '<td><input type="text" style="text-align: center;background-color: #fff !important" tabindex="-1" readonly class="form-control" value="' + val.totalAmountAfterTax + '" name="invoiceDetails[' + counter + '].totalAmountAfterTax" id="totalAmountAfterTax' + counter + '"/></td>';
                        cols += '<td><input type="button" class="ibtnDel btn btn-md btn-danger "  value="X"></td>';
                        newRow.append(cols);



                        $("#myTable").append(newRow);

                        $('#productSelect' + counter + '').append($options);
                        $('#productSelect' + counter + '').val(val.productId);
                        counter++;
                        $('#count').val(counter);

                    });

                });
            }
            
            function viewBillPdfPurchase(id_in)
            {
                $('#invoiceModal').modal('show');
               
               
                $.ajax({
                    url: 'printPurchasePDF?val='+id_in,
                    type: "POST",
                    
                }).success(function(response) {
                    $("#spinner").hide();
//                    alert(response);
                    $('#invoiceModal').find('.modal-body').text("");
                    $('#invoiceModal').find('.modal-body').append("<iframe width='100%' height='700px' id='iFramePdf' src='" + response + "/getPurchasePdfFile'  ></iframe>");
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
            }

            function viewBill()
            {

                var formData = $("#invoiceForm").serialize();
                var id = $("#shipToCompSelect").val();
                $.ajax({
                    url: 'printInvoice',
                    type: "POST",
                    data: formData,
                }).success(function(response) {

//                    alert(response);
                    $('#invoiceModal').find('.modal-body').text("");
                    $('#invoiceModal').find('.modal-body').append("<iframe width='100%' height='700px' id='iFramePdf' src='pdf.pdf'  ></iframe>");
                    $('#invoiceModal').modal('show');
                });
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




    <body style="padding-right: 0px !important">
        <div id="page-wrapper">

            <div class="container-fluid">
                <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12">
                        <h3 class="page-header">
                            Purchase Details
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

                <div class="panel with-nav-tabs panel-info">
                    <div class="panel-heading">
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="#1b" style="padding: 10px 100px !important" data-toggle="tab">List</a></li>
                            <li><a href="#2b" style="padding: 10px 100px !important" data-toggle="tab">View</a></li>


                        </ul>
                    </div>
                    <div class="panel-body">
                        <div class="tab-content">
                            <div class="tab-pane fade in active" id="1b">


                                <div class="row" style="height: 600px">

                                    <table id="invoiceTable" class="table table-bordered table-striped">
                                        <thead>
                                            <tr height="30px">
                                                <th style="text-align: center">Invoice Id</th>
                                                <th style="text-align: center">Invoice Date</th>
                                                <th style="text-align: center">Company name</th>
                                                <th style="text-align: center">Bill Amount</th>
                                                <th style="text-align: center">Status</th>
                                                <th style="text-align: center">Edit</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <s:iterator value="purchaseList">

                                                <tr>

                                                    <td  style="text-align: center"><s:property value = 'invoiceId'/></td>
                                                    <td style="text-align: center"><s:property value = 'date'/></td>
                                                    <td style="text-align: center"><s:property value = 'companyName'/></td>
                                                    <td style="text-align: center"><s:property value = 'amount'/></td>
                                                    <td  style="text-align: center">
                                                                <s:if test = 'isPaymentDone==1'>Paid
                                                                  
                                                            </s:if>
                                                                <s:else>
                                                                    Not Paid
                                                                </s:else>
                                                            </td>
                                                    <td style="text-align: center">
                                                        <a href="createExcelForPurchase?val=<s:property value = 'id'/>" ><input type="button" value="Excel"  class="btn btn-default editButton"></a>
                                                    <s:if test="isPaymentDone== 0">
                                                                    <input type="button" value="Edit" onclick="getPurchaseDetails('<s:property value = 'id'/>')" class="btn btn-default editButton">
                                                                   
                                                                </s:if>
                                                                        <s:else>
                                                                        <input type="button" value="View" onclick="viewBillPdfPurchase('<s:property value = 'id'/>')" class="btn btn-default editButton">
                                                                    </s:else>
                                                                         <s:if test="isLast== 1">
                                                                   
                                                                    <a href="deletePurchase?val=<s:property value = 'id'/>" ><input type="button" value="Delete"  class="btn btn-default editButton"></a>
                                                                </s:if>
                                                    
                                                    </td>

                                                </tr>

                                            </s:iterator>
                                        </tbody>
                                    </table>



                                </div>


                            </div>
                            <div class="tab-pane fade" id="2b">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <form  id="invoiceForm" action="updatePurchase" method="post">
                                            <div class="panel panel-default">
                                                <div class="panel-heading text-center"><b>Tax Invoice</b></div>
                                                <div class="panel-body">
                                                    <div class="row">
                                                        <div class="col-md-6 well">
                                                            <div class="form-group row">
                                                                <label class="col-xs-2 control-label">Status :</label>
                                                                <div class="col-xs-5">
                                                                    <!--<input type="text" class="form-control" id="datepicker"  style="background-color: #fff !important"  readonly name="date" />-->
                                                                    <input size="15" style="background-color: #fff !important" type="text" id="paystatus" readonly class="form-control" >
                                                                </div>
                                                            </div>
                                                            <div id="payDiv">
                                                                <div class="form-group row">
                                                                    <label class="col-xs-2 control-label">Payment Date : </label>
                                                                    <div class="col-xs-5">
                                                                        <!--<input type="text" class="form-control" id="datepicker"  style="background-color: #fff !important"  readonly name="date" />-->
                                                                        <input type="text" id="paydate" style="background-color: #fff !important" readonly class="form-control"  />

                                                                    </div>
                                                                    <div class="form-group row">
                                                                        <label class="col-xs-2 control-label">Payment By : </label>
                                                                        <div class="col-xs-10">
                                                                            <!--<input type="text" class="form-control" id="datepicker"  style="background-color: #fff !important"  readonly name="date" />-->
                                                                            <input type="text"  style="background-color: #fff !important" id="paydesc" readonly class="form-control"  />
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-6 well">

                                                            <div class="form-group row">
                                                                <label class="col-xs-3 ">Company Name</label>
                                                                <div class="col-xs-9 ">
                                                                    <select id="compSelect" name="companyId" class="form-control"  onchange="getCompanyInfo()">
                                                                        <option value="0">Select</option>
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
                                                                    <textarea style="height:80px" id="companyAddress" resize="none" name="billToAddress" class="form-control"> </textarea>

                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label class="control-label col-xs-3" for="inputWarning">GSTIN</label>
                                                                <div class="col-xs-9">
                                                                    <input type="text" class="form-control" id="companyGSTIN">
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label class="col-xs-3 ">State</label>
                                                                <div class="col-xs-5">
                                                                    <input type="text" class="form-control" id="compState" name=""  readonly/>
                                                                </div>

                                                                <label class="col-xs-2 control-label">Code</label>
                                                                <div class="col-xs-2">
                                                                    <input type="text" class="form-control" id="compCode" name="" />
                                                                </div>
                                                            </div>

                                                        </div>
                                                        <div class="col-md-6 well">
                                                            <div class="form-group row">
                                                                <label class="col-xs-4 control-label">Invoice No.</label>
                                                                <div class="col-xs-8">
                                                                    <input type="hidden"  id="purchaseId1" name="id" />
                                                                    <input type="hidden" id="count"/>
                                                                    <input type="text" required class="form-control" id="invoiceNo" name="invoiceNo" />
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label class="col-xs-4 ">Date</label>
                                                                <div class="col-xs-8">
                                                                    <input type="text" required class="form-control" id="datepicker" name="date"  readonly/>
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

                                                                <table id="myTable" class=" table order-list table-bordered" style="">
                                                                    <input type="checkbox" id="cgstCheckBox" onchange="setValue('cgst')"/>CGST<br>
                                                                    <input type="checkbox" id="sgstCheckBox" onchange="setValue('sgst')"/>SGST<br>
                                                                    <input type="checkbox" id="igstCheckBox" onchange="setValue('igst')"/>IGST<br>
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

                                                                    <div style="visibility: hidden">

                                                                        <select id="productSelect" class="form-control" onchange="setProduct(0)">
                                                                            <option value="">Select</option>
                                                                            <s:iterator value="subProductList">
                                                                                <option value="<s:property value = 'subProductId'/>"><s:property value = 'subProductName'/></option>
                                                                            </s:iterator>
                                                                        </select>

                                                                    </div>


                                                                    </thead>
                                                                    <tbody>

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
                                                                            <td>
                                                                                <input type="text" style="text-align: center;background-color: #fff !important" tabindex="-1" readonly name="" id="TotalTatalAmount"  value="0" class="form-control"/>
                                                                            </td>
                                                                            <td>

                                                                            </td>
                                                                            <td>
                                                                                <input type="text" style="text-align: center;background-color: #fff !important" tabindex="-1" readonly name="" id="TotalTatalCGST" value="0" class="form-control"/>
                                                                            </td>
                                                                            <td>

                                                                            </td>
                                                                            <td>
                                                                                <input type="text" name="" style="text-align: center;background-color: #fff !important" tabindex="-1" readonly id="TotalTatalSGST" value="0" class="form-control"/>
                                                                            </td>
                                                                            <td>

                                                                            </td>
                                                                            <td>
                                                                                <input type="text" name="" style="text-align: center;background-color: #fff !important" tabindex="-1" readonly id="TotalTatalIGST" value="0" class="form-control"/>
                                                                            </td>
                                                                            <td>
                                                                                <input type="text" name="" style="text-align: center;background-color: #fff !important" tabindex="-1" readonly id="TotalTotalAmountAfterTax" value="0" class="form-control"/>
                                                                            </td>


                                                                            <td><a class="deleteRow"></a>

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


                                                            <input type="submit" class="btn btn-primary col-xs-2"  value="SAVE" />

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>




                                            
                                            

                                        </form>
                                    </div>
                                </div>


                            </div>

                        </div>
                    </div>
                </div>




                <!-- /#wrapper -->
                <div id="invoiceModal" class="modal fade" role="dialog">
                    <div class="modal-dialog modal-lg">

                        <!-- Modal content-->
                        <div class="modal-content">

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

                    $('.editButton').on('click', function() {

                        // Get the record's ID via attribute

                    });


                </script>



                </body>

                </html>
