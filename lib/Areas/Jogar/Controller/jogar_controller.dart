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
  Perguntas perguntaAtual = litaPerguntas[Random().nextInt(litaPerguntas.length)];

  JogarController(this.audioPlayer);

  void sortearPergunta() {
    int index = Random().nextInt(litaPerguntas.length);
    index = Random().nextInt(litaPerguntas.length);
    indexJaSorteados.add(index);
    perguntaAtual = litaPerguntas[index];
  }

  void acertouPergunta(BuildContext context) async {
    moneyLevel++;
    nextMoneyLevel++;
    AudioCache audioCache = AudioCache();
    audioPlayer = await audioCache.play("suspense_espera_resposta.wav");
    Future.delayed(const Duration(seconds: 3), () async {
      audioPlayer = await audioCache.play("acertou.mp3");
      sortearPergunta();
      RestartScreenHotRestart(context);
    });
  }

  void errouPergunta(BuildContext context) async {
    AudioCache audioCache = AudioCache();
    audioPlayer = await audioCache.play("suspense_espera_resposta.wav");
    Future.delayed(const Duration(seconds: 3), () async {
      audioPlayer = await audioCache.play("errou.mp3");
      RestartScreenHotRestart(context);
    });
  }
}
