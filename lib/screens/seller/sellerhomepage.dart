import 'package:flutter/material.dart';

import 'package:regalo/common/loginpage.dart';
import 'package:regalo/constants/colors.dart';
import 'package:regalo/constants/decorations.dart';
import 'package:regalo/screens/seller/addproducts.dart';

import 'package:regalo/screens/seller/complaints.dart';

import 'package:regalo/screens/seller/feedbackviewselelr.dart';
import 'package:regalo/screens/seller/payments.dart';
import 'package:regalo/screens/seller/productdetails.dart';
import 'package:regalo/screens/seller/viewallorders.dart';
import 'package:regalo/utilities/apptext.dart';
import 'package:regalo/utilities/headerwidget.dart';

class SellerHomePage extends StatefulWidget {
  String? name;
  String? email;
  String? id;
  var status;
  String? address;
  String? pincode;
  String? phone;
  SellerHomePage(
      {Key? key,
      this.email,
      this.id,
      this.name,
      this.status,
      this.address,
      this.pincode,
      this.phone})
      : super(key: key);

  @override
  State<SellerHomePage> createState() => _SellerHomePageState();
}

class _SellerHomePageState extends State<SellerHomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      //drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: priaryColor,
        //centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              icon: Icon(Icons.login))
        ],
      ),
      body: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Row(
                  children: [
                    HeaderWidget(),
                    SizedBox(
                      width: 14,
                    ),

                    AppText(
                      text: "WELCOME ${widget.name}",
                      size: 16,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddProductsPage(
                                      id: widget.id,
                                    )));
                      },
                      child: Container(
                        child: Center(
                          child: AppText(
                            text: 'Add Products',
                            size: 18,
                            fw: FontWeight.w800,
                            color: priaryColor,
                          ),
                        ),
                        height: 100,
                        width: 160,
                        margin: EdgeInsets.only(right: 10),
                        decoration: contDecortion,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductDetailsPage(id: widget.id,)));
                    },
                    child: Container(
                      child: Center(
                        child: AppText(
                          text: 'View All Products',
                          size: 18,
                          fw: FontWeight.w800,
                          color: priaryColor,
                        ),
                      ),
                      height: 100,
                      width: 160,
                      margin: EdgeInsets.only(right: 10),
                      decoration: contDecortion,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(  
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewAllOrders(
                                      id: widget.id,
                                    )));
                      },
                      child: Container(
                        child: Center(
                          child: AppText(
                            text: 'All Orders',
                            size: 18,
                            fw: FontWeight.w800,
                            color: priaryColor,
                          ),
                        ),
                        height: 100,
                        width: 160,
                        margin: EdgeInsets.only(right: 10),
                        decoration: contDecortion,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewPayments(
                                id: widget.id,
                              )));
                    },
                    child: Container(
                      child: Center(
                        child: AppText(
                          text: 'View All Payments',
                          size: 18,
                          fw: FontWeight.w800,
                          color: priaryColor,
                        ),
                      ),
                      height: 100,
                      width: 160,
                      margin: EdgeInsets.only(right: 10),
                      decoration: contDecortion,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewAllFeedbacksSeller(id: widget.id,)));
                      },
                      child: Container(
                        child: Center(
                          child: AppText(
                            text: 'View Feedback',
                            size: 18,
                            fw: FontWeight.w800,
                            color: priaryColor,
                          ),
                        ),
                        height: 100,
                        width: 160,
                        margin: EdgeInsets.only(right: 10),
                        decoration: contDecortion,
                      ),
                    ),
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => ComplaintsPage()));
                  //   },
                  //   child: Container(
                  //     child: Center(
                  //       child: AppText(
                  //         text: 'View Complaints',
                  //         size: 18,
                  //         fw: FontWeight.w800,
                  //         color: priaryColor,
                  //       ),
                  //     ),
                  //     height: 100,
                  //     width: 160,
                  //     margin: EdgeInsets.only(right: 10),
                  //     decoration: contDecortion,
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
