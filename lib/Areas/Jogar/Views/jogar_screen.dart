import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:vexa_show_do_bilionario/Areas/Home/Models/Perguntas.dart';
import 'package:vexa_show_do_bilionario/Areas/Home/Views/home_screen.dart';
import 'package:vexa_show_do_bilionario/Areas/Home/Widgets/home_widgets.dart';
import 'package:vexa_show_do_bilionario/Areas/Jogar/Controller/jogar_controller.dart';
import 'package:vexa_show_do_bilionario/Areas/Jogar/Widgets/jogar_widgets.dart';
import 'package:vexa_show_do_bilionario/Areas/Loja/Widgets/loja_widgets.dart';
import 'package:vexa_show_do_bilionario/Common/GlobalFunctions.dart';
import 'package:vexa_show_do_bilionario/Common/Navigator.dart';

class JogarScreen extends StatefulWidget {
  AudioPlayer audioPlayer;
  JogarScreen(this.audioPlayer, {super.key});

  @override
  State<JogarScreen> createState() => _JogarScreenState();
}

class _JogarScreenState extends State<JogarScreen> {
  final player = AudioCache();
  HomeWidgets homeWidgets = HomeWidgets();
  LojaWidgets lojaWidgets = LojaWidgets();
  JogarWidgets jogarWidgets = JogarWidgets();
  JogarController? jogarController;

  @override
  void initState() {
    StartAudio();
    jogarController = JogarController(widget.audioPlayer);
    jogarController!.sortearPergunta();
    super.initState();
  }

  StartAudio() async {
    widget.audioPlayer.stop();
    widget.audioPlayer = await player.loop("espera_pergunta.wav");
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
          onPressed: () {
            widget.audioPlayer.stop();
            NavigatorController().navigatorToNoReturnNoAnimated(context, HomeScreen());
          },
          icon: Icon(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  jogarWidgets.botaoAjudaContainer(context, Icons.looks_two),
                  jogarWidgets.botaoAjudaContainer(context, Icons.accessibility_new_outlined),
                  jogarWidgets.botaoAjudaContainer(context, Icons.stacked_bar_chart),
                  jogarWidgets.botaoAjudaContainer(context, Icons.shortcut_rounded),
                ],
              ),
              for (int i = 0; i < jogarController!.perguntaAtual.respostas.length; i++)
                jogarWidgets.respostaContainer(context, jogarController!.perguntaAtual.respostas[i], jogarController!.perguntaAtual.indexResposta == i, jogarController!, i),
            ],
          ),
        ),
      ),
    );
  }
}
