// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:unique_identifier/unique_identifier.dart';
import 'package:vexa_show_do_bilionario/Areas/Home/Models/User.dart';
import 'package:vexa_show_do_bilionario/Areas/Loja/Models/Produto.dart';
import 'package:vexa_show_do_bilionario/Areas/Splash/splash_screen.dart';
import 'package:vexa_show_do_bilionario/Common/ConnectionContext.dart';
import 'package:vexa_show_do_bilionario/Common/GlobalFunctions.dart';
import 'package:vexa_show_do_bilionario/Common/Navigator.dart';
import 'package:vexa_show_do_bilionario/Common/SQLiteHelper.dart';
import 'package:vexa_show_do_bilionario/routes_private.dart';

class LojaController {
  RewardedAd? _rewardedAd;

  void loadAd(BuildContext context) {
    DialogShowAwait(context);
    RewardedAd.load(
        adUnitId: Recompesa,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) {
            NavigatorController().navigatorBack(context);
            _rewardedAd = ad;
            mostrarRecompesaAnuncio(context);
          },
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('RewardedAd failed to load: $error');
          },
        ));
  }

  Future<void> comprarPremium(
    BuildContext context,
    Produto produto,
  ) async {
    switch (produto.id) {
      case 1:
        break;
      case 2:
        DatabaseHelper().UpdateMoney(250);
        break;
      case 3:
        DatabaseHelper().UpdateMoney(600);
        break;
      case 4:
        DatabaseHelper().UpdateMoney(1000);
        break;
      case 5:
        DatabaseHelper().UpdateMoney(5000);
        break;
      case 6:
        DatabaseHelper().UpdateMoney(10000);
        break;
      default:
    }
    await ConectionContext().ConsultSQLString("INSERT INTO vexa.transation(price, application, hour, date, imei) VALUES (${produto.preco}, 'SWB', '${DateFormat('Hm').format(DateTime.now())}', '${DateFormat('y').format(DateTime.now())}-${DateFormat('M').format(DateTime.now())}-${DateFormat('d').format(DateTime.now())}' , '${await UniqueIdentifier.serial}');");
    await DatabaseHelper().UpdatePix(produto.id);
    NavigatorController().navigatorToNoReturn(context, const SplashScreen());
  }

  void mostrarRecompesaAnuncio(BuildContext context) {
    _rewardedAd!.show(onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
      DatabaseHelper().UpdateMoney(250);
      RestartScreenHotRestart(context);
    });
  }

  Future<void> comprarVidaExtra(BuildContext context) async {
    List<User> aux = await DatabaseHelper().getUser();
    if (aux[0].money! >= 1500) {
      await DatabaseHelper().UpdateVidaExtra(true);
      FlameAudio.play("compra.mp3");
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        headerAnimationLoop: true,
        animType: AnimType.bottomSlide,
        title: 'VIDA EXTRA',
        autoHide: const Duration(seconds: 1),
        reverseBtnOrder: true,
        // btnOkOnPress: () {},
        // btnCancelOnPress: () {},
        desc: 'Compra feita.',
      ).show();
    }
  }
}
