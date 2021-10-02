import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_optician/styles/colors.dart';

class BookedOrders extends StatefulWidget {
  const BookedOrders({Key? key}) : super(key: key);

  @override
  _BookedOrdersState createState() => _BookedOrdersState();
}

class _BookedOrdersState extends State<BookedOrders> {

  String? status;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
      backgroundColor: AppConstants().primaryColorVendor,
      title: const Text('New orders',),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('bookingOrders')
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.only(top: size.height * 0.02),
                      width: size.width,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      height: size.height * 0.25,
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
                      child:Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(" Order # ${index + 1}"),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Container(
                                width: size.width,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Row(
                                  children: [
                                    Text(
                                      "Address:",
                                      style: TextStyle(
                                          fontSize: size.width * 0.05,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Container(
                                      width: size.width * 0.65,
                                      child: Text(
                                        " ${snapshot.data.docs[index]['address']}",
                                        style: TextStyle(
                                          fontSize: size.width * 0.04,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: size.width,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Row(
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
                              ),
                              Container(
                                  width: size.width,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Phone number:",
                                        style: TextStyle(
                                            fontSize: size.width * 0.04,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        " ${snapshot.data.docs[index]['phone']}",
                                        style: TextStyle(
                                          fontSize: size.width * 0.04,
                                        ),
                                      ),
                                    ],
                                  )),
                              Container(
                                  width: size.width,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Product count:",
                                        style: TextStyle(
                                            fontSize: size.width * 0.04,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        " ${snapshot.data.docs[index]['productId'].length}",
                                        style: TextStyle(
                                          fontSize: size.width * 0.04,
                                        ),
                                      ),
                                    ],
                                  )),
                              Container(
                                  width: size.width,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Product status:",
                                        style: TextStyle(
                                            fontSize: size.width * 0.04,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        " ${snapshot.data.docs[index]['status']}",
                                        style: TextStyle(
                                          fontSize: size.width * 0.04,
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                          DropdownButton<String>(
                            value: snapshot.data.docs[index]['status'],
                            hint: Text(
                              'Change status',
                              style: GoogleFonts.cabin(
                                color: Colors.black,
                              ),
                            ),
                            icon: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Colors.white,
                            ),
                            items: <String>['pending', 'completed','canceled'].map((String value) {
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
                                changeStatus(value: value.toString(), customerId: snapshot.data.docs[index]['customerId'], productName: snapshot.data.docs[index].id);
                              });
                            },
                          ),
                        ],
                      )
                    );
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    ));
  }


  changeStatus({required String value,required String customerId,required String productName})async{
    await FirebaseFirestore.instance
        .collection('users')
        .doc(customerId)
        .collection('orders').doc(productName)
        .update({
      'status': value,
    }).whenComplete(()async {
      await  FirebaseFirestore.instance
          .collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection(
        'bookingOrders'
      ).doc(productName)
          .update({
        'status': value,
      });
    }).whenComplete((){

    });
  }
}
