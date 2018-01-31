/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function() {
    var purchaseChart = Morris.Bar({
        element: 'purchase-report',
        xkey: 'date',
        ykeys: ['amountTotal','amountPaid','amountUnpaid'],
        labels: ['Total', 'Paid', 'Unpaid'],
        barColors: ['#2577B5','#257898','#259685'],
    });

    var salesChart = Morris.Bar({
        element: 'sales-report',
        xkey: 'date',
        ykeys: ['amountTotal','amountPaid','amountUnpaid'],
         labels: ['Total', 'Paid', 'Unpaid'],
        barColors: ['#A7B3BC'],
        
    });

    var plChart = Morris.Bar({
        element: 'pl-report',
        xkey: 'date',
        ykeys: ['amountTotal'],
        labels: ['Sale'],
        barColors: ['#7CB47C']
    });

    var areaChart = Morris.Area({
        element: 'morris-area-chart',
        xkey: 'date',
        ykeys: ['purchase', 'sale', 'profit'],
        labels: ['Purchase', 'Sale', 'Profit'],
        pointSize: 2,
        hideHover: 'auto',
        resize: true,
        fillOpacity: 0.6,
      behaveLikeLine: true
     
    });

    $.ajax({
        url: 'getPurchaseReport',
        type: "POST",
        dataType: 'json'
    }).success(function(response) {
        purchaseChart.setData(response);
    });


    $.ajax({
        url: 'getSalesReport',
        type: "POST",
        dataType: 'json'
    }).success(function(response) {

        salesChart.setData(response);
    });


    $.ajax({
        url: 'getPLReport',
        type: "POST",
        dataType: 'json'
    }).success(function(response) {
        plChart.setData(response);
    });


    $.ajax({
        url: 'getPurchaseSalePlReport',
        type: "POST",
        dataType: 'json'
    }).success(function(response) {
        areaChart.setData(response);
    });

    $("#purchaseReport").on("click", function() {
        var fr = $("#datepickerPurchaseFrom").val();
        var to = $("#datepickerPurchaseTo").val();

        $.ajax({
            url: 'getPurchaseReport?fromDate=' + fr + '&toDate=' + to,
            type: "POST",
            dataType: 'json'
        }).success(function(response) {

            purchaseChart.setData(response);
        });
    });

    $("#salesReport").on("click", function() {
        var fr = $("#datepickerSalesFrom").val();
        var to = $("#datepickerSalesTo").val();

        $.ajax({
            url: 'getSalesReport?fromDate=' + fr + '&toDate=' + to,
            type: "POST",
            dataType: 'json'
        }).success(function(response) {

            salesChart.setData(response);
        });
    });

    $("#plReport").on("click", function() {
        var fr = $("#datepickerPlFrom").val();
        var to = $("#datepickerPlTo").val();

        $.ajax({
            url: 'getPLReport?fromDate=' + fr + '&toDate=' + to,
            type: "POST",
            dataType: 'json'
        }).success(function(response) {

            plChart.setData(response);
        });
    });
    
    
    $("#statsReport").on("click", function() {
        var fr = $("#datepickerStatsFrom").val();
        var to = $("#datepickerSatsTo").val();

        $.ajax({
            url: 'getPurchaseSalePlReport?fromDate=' + fr + '&toDate=' + to,
            type: "POST",
            dataType: 'json'
        }).success(function(response) {

            areaChart.setData(response);
        });
    });


});





$(function() {
    $("#datepickerPurchaseFrom").datepicker({changeMonth: true,
        changeYear: true,
        showAnim: "slideDown",
        dateFormat: "dd/mm/yy"
    });
    $("#datepickerPurchaseTo").datepicker({changeMonth: true,
        changeYear: true,
        showAnim: "slideDown",
        dateFormat: "dd/mm/yy"
    });
    $("#datepickerSalesFrom").datepicker({changeMonth: true,
        changeYear: true,
        showAnim: "slideDown",
        dateFormat: "dd/mm/yy"
    });
    $("#datepickerSalesTo").datepicker({changeMonth: true,
        changeYear: true,
        showAnim: "slideDown",
        dateFormat: "dd/mm/yy"
    });

    $("#datepickerPlFrom").datepicker({changeMonth: true,
        changeYear: true,
        showAnim: "slideDown",
        dateFormat: "dd/mm/yy"
    });
    $("#datepickerPlTo").datepicker({changeMonth: true,
        changeYear: true,
        showAnim: "slideDown",
        dateFormat: "dd/mm/yy"
    });

    $("#datepickerStatsFrom").datepicker({changeMonth: true,
        changeYear: true,
        showAnim: "slideDown",
        dateFormat: "dd/mm/yy"
    });
    $("#datepickerSatsTo").datepicker({changeMonth: true,
        changeYear: true,
        showAnim: "slideDown",
        dateFormat: "dd/mm/yy"
    });

});


           