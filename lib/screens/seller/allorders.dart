import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:regalo/constants/colors.dart';
import 'package:regalo/constants/decorations.dart';
import 'package:regalo/screens/seller/orderdetails.dart';
import 'package:regalo/utilities/apptext.dart';
import 'package:regalo/utilities/headerwidget.dart';

class AllOrders extends StatefulWidget {
  String?sellerid;
  AllOrders({Key? key,this.sellerid}) : super(key: key);

  @override
  State<AllOrders> createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> {
  var id;
  @override
  void initState() {
    id=widget.sellerid;
    print(id);
    // TODO: implement initState
    super.initState();
  }
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
                text: "View All Orders",
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

                      ListView.builder(
                          itemCount: snapshot.data!.docs.length,

                          itemBuilder: (context,index){

                            return InkWell(
                              onTap: (){

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OrderDetailsPage()));
                              },

                              child: Card(
                                child: ListTile(
                                  leading: Container(
                                    child: Image.asset('assets/images/jacket.png'),
                                  ),
                                  title: Text("Hello 2400/"),
                                  subtitle: Text("Description"),
                                  trailing: Icon(Icons.forward,color: priaryColor,),
                                ),
                              ),
                            );
                          });
                    }
                    if(snapshot.hasData&& snapshot.data!.docs.length==0){

                      return Center(
                        child: Text("hello"),
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
