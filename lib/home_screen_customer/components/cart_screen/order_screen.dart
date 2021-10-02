import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_optician/common/functions.dart';
import 'package:smart_optician/common/navgation_fun.dart';
import 'package:smart_optician/styles/colors.dart';

class OrderScreen extends StatefulWidget {
  final List<String> list;
  final price;
  final List<String> productIdList;
  final List<String> productOwnerList;
  const OrderScreen(
      {Key? key,
      required this.list,
      required this.price,
      required this.productOwnerList,
        required this.productIdList,
      })
      : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  TextEditingController _controllerAddress = TextEditingController();
  TextEditingController _controllerNumber = TextEditingController();

  String? deliveryMethod;


  @override
  void initState() {
    super.initState();
 print( widget.list[0]);
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppConstants().backGroundColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Order Details"),
        ),
        body: Container(
          width: size.width,
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.03,
                ),
                Text(
                  "Enter delivery details",
                  style: GoogleFonts.cabin(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: size.width * 0.07),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                TextField(
                  controller: _controllerAddress,
                  decoration:
                      const InputDecoration(hintText: "Enter shipping address"),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                TextField(
                  controller: _controllerNumber,
                  decoration: const InputDecoration(hintText: "Phone number"),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Text(
                  'Delivery method',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: size.width * 0.07,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.05),
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            deliveryMethod = 'cashOnDelivery';
                          });
                        },
                        child: Container(
                          child: Text(
                            "Cash on \ndelivery",
                            style: GoogleFonts.cabin(
                                color: Colors.white,
                                fontSize: size.width * 0.08),
                          ),
                          width: size.width * 0.4,
                          height: size.width * 0.4,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: deliveryMethod == 'cashOnDelivery'
                                  ? AppConstants().primaryColorCustomer
                                  : Colors.grey.shade500,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            deliveryMethod = 'stripe';
                          });
                        },
                        child: Container(
                          child: Text(
                            "Stripe ",
                            style: GoogleFonts.cabin(
                                color: Colors.white,
                                fontSize: size.width * 0.08),
                          ),
                          width: size.width * 0.4,
                          height: size.width * 0.4,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: deliveryMethod == 'stripe'
                                  ? AppConstants().primaryColorCustomer
                                  : Colors.grey.shade500,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: InkWell(
          onTap: () async{
            if (_controllerNumber.text.length <= 10) {
              showSnackBarFailed(context, 'Please enter correct phone number');
            } else if (_controllerAddress.text.length <= 6) {
              showSnackBarFailed(context, 'Please enter correct address');
            } else if (deliveryMethod == null) {
              showSnackBarFailed(context, 'Please select delivery address');
            } else {




              for (int i = 0; i < widget.productOwnerList.length; i++) {
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('orders').doc(widget.list[i])
                    .set({
                  'status': 'pending',
                  'address': _controllerAddress.text,
                  'phone': _controllerNumber.text,
                  'deliveryMethod': deliveryMethod,
                  "productId": widget.list,
                  'price': widget.price,
                  'customerId': FirebaseAuth.instance.currentUser!.uid,
                  'ownerId': widget.productOwnerList[i]
                }).whenComplete(()async {
                  await  FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.productOwnerList[i]).collection('bookingOrders').doc(
                      widget.list[i]
                  )
                      .set({
                    'status': 'pending',
                    'address': _controllerAddress.text,
                    'phone': _controllerNumber.text,
                    'deliveryMethod': deliveryMethod,
                    "productId": widget.list,
                    'price': widget.price,
                    'customerId': FirebaseAuth.instance.currentUser!.uid,
                    'ownerId': widget.productOwnerList[i]
                  });
                }).whenComplete((){
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('cart').doc(widget.productIdList[i]).delete();
                });
              }

              goBackPreviousScreen(context);
              goBackPreviousScreen(context);
              showSnackBarSuccess(context, 'Order booked successfully');
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
