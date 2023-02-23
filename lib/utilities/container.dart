import 'package:flutter/material.dart';
import 'package:regalo/utilities/apptext.dart';


class MyContainer extends StatelessWidget {
  String? text;
  double?ht;
  double?width;
  Color? color;

  MyContainer({Key? key,required this.text,this.ht,this.width,this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      height: ht,
        width: width,
color: color,
      child: Center(child:AppText(text: text,color: Colors.white,size: 16,)),
    );
  }
}
