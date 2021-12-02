import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_optician/common_function/nav_functions.dart';
import 'package:smart_optician/ui/cart_screen/cart_screen.dart';

import 'component/drawer.dart';
import 'component/product_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

String? gender;
String? brand;
bool? filteredIsRemoved;
TextEditingController _minPrice = TextEditingController();
TextEditingController _maxPrice = TextEditingController();

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controllerSearch = TextEditingController();
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        key: _globalKey,
        drawer: CustomDrawer(),
        backgroundColor: Colors.white.withOpacity(0.95),
        body: Container(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        // _globalKey.currentState!.openDrawer();
                      },
                      icon: const Icon(Icons.menu)),
                  IconButton(
                    onPressed: () {
                      screenPush(context, CartScreen());
                    },
                    icon: const Icon(Icons.shopping_cart),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: size.width * 0.89,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controllerSearch,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search",
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              suffixIcon: IconButton(
                                icon: const Icon(
                                  Icons.sort,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  showCustomSheet(context);
                                },
                              )),
                        ),
                      ),
                    ],
                  )),
              Container(
                width: size.width,
                margin: EdgeInsets.only(
                    top: size.height * 0.02, left: size.width * 0.05),
                child: Text(
                  "Categories",
                  style: GoogleFonts.rubik(
                    color: Colors.black,
                    fontSize: size.width * 0.05,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        selected = 0;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: size.width * 0.1),
                            width: size.width * 0.2,
                            height: size.height * 0.05,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color:
                                    selected == 0 ? Colors.black : Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Image.asset(
                              'assets/images/glassess.png',
                              color: selected == 0 ? Colors.white : null,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            padding: EdgeInsets.only(left: size.width * 0.076),
                            alignment: Alignment.center,
                            child: Text(
                              'Glasses',
                              style: GoogleFonts.cabin(
                                color: Colors.black,
                                fontSize: size.width * 0.04,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        selected = 1;
                      });
                    },
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: size.width * 0.1),
                          width: size.width * 0.2,
                          height: size.height * 0.05,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color:
                                  selected == 1 ? Colors.black : Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Image.asset(
                            'assets/images/goggles.png',
                            color: selected == 1 ? Colors.white : null,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          padding: EdgeInsets.only(left: size.width * 0.076),
                          alignment: Alignment.center,
                          child: Text(
                            'Goggles',
                            style: GoogleFonts.cabin(
                              color: Colors.black,
                              fontSize: size.width * 0.04,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        selected = 2;
                      });
                    },
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: size.width * 0.1),
                            width: size.width * 0.2,
                            height: size.height * 0.05,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color:
                                    selected == 2 ? Colors.black : Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Image.asset(
                              'assets/images/lens.png',
                              color: selected == 2 ? Colors.white : null,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            padding: EdgeInsets.only(left: size.width * 0.076),
                            alignment: Alignment.center,
                            child: Text(
                              'Lens',
                              style: GoogleFonts.cabin(
                                color: Colors.black,
                                fontSize: size.width * 0.04,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection(selected == 0
                            ? 'Glasses'
                            : selected == 1
                                ? 'Goggles'
                                : selected == 2
                                    ? 'Lens'
                                    : '')
                        .snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return GridView.builder(
                            itemCount: snapshot.data.docs.length ?? 0,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1,
                              crossAxisSpacing: 2,
                              mainAxisSpacing: 10,
                            ),
                            itemBuilder: (context, index) {
                              if (filteredIsRemoved == null
                                  ? true
                                  : (snapshot.data.docs[index]['gender'] ==
                                          gender &&
                                      snapshot.data.docs[index]['brand'] ==
                                          brand &&
                                      int.parse(snapshot
                                              .data.docs[index]['price']
                                              .toString()) >=
                                          int.parse(_minPrice.text) &&
                                      int.parse(snapshot
                                              .data.docs[index]['price']
                                              .toString()) <=
                                          int.parse(_maxPrice.text))) {
                                return InkWell(
                                  onTap: () {
                                    screenPush(
                                        context,
                                        ProductViewScreen(
                                          imageUrl: snapshot.data.docs[index]
                                              ['image'],
                                          price: snapshot.data.docs[index]
                                              ['price'],
                                          name: snapshot.data.docs[index]
                                              ['name'],
                                          gender: snapshot.data.docs[index]
                                              ['gender'],
                                          brandName: snapshot.data.docs[index]
                                              ['brand'],
                                          desc: snapshot.data.docs[index]
                                              ['desc'],
                                          ownerId: snapshot.data.docs[index]
                                              ['ownerId'],
                                          productId: snapshot.data.docs[index]
                                              ['code'],
                                        ));
                                  },
                                  child: Container(
                                    width: size.width * 0.46,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    height: size.height * 0.1,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: size.width * 0.46,
                                          height: size.height * 0.14,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                            image: NetworkImage(snapshot
                                                .data.docs[index]['image']),
                                          )),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 5, bottom: 2),
                                          child: Text(
                                            snapshot.data.docs[index]['name'],
                                            style: GoogleFonts.cabin(
                                              color: Colors.grey.shade700,
                                              fontSize: size.width * 0.05,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5, bottom: 2),
                                          child: Text(
                                            snapshot.data.docs[index]['price'],
                                            style: GoogleFonts.cabin(
                                              color: Colors.black,
                                              fontSize: size.width * 0.05,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            });
                      } else {
                        return const Center();
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  showCustomSheet(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        builder: (context) => BottomSheet());
  }
}

class BottomSheet extends StatefulWidget {
  const BottomSheet({Key? key}) : super(key: key);

  @override
  _BottomSheetState createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * 0.44,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20))),
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Text(
            "Filter",
            style: GoogleFonts.rubik(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: size.width * 0.055),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Text(
                    "Min ",
                    style: GoogleFonts.rubik(
                        fontSize: size.width * 0.044,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5),
                    width: size.width * 0.2,
                    height: size.height * 0.05,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    child: TextField(
                      controller: _minPrice,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: 'Price'),
                    ),
                  )
                ],
              ),
              Text("To"),
              Row(
                children: [
                  Text(
                    "Max ",
                    style: GoogleFonts.rubik(
                        fontSize: size.width * 0.044,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5),
                    width: size.width * 0.2,
                    height: size.height * 0.05,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    child: TextField(
                      controller: _maxPrice,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: 'Price'),
                    ),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Gender:",
                style: GoogleFonts.rubik(
                    color: Colors.black, fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  const Text("Female:"),
                  Radio(
                      value: 'male',
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value as String?;
                        });
                      }),
                ],
              ),
              Row(
                children: [
                  const Text("Male:"),
                  Radio(
                      value: 'female',
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value as String?;
                        });
                      }),
                ],
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Container(
            width: size.width * 0.8,
            child: DropdownButton<String>(
              isExpanded: true,
              value: brand,
              hint: Text("Select brand"),
              items: <String>['rayban', 'Prada', 'Oakla'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  brand = value;
                });
              },
            ),
          ),
          SizedBox(
            height: size.height * 0.04,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    filteredIsRemoved = false;
                    Navigator.pop(context);
                  });
                },
                child: Container(
                  width: size.width * 0.3,
                  height: size.height * 0.05,
                  alignment: Alignment.center,
                  child: Text(
                    'Apply',
                    style: GoogleFonts.rubik(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(4)),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    gender = null;
                    filteredIsRemoved = null;
                    brand = null;
                  });
                  Navigator.pop(context);
                },
                child: Container(
                  width: size.width * 0.3,
                  height: size.height * 0.05,
                  alignment: Alignment.center,
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.rubik(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
