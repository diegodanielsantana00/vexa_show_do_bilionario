// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:vexa_show_do_bilionario/Areas/Home/Models/User.dart';
import 'package:vexa_show_do_bilionario/Areas/Home/Views/home_screen.dart';
import 'package:vexa_show_do_bilionario/Areas/Jogar/Controller/jogar_controller.dart';
import 'package:vexa_show_do_bilionario/Areas/Jogar/Views/jogar_screen.dart';
import 'package:vexa_show_do_bilionario/Common/GlobalFunctions.dart';
import 'package:vexa_show_do_bilionario/Common/Navigator.dart';
import 'package:vexa_show_do_bilionario/Common/Perguntas.dart';
import 'package:vexa_show_do_bilionario/Common/SQLiteHelper.dart';
import 'package:vexa_show_do_bilionario/routes_private.dart';

class JogarWidgets {
  bool disabilitado = false;
  RewardedAd? _rewardedAd;

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
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: getSize(context).width * 0.25,
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
                      moneyLevel[moneyInt - 1 < 0 ? 0 : moneyInt - 1].toString(),
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                  ],
                )),
              ),
              Container(
                width: getSize(context).width * 0.25,
                height: 40,
                decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(20)),
                child: Center(
                    child: Column(
                  children: [
                    const Text(
                      "Sair",
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
                width: getSize(context).width * 0.25,
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

  Widget botaoAjudaContainer(BuildContext context, IconData icon, bool ajudaAtiva) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: getSize(context).width * 0.2,
        height: 50,
        decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
        child: Center(
            child: Icon(
          icon,
          color: ajudaAtiva ? Colors.white : Colors.red[200],
        )),
      ),
    );
  }

  List<Color> colorBotaoAux = [Colors.blue.withOpacity(0.1), Colors.blue.withOpacity(0.1), Colors.blue.withOpacity(0.1), Colors.blue.withOpacity(0.1)];

  Widget respostaContainer(BuildContext context, String resposta, bool certa, JogarController jogarController, int index) {
    return GestureDetector(
      onTap: () async {
        if (!disabilitado) {
          disabilitado = true;
          colorBotaoAux[index] = Colors.amber.withOpacity(0.4);
          RestartScreenHotRestart(context);
          Future.delayed(const Duration(milliseconds: 5350), () async {
            disabilitado = false;
          });
          if (certa) {
            if (jogarController.nextMoneyLevel + 1 != moneyLevel.length) {
              await jogarController.acertouPergunta(context);
              Future.delayed(const Duration(milliseconds: 3500), () async {
                FlameAudio.play('acertou.mp3');
                colorBotaoAux[index] = Colors.green[900]!;
                RestartScreenHotRestart(context);
              });
              Future.delayed(const Duration(milliseconds: 5300), () async {
                colorBotaoAux[index] = Colors.blue.withOpacity(0.1);
                RestartScreenHotRestart(context);
                modalNiveis(context, jogarController.moneyLevel);
                jogarController.musicaFundo();
              });
            } else {
              modalFinalizacaoJogo(context, moneyLevel[jogarController.nextMoneyLevel], jogarController.nextMoneyLevel, -1, jogarController);
            }
          } else {
            await jogarController.errouPergunta(context);
            Future.delayed(const Duration(milliseconds: 2900), () async {
              FlameAudio.play('errou.mp3');
            });
            Future.delayed(const Duration(milliseconds: 3500), () async {
              colorBotaoAux[index] = Colors.red[900]!;
              colorBotaoAux[jogarController.perguntaAtual.indexResposta] = Colors.green[400]!;
              RestartScreenHotRestart(context);
            });
            Future.delayed(const Duration(milliseconds: 5300), () async {
              jogarController.musicaFundo();
              List<User> vidaExtra = await DatabaseHelper().getUser();
              modalFinalizacaoJogo(
                  context, moneyLevel[jogarController.moneyLevel - 1 < 0 ? 0 : jogarController.moneyLevel - 1], jogarController.moneyLevel, vidaExtra[0].qtd_vida ?? 0, jogarController);
            });
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          width: getSize(context).width * 0.9,
          height: 60,
          decoration: BoxDecoration(color: colorBotaoAux[index], borderRadius: BorderRadius.circular(20)),
          child: Center(
              child: Text(
            resposta,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          )),
        ),
      ),
    );
  }

  void modalNiveis(BuildContext context, int monetAtual) {
    showModalBottomSheet(
        backgroundColor: Colors.blueGrey[900],
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        isScrollControlled: true,
        builder: (context) {
          return GestureDetector(
            onTap: () => NavigatorController().navigatorBack(context),
            child: Container(
              padding: EdgeInsets.all(8),
              height: getSize(context).height * 0.8,
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Clique para voltar", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                    ),
                    for (int i = 0; i < moneyLevel.length; i++)
                      i != 0
                          ? Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Container(
                                width: getSize(context).width * .8,
                                height: 50,
                                decoration: BoxDecoration(color: moneyLevel[monetAtual] >= moneyLevel[i] ? Colors.green[900] : Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Nivel $i", style: const TextStyle(color: Colors.white)),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.money,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "  ${moneyLevel[i]}",
                                            style: const TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox()
                  ],
                ),
              ),
            ),
          );
        });
  }

  void modalFinalizacaoJogo(BuildContext context, int indexMoney, int questao, int vidaExtra, JogarController jogarController) {
    DatabaseHelper().UpdateFimPartida(indexMoney);
    bool clickButton = false;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            backgroundColor: Colors.grey[900],
            content: Container(
              width: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "RESUMO DA RODADA",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[400], fontWeight: FontWeight.w700, fontSize: 12),
                    ),
                  ),
                  detalhePartidaResumoMenu("Moedas ganhas", indexMoney.toString()),
                  detalhePartidaResumoMenu("Questões acertadas", questao.toString()),
                  const Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () async {
                        if (vidaExtra > 0) {
                          DatabaseHelper().DesfazerUpdateFimPartida(indexMoney);
                          clickButton = true;
                          jogarController.retornarAoJogo();
                          colorBotaoAux = [Colors.blue.withOpacity(0.1), Colors.blue.withOpacity(0.1), Colors.blue.withOpacity(0.1), Colors.blue.withOpacity(0.1)];
                          DatabaseHelper().UpdateVidaExtra(false);
                          NavigatorController().navigatorBack(context);
                        } else {
                          DialogShowAwait(context);
                          RewardedAd.load(
                              adUnitId: Recompesa,
                              request: const AdRequest(),
                              rewardedAdLoadCallback: RewardedAdLoadCallback(
                                onAdLoaded: (ad) {
                                  NavigatorController().navigatorBack(context);
                                  _rewardedAd = ad;
                                  _rewardedAd!.show(onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
                                    DatabaseHelper().DesfazerUpdateFimPartida(indexMoney);
                                    clickButton = true;
                                    jogarController.retornarAoJogo();
                                    colorBotaoAux = [Colors.blue.withOpacity(0.1), Colors.blue.withOpacity(0.1), Colors.blue.withOpacity(0.1), Colors.blue.withOpacity(0.1)];
                                    NavigatorController().navigatorBack(context);
                                  });
                                },
                                onAdFailedToLoad: (LoadAdError error) {
                                  debugPrint('RewardedAd failed to load: $error');
                                },
                              ));
                        }
                      },
                      child: Container(
                        width: 130,
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(vidaExtra == 0 ? Icons.tv : Icons.heart_broken_sharp, color: Colors.amber),
                                  SizedBox(
                                    width: 170,
                                    child: Text(
                                      vidaExtra == 0 ? " Assista e ganhe uma chance" : " Usar vida extra",
                                      style: TextStyle(color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                vidaExtra.toString(),
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            clickButton = true;
                            NavigatorController().navigatorToNoReturnNoAnimated(context, const HomeScreen());
                          },
                          child: Container(
                            width: 130,
                            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              "Menu",
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        InkWell(
                          onTap: () async {
                            clickButton = true;
                            await FlameAudio.bgm.stop();
                            if (!FlameAudio.bgm.isPlaying && configGlobal.music == "T") {
                              await FlameAudio.bgm.play("espera_pergunta.wav", volume: 0.1);
                            }
                            NavigatorController().navigatorToNoReturnNoAnimated(context, JogarScreen());
                          },
                          child: Container(
                            width: 130,
                            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                            decoration: BoxDecoration(
                              color: Colors.green[900],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              "Jogar Novamente",
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }).then((value) {
      !clickButton ? NavigatorController().navigatorToReturn(context, const HomeScreen()) : null;
      !clickButton ? null : RestartScreenHotRestart(context);
    });
  }

  Widget detalhePartidaResumoMenu(String key, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            key,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[400], fontWeight: FontWeight.w700, fontSize: 12),
          ),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 17),
          ),
        ],
      ),
    );
  }

  Widget universitariosDica(BuildContext context, String stringUniversitarios, bool visible) {
    return Visibility(
      visible: visible,
      child: Container(
        width: getSize(context).width * 0.9,
        height: 60,
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.accessibility_new_outlined,
                  color: Colors.white,
                ),
              ),
              Text(
                stringUniversitarios,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget estatisticaDica(BuildContext context, List<String> porcentagem, bool visible) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Visibility(
        visible: visible,
        child: Container(
          width: getSize(context).width * 0.9,
          height: 120,
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  "Perguntas",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, left: 30.0, right: 30.0, top: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (int i = 0; i < porcentagem.length; i++)
                      Text(
                        "${i + 1}\n\n${porcentagem[i]}%",
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white),
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
