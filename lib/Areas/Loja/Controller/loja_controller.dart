// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:vexa_show_do_bilionario/Areas/Home/Models/User.dart';
import 'package:vexa_show_do_bilionario/Common/SQLiteHelper.dart';

class LojaController {
  Future<void> comprarVidaExtra(BuildContext context) async {
    List<User> aux = await DatabaseHelper().getUser();
    if (aux[0].money! >= 1500) {
      await DatabaseHelper().UpdateVidaExtra();
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        headerAnimationLoop: true,
        animType: AnimType.bottomSlide,
        title: 'INFO Reversed',
        reverseBtnOrder: true,
        btnOkOnPress: () {},
        btnCancelOnPress: () {},
        desc:
            'Lorem ipsum dolor sit amet consectetur adipiscing elit eget ornare tempus, vestibulum sagittis rhoncus felis hendrerit lectus ultricies duis vel, id morbi cum ultrices tellus metus dis ut donec. Ut sagittis viverra venenatis eget euismod faucibus odio ligula phasellus,',
      ).show();
    }
  }
}
