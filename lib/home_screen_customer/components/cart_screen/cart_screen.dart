import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_optician/common/functions.dart';
import 'package:smart_optician/common/navgation_fun.dart';
import 'package:smart_optician/styles/colors.dart';

import 'order_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<String> productList = [];
  List<String> productListPrice = [];
  List<String> productOwnerList = [];
  List<String> productIdList = [];

  int price = 0;
  String? ownerId;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppConstants().backGroundColor,
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Cart"),
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('cart')
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                width: size.width,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                height: size.height * 0.22,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade300,
                                        offset: const Offset(1, 1),
                                        blurRadius: 2,
                                        spreadRadius: 2),
                                  ],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Image.network(
                                          snapshot.data.docs[index]['image']),
                                      width: size.width * 0.4,
                                      height: size.height * 0.16,
                                      padding: const EdgeInsets.all(20),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.08,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "Brand:",
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.width * 0.04,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    " ${snapshot.data.docs[index]['brand']}",
                                                    style: TextStyle(
                                                      fontSize:
                                                          size.width * 0.04,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              Text(
                                                "Price:",
                                                style: TextStyle(
                                                    fontSize: size.width * 0.04,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Text(
                                                " ${snapshot.data.docs[index]['price']}",
                                                style: TextStyle(
                                                  fontSize: size.width * 0.04,
                                                ),
                                              ),
                                            ],
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Gender:",
                                              style: TextStyle(
                                                  fontSize: size.width * 0.04,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              " ${snapshot.data.docs[index]['gender']}",
                                              style: TextStyle(
                                                fontSize: size.width * 0.04,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Quantity:",
                                              style: TextStyle(
                                                  fontSize: size.width * 0.04,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              " ${snapshot.data.docs[index]['quantity']}",
                                              style: TextStyle(
                                                fontSize: size.width * 0.04,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .collection('cart')
                                      .doc(snapshot.data.docs[index].id)
                                      .delete();
                                },
                                child: Container(
                                    padding: const EdgeInsets.only(
                                        top: 20, right: 20),
                                    child: const Icon(Icons.delete)),
                              ),
                              Positioned(
                                  bottom: 0,
                                  child: InkWell(
                                    onTap: () {
                                      if (productList.contains(snapshot
                                          .data.docs[index]['productId'])) {
                                        productList.remove(snapshot
                                            .data.docs[index]['productId']);
                                        productListPrice.remove(
                                            snapshot.data.docs[index]['price']);
                                        productOwnerList.remove(snapshot
                                            .data.docs[index]['ownerId']);
                                        productIdList.remove(
                                            snapshot.data.docs[index].id);
                                        price = price -
                                            (int.parse(snapshot.data.docs[index]
                                                    ['price']) *
                                                int.parse(snapshot.data
                                                    .docs[index]['quantity']
                                                    .toString()));
                                      } else {
                                        productList.add(snapshot
                                            .data.docs[index]['productId']);
                                        productListPrice.add(snapshot
                                            .data.docs[index]['productId']);
                                        productOwnerList.add(snapshot
                                            .data.docs[index]['ownerId']);
                                        productIdList
                                            .add(snapshot.data.docs[index].id);
                                        price = price +
                                            (int.parse(snapshot.data.docs[index]
                                                    ['price']) *
                                                int.parse(snapshot.data
                                                    .docs[index]['quantity']
                                                    .toString()));
                                      }
                                      setState(() {});
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          top: 20, right: 20, bottom: 10),
                                      child: productList.contains(snapshot
                                              .data.docs[index]['productId'])
                                          ? const Icon(
                                              Icons.remove,
                                              color: Colors.black,
                                            )
                                          : const Icon(
                                              Icons.add,
                                            ),
                                    ),
                                  ))
                            ],
                          );
                        });
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            Container(
                width: size.width,
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Selected product: ",
                          style: GoogleFonts.cabin(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: size.width * 0.056),
                        ),
                        SizedBox(
                          width: size.width * 0.01,
                        ),
                        Text(
                          "${productList.length}",
                          style: GoogleFonts.cabin(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: size.width * 0.056),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Total price:",
                          style: GoogleFonts.cabin(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: size.width * 0.056),
                        ),
                        SizedBox(
                          width: size.width * 0.01,
                        ),
                        Text(
                          "$price",
                          style: GoogleFonts.cabin(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: size.width * 0.056),
                        ),
                      ],
                    ),
                  ],
                ))
          ],
        ),
        bottomNavigationBar: InkWell(
          onTap: () {
            if (productList.length == 0) {
              showSnackBarFailed(context, 'Please add products');
            } else {
              screenPush(
                  context,
                  OrderScreen(
                      list: productList,
                      price: price,
                      productOwnerList: productOwnerList,
                      productIdList: productIdList));
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
              "Next",
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
