import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:vexa_show_do_bilionario/Areas/Home/Widgets/home_widgets.dart';
import 'package:vexa_show_do_bilionario/Areas/Jogar/Views/jogar_screen.dart';
import 'package:vexa_show_do_bilionario/Areas/Loja/Views/loja_screen.dart';
import 'package:vexa_show_do_bilionario/Common/Navigator.dart';
import 'package:vexa_show_do_bilionario/Common/Perguntas.dart';
import 'package:vexa_show_do_bilionario/Common/SQLiteHelper.dart';
import 'package:vexa_show_do_bilionario/routes_private.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BannerAd? bannerAd;

  @override
  void initState() {
    StartAudio();
    super.initState();
    // if (!widget.premium) {
    createBannerAd();
    // }
  }

  BannerAdListener listener = BannerAdListener(
      onAdClosed: (ad) => debugPrint('Ad Close'),
      onAdLoaded: (ad) => debugPrint('Ad loaded'),
      onAdOpened: (ad) => debugPrint('Ad Opened'),
      onAdFailedToLoad: (ad, error) {
        ad.dispose();
        debugPrint(error.message.toString());
      });
  createBannerAd() {
    bannerAd = BannerAd(size: AdSize.fullBanner, adUnitId: BannerID, listener: listener, request: const AdRequest())..load();
  }

  StartAudio() async {
    await FlameAudio.bgm.stop();
    if (!FlameAudio.bgm.isPlaying && configGlobal.music == "T") {
      FlameAudio.bgm.play("inicio.mp3", volume: 0.1);
    }
  }

  @override
  Widget build(BuildContext context) {
    HomeWidgets homeWidgets = HomeWidgets();

    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        actions: [
          homeWidgets.actionMoedasQuantidades(false),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              homeWidgets.imagemLogoJogoMilhao(context),
              const SizedBox(height: 50),
              homeWidgets.botaoHomeScreen(" Jogar", () {
                //DatabaseHelper().UpdateFimPartida(1000000);
                NavigatorController().navigatorToNoReturnNoAnimated(context, JogarScreen());
              }, Icons.play_arrow_rounded),
              homeWidgets.botaoHomeScreen(" Loja", () {
                NavigatorController().navigatorToReturn(context, LojaScreen());
              }, Icons.store),
              homeWidgets.botaoHomeScreen(" Sair", () {
                exit(0);
              }, Icons.exit_to_app),
              homeWidgets.acaoIconsButton()
            ],
          ),
        ),
      ),
      bottomNavigationBar: bannerAd == null /*|| widget.premium*/
          ? null
          : Container(
              margin: const EdgeInsets.only(bottom: 30),
              height: 52,
              child: AdWidget(ad: bannerAd!),
            ),
    );
  }
}
