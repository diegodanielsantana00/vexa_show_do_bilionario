// ignore_for_file: non_constant_identifier_names, avoid_init_to_null

import 'package:flutter/material.dart';

class NavigatorController {
  navigatorToNoReturn(context, dynamic screen) {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => screen), (Route<dynamic> route) => false);
  }

  Future<dynamic> navigatorToReturn(context, dynamic screen) async {
    dynamic screenResult = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
    return screenResult;
  }

  navigatorToNoReturnNoAnimated(context, dynamic screen) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => screen,
        transitionDuration: Duration.zero,
      ),
    );
  }

  navigatorBack(context) {
    Navigator.of(context).pop();
  }

  Widget ButtonNavigatorBack(BuildContext context, {Function? function = null, bool border = true}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          if (function != null) {
            function();
          }
          NavigatorController().navigatorBack(context);
        },
        child: CircleAvatar(
            radius: 10,
            backgroundColor: border ? const Color.fromRGBO(220, 203, 191, 1) : Colors.transparent,
            child: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Color.fromARGB(255, 85, 58, 1),
              size: 27,
            )),
      ),
    );
  }
}
