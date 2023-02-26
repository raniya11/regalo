

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:regalo/common/loginpage.dart';
import 'package:regalo/constants/colors.dart';
import 'package:regalo/constants/decorations.dart';
import 'package:regalo/utilities/apptext.dart';
import 'package:regalo/utilities/headerwidget.dart';


class ProductDetailsPage extends StatefulWidget {
  String?id;
 ProductDetailsPage({Key? key,this.id}) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: priaryColor,
        //centerTitle: true,
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
                text: "View All Products",
                size: 18,
                fw: FontWeight.w800,
                color: priaryColor,
              ),
              SizedBox(
                height: 10,
              ),
              Container(

                height: 700,
                // color: Colors.red,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('products').where('sellerid',isEqualTo:widget.id ).snapshots(),

                  builder: (context,snapshot){


                    if(snapshot.hasData){

                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,

                          itemBuilder: (context,index){

                            return Card(
                              child: ListTile(
                                leading: Container(
                                  child: Image.network(snapshot.data!.docs[index]['productImage'].toString()),
                                ),
                                title: Text(snapshot.data!.docs[index]['productName']),
                                subtitle: Text(snapshot.data!.docs[index]['productCode']),
                                trailing: Icon(Icons.forward,color: priaryColor,),
                              ),
                            );
                          });
                    }

                    if(snapshot.hasError){

                      return Center(
                        child: Text("Some Error occured"),
                      );
                    }

                    if(snapshot.hasData && snapshot.data!.docs.length==0){


                      return Center(
                        child: Text("No Products Found"),
                      );
                    }

                    return Center(
                      child: CircularProgressIndicator(),
                    );

                  },
                )
              )
            ],
          ),
        ),

      ),
    );
  }
}

