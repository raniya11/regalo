import 'package:flutter/material.dart';
import 'package:regalo/common/loginpage.dart';
import '../screens/homepage.dart';
import '../screens/allcategory.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(
      Duration(seconds: 8),
        ()=>Navigator.push(
            context, MaterialPageRoute(builder: (context)=>LoginPage()))
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(



      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/logonew.png',scale: 2,),
            RichText(
              text: TextSpan(
                text: 'REG',
                style: TextStyle(color: Colors.deepOrangeAccent,fontSize: 26,fontWeight: FontWeight.bold),
                children: const <TextSpan>[
                  TextSpan(text: 'ALO', style: TextStyle(color: Colors.pinkAccent,fontSize: 26)),
                               ],
              ),
            ),
            SizedBox(height: 20,),
            // ElevatedButton(onPressed: (){
            //   Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
            //
            // }, child: Text("Get Started"),)


          ],
        ),
      ),
    );
  }
}
