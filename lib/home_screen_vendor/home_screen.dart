import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_optician/common/navgation_fun.dart';
import 'package:smart_optician/home_screen_customer/components/Product_detail_screen/product_detail.dart';
import 'package:smart_optician/home_screen_vendor/add_product/add_product_screen.dart';
import 'package:smart_optician/registration/login_screen.dart';
import 'package:smart_optician/styles/colors.dart';

import 'drawer/custom_drawer.dart';

class HomeScreenVendor extends StatefulWidget {
  const HomeScreenVendor({Key? key}) : super(key: key);

  @override
  _HomeScreenVendorState createState() => _HomeScreenVendorState();
}

class _HomeScreenVendorState extends State<HomeScreenVendor> {




  final globalKey = GlobalKey<ScaffoldState>();
  String? gender  = 'Glasses' ;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
          key: globalKey,
          endDrawer: CustomDrawerVendor(),
          backgroundColor: AppConstants().backGroundColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: size.width,
                  height: 50,
                  decoration: BoxDecoration(color: AppConstants().primaryColorVendor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: size.width * 0.1,
                      ),
                      DropdownButton<String>(
                        dropdownColor: AppConstants().primaryColorVendor,
                        value: gender,
                        hint: Text(
                          'Select type',
                          style: GoogleFonts.cabin(
                            color: Colors.white,
                          ),
                        ),
                        icon: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Colors.white,
                        ),
                        items: <String>['Glasses', 'Goggles', 'Lens'].map((String value) {
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
                  height: size.height*0.91,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection(gender ?? 'data')
                        .snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              if(FirebaseAuth.instance.currentUser!.uid !=  snapshot.data.docs[index]['ownerId']){
                                return Container();
                              }else{
                                return InkWell(
                                  onTap: () {
                                    screenPush(
                                        context,
                                        ProductDetailScreen(
                                          brand: snapshot.data.docs[index]['brand'],
                                          gender: snapshot.data.docs[index]['gender'],
                                          image: snapshot.data.docs[index]['image'],
                                          price: snapshot.data.docs[index]['price'],
                                          ownerId: snapshot.data.docs[index]['ownerId'],
                                          productId: snapshot.data.docs[index]['productId'],
                                        ),
                                    );
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
                                    child: Stack(
                                      alignment: Alignment.topRight,
                                      children: [
                                        Column(
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
                                              margin: EdgeInsets.symmetric(horizontal: 10),
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
                                              margin: EdgeInsets.symmetric(horizontal: 10),
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
                                        IconButton(
                                          onPressed: (){
                                            FirebaseFirestore.instance
                                                .collection(gender ?? 'data')
                                                .doc(snapshot.data.docs[index].id)
                                                .delete();
                                          },
                                          icon: const Icon(Icons.delete_forever),
                                        )
                                      ],
                                    )
                                  ),
                                );
                              }

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
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppConstants().primaryColorVendor,
            onPressed: (){
              screenPush(context, AddProduct());
            },
            child: const Icon(Icons.add),
          ),
        ));
  }
}
