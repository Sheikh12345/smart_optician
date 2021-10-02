import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_optician/common/functions.dart';
import 'package:smart_optician/styles/colors.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerBrand = TextEditingController();
  final TextEditingController _controllerPrice = TextEditingController();
  final TextEditingController _controllerGender = TextEditingController();

  XFile? image;
  bool imageIsSelected = false;
  bool fileIsUploading = false;
  String? gender;

  imagePicker() async {
    final ImagePicker _picker = ImagePicker();
    image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 60);
    if (image != null) {
      imageIsSelected = true;
    }
    setState(() {});
  }

  uploadProduct(BuildContext context) async {
    if (_controllerName.text.length < 3) {
      showSnackBarFailed(context, 'Product name is short');
    } else if (_controllerPrice.text.isEmpty) {
      showSnackBarFailed(context, 'Product price is short');
    } else if (gender == null) {
      showSnackBarFailed(context, 'Please select gender');
    } else if (_controllerBrand.text.isEmpty) {
      showSnackBarFailed(context, 'Product brand name is short');
    } else if (image == null) {
      showSnackBarFailed(context, 'Image is required');
    } else {
      setState(() {
        fileIsUploading = true;
      });
      firebase_storage.Reference obj = firebase_storage.FirebaseStorage.instance
          .ref()
          .child(basename(image!.path));

      obj.putFile(File(image!.path)).whenComplete(() {
        obj.getDownloadURL().then((value) {
          FirebaseFirestore.instance
              .collection(gender!)
              //sender
              .doc()
              .set(
            {
              'productId':_controllerName.text.toString(),
              'brand': _controllerBrand.text.toString(),
              'gender': gender,
              'image': value.toString(),
              'ownerId': FirebaseAuth.instance.currentUser!.uid,
              'price': _controllerPrice.text.toString(),
            },
          ).whenComplete(() {
            Navigator.pop(context);
          });
        });

        setState(() {
          image = null;
          fileIsUploading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppConstants().backGroundColor,
        appBar: AppBar(
          backgroundColor: AppConstants().primaryColorVendor,
          title: const Text("Add new product"),
          centerTitle: true,
        ),
        body: Container(
          width: size.width,
          margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          height: size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.02,
                ),
                TextField(
                  controller: _controllerName,
                  decoration: const InputDecoration(
                    hintText: 'Product name',
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                TextField(
                  controller: _controllerPrice,
                  decoration: const InputDecoration(
                    hintText: 'Product Price',
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                TextField(
                  controller: _controllerBrand,
                  decoration: const InputDecoration(
                    hintText: 'Product Brand',
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                DropdownButton<String>(
                  isExpanded: true,
                  dropdownColor: AppConstants().primaryColorVendor,
                  value: gender,
                  hint: Text(
                    'Select gender',
                    style: GoogleFonts.cabin(
                      color: Colors.black,
                    ),
                  ),
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Colors.black,
                  ),
                  items: <String>['male', 'female'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: GoogleFonts.cabin(
                          color: Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      gender = value;
                    });
                  },
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                image == null
                    ? MaterialButton(
                        color: AppConstants().primaryColorVendor,
                        onPressed: () {
                          imagePicker();
                        },
                        child: Text(
                          "Select Product image",
                          style: GoogleFonts.cabin(color: Colors.white),
                        ),
                      )
                    : Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Image.file(
                          File(image!.path),
                        ),
                      ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: InkWell(
          onTap: fileIsUploading == false
              ? () {
                  uploadProduct(context);
                }
              : null,
          child: Container(
            width: size.width,
            height: size.height * 0.07,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppConstants().primaryColorVendor,
            ),
            margin: EdgeInsets.symmetric(
                horizontal: size.width * 0.09, vertical: size.height * 0.02),
            child: fileIsUploading == false
                ? Text(
                    "Upload product",
                    style: GoogleFonts.cabin(
                      color: Colors.white,
                      fontSize: size.width * 0.05,
                    ),
                  )
                : const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
