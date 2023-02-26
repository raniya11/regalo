import 'package:flutter/material.dart';
import 'package:regalo/common/loginpage.dart';
import 'package:regalo/constants/colors.dart';
import 'package:regalo/constants/decorations.dart';
import 'package:regalo/screens/allcategory.dart';
import 'package:regalo/screens/allstores.dart';
import 'package:regalo/screens/storedetails.dart';
import 'package:regalo/screens/user/addfeedback.dart';
import 'package:regalo/screens/user/userfeedbackview.dart';
import 'package:regalo/utilities/apptext.dart';
import 'package:regalo/utilities/headerwidget.dart';

class UserHomePage extends StatefulWidget {

  String ?name;
  String?email;
  String? id;
  int?status;
UserHomePage({Key? key,this.email,this.id,this.name,this.status}) : super(key: key);

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  List category = ["Scrapbooks", "Frames", "Hamper", "Bouquet"];
  List category_img = [
    "scrapbook.jpg",
    "frames.jpg",
    "hanper.jpg",
    "boquet.jpg"
  ];

  List<Map<String, dynamic>> scrapBook = [
    {"id": 1, "title": "Scrapbook1", 'desc': "Sample Desc"}
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [

            DrawerHeader(child: Row(children: [

              CircleAvatar(
                child: Center(
                  child: Text(widget.name![0].toUpperCase()),
                ),
                
              ),SizedBox(width: 20,),
              AppText(text: widget.name)
            ],)),
            ListTile(
              onTap: (){

                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddFeedBack(id: widget.id,email: widget.email,name: widget.name,)));
              },
              title: Text("Add Feedback"),
            ),
            ListTile(
              onTap: (){

                Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllFeedbacksUser(id: widget.id,)));
              },
              title: Text("View Feedback"),
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: priaryColor,
        //centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              icon: Icon(Icons.login))
        ],
      ),
      body: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Row(
                  children: [
                    HeaderWidget(),
                    SizedBox(
                      width: 14,
                    ),
                    Expanded(
                      child: AppText(
                        text: "WELCOME ${widget.name}",
                        size: 17,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              AppText(
                text: "Recently Viewed",
                size: 18,
                fw: FontWeight.w800,
                color: priaryColor,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  height: 150,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(right: 10),
                          height: 150,
                          width: size.width * 0.75,
                          decoration: contDecortion,
                        );
                      })),
              SizedBox(
                height: 20,
              ),
              AppText(
                text: "Shop By Category",
                size: 18,
                fw: FontWeight.w800,
                color: priaryColor,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  height: 150,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: category.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewAllCategory(
                                        title: category[index])));
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            height: 100,
                            width: size.width * 0.50,
                            decoration: BoxDecoration(
                                color: contColor,
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    scale: 4,
                                    image: AssetImage(

                                        'assets/images/'+category_img[index].toString()),fit: BoxFit.cover
                            )),

                            child:
                                AppText(text: category[index],color: priaryColor,),
                          ),
                        );
                      })),
              SizedBox(
                height: 20,
              ),
              AppText(
                text: "Visit Store",
                size: 18,
                fw: FontWeight.w800,
                color: priaryColor,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: contColor,
                  height: 150,
                  child:

              InkWell(
                onTap: (){


                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewAllStoreCategory(
                    cemail: widget.email,
                      cid: widget.id,
                    cname: widget.name,


                  )));
                },
                child: Center(
                  child:AppText(text: "Stores",size: 20,color: priaryColor,),
                ),
              )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
