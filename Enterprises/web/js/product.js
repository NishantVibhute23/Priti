/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


$(document).ready(function () {
    var counter = 1;

    $("#addrow").on("click", function () {
        
        var newRow = $("<tr>");
        var cols = "";

        cols += '<td><input type="text" required class="form-control" name="subProductList[' + counter + '].subProductName"/></td>';
        cols += '<td><input type="text" required class="form-control" name="subProductList[' + counter + '].subProductCode"/></td>';
        
        cols += '<td><input type="button" class="ibtnDel btn btn-md btn-danger "  value="Delete"></td>';
        newRow.append(cols);
        $("table.order-list").append(newRow);
        
        counter++;
    });
    
    
    $("#editaddrow").on("click", function () {
        
        var counter1 =$('#count').val();
        var newRow = $("<tr>");
        var cols = "";

        cols += '<td><input type="hidden" name="subProductList[' + counter1 + '].subProductId" value="0"/><input type="text" class="form-control" name="subProductList[' + counter1 + '].subProductName"/></td>';
        cols += '<td><input type="text" required class="form-control" value="0" name="subProductList[' + counter1 + '].qty"/></td>';
        
        cols += '<td><input type="button" class="ibtnDel btn btn-md btn-danger "  value="Delete"></td>';
        newRow.append(cols);
        $("#myEditTable").append(newRow);
        counter1++;
        $('#count').val(counter1);
    });



    $("table.order-list").on("click", ".ibtnDel", function (event) {
        $(this).closest("tr").remove();       
        counter -= 1
    });


});



function calculateRow(row) {
    var price = +row.find('input[name^="price"]').val();

}

function calculateGrandTotal() {
    var grandTotal = 0;
    $("table.order-list").find('input[name^="price"]').each(function () {
        grandTotal += +$(this).val();
    });
    $("#grandtotal").text(grandTotal.toFixed(2));
}