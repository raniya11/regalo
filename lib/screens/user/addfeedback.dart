import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:regalo/constants/colors.dart';
import 'package:regalo/utilities/apptext.dart';
import 'package:regalo/utilities/container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';



class AddFeedBack extends StatefulWidget {
  String?id;
  String?name;
  String?email;
   AddFeedBack({Key? key,this.id,this.email,this.name}) : super(key: key);

  @override
  State<AddFeedBack> createState() => _AddFeedBackState();
}

class _AddFeedBackState extends State<AddFeedBack> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final notifkey = GlobalKey<FormState>();

// daclare these variables inthe extendedstate class

  var uuid = Uuid();
  var _notid;
  List<String>category=["Store","Common"];
  String?_selectedCategory;
  String ?_store;
  String?_storename;
  String?_storeEmail;
  String?storePhone;
  String? id, email, name, phone;

  @override
  initState() {
    _notid = uuid.v1();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: priaryColor,
        elevation: 0.0,
        title: Text(""
            "Create Feedback"),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: notifkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: "Create New Feedback",
                  size: 18,
                 color: Colors.black87,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: titleController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter a Valid Title";
                    }
                  },

                  decoration: InputDecoration(


                      hintText: "Title"),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: descriptionController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter a Valid Description";
                    }
                  },

                  decoration: InputDecoration(

                      hintText: "Description"),
                ),
                SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField<String>(
                  style: TextStyle(color: Colors.black87),
                  //dropdownColor: primaryColor,
                  decoration: InputDecoration(

                      hintText: "Select Category"),
                  items: category.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    _selectedCategory = newValue;
                  },
                ),
                SizedBox(
                  height: 20,
                ),

                Container(

                  height: 54,
                  width: MediaQuery.of(context).size.width,

                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users').where('usertype',isEqualTo: "seller")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return SizedBox.shrink();
                      }

                      if (snapshot.hasData &&
                          snapshot.data!.docs.length == 0) {
                        return SizedBox.shrink();
                      }
                      if (snapshot.hasData &&
                          snapshot.data!.docs.length != 0) {
                        return DropdownButtonFormField<String>(
                            value: _store,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                                errorStyle:
                                TextStyle(color: Colors.red),
                                hintStyle: TextStyle(color: Colors.black87),
                                //enabledBorder: borderEnabledBorderblck,
                                //focusedBorder: borderfocusedBorderblack,
                                hintText: "Select Seller"),
                            onChanged: (value) => setState(() {
                              _store = value;


                            }),
                            validator: (value) => value == null
                                ? 'field required'
                                : null,
                            items: snapshot.data!.docs
                                .map((DocumentSnapshot document) {

                              return DropdownMenuItem<String>(
                                  value: '${document['name']}/${document['uid']}',
                                  child: Text(
                                      '${document['name']}'));
                            }).toList());
                      }

                      return SizedBox.shrink();
                    },
                  ),
                ),


                SizedBox(
                  height: 20,
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      splitString(_store);
                      if (notifkey.currentState!.validate()) {
                        FirebaseFirestore.instance
                            .collection('feedbackstore')
                            .doc(_notid)
                            .set({
                          'fdid': _notid,
                          'title': titleController.text,
                          'description': descriptionController.text,
                          'category':_selectedCategory,
                          'status': 1,
                          'sellerid':storeid,
                          'sellername':storename,
                          'postedby':widget.name,
                          'userphone':phone,
                          'userid':widget.id,
                          'useremail':widget.email,
                          'createdAt': DateTime.now(),
                          'reply':"",
                          'replystatus':0
                        }).then((value) {
                          Navigator.pop(context);
                        });
                      }
                    },
                   child: MyContainer(
                     color: priaryColor,
                     width: 250,
                     ht: 45,

                     text: "Submit",
                   ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// add these function at the bottom of the extended class
var storeid,storename;

  splitString(String?data){
    String pattern='/';
    List<String>splitString=data!.split(pattern);
    splitString.forEach((part) {
      print(part);
    });

    setState(() {
      storename=splitString[0];
      storeid=splitString[1];

    });

    print(storeid);
    print(storename);

  }



}
