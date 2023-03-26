// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:vexa_show_do_bilionario/Areas/Loja/Controller/loja_controller.dart';
import 'package:vexa_show_do_bilionario/Common/GlobalFunctions.dart';

class LojaWidgets {
  LojaController lojaController = LojaController();

  Widget containerProdutosLoja(BuildContext context, String produto, int preco) {
    return GestureDetector(
      onTap: () async {
        await lojaController.comprarVidaExtra(context);
        RestartScreenHotRestart(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: getSize(context).width * 0.9,
          height: 50,
          decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(20)), color: Colors.blue.withOpacity(0.1)),
          child: Padding(
            padding: const EdgeInsets.all(9.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.heart_broken,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        produto,
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.money,
                      color: Colors.amber,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        preco.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dinheiroGratis(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        width: getSize(context).width * 0.7,
        height: 50,
        decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(20)), color: Colors.blue.withOpacity(0.1)),
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Obtenha 250 moedas grátis",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Icon(
                Icons.play_arrow_rounded,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget titulo(String titulo) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            titulo,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
