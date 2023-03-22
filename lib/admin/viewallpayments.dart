

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:regalo/common/loginpage.dart';
import 'package:regalo/constants/colors.dart';
import 'package:regalo/constants/decorations.dart';
import 'package:regalo/utilities/apptext.dart';
import 'package:regalo/utilities/headerwidget.dart';


class ViewPaymentsAdmin extends StatefulWidget {
  String?id;
  ViewPaymentsAdmin({Key? key,this.id}) : super(key: key);

  @override
  State<ViewPaymentsAdmin> createState() => _ViewPaymentsAdminState();
}

class _ViewPaymentsAdminState extends State<ViewPaymentsAdmin> {
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
                text: "View All Payments",
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
                    stream: FirebaseFirestore.instance.collection('orders').snapshots(),

                    builder: (context,snapshot){


                      if(snapshot.hasData){

                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,

                            itemBuilder: (context,index){

                              return Card(
                                elevation: 5.0,
                                child: Container(
                                  padding: EdgeInsets.all(20),

                                  width: MediaQuery.of(context).size.width,

                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          AppText(text: "Payment Details",size: 16,fw: FontWeight.bold,),
                                          snapshot.data!.docs[index]['paymentstatus']==1?AppText(text: "Confirmed",size: 16,fw: FontWeight.bold,color: Colors.green,):SizedBox(),
                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      Row(
                                        children: [
                                          AppText(text: 'Item',fw: FontWeight.bold,size: 14,),
                                          AppText(text: ' ${snapshot.data!.docs[index]['itemname']}'),
                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      Row(
                                        children: [
                                          AppText(text: 'Amount Recived',fw: FontWeight.bold,size: 14,),
                                          AppText(text: ' ${snapshot.data!.docs[index]['price']}'),
                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      Row(
                                        children: [
                                          AppText(text: 'Customer Details',fw: FontWeight.bold,size: 14,),
                                          AppText(text: ' ${snapshot.data!.docs[index]['customername']}   ${snapshot.data!.docs[index]['customeremail']}'),
                                        ],
                                      ),


                                    ],
                                  ),
                                ),
                              );



                              Card(
                                child: ListTile(

                                  title: Text(snapshot.data!.docs[index]['itemname']),
                                  subtitle: Text(snapshot.data!.docs[index]['customername']),
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

