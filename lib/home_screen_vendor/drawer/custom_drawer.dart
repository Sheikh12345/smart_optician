import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_optician/common/navgation_fun.dart';
import 'package:smart_optician/home_screen_customer/components/cart_screen/cart_screen.dart';
import 'package:smart_optician/home_screen_customer/components/chat_screen/chat_screen.dart';
import 'package:smart_optician/home_screen_customer/components/chat_screen/list_of_chat_users.dart';
import 'package:smart_optician/home_screen_customer/components/my_orders/my_orders.dart';
import 'package:smart_optician/home_screen_vendor/my_orders/customer_orders.dart';
import 'package:smart_optician/registration/login_screen.dart';
import 'package:smart_optician/styles/colors.dart';

class CustomDrawerVendor extends StatefulWidget {
  const CustomDrawerVendor({Key? key}) : super(key: key);

  @override
  _CustomDrawerVendorState createState() => _CustomDrawerVendorState();
}

class _CustomDrawerVendorState extends State<CustomDrawerVendor> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: AppConstants().primaryColorVendor,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)),
      ),
      width: size.width * 0.6,
      height: size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          drawerTile(
              size: size,
              text: 'Orders',
              voidCallback: () {
                goBackPreviousScreen(context);
                screenPush(context, BookedOrders());
              }),
          drawerTile(
              size: size,
              text: 'Messages',
              voidCallback: () {
                goBackPreviousScreen(context);
                screenPush(
                    context,
                    ListOfChatUsers(
                      color: AppConstants().primaryColorVendor,
                    ));
              }),
          drawerTile(
              size: size,
              text: 'LogOut',
              voidCallback: () {
                FirebaseAuth.instance.signOut().whenComplete(() {
                  Navigator.pop(context);
                  screenPushRep(context, const LoginScreen());
                });
              }),
        ],
      ),
    );
  }

  drawerTile(
      {required String text,
      required VoidCallback voidCallback,
      required Size size}) {
    return InkWell(
        onTap: voidCallback,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            '$text',
            style: GoogleFonts.cabin(
                color: Colors.white, fontSize: size.width * 0.06),
          ),
        ),
    );
  }
}