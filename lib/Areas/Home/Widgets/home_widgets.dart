import 'package:flutter/material.dart';
import 'package:vexa_show_do_bilionario/Common/GlobalFunctions.dart';

class HomeWidgets {
  Widget actionMoedasQuantidades() {
    return Row(
      children: const [
        Icon(
          Icons.money,
          color: Colors.amber,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("1000 Moedas"),
        )
      ],
    );
  }

  Widget acaoIconsButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.share,
              color: Colors.white,
            )),
        IconButton(
            onPressed: () {},
            icon: Icon(
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
