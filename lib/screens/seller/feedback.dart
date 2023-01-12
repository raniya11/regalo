import 'package:flutter/material.dart';
import 'package:regalo/constants/colors.dart';
import 'package:regalo/constants/decorations.dart';
import 'package:regalo/screens/seller/orderdetails.dart';
import 'package:regalo/utilities/apptext.dart';
import 'package:regalo/utilities/headerwidget.dart';
class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
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
                text: "Feedback",
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

                      return Card(
                        child: ListTile(
                          leading: Container(
                            child: Image.asset('assets/images/jacket.png'),
                          ),
                          title: Text("Hello 2400/"),
                          subtitle: Text("Description"),
                          trailing: Icon(Icons.forward,color: priaryColor,),
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
