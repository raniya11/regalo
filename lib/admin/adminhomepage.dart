import 'package:flutter/material.dart';
import 'package:regalo/admin/viewallsellers.dart';
import 'package:regalo/admin/viewallusers.dart';
import 'package:regalo/common/loginpage.dart';
import 'package:regalo/screens/allcategory.dart';

import 'package:regalo/screens/seller/payments.dart';
import 'package:regalo/utilities/apptext.dart';
import 'package:regalo/utilities/container.dart';
import 'package:regalo/constants/colors.dart';


class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(


        actions: [
          IconButton(
              onPressed: ()  {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                        (route) => false);
              },
              icon: Icon(Icons.logout_sharp))

        ],
        backgroundColor: priaryColor,
      ),

      body: Container(
padding: EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(text: "Admin Dashboard",size: 18,fw: FontWeight.bold,color: priaryColor,),
            SizedBox(height: 20,),
            Row(
              children: [
                InkWell(
                  onTap: (){

                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllSellers()));
                  },
                  child: MyContainer(text: "View All Sellers",
                  ht: 100,width: 160,color: priaryColor,
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: InkWell(
                    onTap: (){

                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllUsers()));
                    },
                    child: MyContainer(text: "View All Users",
                      ht: 100, width:160,color: priaryColor,
                    ),
                  ),
                ),
              ],

            ),
            SizedBox(height: 10,),
            Row(
              children: [
                  InkWell(
                    onTap: (){

                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>FeedbackPage()));
                    },
                    child: MyContainer(text: "View All Feedback",
                      ht: 100,width: 160,color: priaryColor,
                    ),
                  ),

                SizedBox(width: 10,),
                Expanded(
                  child: InkWell(  
                    onTap: (){

                       Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentDetails()));
                    },
                    child: MyContainer(text: "View All Payment",
                      ht: 100,width: 160,color: priaryColor,
                    ),
                  ),
                ),
              ],

            ),

          
          
          ],
        ),
      ),
    );
  }
}
