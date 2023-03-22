// ignore_for_file: prefer_const_constructors, non_constant_identifier_names
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:vexa_show_do_bilionario/Areas/Home/Views/home_screen.dart';
import 'package:vexa_show_do_bilionario/Common/Navigator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // final InAppReview inAppReview = InAppReview.instance;
  // AdsController adsController = AdsController();

  @override
  void initState() {
    // TODO: implement initState
    // super.initState();
    // NotificationController notificationController = NotificationController();
    // int id = 0;

    // for (var i = 0; i < lotteryCommon.length; i++) {
    //   for (var j = 0; j < lotteryCommon[i].listWeek.length; j++) {
    //     notificationController.scheduleWeeklyNotificationNoPremium(id, lotteryCommon[i].listWeek[j], lotteryCommon[i].name, "Venha conferir o resultado!");
    //     id++;
    //   }
    // }

    // notificationController.scheduleDailyTenAMNotificationNoPremium(1, 12, Random().nextInt(55) + 1);
    // notificationController.scheduleDailyTenAMNotificationNoPremium(2, 15, Random().nextInt(55) + 1);
    // notificationController.scheduleDailyTenAMNotificationNoPremium(3, 18, Random().nextInt(55) + 1);
  }

  @override
  Widget build(BuildContext context) {
    StartProcess() async {
      try {
        final result = await InternetAddress.lookup('google.com.br');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          Future.delayed(Duration(seconds: 2), () {
            NavigatorController().navigatorToNoReturnNoAnimated(context, HomeScreen());
          });
        } else {
          //NavigatorController().navigatorToNoReturnNoAnimated(context, InternetErrorSplashScreen());
        }
      } on SocketException catch (_) {
        //NavigatorController().navigatorToNoReturnNoAnimated(context, InternetErrorSplashScreen());
      }
    }

    StartProcess();
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 150,
              height: 150,
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
            CircleAvatar(
                radius: 65,
                backgroundColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/logo.png"),
                )),
          ],
        ),
      ),
    );
  }
}