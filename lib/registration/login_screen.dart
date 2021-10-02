import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_optician/common/functions.dart';
import 'package:smart_optician/common/navgation_fun.dart';
import 'package:smart_optician/firebase_interaction/auth.dart';
import 'package:smart_optician/registration/sign_up.dart';
import 'package:smart_optician/styles/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  int? roleValue;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                Text(
                  "Smart Optician",
                  style: GoogleFonts.courgette(
                      color: AppConstants().primaryColorCustomer,
                      fontSize: size.width * 0.09),
                ),
                SizedBox(
                  height: size.height * 0.06,
                ),
                Text(
                  "Sign in",
                  style: GoogleFonts.cabin(
                      color: Colors.black,
                      fontSize: size.width * 0.07,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.02),
                  width: size.width * 0.8,
                  child: TextField(
                    autofocus: false,
                    controller: _controllerEmail,
                    decoration: const InputDecoration(
                      hintText: "Enter your email",
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.02),
                  width: size.width * 0.8,
                  child: TextField(
                    autofocus: false,
                    controller: _controllerPassword,
                    decoration: const InputDecoration(
                      hintText: "Enter your password",
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                      top: size.height * 0.02, bottom: size.height * 0.025),
                  width: size.width * 0.87,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Select role",
                        style: GoogleFonts.cabin(
                            color: Colors.black,
                            fontSize: size.width * 0.05,
                            fontWeight: FontWeight.w400),
                      ),
                      Row(
                        children: [
                          Text(
                            "Vendor",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: size.width * 0.045,
                            ),
                          ),
                          Radio(
                              value: 0,
                              groupValue: roleValue,
                              onChanged: (value) {
                                setState(() {
                                  roleValue = value as int?;
                                });
                              })
                        ],
                      ),
                      Row(
                        children: [
                          const Text("Customer"),
                          Radio(
                              value: 1,
                              groupValue: roleValue,
                              onChanged: (value) {
                                setState(() {
                                  roleValue = value as int?;
                                });
                              })
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                InkWell(
                  onTap: () {
                    signIn(context);
                  },
                  child: Hero(
                    tag: 'login',
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.05,
                          vertical: size.height * 0.015),
                      color: AppConstants().primaryColorCustomer,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: size.height * 0.02),
                      width: size.width * 0.8,
                      child: Text(
                        "Login",
                        style: GoogleFonts.cabin(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: size.width * 0.045),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    screenPush(context, const SignUp());
                  },
                  child: Hero(
                    tag: 'signup',
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.05,
                          vertical: size.height * 0.015),
                      color: AppConstants().primaryColorCustomer,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: size.height * 0.02),
                      width: size.width * 0.8,
                      child: Text(
                        "Sign Up",
                        style: GoogleFonts.cabin(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: size.width * 0.045),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  signIn(BuildContext context) {
    if (!EmailValidator.validate(_controllerEmail.text.replaceAll(' ', ''))) {
      showSnackBarFailed(context, 'Email is not valid');

      return;
    } else if (_controllerPassword.text.replaceAll(' ', '').length < 5) {
      showSnackBarFailed(context, 'Passsword is short');

      return;
    } else if (roleValue == null) {
      showSnackBarFailed(context, 'please select role first');
    } else {
      AuthOperations().signIn(_controllerEmail.text.replaceAll(' ', ''),
          _controllerPassword.text.replaceAll(' ', ''), roleValue!, context);
    }
  }
}
