import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:regalo/constants/colors.dart';
import 'package:regalo/constants/decorations.dart';
import 'package:regalo/screens/storedetails.dart';
import 'package:regalo/utilities/apptext.dart';
import 'package:regalo/utilities/headerwidget.dart';


class ViewAllSellers extends StatefulWidget {

  String?title;
  String ?cname;
  String?cemail;
  String? cid;


  ViewAllSellers({Key? key,this.title,this.cemail,this.cid,this.cname}) : super(key: key);

  @override
  State<ViewAllSellers> createState() => _ViewAllSellersState();
}

class _ViewAllSellersState extends State<ViewAllSellers> {

  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return Scaffold(

      appBar: AppBar(

        backgroundColor: priaryColor,
        //centerTitle: true,
        title: Text("All Stores"),

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
                                  print(snapshot.data!.docs[index]['name']);

                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>StoreDetails(
                                    id: snapshot.data!.docs[index]['uid'],
                                    title: snapshot.data!.docs[index]['name'],
                                    cid: widget.cid,
                                    cemail: widget.cemail,
                                    cname: widget.cname,
                                    from: "admin",
status: snapshot.data!.docs[index]['status'],


                                  )));

                                },
                                // leading: Container(
                                //   child: Image.network(snapshot.data!.docs[index]['name'].toString()),
                                // ),
                                title: Text(snapshot.data!.docs[index]['email']),
                                subtitle: Text(snapshot.data!.docs[index]['phone']),
                                trailing: snapshot.data!.docs[index]['status']==0?Text("Not Approved",style: TextStyle(color: Colors.red,fontSize: 16),):Text("Approved",style: TextStyle(color: Colors.green,fontSize: 18)),
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
