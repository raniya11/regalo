
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:regalo/screens/user/shoppingitem.dart';
import 'package:regalo/utilities/apptext.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:uuid/uuid.dart';

class ShoppingCartScreen extends StatefulWidget {
  List<String>?itemselected;
  String?shopid;
  bool? from;
  ShoppingCartScreen({Key? key, this.itemselected,this.shopid,this.from }) : super(key: key);
  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  var shoppingCart;
  var orderid;
  var uuid = Uuid();

  Future<void> initHive() async {
    await Hive.initFlutter();
    shoppingCart = await Hive.openBox<ShoppingItem>('shopping_cart');
  }

  void addToCart(ShoppingItem item) {
    shoppingCart.add(item);
  }

  void removeFromCart(int index) {
    shoppingCart.deleteAt(index);
  }

  Future<List<ShoppingItem>> getCartItems() {
    print("helo");

    return shoppingCart.values.toList();
  }

  var _total;

  @override
  void initState() {
    super.initState();
    initHive();
    //getdata();
    orderid = uuid.v1();
  }

  @override
  Widget build(BuildContext context) {
    _total = getCartTotal();
    return Scaffold(
        appBar: AppBar(
          title: Text('Shopping Cart'),
        ),
        body: Column(
          children: [
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 2,
              child: FutureBuilder(
                  future: Hive.openBox<ShoppingItem>('shopping_cart'),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else {
                        var shoppingCartBox = Hive.box<ShoppingItem>(
                            'shopping_cart');
                        return ListView.builder(
                          itemCount: shoppingCartBox.length,
                          itemBuilder: (BuildContext context, int index) {
                            final cartItem = shoppingCartBox.getAt(index);

                            return ListTile(
                              isThreeLine: true,
                              title: Text(cartItem!.name.toString()),
                              subtitle: Text("${cartItem.price.toString()} ${cartItem.size.toString()}"),
                              trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  setState(() {
                                    shoppingCartBox.deleteAt(index);
                                  });
                                },
                              ),
                            );
                          },
                        );
                      }
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),

            Container(
              height: 100,
              child: StreamBuilder<double>(
                stream: getCartTotal().asStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return AppText(
                      text: "Cart Total: ${snapshot.data}", size: 22,);
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),
            Container(

                child: InkWell(
                  onTap: () async {
                    var items = await getCartItem();
                    var cattoal = await getCartTotal();
                    print(items);
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>Payment_Page(
                    //   carttotal:cattoal ,
                    //   shoppingItems:  items,
                    //   shopid: widget.shopid,
                    //   items: widget.itemselected,
                    //   from: widget.from,
                    //
      int i=0;              // )));
  for(i=0;i<items.length;i++){

    FirebaseFirestore.instance.collection('orders').doc(orderid).set({

      'orderid':orderid,
      'itemname':items[i]['name'],
      'itemid':items[i]['id'],
      'price':items[i]['price'],
      'size':items[i]['size']

    }).then((value) => print("order placed"));
  }

                  },
                  child: Text("View"),
                )
            )
          ],
        ));
  }


  Future<double> getCartTotal() async {
    var box = await Hive.openBox<ShoppingItem>("shopping_cart");
    _total = 0.0;
    for (var item in box.values) {
      _total += item.price!;
    }

    print("Total is ${_total}");
    return _total;
  }

  Future<List<Map<String, dynamic>>> getCartItem() async {
    var box = await Hive.openBox<ShoppingItem>("shopping_cart");
    var items = box.values.map((item) =>
    {
      "name": item.name,
      "price": item.price,
      "id": item.id,
      "size": item.size ?? "NIL"
    }).toList();

    return items;


    var id, email, name, phone, type;
    getdata() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      id = prefs.getString('uid');
      email = prefs.getString('email');
      phone = prefs.getString('phone');
      name = prefs.getString('name');
      type = prefs.getString('type');


      print(name);
      print(email);
    }
  }
}


