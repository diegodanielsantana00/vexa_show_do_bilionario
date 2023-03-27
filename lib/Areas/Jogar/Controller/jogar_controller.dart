// ignore_for_file: use_build_context_synchronously

import 'dart:ffi';
import 'dart:math';

import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:vexa_show_do_bilionario/Areas/Home/Models/Perguntas.dart';
import 'package:vexa_show_do_bilionario/Common/GlobalFunctions.dart';
import 'package:vexa_show_do_bilionario/Common/Perguntas.dart';

class JogarController {
  List<int> indexJaSorteados = [];
  int moneyLevel = 0;
  int nextMoneyLevel = 1;
  String stringUniversitarios = "";
  List<String> listStringEstatisca = [];
  bool boolEstatistica = false;
  bool boolUniversitarios = false;
  late Perguntas perguntaAtual;

  Future<void> musicaFundo() async {
    await FlameAudio.bgm.stop();
    if (!FlameAudio.bgm.isPlaying && configGlobal.music == "T") {
      await FlameAudio.bgm.play("espera_pergunta.wav", volume: 0.1);
    }
  }

  void sortearPergunta() {
    int index = Random().nextInt(litaPerguntas.length);
    index = Random().nextInt(litaPerguntas.length);
    while (indexJaSorteados.contains(index)) {
      index = Random().nextInt(litaPerguntas.length);
    }
    indexJaSorteados.add(index);
    perguntaAtual = Perguntas(litaPerguntas[index].pergunta, litaPerguntas[index].respostas, litaPerguntas[index].indexResposta);
  }

  Future<void> acertouPergunta(BuildContext context) async {
    FlameAudio.bgm.stop();
    FlameAudio.play('suspense_espera_resposta.wav');
    Future.delayed(const Duration(milliseconds: 5300), () async {
      boolUniversitarios = false;
      boolEstatistica = false;
      moneyLevel++;
      nextMoneyLevel++;
      sortearPergunta();
    });
  }

  Future<void> errouPergunta(BuildContext context) async {
    FlameAudio.bgm.stop();
    FlameAudio.play('suspense_espera_resposta.wav');
    boolEstatistica = false;
    boolUniversitarios = false;
  }

  void eliminarDuasRespostas() {
    String resposta = perguntaAtual.respostas[perguntaAtual.indexResposta];
    List<String> respostas = [perguntaAtual.respostas[perguntaAtual.indexResposta]];
    int result = Random().nextInt(perguntaAtual.respostas.length - 1);

    while (result == perguntaAtual.indexResposta) {
      result = Random().nextInt(perguntaAtual.respostas.length - 1);
    }
    respostas.add(perguntaAtual.respostas[result]);
    respostas.shuffle();

    for (var i = 0; i < respostas.length; i++) {
      if (resposta == respostas[i]) {
        perguntaAtual.indexResposta = i;
      }
    }

    perguntaAtual.respostas = respostas;
  }

  void chamarUniversitarios(BuildContext context) {
    String resposta = perguntaAtual.respostas[perguntaAtual.indexResposta];
    stringUniversitarios = "Acho que é $resposta";
    boolUniversitarios = true;
    RestartScreenHotRestart(context);
  }

  void passarPergunta(BuildContext context) {
    boolUniversitarios = false;
    boolEstatistica = false;
    sortearPergunta();
    RestartScreenHotRestart(context);
  }

  void mostrarEstatistica(BuildContext context) {
    boolEstatistica = true;
    listStringEstatisca = [];
    int soma = 0;
    for (var i = 0; i < perguntaAtual.respostas.length; i++) {
      int porcetagem = Random().nextInt(15);
      if (i == perguntaAtual.indexResposta) {
        porcetagem = Random().nextInt(100);
        while (porcetagem < 70) {
          porcetagem = Random().nextInt(100);
        }
      }
      soma += porcetagem;
      listStringEstatisca.add(porcetagem.toString());
    }

    if (soma < 0) {
      int resto = 100 - soma;
      listStringEstatisca[perguntaAtual.indexResposta] = (int.parse(listStringEstatisca[perguntaAtual.indexResposta]) + resto).toString();
    } else {
      int resto = soma - 100;
      listStringEstatisca[perguntaAtual.indexResposta] = (int.parse(listStringEstatisca[perguntaAtual.indexResposta]) - resto).toString();
    }

    RestartScreenHotRestart(context);
  }
}
