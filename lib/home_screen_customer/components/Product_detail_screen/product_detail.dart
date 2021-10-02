import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_optician/common/functions.dart';
import 'package:smart_optician/common/navgation_fun.dart';
import 'package:smart_optician/home_screen_customer/components/chat_screen/chat_screen.dart';
import 'package:smart_optician/styles/colors.dart';

import 'camera.dart';

class ProductDetailScreen extends StatefulWidget {
  final String image;
  final String price;
  final String brand;
  final String gender;
  final String ownerId;
  final String productId;

  const ProductDetailScreen(
      {Key? key,
      required this.image,
      required this.price,
      required this.brand,
      required this.gender,
      required this.ownerId,
      required this.productId})
      : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppConstants().backGroundColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Details"),
          actions: [
            IconButton(
                onPressed: () {
                  screenPush(
                      context,
                      ChatScreenWithUser(
                        receiverName: "Owner",
                        receiverId: widget.ownerId,
                      ));
                },
                icon: const Icon(Icons.message)),
            IconButton(
                onPressed: () {
                  screenPush(
                      context,
                      CustomCamera(
                        ImageAddres: widget.image,
                      ),
                  );
                },
                icon: const Icon(Icons.camera_alt)),
          ],
        ),
        body: Container(
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: size.height * 0.24,
                  margin: EdgeInsets.only(
                      top: size.height * 0.12,
                      left: size.width * 0.1,
                      right: size.width * 0.1,
                      bottom: size.height * 0.1),
                  child: Image.network(widget.image),
                  width: size.width,
                  padding: EdgeInsets.all(20),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  width: size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.03, vertical: 10),
                  child: Column(
                    children: [
                      Text(
                        'Product details:',
                        style: GoogleFonts.cabin(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: size.width * 0.07,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      Row(
                        children: [
                          Text(
                            "Price:",
                            style: TextStyle(
                                fontSize: size.width * 0.053,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            " ${widget.price}",
                            style: TextStyle(
                              fontSize: size.width * 0.04,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Row(
                        children: [
                          Text(
                            "Brand:",
                            style: TextStyle(
                                fontSize: size.width * 0.053,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            " ${widget.brand}",
                            style: TextStyle(
                              fontSize: size.width * 0.04,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Row(
                        children: [
                          Text(
                            "Gender:",
                            style: TextStyle(
                                fontSize: size.width * 0.053,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            " ${widget.gender}",
                            style: TextStyle(
                              fontSize: size.width * 0.04,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: size.height * 0.05,
                            bottom: size.height * 0.02),
                        width: size.width,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (quantity >= 0) {
                                    quantity = quantity - 1;
                                  }
                                });
                              },
                              child: Container(
                                child: const Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                ),
                                decoration: BoxDecoration(
                                    color: AppConstants().primaryColorCustomer,
                                    borderRadius: BorderRadius.circular(10)),
                                padding: EdgeInsets.all(4),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              quantity.toString(),
                              style: GoogleFonts.cabin(
                                  color: Colors.black,
                                  fontSize: size.width * 0.05),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (quantity >= 0) {
                                    quantity = quantity + 1;
                                  }
                                });
                              },
                              child: Container(
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                decoration: BoxDecoration(
                                    color: AppConstants().primaryColorCustomer,
                                    borderRadius: BorderRadius.circular(10)),
                                padding: EdgeInsets.all(4),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: InkWell(
          onTap: () {
            if (quantity > 0) {
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('cart')
                  .doc()
                  .set({
                'image': widget.image,
                'brand': widget.brand,
                'price': widget.price,
                'gender': widget.gender,
                'quantity': quantity,
                'productId': widget.productId,
                'ownerId': widget.ownerId
              }).whenComplete(() {
                showSnackBarSuccess(context, 'Product added to cart');
                goBackPreviousScreen(context);
              });
            } else {
              showSnackBarFailed(context, 'Quantity should be greater than 0');
            }
          },
          child: Container(
            width: size.width,
            height: size.height * 0.07,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppConstants().primaryColorCustomer,
            ),
            margin: EdgeInsets.symmetric(
                horizontal: size.width * 0.09, vertical: size.height * 0.02),
            child: Text(
              "Add to cart",
              style: GoogleFonts.cabin(
                color: Colors.white,
                fontSize: size.width * 0.05,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
