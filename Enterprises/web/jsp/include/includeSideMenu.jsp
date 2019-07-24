<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Dashboard</title>

        <!-- Bootstrap Core CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">

        <!-- Custom CSS -->
        <link href="css/sb-admin.css" rel="stylesheet">
        <link href="css/global.css" rel="stylesheet">

        <!-- Morris Charts CSS -->
        <link href="css/plugins/morris.css" rel="stylesheet">

        <!-- Custom Fonts -->
        <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
            <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
            <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->

        

            <!-- jQuery -->
            <script src="js/jquery.js"></script>

            <!-- Bootstrap Core JavaScript -->
            <script src="js/bootstrap.min.js"></script>

            <!-- Morris Charts JavaScript -->
            <script src="js/plugins/morris/raphael.min.js"></script>
            <script src="js/plugins/morris/morris.min.js"></script>
            <!--<script src="js/plugins/morris/morris-data.js"></script>-->
        
    </head>

    <body>

        <div id="wrapper">

            <!-- Navigation -->
            <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="myProfile"><s:property value="#session.companyName"/> </a>
                </div>
                <!-- Top Menu Items -->
                <ul class="nav navbar-right top-nav">
                    <li class="dropdown">
                        
                        <s:iterator value='#session.productList'>

                                <s:if test="subProductList.size() > 0">
                                    <s:iterator value="subProductList" >

                                        <s:if test="qty <= #session.productThreshold">
                                            
                                            <s:set var="isLess" value="true" />
                                        </s:if>
                                    </s:iterator>
                                </s:if>
                            </s:iterator>
                        
                        <s:if test="isLess">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i style="color: skyblue" class="fa fa-envelope"></i> <b class="caret"></b></a>
                        </s:if>
                        <s:else>
                                                 <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i style="color: white" class="fa fa-envelope"></i> <b class="caret"></b></a>
                                            </s:else>
                        
                        
                        
                        
                        <ul class="dropdown-menu message-dropdown">


                            <s:iterator value='#session.productList'>

                                <s:if test="subProductList.size() > 0">
                                    <s:iterator value="subProductList" >

                                        <s:if test="qty <= #session.productThreshold">

                                            <li class="message-preview">
                                                <a href="#">
                                                    <div class="media">

                                                        <center> <span style="border-radius: 25px;
                                                                       background: red;

                                                                       width: 50px;
                                                                       height: 50px;
                                                                       color:white;margin-right: 5px" class="pull-left">
                                                                <h4 style="margin-top: 15px"><s:property value = 'qty'/></h4>
                                                            </span></center>
                                                        <div class="media-body">
                                                            <h5 class="media-heading"><strong><s:property value = 'subProductName'/></strong>
                                                            </h5>

                                                            <p><s:property value = 'mainProductName'/></p>
                                                        </div>
                                                    </div>
                                                </a>
                                            </li>


                                        </s:if>



                                    </s:iterator>
                                </s:if>
                            </s:iterator>

                            <li class="message-footer">
                                <a href="getproduct">View Products</a>
                            </li>
                        </ul>
                    </li>
                        
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> <s:property value="#session.userName"/> <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li>
                                <a href="myProfile"><i class="fa fa-fw fa-user"></i> Profile</a>
                            </li>
                           
                             <li>
                                <a href="redirectChangePassword"><i class="fa fa-fw fa-key" ></i> Password</a>
                            </li>
                            
                            <li class="divider"></li>
                            <li>
                                <a href="logout"><i class="fa fa-fw fa-power-off"></i> Log Out</a>
                            </li>
                        </ul>
                    </li>
                </ul>
                        
                        
                        
                <!-- Sidebar Menu Items - These collapse to the responsive navigation menu on small screens -->
                <div  class="collapse navbar-collapse navbar-ex1-collapse">
                    <ul class="nav navbar-nav side-nav">
                        <li id="dashboard">
                            <a href="dashboard"><i class="fa fa-fw fa-dashboard "></i> Dashboard</a>
                        </li>

                        <li id="Invoice">
                            <a href="javascript:;" data-toggle="collapse" data-target="#invoiceId"><i class="fa fa-fw fa-files-o"></i> Invoice <i class="fa fa-fw fa-caret-down"></i></a>
                            <ul id="invoiceId" class="collapse">
                                <li id="InvoiceNew" >
                                    <a  href="invoice">New</a>
                                </li>
                                <li id="InvoiceDetails">
                                    <a href="invoiceDetails">Details</a>
                                </li>
                                <li id="InvoicePayment">
                                    <a href="invoicePayment">Payment</a>
                                </li>
                            </ul>
                        </li>



                        <li id="Purchase">
        
                            
                            <a href="javascript:;" data-toggle="collapse" data-target="#purchaseId"><i class="fa fa-fw fa-shopping-basket"></i> Purchase <i class="fa fa-fw fa-caret-down"></i></a>
                            <ul id="purchaseId" class="collapse">
                                <li id="PurchaseNew">
                                    <a href="purchase">New</a>
                                </li>

                                <li id="PurchaseDetails">
                                    <a href="purchaseDetails">Details</a>
                                </li>
                                
                                 <li id="PurchasePayment">
                                    <a href="purchasePayment">Payment</a>
                                </li>
                            </ul>
                        </li>




<!--                        <li>
                            <a href="getvoucher"><i class="fa fa-fw fa-credit-card"></i> Voucher</a>
                        </li>-->
                        <li id="Products">
                            <a href="getproduct"><i class="fa fa-fw fa-product-hunt"></i> Products</a>
                        </li>

                        <li id="AddressBook">
                            <a href="getaddressbook"><i class="fa fa-fw fa-address-card-o"></i> Address Book</a>
                        </li>
                         <li id="Ledger">
                            <a href="ledger"><i class="fa fa-fw fa-book"></i> Ledger</a>
                        </li>
                        <li id="RawMaterial">
                            <a href="rawMaterial"><i class="fa fa-fw fa-industry"></i> Raw Material</a>
                        </li>
                        <li id="Bills">
                            <a href="bill"><i class="fa fa-fw fa-dollar"></i> Bill</a>
                        </li>



                        <!--                        <li>
                                                    <a href="getPrintList"><i class="fa fa-fw fa-print"></i> Print</a>
                                                </li>-->

                    </ul>
                </div>
                <!-- /.navbar-collapse -->
            </nav>






    </body>

</html>
