import 'package:flutter/material.dart';
import 'package:vexa_show_do_bilionario/Areas/Home/Controller/views_controller.dart';
import 'package:vexa_show_do_bilionario/Areas/Home/Models/User.dart';
import 'package:vexa_show_do_bilionario/Common/GlobalFunctions.dart';
import 'package:share_plus/share_plus.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:vexa_show_do_bilionario/Common/SQLiteHelper.dart';

class HomeWidgets {
  Widget actionMoedasQuantidades() {
    return FutureBuilder<List<User>>(
      future: DatabaseHelper().getUser(),
      builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          return Row(
            children: [
              Icon(
                Icons.money,
                color: Colors.amber,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(snapshot.data![0].money.toString()),
              )
            ],
          );
        } else if (snapshot.hasError) {
          children = <Widget>[
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Error: ${snapshot.error}'),
            )
          ];
        } else {
          children = const <Widget>[
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(),
            ),
          ];
        }
        return Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          ),
        );
      },
    );
  }

  Widget acaoIconsButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {
              Share.share('Estou jogando o jogo do bilhão 💵🤑 -- https://play.google.com/store/apps/details?id=com.danieldiego.vexa_show_do_bilionario');
            },
            icon: const Icon(
              Icons.share,
              color: Colors.white,
            )),
        IconButton(
            onPressed: () async {
              final InAppReview inAppReview = InAppReview.instance;
              if (await inAppReview.isAvailable()) {
                inAppReview.requestReview();
              }
            },
            icon: const Icon(
              Icons.star,
              color: Colors.white,
            )),
        IconButton(
            onPressed: () {
              ViewsController().launchURL('https://bit.ly/3m3fUeO');
            },
            icon: const Icon(
              Icons.telegram_outlined,
              color: Colors.white,
            ))
      ],
    );
  }

  Widget botaoHomeScreen(String titulo, Function() acao, IconData icone) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 300,
        child: ElevatedButton(
          onPressed: acao,
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0))),
          ),
          // padding: const EdgeInsets.all(0.0),
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.blue[900] ?? Colors.blue,
                  Colors.blue[800] ?? Colors.blue,
                ],
              ),
              borderRadius: BorderRadius.all(Radius.circular(80.0)),
            ),
            child: Container(
              constraints: const BoxConstraints(minWidth: 88.0, minHeight: 40.0), // min sizes for Material buttons
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icone),
                  Text(
                    titulo,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget imagemLogoJogoMilhao(BuildContext context) {
    return CircleAvatar(
        radius: getSize(context).width * .35,
        backgroundColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset("assets/logo.png"),
        ));
  }
}
