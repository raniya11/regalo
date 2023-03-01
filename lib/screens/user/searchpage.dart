
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:regalo/constants/colors.dart';
import 'package:regalo/screens/user/products.dart';
import 'package:regalo/utilities/apptext.dart';



class SearchPage extends StatefulWidget {
  String?cname;
  String?cemail;
  String?cid;

 SearchPage({Key? key,this.cname,this.cid,this.cemail}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: priaryColor,

        title: AppText(
          text: "Find Products",

        ),


      ),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView( 
            child: Column(
              children: [
                Container(
                  height: 48,
                  padding: EdgeInsets.only(left: 10),
                  margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white30,
                        offset: Offset(0, 1),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: TextField(

                    controller: searchController,

                    cursorColor: priaryColor,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black12,
                      hintText: "Search...",
                      hintStyle: TextStyle(color: Colors.black38),
                      suffixIcon: Icon(
                        Icons.search,
                        color: priaryColor,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height*0.85,
                  padding: EdgeInsets.all(20),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('products').where('status',isEqualTo: 1).where('productName',isEqualTo:searchController.text ).snapshots(),

                    builder: (_,snapshot){
                      if(snapshot.hasData){
                        return ListView.builder(

                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                child: Column(
                                  children: <Widget>[

                                    Align(

                                      alignment: Alignment(1.0,0.0),                              child: Container(
                                      width: MediaQuery.of(context).size.width/2,

                                      height: 30,
                                      //color:snapshot.data!.docs[index]['status']==1? secondaryColor:primaryColor,
                                      child:
                                      Center(child: AppText(text: snapshot.data!.docs[index]['category'],))
                                      ,
                                    ),
                                    ),
                                    ListTile(
                                      leading: Image.network(snapshot.data!.docs[index]['productImage'].toString(),),
                                      title: Text(snapshot.data!.docs[index]['productName']),
                                      subtitle: Text(snapshot.data!.docs[index]['price']),
                                      trailing: IconButton(
                                        onPressed: (){
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ProductsPage(
                                                cname: widget.cname,
                                                cemail: widget.cemail,
                                                cid: widget.cid,
                                                item:snapshot.data!.docs[index]
                                                ['size'],
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
                                        icon: Icon(Icons.details),
                                      ),
                                    ),


                                  ],
                                ),
                              );





                            });
                      }
                      if(snapshot.hasError){

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
      ),
    );
  }
}
