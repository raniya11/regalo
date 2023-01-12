import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:regalo/constants/colors.dart';
import 'package:regalo/constants/decorations.dart';
import 'package:regalo/screens/storedetails.dart';
import 'package:regalo/utilities/apptext.dart';
import 'package:regalo/utilities/headerwidget.dart';


class ViewAllStoreCategory extends StatefulWidget {

  String?title;

  ViewAllStoreCategory({Key? key,this.title,}) : super(key: key);

  @override
  State<ViewAllStoreCategory> createState() => _ViewAllStoreCategoryState();
}

class _ViewAllStoreCategoryState extends State<ViewAllStoreCategory> {

  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
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

              AppText(text: "Stores",fw: FontWeight.bold,color: priaryColor,size: 18,),
              SizedBox(height: 10,),

              Container(

                height: 700,
                // color: Colors.red,
                child:StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('users').where('usertype',isEqualTo: 'seller').snapshots(),

                  builder: (context,snapshot){


                    if(snapshot.hasData){

                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,

                          itemBuilder: (context,index){

                            return Card(
                              child: ListTile(

                                onTap: (){

                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>StoreDetails(
                                    id: snapshot.data!.docs[index]['uid'],



                                  )));

                                }
                                ,
                                // leading: Container(
                                //   child: Image.network(snapshot.data!.docs[index]['name'].toString()),
                                // ),
                                title: Text(snapshot.data!.docs[index]['email']),
                                subtitle: Text(snapshot.data!.docs[index]['phone']),
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
                ),
              )

            ],
          ),
        ),
      ),

    );
  }
}
