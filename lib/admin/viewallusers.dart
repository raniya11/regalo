import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:regalo/constants/colors.dart';
import 'package:regalo/constants/decorations.dart';
import 'package:regalo/utilities/apptext.dart';
import 'package:regalo/utilities/headerwidget.dart';

class ViewAllUsers extends StatefulWidget {
  const ViewAllUsers({Key? key}) : super(key: key);

  @override
  State<ViewAllUsers> createState() => _ViewAllUsersState();
}

class _ViewAllUsersState extends State<ViewAllUsers> {
  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: priaryColor,
        //centerTitle: true,
        title: Text("All Users"),

      ),
      body: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(text: "Users",fw: FontWeight.bold,color: priaryColor,size: 18,),
              SizedBox(height: 10,),
              Container(
                height: 700,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('users').where('usertype',isEqualTo: 'user').snapshots(),
                  builder: (context,snapshot){
                    if(snapshot.hasData){
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context,index){
                            return Card(
                              child: ListTile(
                                title: Text(snapshot.data!.docs[index]['name']),


                              ),
                            );
                          });

                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
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
