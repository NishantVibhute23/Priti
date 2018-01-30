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
        <script type="text/javascript" src="js/rawmaterial.js"></script>
        <!--<script type="text/javascript" src="js/bootstrap-datepicker.min.js"></script>-->
        <script type="text/javascript" src="js/jquery-ui-1.12.1.js"></script>


        <script type="text/javascript" src="js/bootstrap.js"></script>

        <link href="css/jquery-ui.css" rel="stylesheet">
        <script type="text/javascript" src="https://cdn.datatables.net/r/bs-3.3.5/jqc-1.11.3,dt-1.10.8/datatables.min.js"></script>
        <title>JSP Page</title>

        <script>

            $(document).ready(function() {
//                $('#productTable').DataTable();


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
                $("#AddressBook").removeClass("active");
                $("#RawMaterial").addClass("active");


            });


            function getProduct()
            {

                var id = $("#productMain option:selected").val()

                $.ajax({
                    url: 'getUOMQTY?prodId=' + id,
                    type: "POST",
                    dataType: 'json'
                }).success(function(response) {

                    $("#mainQty").val(response.qty);
                    $("#mainUOM").val(response.mainProductUOM);

                    $("#UOMin").val(response.mainProductUOM);
                });



            }


            function setProductHSN(val)
            {



                var id = $("#productSelect" + val + " option:selected").val()

                $.ajax({
                    url: 'getHSNUOM?prodId=' + id,
                    type: "POST",
                    dataType: 'json'
                }).success(function(response) {


                    $("#uom" + val).val(response.mainProductUOM);

                });



                $("#productId" + val).val($("#productSelect" + val + " option:selected").text());
            }




        </script>

    </head>
    <body>
        <div id="page-wrapper">

            <div class="container-fluid">
                <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12">
                        <h3 class="page-header">
                            Raw Material
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
                <div class="row col-sm-7" style="height: 600px">
                    <form method="post" action="saveRawMaterial"> 
                        <div class="panel panel-default ">
                            <div class="panel-heading text-center"><b>Raw Material</b></div>
                            <div class="panel-body ">
                                <div class="row">
                                    <div class="col-sm-12">

                                        <div class="form-group row">
                                            <label for="lgFormGroupInput" class="col-sm-2 col-form-label col-form-label-lg">Product</label>
                                            <div class="col-sm-9">
                                                <select id="productMain" required name="productId" class="form-control" onchange="getProduct()">
                                                    <option value="">Select</option>
                                                    <s:iterator value="rawProductList">
                                                        <option value="<s:property value = 'subProductId'/>"><s:property value = 'subProductName'/></option>
                                                    </s:iterator>
                                                </select>

                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label for="lgFormGroupInput" class="col-sm-2 col-form-label col-form-label-lg">Available</label>

                                            <div class="col-xs-3 ">
                                                <input type="text" class="form-control" required readonly  id="mainQty" >
                                            </div>
                                            <div class="col-xs-3">
                                                <input type="text" class="form-control" required readonly id="mainUOM">
                                            </div>


                                        </div>
                                        <div class="form-group row">
                                            <label for="lgFormGroupInput" class="col-sm-2 col-form-label col-form-label-lg">Used</label>

                                            <div class="col-xs-3 ">
                                                <input type="text" class="form-control" required name="qty" >
                                            </div>
                                            <div class="col-xs-3">
                                                <input type="text" class="form-control" required readonly id="UOMin">
                                            </div>


                                        </div>
                                        <div class="form-group row">


                                            <div class="col-xs-12 ">
                                                <table class=" table order-list" width="100%"  >
                                                    <thead>
                                                        <tr>
                                                            <th class="col-sm-4">Product</th>
                                                            <th class="col-sm-1">QTY</th>
                                                            <th class="col-sm-1">UOM</th></tr>
                                                    </thead>
                                                    <tbody>

                                                        <tr>

                                                            <td class="col-sm-4">

                                                                <select id="productSelect0" required name="subProduct[0].subProductId" class="form-control" onchange="setProductHSN(0)">
                                                                    <option value="">Select</option>
                                                                    <s:iterator value="subProductList">
                                                                        <option value="<s:property value = 'subProductId'/>"><s:property value = 'subProductName'/></option>
                                                                    </s:iterator>
                                                                </select>
                                                            </td>
                                                            <td class="col-sm-1">
                                                                <input type="text" name="subProduct[0].qty" required id="qty0"   class="form-control"/>
                                                            </td>
                                                            <td class="col-sm-1">
                                                                <input type="text"  id="uom0" required class="form-control"/>
                                                            </td>


                                                            <td class="col-sm-1"><a class="deleteRow"></a>

                                                            </td>
                                                        </tr>

                                                    </tbody>
                                                    <tfoot>
                                                        <tr>
                                                            <td colspan="3" style="text-align: left;">
                                                                <input type="button" class="btn btn-block " id="addrow" value="Add Row" />
                                                            </td>
                                                        </tr>

                                                    </tfoot>
                                                </table>
                                            </div>
                                        </div>
                                        <div class="form-group row">


                                            <div class="col-xs-5 ">
                                                <input type="submit" class="btn  btn-block btn-primary col-xs-offset-4"  value="SAVE" />
                                            </div>



                                        </div>


                                    </div>
                                    </form>
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
