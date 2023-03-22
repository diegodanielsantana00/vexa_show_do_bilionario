// ignore_for_file: use_build_context_synchronously

import 'dart:ffi';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:vexa_show_do_bilionario/Areas/Home/Models/Perguntas.dart';
import 'package:vexa_show_do_bilionario/Common/GlobalFunctions.dart';
import 'package:vexa_show_do_bilionario/Common/Perguntas.dart';

class JogarController {
  List<int> indexJaSorteados = [];
  int moneyLevel = 0;
  int nextMoneyLevel = 1;
  AudioPlayer audioPlayer;
  late Perguntas perguntaAtual;

  JogarController(this.audioPlayer);

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
    AudioCache audioCache = AudioCache();
    audioPlayer = await audioCache.play("suspense_espera_resposta.wav");
    Future.delayed(const Duration(seconds: 2), () async {
      audioPlayer = await audioCache.play("acertou.mp3");
    });
    Future.delayed(const Duration(seconds: 4), () async {
      moneyLevel++;
      nextMoneyLevel++;
      sortearPergunta();
    });
  }

  Future<void> errouPergunta(BuildContext context) async {
    AudioCache audioCache = AudioCache();
    audioPlayer = await audioCache.play("suspense_espera_resposta.wav");
    Future.delayed(const Duration(seconds: 3), () async {
      audioPlayer = await audioCache.play("errou.mp3");
      RestartScreenHotRestart(context);
    });
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
}
