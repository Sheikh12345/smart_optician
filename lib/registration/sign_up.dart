import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_optician/common/functions.dart';
import 'package:smart_optician/common/navgation_fun.dart';
import 'package:smart_optician/firebase_interaction/auth.dart';
import 'package:smart_optician/styles/colors.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerfullName = TextEditingController();
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
                "Sign Up",
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
                  controller: _controllerfullName,
                  decoration: const InputDecoration(
                    hintText: "Enter your full name",
                  ),
                ),
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
              SizedBox(
                height: size.height * 0.04,
              ),
              InkWell(
                onTap: () {
                  signUp(context);
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
              InkWell(
                onTap: () {
                  goBackPreviousScreen(context);
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
            ],
          ),
        ),
      ),
    ));
  }

  signUp(BuildContext context) {
    if (_controllerfullName.text.replaceAll(' ', '').length < 3) {
      showSnackBarFailed(context, 'Name is short');
    } else if (!EmailValidator.validate(
        _controllerEmail.text.replaceAll(' ', ''))) {
      showSnackBarFailed(context, 'Email is not valid');
    } else if (_controllerPassword.text.replaceAll(' ', '').length < 4) {
      showSnackBarFailed(context, 'Password is short');

      Fluttertoast.showToast(msg: '', backgroundColor: Colors.red);
    } else {
      AuthOperations().signUp(context, _controllerEmail.text,
          _controllerPassword.text, _controllerfullName.text);
    }
  }

}
