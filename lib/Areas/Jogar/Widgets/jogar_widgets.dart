import 'package:flutter/material.dart';
import 'package:vexa_show_do_bilionario/Areas/Jogar/Controller/jogar_controller.dart';
import 'package:vexa_show_do_bilionario/Common/GlobalFunctions.dart';
import 'package:vexa_show_do_bilionario/Common/Perguntas.dart';

class JogarWidgets {
  Widget perguntaContainer(BuildContext context, String pergunta, int moneyInt, int moneyProximo) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: getSize(context).width * 0.9,
                height: 150,
                decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      pergunta,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 17),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 36.0, right: 36.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: getSize(context).width * 0.3,
                height: 40,
                decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(20)),
                child: Center(
                    child: Column(
                  children: [
                    const Text(
                      "Errar",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      moneyLevel[moneyInt].toString(),
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                  ],
                )),
              ),
              Container(
                width: getSize(context).width * 0.3,
                height: 40,
                decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(20)),
                child: Center(
                    child: Column(
                  children: [
                    const Text(
                      "Acertar",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      moneyLevel[moneyProximo].toString(),
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                  ],
                )),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget botaoAjudaContainer(BuildContext context, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: getSize(context).width * 0.2,
        height: 50,
        decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
        child: Center(
            child: Icon(
          icon,
          color: Colors.white,
        )),
      ),
    );
  }

  Widget respostaContainer(BuildContext context, String resposta, bool certa, JogarController jogarController) {
    return GestureDetector(
      onTap: () {
        if(certa){
          jogarController.acertouPergunta(context);
        }else{
          jogarController.errouPergunta(context);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          width: getSize(context).width * 0.9,
          height: 60,
          decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
          child: Center(
              child: Text(
            resposta,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          )),
        ),
      ),
    );
  }
}
