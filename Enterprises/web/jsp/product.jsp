<%--
    Document   : product
    Created on : Jul 18, 2017, 3:21:30 PM
    Author     : nishant.vibhute
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/jsp/include/includeSideMenu.jsp"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/product.css" rel="stylesheet">
        <script type="text/javascript" src="js/jquery-2.2.4.min.js"></script>
        <script type="text/javascript" src="js/product.js"></script>
        <script type="text/javascript" src="js/datatables.min.js"></script>
        <link href="css/datatable.css" rel="stylesheet">
        <link href="css/dataTables.bootstrap.min.css" rel="stylesheet">
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

                $("#Products").addClass("active");
                $("#AddressBook").removeClass("active");
                $("#RawMaterial").removeClass("active");
                $("#Ledger").removeClass("active");



            });


            function getProductInfo(idIn)
            {
                $("#editTableBody").text("");
                var id = 0;
                if (idIn === '0')
                {
                    id = $("#productSelect").val();
                }
                else {
                    id = idIn;
                }

                $.ajax({
                    url: 'getProductInfo?val=' + id,
                    type: "POST",
                    dataType: 'json'
                }).success(function(response) {

                    $("#hsnCode").val(response.mainProductHSN);
                    $("#editmainProductName").val(response.mainProductName);

                    $("#editmainProductId").val(response.id);
                    $("#uomTypeSelect").val(response.mainProductUOM);
                    $("#ProductTypeSelect").val(response.mainProductType);
                    var counter = 0;
                    $.each(response.subProductList, function(i, val) {
//                        alert(" - " + val.subProductId);
                        var newRow = $("<tr>");
                        var cols = "";
                        cols += '<td><input type="hidden" name="subProductList[' + counter + '].subProductId" value="' + val.subProductId + '"/><input type="text" value="' + val.subProductName + '" class="form-control" name="subProductList[' + counter + '].subProductName"/></td>';
                        cols += '<td><input type="text" value="' + val.qty + '" class="form-control" name="subProductList[' + counter + '].qty"/></td>';
                        newRow.append(cols);
                        $("#myEditTable").append(newRow);

                        counter++;
                        $('#count').val(counter);

                    });

                    $('#myModal').modal('show');
                });
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
                            Products 
                        </h3>


                    </div>
                </div>
                <!-- /.row -->
                <div class="row" >
                    <div style="float: right">
                        <form action="updateProductThreshold"> <b>Threshold</b> : <input type="text" value="<s:property value = '#session.productThreshold'/>" size="2" name="threshold" style="text-align: center" /> <button type="submit" class="btn btn-default" >Update</button></form>
                    </div>
                </div>

                <div class="row" >

                    <div class="panel with-nav-tabs panel-info">
                        <div class="panel-heading">
                            <ul  class="nav nav-pills">
                                <li class="active" >
                                    <a  href="#1b" data-toggle="tab" style="padding: 10px 100px !important">List</a>
                                </li>
                                <li><a href="#2b" data-toggle="tab" style="padding: 10px 100px !important">New</a>
                                </li>


                            </ul>
                        </div>
                        <div class="panel-body">
                            <div class="tab-content">
                                <div class="tab-pane fade in active" id="1b">
                                    <table id='productTable' class="table table-bordered"  width="100%">
                                        <thead>
                                            <tr>
                                                <th>Product Name</th>
                                                <th>Sub Product Name</th>
                                                <th>QTY</th>

                                                <th>UOM</th>
                                                <th>HSN CODE</th>
                                                <th>Type</th>
                                                <th>ACTION</th>
                                            </tr>
                                        </thead>
                                        <s:iterator value="productList">
                                            <tr >
                                                <td style='vertical-align: middle !important' rowspan="<s:property value = 'subProductList.size()'/>" ><s:property value = 'mainProductName'/></td>
                                                <td  ><s:property value = 'subProductList[0].subProductName'/></td>

                                                <s:if test="subProductList[0].qty <= #session.productThreshold">
                                                    <td align="center" class="invalid"><s:property value = 'subProductList[0].qty'/></td>
                                                </s:if>
                                                <s:else>
                                                    <td align="center" class=""><s:property value = 'subProductList[0].qty'/></td>
                                                </s:else>

                                                    <td  style='vertical-align: middle !important' rowspan="<s:property value = 'subProductList.size()'/>" ><s:property value = 'mainProductUOMName'/></td>
                                                    <td  style='vertical-align: middle !important' rowspan="<s:property value = 'subProductList.size()'/>" ><s:property value = 'mainProductHSN'/></td>

                                                <td  style='vertical-align: middle !important'  rowspan="<s:property value = 'subProductList.size()'/>" ><s:property value = 'mainProductTypeName'/></td>

                                                <td   style='vertical-align: middle !important' rowspan="<s:property value = 'subProductList.size()'/>" ><button class="btn btn-sm btn-block btn-primary" onclick="getProductInfo(<s:property value = 'id'/>)"> EDIT</button></td>
                                            </tr>
                                            <s:if test="subProductList.size() > 0">
                                                <s:iterator value="subProductList" begin="1">
                                                    <tr >
                                                        <td  ><s:property value = 'subProductName'/>
                                                        </td>
                                                        <s:if test="qty <= #session.productThreshold">
                                                            <td align="center" class="invalid" ><p class="steps"><s:property value = 'qty'/></p>
                                                            </td>
                                                        </s:if>
                                                        <s:else  >
                                                            <td align="center" class="" ><s:property value = 'qty'/>
                                                            </td>
                                                        </s:else>

                                                    </tr>
                                                </s:iterator>
                                            </s:if>
                                        </s:iterator>
                                    </table>

                                </div>
                                <div class="tab-pane fade" id="2b">
                                    <s:form action="saveProduct" >
                                        <div class="row">
                                            <div class="form-group">
                                                <label class="col-xs-2 control-label">Product Name</label>
                                                <div class="col-xs-3">
                                                    <input type="text" class="form-control" name="mainProductName"  />


                                                </div>

                                                <div class="form-group">
                                                    <label class="col-xs-2 ">HSN Code</label>
                                                    <div class="col-xs-3 ">

                                                        <input type="text" class="form-control" name="mainProductHSN"  />
                                                    </div>

                                                </div>

                                            </div>
                                        </div>
                                        <br>
                                        <div class="row">
                                            <div class="form-group">
                                                <label class="col-xs-2 ">UOM Type</label>
                                                <div class="col-xs-3 ">
                                                    <select id="uomSelect" name="mainProductUOM" class="form-control"  >
                                                        <option value="0">Select</option>
                                                        <s:iterator value="uomBeanList">
                                                            <option value="<s:property value = 'id'/>"><s:property value = 'name'/></option>
                                                        </s:iterator>
                                                    </select>
                                                </div>

                                                <label class="col-xs-2 ">Product Type</label>
                                                <div class="col-xs-3 ">
                                                    <select id="ProductSelect" name="mainProductType" class="form-control"  >
                                                        <option value="0">Select</option>
                                                        <s:iterator value="productTypeBeanList">
                                                            <option value="<s:property value = 'id'/>"><s:property value = 'name'/></option>
                                                        </s:iterator>
                                                    </select>
                                                </div>

                                            </div>
                                        </div>

                                        <hr>
                                        <table id="myTable" class=" table order-list">
                                            <thead>
                                                <tr>
                                                    <td >Name</td>
                                                    <td>Code</td>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>

                                                    <td class="col-sm-4">
                                                        <input type="text" name="subProductList[0].subProductName" class="form-control" />
                                                    </td>
                                                    <td class="col-sm-4">
                                                        <input type="text" name="subProductList[0].subProductCode"  class="form-control"/>
                                                    </td>

                                                    <td class="col-sm-2"><a class="deleteRow"></a>

                                                    </td>
                                                </tr>
                                            </tbody>
                                            <tfoot>
                                                <tr>
                                                    <td colspan="4" style="text-align: left;">
                                                        <input type="button" class="btn btn-sm btn-block btn-block " id="addrow" value="Add Row" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4" style="text-align: left;">
                                                        <div class="form-group">
                                                            <div class="col-xs-12 col-xs-offset-5">



                                                                <input type="submit" class="btn btn-primary col-xs-2" id="addrow" value="Save" />

                                                            </div>
                                                        </div>

                                                    </td>
                                                </tr>
                                            </tfoot>
                                        </table>
                                    </s:form>

                                </div>

                            </div>
                        </div>
                    </div>




                    <div id="myModal" class="modal fade" role="dialog">
                        <div class="modal-dialog modal-lg">

                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <h4 class="modal-title">Edit</h4>
                                </div>
                                <div class="modal-body">
                                    <s:form action="updateProduct" >

                                        <div class="row">
                                            <div class="form-group">
                                                <div class="form-group">
                                                    <input type='hidden' id='count' />
                                                    <input type='hidden' name = "id" id='editmainProductId' />
                                                    <label class="col-xs-2 ">Product Name</label>
                                                    <div class="col-xs-3 ">
                                                        <input type="text" required id='editmainProductName' class="form-control" name="mainProductName"  />
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-xs-2 ">HSN Code</label>
                                                    <div class="col-xs-3 ">

                                                        <input type="text" required id='hsnCode' class="form-control" name="mainProductHSN"  />
                                                    </div>

                                                </div>

                                            </div>
                                        </div>
                                        <br>
                                        <div class="row">
                                            <div class="form-group">
                                                <label class="col-xs-2 ">UOM Type</label>
                                                <div class="col-xs-3 ">
                                                    <select required id="uomTypeSelect" name="mainProductUOM" class="form-control"  >
                                                        <option value="">Select</option>
                                                        <s:iterator value="uomBeanList">
                                                            <option value="<s:property value = 'id'/>"><s:property value = 'name'/></option>
                                                        </s:iterator>
                                                    </select>
                                                </div>

                                                <label class="col-xs-2 ">Product Type</label>
                                                <div class="col-xs-3 ">
                                                    <select required id="ProductTypeSelect" name="mainProductType" class="form-control"  >
                                                        <option value="">Select</option>
                                                        <s:iterator value="productTypeBeanList">
                                                            <option value="<s:property value = 'id'/>"><s:property value = 'name'/></option>
                                                        </s:iterator>
                                                    </select>
                                                </div>

                                            </div>
                                        </div>

                                        <hr>
                                        <table id="myEditTable" class=" table order-list">
                                            <thead>
                                                <tr>
                                                    <td >Name</td>
                                                    <td>QTY</td>
                                                </tr>
                                            </thead>
                                            <tbody id='editTableBody'>

                                            </tbody>
                                            <tfoot>

                                                <tr>
                                                    <td colspan="4" style="text-align: left;">
                                                        <input type="button" class="btn btn-sm btn-block" id="editaddrow" value="Add Row" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4" style="text-align: left;">
                                                        <div class="form-group">
                                                            <div class="col-xs-12 col-xs-offset-5">



                                                                <input type="submit" class="btn btn-primary col-xs-2" id="addrow" value="Save" />

                                                            </div>
                                                        </div>

                                                    </td>
                                                </tr>
                                            </tfoot>
                                        </table>
                                    </s:form>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                </div>
                            </div>

                        </div>
                    </div>


                    <!-- Bootstrap core JavaScript
                        ================================================== -->
                    <!-- Placed at the end of the document so the pages load faster -->
                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
                    <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
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
