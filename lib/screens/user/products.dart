import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:regalo/constants/colors.dart';
import 'package:regalo/constants/decorations.dart';
import 'package:regalo/screens/storedetails.dart';
import 'package:regalo/utilities/apptext.dart';
import 'package:regalo/utilities/framesize.dart';
import 'package:regalo/utilities/headerwidget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uuid/uuid.dart';

class ProductsPage extends StatefulWidget {
  String? name;
  String? imgurl;
  String? description;
  String? productid;
  String? price;
  String? offers;
  String? sellerid;
  String? code;

  ProductsPage(
      {Key? key,
      this.name,
      this.imgurl,
      this.code,
      this.description,
      this.offers,
      this.price,
      this.productid,
      this.sellerid})
      : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  var item;
  List cart = [];

  List itemSize = ["5x7", "6x8", "12 x12"];
  var uuid = Uuid();
  var bookingid;
  @override
  void initState() {
    bookingid = uuid.v1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Badge(
            badgeContent: Text(cart.length.toString()),
            position: const BadgePosition(start: 30, bottom: 30),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: widget.imgurl == null ? Colors.transparent : priaryColor,
                height: size.height / 2,
                child: Stack(
                  children: [
                    Container(
                        padding: EdgeInsets.all(10),
                        height: size.height / 2,
                        width: MediaQuery.of(context).size.width,
                        child: widget.imgurl == null
                            ? Image.network(
                                widget.imgurl.toString(),
                                fit: BoxFit.contain,
                              )
                            : SizedBox(
                                width: 200.0,
                                height: 100.0,
                              )),
                    Positioned(
                        bottom: 30,
                        left: 20,
                        child: Container(
                          child: AppText(
                            text: widget.name.toString(),
                            color: Colors.white,
                            size: 30,
                            fw: FontWeight.bold,
                          ),
                        ))
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: 'Description',
                        size: 20,
                        fw: FontWeight.bold,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          height: 250,
                          child: Text(widget.description.toString())),
                      AppText(
                        text: 'Sizes',
                        size: 20,
                        fw: FontWeight.bold,
                      ),
                      FrameSizes(),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              cart.add(widget.productid);
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                color: priaryColor,
                                borderRadius: BorderRadius.circular(12)),
                            child: Center(
                              child: AppText(text: 'Buy Now', size: 15),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
