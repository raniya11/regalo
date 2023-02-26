import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:regalo/constants/colors.dart';
import 'package:regalo/constants/decorations.dart';
import 'package:regalo/screens/storedetails.dart';
import 'package:regalo/screens/user/shoppingitem.dart';
import 'package:regalo/screens/user/viewcartpage.dart';
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
  String? cname;
  String? cemail;
  String? cid;
  List? item;

  ProductsPage(
      {Key? key,
      this.name,
      this.item,
      this.imgurl,
      this.code,
      this.description,
      this.offers,
      this.price,
      this.productid,
      this.sellerid,
      this.cemail,
      this.cid,
      this.cname})
      : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  var shoppingCart;

  Future<Box<ShoppingItem>> _openShoppingCartBox() async {
    var shoppingCartBox = await Hive.openBox<ShoppingItem>('shopping_cart');
    return shoppingCartBox;
  }

  void addToCart(ShoppingItem item) {
    bool itemExists = false;
    int? itemIndex;
    for (int i = 0; i < shoppingCart.length; i++) {
      ShoppingItem currentItem = shoppingCart.getAt(i);
      if (currentItem.name == item.name) {
        itemExists = true;
        itemIndex = i;
        break;
      }
    }
    if (itemExists) {
      shoppingCart.putAt(itemIndex, item);
    } else {
      shoppingCart.add(item);
    }
  }

  void removeFromCart(int index) {
    shoppingCart.deleteAt(index);
  }

  List<ShoppingItem> getCartItems() {
    return shoppingCart.values.toList();
  }

  List<String>? _items;

  int itemCount = 0;

  void updateItemCount() async {
    var shoppingCartBox = await Hive.openBox<ShoppingItem>('shopping_cart');
    setState(() {
      itemCount = Hive.box<ShoppingItem>('shopping_cart').length;
    });
  }

  var item;
  List cart = [];

  bool? isItemSelected;
  String? selecteditem;
  var uuid = Uuid();
  var bookingid;
  var imgurl;
  int? _selectedItemIndex;
  @override
  void initState() {
    bookingid = uuid.v1();
    imgurl = widget.imgurl;
    print(imgurl);
    _openShoppingCartBox();
    updateItemCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping'),
        actions: <Widget>[
          IconButton(
            icon: SizedBox(),
            onPressed: () {},
          ),
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Badge(
              badgeContent: Text(
                itemCount.toString(),
                style: TextStyle(color: Colors.white),
              ),
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShoppingCartScreen(),
                      ),
                    );
                  },
                  child: Icon(Icons.shopping_cart)),
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
                        child: widget.imgurl != null
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
                          height: 150,
                          child: Text(widget.description.toString())),
                      AppText(
                        text: 'Sizes',
                        size: 20,
                        fw: FontWeight.bold,
                      ),

                      Container(
                        height: 50,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.item!.length,
                          itemBuilder: (context, index) {
                            bool isSelected = _selectedItemIndex == index;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedItemIndex = index;
                                  selecteditem = (widget.item![index]);
                                  print(selecteditem);
                                });
                                // Do something when the chip is selected
                                print('Selected item: ${widget.item![index]}');
                              },
                              child: Chip(
                                label: Text(widget.item![index]),
                                backgroundColor:
                                    isSelected ? Colors.blue : Colors.grey,
                                labelStyle: TextStyle(
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      // Row(
                      //   children: [
                      //     InkWell(
                      //       onTap: () {
                      //         if (_selectedA3 == false && _selectedsize == "") {
                      //           setState(() {
                      //             _selectedsize = "A3";
                      //             _selectedA3 = true;
                      //             _selectedA4 = false;
                      //             _selectedA5 = false;
                      //           });
                      //
                      //           print(_selectedsize);
                      //         } else {
                      //           setState(() {
                      //             _selectedsize = "";
                      //             _selectedA3 = false;
                      //             _selectedA4 = false;
                      //             _selectedA5 = false;
                      //           });
                      //           print(_selectedsize);
                      //         }
                      //       },
                      //       child: Chip(
                      //           backgroundColor: _selectedA3 == true
                      //               ? Colors.green
                      //               : Colors.grey,
                      //           label: Text("A3")),
                      //     ),
                      //     InkWell(
                      //       onTap: () {
                      //         if (_selectedA4 == false && _selectedsize == "") {
                      //           setState(() {
                      //             _selectedsize = "A4";
                      //             _selectedA4 = true;
                      //             _selectedA3 = false;
                      //             _selectedA5 = false;
                      //           });
                      //           print(_selectedsize);
                      //         } else {
                      //           setState(() {
                      //             _selectedsize = "";
                      //             _selectedA4 = false;
                      //             _selectedA3 = false;
                      //             _selectedA5 = false;
                      //           });
                      //           print(_selectedsize);
                      //         }
                      //       },
                      //       child: Chip(
                      //           backgroundColor: _selectedA4 == true
                      //               ? Colors.green
                      //               : Colors.grey,
                      //           label: Text("A4")),
                      //     ),
                      //     InkWell(
                      //       onTap: () {
                      //         if (_selectedA5 == false && _selectedsize == "") {
                      //           setState(() {
                      //             _selectedsize = "A4";
                      //             _selectedA5 = true;
                      //             _selectedA3 = false;
                      //             _selectedA4 = false;
                      //           });
                      //           print(_selectedsize);
                      //         } else {
                      //           setState(() {
                      //             _selectedsize = "";
                      //             _selectedA5 = false;
                      //             _selectedA3 = false;
                      //             _selectedA4 = false;
                      //           });
                      //           print(_selectedsize);
                      //         }
                      //       },
                      //       child: Chip(
                      //           backgroundColor: _selectedA5 == true
                      //               ? Colors.green
                      //               : Colors.grey,
                      //           label: Text("A5")),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      AppText(
                        text: 'Price',
                        size: 20,
                        fw: FontWeight.bold,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Text(widget.price.toString())),
                      SizedBox(
                        height: 10,
                      ),

                      Center(
                        child: InkWell(
                          onTap: () async {

                            print(selecteditem);
                            var shoppingCartBox =
                                await Hive.openBox<ShoppingItem>(
                                    'shopping_cart');
                            shoppingCartBox.add(
                              ShoppingItem(
                                  name: widget.name,
                                  price: double.parse(widget.price.toString()),
                                  id: widget.productid,
                                  size: selecteditem!.toString(),
                                sellerid: widget.sellerid

                              ),

                            );
                            updateItemCount();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Item added to cart'),
                              ),
                            );

                            // FirebaseFirestore.instance
                            //     .collection('orders')
                            //     .doc(bookingid)
                            //     .set({
                            //   'orderid': bookingid,
                            //   'customerid': widget.cid,
                            //   'produtid': widget.productid,
                            //   'producctname': widget.name,
                            //   'selectedsize': _selectedsize,
                            //   'price': widget.price,
                            //   'createdat': DateTime.now(),
                            //   'status': 1,
                            //   'sellerid': widget.sellerid,
                            //   'delistatus': 0
                            // }).then((value) {});
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
