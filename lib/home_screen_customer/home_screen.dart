import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_optician/common/navgation_fun.dart';
import 'package:smart_optician/styles/colors.dart';

import 'components/Product_detail_screen/product_detail.dart';
import 'components/drawer/custom_drawer.dart';

class HomeScreenCustomer extends StatefulWidget {
  const HomeScreenCustomer({Key? key}) : super(key: key);

  @override
  _HomeScreenCustomerState createState() => _HomeScreenCustomerState();
}

class _HomeScreenCustomerState extends State<HomeScreenCustomer> {
  final globalKey = GlobalKey<ScaffoldState>();
  String? gender = 'Glasses';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      key: globalKey,
      endDrawer: CustomDrawer(),
      backgroundColor: AppConstants().backGroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: size.width,
              height: 50,
              decoration:
                  BoxDecoration(color: AppConstants().primaryColorCustomer),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: size.width * 0.1,
                  ),
                  DropdownButton<String>(
                    dropdownColor: AppConstants().primaryColorCustomer,
                    value: gender,
                    hint: Text(
                      'Glasses type',
                      style: GoogleFonts.cabin(
                        color: Colors.white,
                      ),
                    ),
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.white,
                    ),
                    items: <String>['Glasses', 'Goggles', 'Lens']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: GoogleFonts.cabin(
                            color: Colors.white,
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
                  IconButton(
                    onPressed: () {
                      globalKey.currentState!.openEndDrawer();
                    },
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: size.width,
              height: size.height * 0.91,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(gender ?? 'data')
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              screenPush(
                                  context,
                                  ProductDetailScreen(
                                    brand: snapshot.data.docs[index]['brand'],
                                    gender: snapshot.data.docs[index]['gender'],
                                    image: snapshot.data.docs[index]['image'],
                                    price: snapshot.data.docs[index]['price'],
                                    ownerId: snapshot.data.docs[index]
                                        ['ownerId'],
                                    productId: snapshot.data.docs[index]
                                        ['productId'],
                                  ));
                            },
                            child: Container(
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Image.network(
                                        snapshot.data.docs[index]['image']),
                                    width: size.width * 0.8,
                                    height: size.height * 0.16,
                                    padding: EdgeInsets.all(20),
                                  ),
                                  Container(
                                    width: size.width,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Brand:",
                                              style: TextStyle(
                                                  fontSize: size.width * 0.04,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              " ${snapshot.data.docs[index]['brand']}",
                                              style: TextStyle(
                                                fontSize: size.width * 0.04,
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
                                    width: size.width,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Price:",
                                              style: TextStyle(
                                                  fontSize: size.width * 0.04,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              " ${snapshot.data.docs[index]['price']}",
                                              style: TextStyle(
                                                fontSize: size.width * 0.04,
                                              ),
                                            ),
                                          ],
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
                                        )
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            )
          ],
        ),
      ),
    ));
  }
}
