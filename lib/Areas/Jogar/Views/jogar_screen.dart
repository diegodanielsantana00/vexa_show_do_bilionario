// ignore_for_file: use_build_context_synchronously

import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:vexa_show_do_bilionario/Areas/Home/Models/Perguntas.dart';
import 'package:vexa_show_do_bilionario/Areas/Home/Models/User.dart';
import 'package:vexa_show_do_bilionario/Areas/Home/Views/home_screen.dart';
import 'package:vexa_show_do_bilionario/Areas/Home/Widgets/home_widgets.dart';
import 'package:vexa_show_do_bilionario/Areas/Jogar/Controller/jogar_controller.dart';
import 'package:vexa_show_do_bilionario/Areas/Jogar/Widgets/jogar_widgets.dart';
import 'package:vexa_show_do_bilionario/Areas/Loja/Widgets/loja_widgets.dart';
import 'package:vexa_show_do_bilionario/Common/Perguntas.dart';
import 'package:vexa_show_do_bilionario/Common/SQLiteHelper.dart';
import 'package:vexa_show_do_bilionario/routes_private.dart';

class JogarScreen extends StatefulWidget {
  JogarScreen({super.key});

  @override
  State<JogarScreen> createState() => _JogarScreenState();
}

class _JogarScreenState extends State<JogarScreen> {
  HomeWidgets homeWidgets = HomeWidgets();
  LojaWidgets lojaWidgets = LojaWidgets();
  BannerAd? bannerAd;
  JogarWidgets jogarWidgets = JogarWidgets();
  late bool retirarDois;
  late bool universitarios;
  late bool estatistica;
  late bool passarPergunta;
  JogarController? jogarController;

  @override
  void initState() {
    retirarDois = true;
    universitarios = true;
    estatistica = true;
    passarPergunta = true;
    jogarController = JogarController();
    jogarController!.sortearPergunta();
    jogarController!.musicaFundo();
    createBannerAd();
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () async {
            List<User> vidaExtra = await DatabaseHelper().getUser();
            jogarWidgets.modalFinalizacaoJogo(context, moneyLevel[jogarController!.moneyLevel], jogarController!.moneyLevel, vidaExtra[0].qtd_vida??0, jogarController!);
          },
          icon: const Icon(
            Icons.cancel_outlined,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              jogarWidgets.perguntaContainer(context, jogarController!.perguntaAtual.pergunta, jogarController!.moneyLevel, jogarController!.nextMoneyLevel),
              jogarWidgets.universitariosDica(context, jogarController!.stringUniversitarios, jogarController!.boolUniversitarios),
              jogarWidgets.estatisticaDica(context, jogarController!.listStringEstatisca, jogarController!.boolEstatistica),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        if (retirarDois) {
                          jogarController!.eliminarDuasRespostas();
                          setState(() {
                            retirarDois = false;
                          });
                        }
                      },
                      child: jogarWidgets.botaoAjudaContainer(context, Icons.looks_two, retirarDois)),
                  GestureDetector(
                      onTap: () {
                        if (universitarios) {
                          jogarController!.chamarUniversitarios(context);
                          setState(() {
                            universitarios = false;
                          });
                        }
                      },
                      child: jogarWidgets.botaoAjudaContainer(context, Icons.accessibility_new_outlined, universitarios)),
                  GestureDetector(
                      onTap: () {
                        if (estatistica) {
                          jogarController!.mostrarEstatistica(context);
                          setState(() {
                            estatistica = false;
                          });
                        }
                      },
                      child: jogarWidgets.botaoAjudaContainer(context, Icons.stacked_bar_chart, estatistica)),
                  GestureDetector(
                      onTap: () {
                        if (passarPergunta) {
                          jogarController!.passarPergunta(context);
                          setState(() {
                            passarPergunta = false;
                          });
                        }
                      },
                      child: jogarWidgets.botaoAjudaContainer(context, Icons.shortcut_rounded, passarPergunta)),
                ],
              ),
              for (int i = 0; i < jogarController!.perguntaAtual.respostas.length; i++)
                jogarWidgets.respostaContainer(context, jogarController!.perguntaAtual.respostas[i], jogarController!.perguntaAtual.indexResposta == i, jogarController!, i),
            ],
          ),
        ),
      ),
                  bottomNavigationBar: bannerAd == null /*|| widget.premium*/
          ? null
          : Container(
              margin: const EdgeInsets.only(bottom: 30),
              height: 52,
              child: AdWidget(ad: bannerAd!),)
    );
  }
}
