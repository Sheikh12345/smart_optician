import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.7,
      height: size.height,
      decoration: BoxDecoration(color: Colors.black),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            width: size.width * .33,
            height: size.width * 0.33,
            decoration:
                BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          )
        ],
      ),
    );
  }
}
