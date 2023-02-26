import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:regalo/common/loginpage.dart';
import 'package:regalo/constants/colors.dart';
import 'package:regalo/constants/decorations.dart';
import 'package:regalo/utilities/apptext.dart';
import 'package:regalo/utilities/headerwidget.dart';
import 'package:uuid/uuid.dart';

class AddProductsPage extends StatefulWidget {
  String?id;
   AddProductsPage({Key? key,this.id}) : super(key: key);

  @override
  State<AddProductsPage> createState() => _AddProductsPageState();
}

class _AddProductsPageState extends State<AddProductsPage> {
  // Imgage picker

  final ImagePicker _picker = ImagePicker(); // For pick Image
  XFile? _image; // For accept Null:-?

  var imageurl;

  String? _category;
  List<String> categories = ["Scrapbooks", "Frames", "Hamper", "Bouquet"];
  TextEditingController productNamecontroller = TextEditingController();
  TextEditingController productIDcontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController offerscontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();

  //unique id

  var uuid = Uuid();

  var productId;

  @override
  void initState() {
    productId = uuid.v1();
    super.initState();
  }

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
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: "Add Products",
                  size: 18,
                  fw: FontWeight.w800,
                  color: priaryColor,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: productNamecontroller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "All Fields are mandatory";
                    }
                  },
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink, width: 3)),
                      hintText: 'Product Name'),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: productIDcontroller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "All Fields are mandatory";
                    }
                  },
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink, width: 3)),
                      hintText: 'Product ID'),
                ),
                SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField(
                  items: categories.map((String category) {
                    return new DropdownMenuItem<String>(
                        value: category,
                        child: Row(
                          children: <Widget>[
                            Text(category),
                          ],
                        ));
                  }).toList(),
                  onChanged: (String?newValue) {
                    // do other stuff with _category
                    setState(() => _category = newValue);
                  },
                  value: _category,
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink, width: 3)),
                      hintText: 'Category'),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: pricecontroller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "All Fields are mandatory";
                    }
                  },
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink, width: 3)),
                      hintText: 'Price'),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: offerscontroller,
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink, width: 3)),
                      hintText: 'Offers'),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: descriptioncontroller,
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink, width: 3)),
                      hintText: 'Description'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: GestureDetector(
                    onTap: () {
                      showimage();
                    },
                    child: Container(
                      height: 150,
                      width: 150,
                      color: Colors.transparent,
                      child: _image != null
                          ? ClipRRect(
                              child: Image.file(
                              File(_image!.path),
                              fit: BoxFit.cover,
                            ))
                          : Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // CircleAvatar(
                                  //   radius: 45.0,
                                  //   backgroundImage: NetworkImage(widget.imgurl),
                                  //   backgroundColor: Colors.transparent,
                                  // ),

                                  Icon(
                                    Icons.upload_file,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      if (formkey.currentState!.validate()) {
                        if (_category != null) {
                          String fileName = DateTime.now().toString();
                          var ref = FirebaseStorage.instance
                              .ref()
                              .child("products/$fileName");
                          UploadTask uploadTask =
                              ref.putFile(File(_image!.path));

                          uploadTask.then((res) async {
                            imageurl = (await ref.getDownloadURL()).toString();
                          }).then((value) {
                            FirebaseFirestore.instance
                                .collection('products')
                                .doc(productId)
                                .set({
                              'productId': productId,
                              'sellerid':widget.id,
                              'description': descriptioncontroller.text,
                              'productName': productNamecontroller.text,
                              'productCode': productIDcontroller.text,
                              'category': _category,
                              'price': pricecontroller.text,
                              'offer': offerscontroller.text,
                              'status': 1,
                              'createdat': DateTime.now(),
                              'productImage': imageurl
                            }).then((value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Product Added")));
                              Navigator.pop(context);
                            });
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Select a Category")));
                        }
                      }
                    },
                    child: Container(
                      height: 48,
                      width: 250,
                      decoration: BoxDecoration(
                          color: priaryColor,
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                        child: Text(
                          "Add Product",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showimage() {
    showModalBottomSheet(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return Container(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Ink(
                        decoration: ShapeDecoration(
                          color: Colors.pink,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          onPressed: () {
                            _imagefromcamera();
                          },
                          icon: Icon(Icons.camera_alt_rounded,
                              color: Colors.white),
                          iconSize: 20,
                          splashRadius: 40,
                        ),
                      ),
                      Text("Camera"),
                    ],
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Column(
                    children: [
                      Ink(
                        decoration: ShapeDecoration(
                          color: Colors.purple,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          onPressed: () {
                            _imagefromgallery();
                          },
                          icon: Icon(Icons.photo),
                          color: Colors.white,
                          iconSize: 20,
                          splashRadius: 40,
                        ),
                      ),
                      Text("Gallery"),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

// add these function at the bottom of the extended class
  _imagefromgallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  _imagefromcamera() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = photo;
    });
  }
}
