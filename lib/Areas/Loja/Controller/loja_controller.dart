// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:vexa_show_do_bilionario/Areas/Home/Models/User.dart';
import 'package:vexa_show_do_bilionario/Common/SQLiteHelper.dart';

class LojaController {
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
