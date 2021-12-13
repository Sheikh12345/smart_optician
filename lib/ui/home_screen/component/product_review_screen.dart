import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_optician/ui/home_screen/component/rating_dialog_box.dart';

class ProductReviewScreen extends StatefulWidget {
  final String productDocId;
  final String productCategory;
  const ProductReviewScreen(
      {Key? key, required this.productDocId, required this.productCategory})
      : super(key: key);

  @override
  _ProductReviewScreenState createState() => _ProductReviewScreenState();
}

class _ProductReviewScreenState extends State<ProductReviewScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Review",
          style: GoogleFonts.rubik(
              color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(widget.productCategory)
            .doc(widget.productDocId)
            .collection('productReviews')
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(9),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                    width: size.width,
                    height: size.height * 0.16,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 2,
                              spreadRadius: 2,
                              offset: Offset(2, 2)),
                          BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 2,
                              spreadRadius: 2,
                              offset: Offset(-2, -2))
                        ],
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: size.width * 0.96,
                          alignment: Alignment.center,
                          child: Text(
                            "${snapshot.data.docs[index]['comment']}",
                            style: GoogleFonts.rubik(
                                color: Colors.black,
                                fontSize: size.width * 0.05,
                                fontWeight: FontWeight.w500),
                            maxLines: 2,
                          ),
                        ),
                        RatingBarIndicator(
                          rating:
                              double.parse(snapshot.data.docs[index]['rating']),
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.green,
                          ),
                          itemCount: 5,
                          itemSize: size.width * 0.11,
                          direction: Axis.horizontal,
                        ),
                      ],
                    ),
                  );
                });
          } else {
            return Container();
          }
        },
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          showDialogBox(context, widget.productDocId, widget.productCategory);
        },
        child: Container(
          height: 50,
          padding: EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          child: Text(
            "Add review",
            style: GoogleFonts.rubik(color: Colors.white, fontSize: 15),
          ),
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    ));
  }

  showDialogBox(BuildContext context, String? docId, String collectionName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: CustomDialogBox(
            docId: docId,
            collectionName: collectionName,
          ),
          backgroundColor: Colors.white,
        );
      },
    );
  }
}
