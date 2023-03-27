// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:vexa_show_do_bilionario/Areas/Home/Models/User.dart';
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

  void mostrarRecompesaAnuncio(BuildContext context) {
    _rewardedAd!.show(onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
      DatabaseHelper().UpdateMoney(250);
      RestartScreenHotRestart(context);
    });
  }

  Future<void> comprarVidaExtra(BuildContext context) async {
    List<User> aux = await DatabaseHelper().getUser();
    if (aux[0].money! >= 1500) {
      await DatabaseHelper().UpdateVidaExtra();
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
