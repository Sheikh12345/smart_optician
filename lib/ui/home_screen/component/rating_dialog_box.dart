import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:smart_optician/common_function/snackbar.dart';

class CustomDialogBox extends StatefulWidget {
  final String? docId;
  final String? collectionName;
  const CustomDialogBox(
      {Key? key, required this.docId, required this.collectionName})
      : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  String rating = '';
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * 0.33,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40), color: Colors.white),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: 10,
              ),
            ],
          ),
          Text(
            "Rate this place",
            style: TextStyle(
              color: Colors.black,
              fontSize: size.width * 0.065,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
              margin: EdgeInsets.only(
                  top: size.height * 0.03, left: size.width * 0.03),
              width: size.width,
              child: RatingBar.builder(
                initialRating: 3,
                itemSize: size.width * 0.09,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.green,
                ),
                onRatingUpdate: (rat) {
                  setState(() {
                    rating = rat.toString();
                  });
                },
              )),
          SizedBox(
            height: size.height * 0.03,
          ),
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'Write your review',
            ),
          ),
          InkWell(
            onTap: () {
              if (rating.isNotEmpty) {
                FirebaseFirestore.instance
                    .collection(widget.collectionName.toString())
                    .doc(widget.docId)
                    .collection('productReviews')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .set({
                  'rating': rating,
                  'comment': _controller.text
                }).whenComplete(() {
                  Navigator.pop(context);
                });
              } else {
                showSnackBarFailed(context, 'Rating and comment is required');
              }
            },
            child: Container(
              margin: EdgeInsets.only(top: size.height * 0.034),
              alignment: Alignment.center,
              width: size.width * 0.65,
              height: size.height * 0.06,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.black),
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
