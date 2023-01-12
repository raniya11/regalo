import 'package:flutter/material.dart';
import 'package:regalo/common/loginpage.dart';
import 'package:regalo/constants/colors.dart';
import 'package:regalo/constants/decorations.dart';
import 'package:regalo/utilities/apptext.dart';
import 'package:regalo/utilities/headerwidget.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({Key? key}) : super(key: key);

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
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
                text: "Order Details",
                size: 18,
                fw: FontWeight.w800,
                color: priaryColor,
              ),
              SizedBox(
                height: 10,
              ),

            ],
          ),
        ),

      ),
    );
  }
}
