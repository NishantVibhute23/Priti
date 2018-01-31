/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


$(document).ready(function () {
    
    var counter = 1;

    $("#addrow").on("click", function () {
       
        var $options = $("#productSelect0 > option").clone();
       
        var newRow = $("<tr>");
        var cols = "";
        
        cols += '<td><select required id="productSelect' + counter + '" name="subProduct[' + counter + '].subProductId" class="form-control" onchange="setProductHSN('+counter+')"></select></td>';
        cols += '<td><input required type="text" name="subProduct[' + counter + '].qty" id="qty' + counter + '"  class="form-control"/></td>';
        cols += '<td><input required type="text"  id="uom' + counter + '" class="form-control"/></td>';
        
        cols += '<td><input type="button" class="ibtnDel btn btn-md btn-danger "  value="X"></td>';
        newRow.append(cols);
        


        $("table.order-list").append(newRow);
        $('#productSelect' + counter + '').append($options);
        counter++;
    });
    
    $("table.order-list").on("click", ".ibtnDel", function (event) {
        $(this).closest("tr").remove();       
        counter -= 1
    });
    });
