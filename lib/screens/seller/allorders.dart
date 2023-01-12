import 'package:flutter/material.dart';
import 'package:regalo/constants/colors.dart';
import 'package:regalo/constants/decorations.dart';
import 'package:regalo/screens/seller/orderdetails.dart';
import 'package:regalo/utilities/apptext.dart';
import 'package:regalo/utilities/headerwidget.dart';

class AllOrders extends StatefulWidget {
  const AllOrders({Key? key}) : super(key: key);

  @override
  State<AllOrders> createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> {
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
                child: ListView.builder(
                    itemCount: 20,

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
                    }),
              )
            ],
          ),
        ),

      ),
    );
  }
}
