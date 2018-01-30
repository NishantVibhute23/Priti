<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>HTML to PDF</title>
        <style>
            .font-medium{
                font-size: 11px;
            }

        </style>
    </head>
    <body  bgcolor="#E6E6FA">
        <table  width="100%" class="border-style-1 no-spacing">
            <tr  class="border-style">
                <td colspan="2" >
                    <table cellpadding="3" width="100%">
                        <tr>
                            <td colspan="6" >
                                <div style="text-align: center;width: 100%;">
                                    <br/>
                                    <p ><b class="font-heading" >${companyHeaderName}</b></p>
                                    <br></br>
                                    <p class="font-medium">${companyHeaderAddress}</p>
                                    <br></br>
                                    <p class="font-medium">GSTIN : ${companyHeaderGSTIN} </p>
                                    <br></br>
                                    <p class="font-medium">Ledger Account</p>
                                    <br></br>
                                    <p class="font-medium">${fromDate} to ${toDate} </p>
                                    <br></br>
                                    <hr></hr>
                                </div>
                            </td>
                        </tr>
                        <tr style=' border-bottom:1px solid black;'>
                            <td width="10%">Date</td>
                            <td width="5%"></td>
                            <td width="45%">Particulars</td>
                            <td width="10%">Invoice No</td>
                            <td width="10%">Debit</td>
                            <td width="10%">Credit</td>
                        </tr>
                        <tr height="2px">
                            <td colspan="6">
                                <hr></hr>
                            </td>
                        </tr>
<#assign prevDate = ''>
                        <#list ledgerDetails as ledger>
                        <tr>
                            <#if ledger.paymentDate == prevDate>
                            <td width="10%"></td>
                            <#else>
                            <td valign='top' width="10%"><span class="font-medium">${ledger.paymentDate}</span></td>
                                <#assign prevDate = ledger.paymentDate>
                            </#if>
                            <#if ledger.type == '1'>
                            <td valign='top' width="5%"><span class="font-medium">By</span></td>
                                <#if ledger.paymentMode == 'cash'>

                            <td valign='top' width="40%"><span class="font-medium">${ledger.companyName}<br></br>by Cash</span></td>
<#elseif ledger.paymentMode == 'cheque'>
                            <td valign='top' width="40%"><span class="font-medium">${ledger.companyName}<br></br>by Cheque : ${ledger.bankName} - Chq No:${ledger.chequeNo} </span></td>
<#elseif ledger.paymentMode == 'neft'>
                            <td  valign='top' width="40%"><span class="font-medium">${ledger.companyName}<br></br>by NEFT : UTR No.${ledger.utrNo} - IFSC Code:${ledger.ifscCode}</span></td>
                            </#if>

                            <td valign='top'  width="15%"><span class="font-medium">${ledger.invoiceId}</span></td>

                            <td valign='top' width="10%"></td>
                            <td valign='top' width="10%"><span class="font-medium">${ledger.paymentAmount}</span></td>
                            <#else>
                            <td valign='top' width="5%"><span class="font-medium">To</span></td>
                            <#if ledger.paymentMode == 'cash'>

                            <td valign='top' width="40%"><span class="font-medium">${ledger.companyName}<br></br>by Cash</span></td>
<#elseif ledger.paymentMode == 'cheque'>
                            <td valign='top' width="40%"><span class="font-medium">${ledger.companyName}<br></br>by Cheque : ${ledger.bankName} - Chq No:${ledger.chequeNo} </span></td>
<#elseif ledger.paymentMode == 'neft'>
                            <td  valign='top' width="40%"><span class="font-medium">${ledger.companyName}<br></br>by NEFT : UTR No.${ledger.utrNo} - IFSC Code:${ledger.ifscCode}</span></td>
                            </#if>
                            <td valign='top' width="15%"><span class="font-medium">${ledger.invoiceId}</span></td>

                            <td valign='top' width="10%"><span class="font-medium">${ledger.paymentAmount}</span></td>
                            <td valign='top' width="10%"></td>
                            </#if>
                           
                           
                        </tr>
                        </#list>
                        <tr>
                            <td colspan="4">
                            </td>
                            <td >
                                <hr></hr>
                                <span class="font-medium">${debitTotal}</span>
                            </td>
                            <td >
<hr></hr>
<span class="font-medium">${creditTotal}</span> 
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr height="5px">
                <td colspan="2">

                </td>
            </tr>
            

        </table>
    </body>
</html>