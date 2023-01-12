import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:regalo/constants/colors.dart';
import 'package:regalo/constants/decorations.dart';
import 'package:regalo/screens/user/products.dart';
import 'package:regalo/utilities/apptext.dart';
import 'package:regalo/utilities/headerwidget.dart';
import 'package:regalo/screens/allcategory.dart';
import 'package:regalo/screens/allstores.dart';

class StoreDetails extends StatefulWidget {
  String? title;
  String? id;

  StoreDetails({Key? key, this.title, this.id}) : super(key: key);

  @override
  State<StoreDetails> createState() => _StoreDetailsState();
}

class _StoreDetailsState extends State<StoreDetails> {
  List category = ["Scrapbooks", "Frames", "Hamper", "Bouquet"];
  List category_img = [
    "scrapbook.jpg",
    "frames.jpg",
    "hanper.jpg",
    "boquet.jpg"
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: priaryColor,
        //centerTitle: true,
        title: Text(widget.title.toString()),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: "Gift Store",
                fw: FontWeight.bold,
                color: priaryColor,
                size: 22,
              ),
              SizedBox(
                height: 10,
              ),
              AppText(
                text: "View all Category",
                fw: FontWeight.bold,
                color: priaryColor,
                size: 18,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  height: 180,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: category.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewAllCategory(
                                        fromstore: true,
                                        id: widget.id,
                                        title: category[index])));
                          },
                          child: Card(
                            elevation: 5.0,
                            child: Container(
                              //margin: EdgeInsets.only(right: 10),
                              height: 150,
                              //color: Colors.red,
                              child: Stack(
                                children: [
                                  Container(
                                    height: 100,
                                    width: size.width * 0.50,
                                    decoration: BoxDecoration(
                                        color: contColor,
                                        //borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,

                                            image: AssetImage(

                                               'assets/images/'+category_img[index].toString()))),
                                  ),
                                  Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                          height: 52,
                                          width: size.width * 0.50,
                                          color: Colors.teal,
                                          child: Center(
                                              child: AppText(
                                                  text: category[index])))),
                                ],
                              ),
                            ),
                          ),
                        );
                      })),
              SizedBox(
                height: 10,
              ),
              AppText(
                text: "All Products",
                color: priaryColor,
                size: 18,
                fw: FontWeight.bold,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  height: 700,
                  // color: Colors.red,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('products')
                        .where('sellerid', isEqualTo: widget.id.toString())
                        .snapshots(),
                    builder: (_, snapshot) {
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductsPage(
                                      price: snapshot.data!.docs[index]
                                          ['price'],
                                      name: snapshot.data!.docs[index]
                                          ['productName'],
                                      imgurl: snapshot.data!.docs[index]
                                          ['productImage'],
                                      offers: snapshot.data!.docs[index]
                                          ['offer'],
                                      description: snapshot.data!.docs[index]
                                          ['description'],
                                      sellerid: snapshot.data!.docs[index]
                                          ['sellerid'],
                                      productid: snapshot.data!.docs[index]
                                          ['productId'],
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                child: ListTile(
                                  leading: Container(
                                    child: Image.network(snapshot
                                        .data!.docs[index]['productImage']
                                        .toString()),
                                  ),
                                  title: Text(snapshot.data!.docs[index]
                                      ['productName']),
                                  subtitle: Text("Description"),
                                  trailing: Icon(
                                    Icons.forward,
                                    color: priaryColor,
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
