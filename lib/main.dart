// ignore_for_file: prefer_const_constructors
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vexa_show_do_bilionario/Areas/Splash/splash_screen.dart';
import 'package:vexa_show_do_bilionario/Common/Perguntas.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  litaPerguntas.shuffle();

  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen()));
}
