import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:regalo/constants/colors.dart';
import 'package:regalo/constants/decorations.dart';
import 'package:regalo/utilities/apptext.dart';
import 'package:regalo/utilities/headerwidget.dart';


class ViewAllCategory extends StatefulWidget {

  String?title;
  String?id;
  bool? fromstore;

  ViewAllCategory({Key? key,this.title,this.id,this.fromstore=false}) : super(key: key);

  @override
  State<ViewAllCategory> createState() => _ViewAllCategoryState();
}

class _ViewAllCategoryState extends State<ViewAllCategory> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
              AppText(text: 'Gift to your loved ones',color: priaryColor,size: 18,fw: FontWeight.bold,),
              
              Container(
                
                height: 700,
               // color: Colors.red,
                child:StreamBuilder<QuerySnapshot>(
                  stream: widget.fromstore==false?FirebaseFirestore.instance.collection('products').where('category',isEqualTo:widget.title).snapshots()

                  :FirebaseFirestore.instance.collection('products').where('category',isEqualTo: widget.title.toString()).where('sellerid',isEqualTo: widget.id.toString()).snapshots(),

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
