import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_optician/common_function/nav_functions.dart';
import 'package:smart_optician/ui/authentication_screen/signup_screen.dart';
import 'package:smart_optician/ui/home_screen/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      body: Container(
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.07,
              ),
              Container(
                  alignment: Alignment.center,
                  width: size.width * 0.32,
                  height: size.width * 0.32,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 2,
                            spreadRadius: 2,
                            offset: Offset(1, 1))
                      ]),
                  child: Image.asset('assets/images/logo.png')),
              SizedBox(
                height: 10,
              ),
              Text(
                "Login",
                style: GoogleFonts.rubik(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: size.width * 0.05,
                ),
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              Container(
                width: size.width,
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 0.1),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                          hintText: "Enter your email",
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Container(
                width: size.width,
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 0.1),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                          hintText: "Enter your password",
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Container(
                alignment: Alignment.bottomRight,
                width: size.width,
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(),
                child: Text(
                  'Forgot password?',
                  style: GoogleFonts.rubik(
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              InkWell(
                onTap: () {
                  screenPush(context, HomeScreen());
                },
                child: Container(
                  width: size.width * 0.9,
                  height: size.height * 0.07,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Text(
                    'Login',
                    style: GoogleFonts.cabin(
                      color: Colors.white,
                      fontSize: size.width * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  screenPush(context, SignUpScreen());
                },
                child: Container(
                  width: size.width * 0.9,
                  height: size.height * 0.07,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Text(
                    'Sign Up',
                    style: GoogleFonts.cabin(
                      color: Colors.white,
                      fontSize: size.width * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
