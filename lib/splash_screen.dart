import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_optician/home_screen_customer/home_screen.dart';
import 'package:smart_optician/registration/login_screen.dart';
import 'package:smart_optician/styles/colors.dart';

import 'common/navgation_fun.dart';
import 'home_screen_vendor/home_screen.dart';
import 'main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreeState createState() => _SplashScreeState();
}

class _SplashScreeState extends State<SplashScreen> {
  late bool state;
  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title.toString()),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body.toString())],
                  ),
                ),
              );
            });
      }
    });
    state = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (state) {
      setState(() {
        moveToLoginScreen(context);
        state = false;
      });
    }

    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                child: Image.network(
                    'https://www.animatedimages.org/data/media/51/animated-glasses-image-0002.gif')),
            SizedBox(
              height: size.height * 0.03,
            ),
            Container(
              padding: EdgeInsets.only(left: size.width * 0.08),
              width: size.width,
              alignment: Alignment.center,
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Smart Optician',
                    textStyle: GoogleFonts.courgette(
                        letterSpacing: 1,
                        color: AppConstants().primaryColorCustomer,
                        fontWeight: FontWeight.w600,
                        fontSize: size.width * 0.09),
                    speed: const Duration(milliseconds: 150),
                  ),
                ],
                totalRepeatCount: 1,
                pause: const Duration(milliseconds: 600),
                displayFullTextOnTap: false,
                stopPauseOnTap: false,
              ),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
          ],
        ),
      ),
    ));
  }

  moveToLoginScreen(BuildContext context) {
    final storage = GetStorage();

    try {
      Future.delayed(const Duration(seconds: 4), () {
        if (FirebaseAuth.instance.currentUser == null) {
          screenPushRep(context, const LoginScreen());
        } else {
          int value = storage.read('role') ?? 0;

          if (value == 1) {
            screenPushRep(context, const HomeScreenCustomer());
          } else {
            screenPushRep(context, const HomeScreenVendor());
          }
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
