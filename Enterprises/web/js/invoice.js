/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
//<input type="text" name="number" placeholder="Number OR Amount" onkeyup="word.innerHTML=convertNumberToWords(this.value)" />
//<div id="word"></div>


/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


$(document).ready(function() {
    var counter = 1;

    $("#addrow").on("click", function() {
        var $options = $("#productSelect0 > option").clone();
var counter = $("#count").val();
        var newRow = $("<tr>");
        var cols = "";

        var cgstPerc = $("#cgstPerc" + (counter - 1)).val();
        var sgstPerc = $("#sgstPerc" + (counter - 1)).val();
        var igstPerc = $("#igstPerc" + (counter - 1)).val();

        cols += '<td><input  type="hidden" id="productId' + counter + '" name="invoiceDetails[' + counter + '].productName"/><select required id="productSelect' + counter + '" name="invoiceDetails[' + counter + '].productId" class="form-control" onchange="setProduct(' + counter + ')"></select></td>';
        cols += '<td><input type="text" required  style="text-align: center;background-color: #fff !important" tabindex="-1" readonly  class="form-control" name="invoiceDetails[' + counter + '].hsn" id="hsn' + counter + '"/></td>';
        cols += '<td><input type="text" required  style="text-align: center;background-color: #fff !important" tabindex="-1"  class="form-control" name="invoiceDetails[' + counter + '].uom" id="uom' + counter + '"/></td>';
        cols += '<td><input type="text" required  style="text-align: center"  class="form-control" onblur="calculateRowGSTTotal(' + counter + ') name="invoiceDetails[' + counter + '].qty" id="qty' + counter + '"/></td>';

        cols += '<td><input type="text" required  style="text-align: center" tabindex="-1" class="form-control" name="invoiceDetails[' + counter + '].price" id="price' + counter + '" onblur="calculateRowGSTTotal(' + counter + ')"/></td>';
        cols += '<td><input type="text" required  style="text-align: center;background-color: #fff !important" tabindex="-1" readonly  class="form-control" name="invoiceDetails[' + counter + '].amount" id="amount' + counter + '" /></td>';
        cols += '<td><input type="text" required  style="text-align: center;background-color: #fff !important" tabindex="-1"   class="form-control" name="invoiceDetails[' + counter + '].cgstPerc" id="cgstPerc' + counter + '" onblur="calculateRowGSTTotal(' + counter + ')" value="' + cgstPerc + '"/></td>';
        cols += '<td><input type="text" required  style="text-align: center;background-color: #fff !important" tabindex="-1" readonly class="form-control" name="invoiceDetails[' + counter + '].cgstAmount" id="cgstAmt' + counter + '"/></td>';
        cols += '<td><input type="text"  required style="text-align: center;background-color: #fff !important" tabindex="-1"   class="form-control" name="invoiceDetails[' + counter + '].sgstPerc" id="sgstPerc' + counter + '" onblur="calculateRowGSTTotal(' + counter + ')"  value="' + sgstPerc + '"/></td>';
        cols += '<td><input type="text"  required style="text-align: center;background-color: #fff !important" tabindex="-1" readonly  class="form-control" name="invoiceDetails[' + counter + '].sgstAmount"  id="sgstAmt' + counter + '" /></td>';
        cols += '<td><input type="text"  required style="text-align: center;background-color: #fff !important" tabindex="-1"   class="form-control" name="invoiceDetails[' + counter + '].igstPerc" id="igstPerc' + counter + '" onblur="calculateRowGSTTotal(' + counter + ')" value="' + igstPerc + '"/></td>';
        cols += '<td><input type="text"  required style="text-align: center;background-color: #fff !important" tabindex="-1" readonly  class="form-control" name="invoiceDetails[' + counter + '].igstAmount" id="igstAmt' + counter + '" /></td>';
        cols += '<td><input type="text"  required style="text-align: center;background-color: #fff !important" tabindex="-1" readonly  class="form-control" name="invoiceDetails[' + counter + '].totalAmountAfterTax" id="totalAmountAfterTax' + counter + '"/></td>';
        cols += '<td><input type="button" class="ibtnDel btn btn-md btn-danger "  value="X"></td>';
        newRow.append(cols);



        $("table.order-list").append(newRow);
        $('#productSelect' + counter + '').append($options);
        counter++;
         $("#count").val(counter);
    });



    $("#addEditrow").on("click", function() {

        var $options = $("#productSelect > option").clone();

        var counter1 = $("#count").val();

        var newRow = $("<tr>");
        var cols = "";

        var cgstPerc = $("#cgstPerc" + (counter1 - 1)).val();
        var sgstPerc = $("#sgstPerc" + (counter1 - 1)).val();
        var igstPerc = $("#igstPerc" + (counter1 - 1)).val();

        cols += '<td><input type="hidden" id="id' + counter1 + '" value="0" name="invoiceDetails[' + counter1 + '].id"/><input type="hidden" id="productId' + counter1 + '" name="invoiceDetails[' + counter1 + '].productName"/><select required id="productSelect' + counter1 + '" name="invoiceDetails[' + counter1 + '].productId" class="form-control" onchange="setProduct(' + counter1 + ')"></select></td>';
        cols += '<td><input type="text" required class="form-control" name="invoiceDetails[' + counter1 + '].hsn" id="hsn' + counter1 + '"/></td>';
        cols += '<td><input type="text" required  class="form-control" name="invoiceDetails[' + counter1 + '].uom" id="uom' + counter1 + '"/></td>';
        cols += '<td><input type="text" required class="form-control" name="invoiceDetails[' + counter1 + '].qty" onblur="calculateRowGSTTotal(' + counter1 + ') id="qty' + counter1 + '"/></td>';

        cols += '<td><input type="text" required class="form-control" tabindex="-1" name="invoiceDetails[' + counter1 + '].price" id="price' + counter1 + '" onblur="calculateRowGSTTotal(' + counter1 + ')"/></td>';
        cols += '<td><input type="text" required class="form-control" name="invoiceDetails[' + counter1 + '].amount" id="amount' + counter1 + '" /></td>';
        cols += '<td><input type="text" required class="form-control" name="invoiceDetails[' + counter1 + '].cgstPerc" id="cgstPerc' + counter1 + '" onblur="calculateRowGSTTotal(' + counter1 + ')" value="' + cgstPerc + '"/></td>';
        cols += '<td><input type="text" required class="form-control" name="invoiceDetails[' + counter1 + '].cgstAmount" id="cgstAmt' + counter1 + '"/></td>';
        cols += '<td><input type="text" required class="form-control" name="invoiceDetails[' + counter1 + '].sgstPerc" id="sgstPerc' + counter1 + '" onblur="calculateRowGSTTotal(' + counter1 + ')"  value="' + sgstPerc + '"/></td>';
        cols += '<td><input type="text" required class="form-control" name="invoiceDetails[' + counter1 + '].sgstAmount"  id="sgstAmt' + counter1 + '" /></td>';
        cols += '<td><input type="text" required class="form-control" name="invoiceDetails[' + counter1 + '].igstPerc" id="igstPerc' + counter1 + '" onblur="calculateRowGSTTotal(' + counter1 + ')" value="' + igstPerc + '"/></td>';
        cols += '<td><input type="text" required class="form-control" name="invoiceDetails[' + counter1 + '].igstAmount" id="igstAmt' + counter1 + '" /></td>';
        cols += '<td><input type="text" required class="form-control" name="invoiceDetails[' + counter1 + '].totalAmountAfterTax" id="totalAmountAfterTax' + counter1 + '"/></td>';
        cols += '<td><input type="button" class="ibtnDel btn btn-md btn-danger "  value="X"></td>';
        newRow.append(cols);



        $("#myTable").append(newRow);
        $('#productSelect' + counter1 + '').append($options);
        counter1++;
        $("#count").val(counter1);
    });


    $("table.order-list").on("click", ".ibtnDel", function(event) {
        $(this).closest("tr").remove();
        counter = $("#count").val();
        counter -= 1
        $("#count").val(counter);
        calculateAllAmount();
    });
});



function calculateTotal() {

    var val = parseFloat($("#totalAmount").val()).toFixed(2);

    var cgstPerc = $("#cgst").val();
    var cgstAmt = parseFloat(val * (cgstPerc / 100)).toFixed(2);
    $("#cgst1").val(cgstAmt);

    var sgstPerc = $("#sgst").val();
    var sgstAmt = parseFloat(val * (sgstPerc / 100)).toFixed(2);
    $("#sgst1").val(sgstAmt);

    var igstPerc = $("#igst").val();
    var igstAmt = parseFloat(val * (igstPerc / 100)).toFixed(2);
    $("#igst1").val(igstAmt);

    var totalAmountAfterTax = parseFloat(parseFloat(val) + parseFloat(cgstAmt) + parseFloat(sgstAmt) + parseFloat(igstAmt)).toFixed(2);
    $("#totalAmountAfterTax").val(totalAmountAfterTax);

}


function calculateRowGSTTotal(i) {

    var qty = parseInt($("#qty" + i).val());
    var price = parseFloat($("#price" + i).val()).toFixed(2);

    var val = parseFloat(qty * parseFloat(price)).toFixed(2);
    $("#amount" + i).val(val);

    var cgstPerc = $("#cgstPerc" + i).val();
    var cgstAmt = parseFloat(val * (cgstPerc / 100)).toFixed(2);
    $("#cgstAmt" + i).val(cgstAmt);

    var sgstPerc = $("#sgstPerc" + i).val();
    var sgstAmt = parseFloat(val * (sgstPerc / 100)).toFixed(2);
    $("#sgstAmt" + i).val(sgstAmt);

    var igstPerc = $("#igstPerc" + i).val();
    var igstAmt = parseFloat(val * (igstPerc / 100)).toFixed(2);
    $("#igstAmt" + i).val(igstAmt);

    var totalAmountAfterTax = parseFloat(parseFloat(val) + parseFloat(cgstAmt) + parseFloat(sgstAmt) + parseFloat(igstAmt)).toFixed(2);
    $("#totalAmountAfterTax" + i).val(totalAmountAfterTax);

calculateAllAmount();



}

function calculateAllAmount()
{
var cnt = $("#count").val();
      
        var TotalTatalAmount = 0, TotalTatalCGST = 0, TotalTatalSGST = 0, TotalTatalIGST = 0, TotalTotalAmountAfterTax = 0;

        for (var i = 0; i < cnt; i++)
        {
            var val = parseFloat($("#amount" + i).val()).toFixed(2);
            TotalTatalAmount = parseFloat(parseFloat(TotalTatalAmount) + parseFloat(val)).toFixed(2);

            var cgstPerc = $("#cgstPerc" + i).val();
            var cgstAmt = parseFloat(val * (cgstPerc / 100)).toFixed(2);
            TotalTatalCGST = parseFloat(parseFloat(TotalTatalCGST) + parseFloat(cgstAmt)).toFixed(2);

            var sgstPerc = $("#sgstPerc" + i).val();
            var sgstAmt = parseFloat(val * (sgstPerc / 100)).toFixed(2);
            TotalTatalSGST = parseFloat(parseFloat(TotalTatalSGST) + parseFloat(sgstAmt)).toFixed(2);

            var igstPerc = $("#igstPerc" + i).val();
            var igstAmt = parseFloat(val * (igstPerc / 100)).toFixed(2);
            TotalTatalIGST = parseFloat(parseFloat(TotalTatalIGST) + parseFloat(igstAmt)).toFixed(2);

            var totalGST = parseFloat(parseFloat(TotalTatalCGST) + parseFloat(TotalTatalSGST) + parseFloat(TotalTatalIGST));

            var totalAmountAfterTax = parseFloat(parseFloat(val) + parseFloat(cgstAmt) + parseFloat(sgstAmt) + parseFloat(igstAmt)).toFixed(2);
            TotalTotalAmountAfterTax = parseFloat(parseFloat(TotalTotalAmountAfterTax) + parseFloat(totalAmountAfterTax)).toFixed(2);


        }

        $("#TotalTatalAmount").val(TotalTatalAmount);
        $("#TotalTatalCGST").val(TotalTatalCGST);
        $("#TotalTatalSGST").val(TotalTatalSGST);
        $("#TotalTatalIGST").val(TotalTatalIGST);
        $("#TotalTotalAmountAfterTax").val(TotalTotalAmountAfterTax);
        $("#totalAmountGST").val(totalGST);



        $("#totalAmountFinal").val(TotalTatalAmount);

        var cgstPercFinal = $("#cgstPercFinal").val();
        var cgstAmtFinal = parseFloat(TotalTatalAmount * (cgstPercFinal / 100)).toFixed(2);
        $("#cgstAmountFinal").val(parseFloat(cgstAmtFinal).toFixed(2));

        var sgstPercFinal = $("#sgstPercFinal").val();
        var sgstAmtFinal = parseFloat(TotalTatalAmount * (sgstPercFinal / 100)).toFixed(2);
        $("#sgstAmountFinal").val(parseFloat(sgstAmtFinal).toFixed(2));

        var igstPercFinal = $("#igstPercFinal").val();
        var igstAmtFinal = parseFloat(TotalTatalAmount * (igstPercFinal / 100)).toFixed(2);
        $("#igstAmountFinal").val(parseFloat(igstAmtFinal).toFixed(2));


        var totalAmountAfterTaxFinal = (parseFloat(TotalTatalAmount) + parseFloat(cgstAmtFinal) + parseFloat(sgstAmtFinal) + parseFloat(igstAmtFinal));
        $("#totalAmountAfterTaxFinal").val(parseFloat(totalAmountAfterTaxFinal).toFixed(2));

        var roundval = Math.round(totalAmountAfterTaxFinal);
        var roubndOffAmountFinal = roundval - totalAmountAfterTaxFinal;
        $("#roubndOffAmountFinal").val(parseFloat(roubndOffAmountFinal).toFixed(2));
        $("#FinalAmount").val(roundval);


        var amountInwords = convertNumberToWords(roundval);
        $("#amountInwords").val(amountInwords + "rupees only");
}




function convertNumberToWords(amount) {
    var words = new Array();
    words[0] = '';
    words[1] = 'One';
    words[2] = 'Two';
    words[3] = 'Three';
    words[4] = 'Four';
    words[5] = 'Five';
    words[6] = 'Six';
    words[7] = 'Seven';
    words[8] = 'Eight';
    words[9] = 'Nine';
    words[10] = 'Ten';
    words[11] = 'Eleven';
    words[12] = 'Twelve';
    words[13] = 'Thirteen';
    words[14] = 'Fourteen';
    words[15] = 'Fifteen';
    words[16] = 'Sixteen';
    words[17] = 'Seventeen';
    words[18] = 'Eighteen';
    words[19] = 'Nineteen';
    words[20] = 'Twenty';
    words[30] = 'Thirty';
    words[40] = 'Forty';
    words[50] = 'Fifty';
    words[60] = 'Sixty';
    words[70] = 'Seventy';
    words[80] = 'Eighty';
    words[90] = 'Ninety';
    amount = amount.toString();
    var atemp = amount.split(".");
    var number = atemp[0].split(",").join("");
    var n_length = number.length;
    var words_string = "";
    if (n_length <= 9) {
        var n_array = new Array(0, 0, 0, 0, 0, 0, 0, 0, 0);
        var received_n_array = new Array();
        for (var i = 0; i < n_length; i++) {
            received_n_array[i] = number.substr(i, 1);
        }
        for (var i = 9 - n_length, j = 0; i < 9; i++, j++) {
            n_array[i] = received_n_array[j];
        }
        for (var i = 0, j = 1; i < 9; i++, j++) {
            if (i == 0 || i == 2 || i == 4 || i == 7) {
                if (n_array[i] == 1) {
                    n_array[j] = 10 + parseInt(n_array[j]);
                    n_array[i] = 0;
                }
            }
        }
        value = "";
        for (var i = 0; i < 9; i++) {
            if (i == 0 || i == 2 || i == 4 || i == 7) {
                value = n_array[i] * 10;
            } else {
                value = n_array[i];
            }
            if (value != 0) {
                words_string += words[value] + " ";
            }
            if ((i == 1 && value != 0) || (i == 0 && value != 0 && n_array[i + 1] == 0)) {
                words_string += "Crores ";
            }
            if ((i == 3 && value != 0) || (i == 2 && value != 0 && n_array[i + 1] == 0)) {
                words_string += "Lakhs ";
            }
            if ((i == 5 && value != 0) || (i == 4 && value != 0 && n_array[i + 1] == 0)) {
                words_string += "Thousand ";
            }
            if (i == 6 && value != 0 && (n_array[i + 1] != 0 && n_array[i + 2] != 0)) {
                words_string += "Hundred and ";
            } else if (i == 6 && value != 0) {
                words_string += "Hundred ";
            }
        }
        words_string = words_string.split("  ").join(" ");
    }
    return words_string;
}


