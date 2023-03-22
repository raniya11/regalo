import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:regalo/common/loginpage.dart';
import 'package:regalo/constants/colors.dart';
import 'package:regalo/constants/decorations.dart';
import 'package:regalo/screens/allcategory.dart';
import 'package:regalo/screens/allstores.dart';
import 'package:regalo/screens/storedetails.dart';
import 'package:regalo/screens/user/addfeedback.dart';
import 'package:regalo/screens/user/searchpage.dart';
import 'package:regalo/screens/user/shoppingitem.dart';
import 'package:regalo/screens/user/userfeedbackview.dart';
import 'package:regalo/screens/user/viewcartpage.dart';
import 'package:regalo/utilities/apptext.dart';
import 'package:regalo/utilities/headerwidget.dart';

class UserHomePage extends StatefulWidget {
  String? name;
  String? email;
  String? id;
  int? status;
  UserHomePage({Key? key, this.email, this.id, this.name, this.status})
      : super(key: key);

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  List category = ["Scrapbooks", "Frames", "Hamper", "Bouquet"];
  List category_img = [
    "scrapbook.jpg",
    "frames.jpg",
    "hanper.jpg",
    "boquet.jpg"
  ];

  List<Map<String, dynamic>> scrapBook = [
    {"id": 1, "title": "Scrapbook1", 'desc': "Sample Desc"}
  ];

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: Drawer(
        backgroundColor: priaryColor,
        child: ListView(
          children: [
            DrawerHeader(
                decoration: BoxDecoration(color: priaryColor),
                child: Row(
                  children: [
                    CircleAvatar(
                      child: Center(
                        child: AppText(
                          text: widget.name![0].toUpperCase(),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    AppText(
                      text: widget.name,
                      color: Colors.white,
                    )
                  ],
                )),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddFeedBack(
                              id: widget.id,
                              email: widget.email,
                              name: widget.name,
                            )));
              },
              title: AppText(
                text: "Add Feedback",
                color: Colors.white,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewAllFeedbacksUser(
                              id: widget.id,
                            )));
              },
              title: AppText(
                text: "View Feedback",
                color: Colors.white,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => false);
              },
              title: AppText(
                text: "Logout",
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: priaryColor,
        //centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: EdgeInsets.only(right: 5, top: 5),
              child: Badge(
                badgeColor: Colors.blue,
                badgeContent: Text(
                  itemCount.toString(),
                  style: TextStyle(color: Colors.white),
                ),
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShoppingCartScreen(
                            cname: widget.name,
                            cemail: widget.email,
                            cid: widget.id,
                          ),
                        ),
                      );
                    },
                    child: Icon(Icons.shopping_cart)),
              ),
            ),
          ),
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
                    Expanded(
                      child: AppText(
                        text: "WELCOME ${widget.name}",
                        size: 17,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchPage(
                  cname: widget.name,

                  cemail: widget.email,
                  cid: widget.id

                  ,) ));            },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 40,

                  decoration: BoxDecoration(   color: Colors.black12,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(text: "Search Products"),
                      Icon(Icons.search)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              AppText(
                text: "Latest Offers",
                size: 18,
                fw: FontWeight.w800,
                color: priaryColor,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 100,
                child: StreamBuilder<QuerySnapshot>(
                  stream:
                      FirebaseFirestore.instance.collection('ads').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(right: 10),
                              height: 100,
                              width: size.width * 0.85,
                              decoration: contDecortion,
                              child: Stack(
                                children: [
                                  Container(
                                    height: 150,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(snapshot
                                                .data!.docs[index]['imgurl']))),
                                  ),
                                  Align(
                                      alignment: Alignment(0.9, -0.6),
                                      child: Container(
                                          width: 150,
                                          child: AppText(
                                            text: snapshot.data!.docs[index]
                                                ['title'],
                                            size: 17,
                                            fw: FontWeight.w700,
                                          ))),
                                  Align(
                                      alignment: Alignment(0.9, -0.2),
                                      child: Container(
                                          width: 150,
                                          child: AppText(
                                            text: snapshot.data!.docs[index]
                                                ['description'],
                                          ))),
                                ],
                              ),
                            );
                          });
                    }
                    if (snapshot!.hasData && snapshot.data!.docs.length == 0) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              AppText(
                text: "Shop By Category",
                size: 18,
                fw: FontWeight.w800,
                color: priaryColor,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  height: 150,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: category.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ViewAllCategory(

                                        cname: widget.name,
                                          cemail: widget.email,
                                          cid: widget.id,
                                          title: category[index])));
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: 100,
                                  width: size.width * 0.50,
                                  decoration: BoxDecoration(
                                      color: contColor,
                                      // borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                          scale: 4,
                                          image: AssetImage('assets/images/' +
                                              category_img[index].toString()),
                                          fit: BoxFit.cover)),
                                ),
                                Container(
                                  height: 30,
                                  width: size.width * 0.50,
                                  color: priaryColor,
                                  child: Center(
                                      child: AppText(
                                    text: category[index],
                                    color: Colors.white,
                                  )),
                                )
                              ],
                            ),
                          ),
                        );
                      })),
              SizedBox(
                height: 20,
              ),
              Center(
                child: AppText(
                  text: "Visit Store",
                  size: 18,
                  fw: FontWeight.w800,
                  color: priaryColor,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewAllStoreCategory(
                                cemail: widget.email,
                                cid: widget.id,
                                cname: widget.name,
                              )));
                },
                child: Center(
                  child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          color: priaryColor, shape: BoxShape.circle),
                      child: Center(
                          child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ))),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              AppText(
                text: "Your Recent Orders",
                size: 18,
                fw: FontWeight.w800,
                color: priaryColor,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 100,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('orders')
                      .where('customerid', isEqualTo: widget.id)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Container(
                                margin: EdgeInsets.only(right: 10),
                                height: 100,
                                width: size.width * 0.65,

                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment(-0.9, 0.0),
                                      child: Container(

                                        decoration: BoxDecoration(

                                        ),
                                        child: CircleAvatar(
                                          child: Text((index + 1).toString()),
                                        ),
                                      ),
                                    ),
                                    Align(
                                        alignment: Alignment(0.9, -0.5),
                                        child: Container(
                                            width: 150,
                                            child: AppText(
                                              text: snapshot.data!.docs[index]
                                                  ['itemname'],
                                              size: 17,
                                              fw: FontWeight.w700,
                                            ))),
                                    Align(
                                        alignment: Alignment(0.9, 0.0),
                                        child: Container(
                                            width: 150,
                                            child: AppText(
                                              text: snapshot.data!.docs[index]
                                                  ['price'].toString(),
                                            ))),
                                    Align(
                                        alignment: Alignment(0.9, 0.5),
                                        child: Container(

                                            width: 150,
                                            child:snapshot.data!.docs[index]
                              ['paymentstatus']==1? AppText(
                                              text: "Paid",color: Colors.green,
                                            ):AppText(text: "Pending"),),),
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                    if (snapshot!.hasData && snapshot.data!.docs.length == 0) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
