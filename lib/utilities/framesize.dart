import 'package:flutter/material.dart';


class FrameSizes extends StatelessWidget {
  const FrameSizes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return     Container(
        height: 50,
        child: Row(
          children: [

            Chip(


                label: Text("A3")),
            Chip(


                label: Text("A3")),
            Chip(


                label: Text("A3")),




          ],
        )
    );
  }
}
