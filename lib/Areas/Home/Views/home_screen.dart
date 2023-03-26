import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:vexa_show_do_bilionario/Areas/Home/Widgets/home_widgets.dart';
import 'package:vexa_show_do_bilionario/Areas/Jogar/Views/jogar_screen.dart';
import 'package:vexa_show_do_bilionario/Areas/Loja/Views/loja_screen.dart';
import 'package:vexa_show_do_bilionario/Common/Navigator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    StartAudio();
    super.initState();
  }

  StartAudio() async {
    

  }

  @override
  Widget build(BuildContext context) {
    HomeWidgets homeWidgets = HomeWidgets();

    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        actions: [
          homeWidgets.actionMoedasQuantidades(false),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              homeWidgets.imagemLogoJogoMilhao(context),
              const SizedBox(height: 50),
              homeWidgets.botaoHomeScreen(" Jogar", () {
                //DatabaseHelper().UpdateFimPartida(1000000);
                NavigatorController().navigatorToNoReturnNoAnimated(context, JogarScreen());
              }, Icons.play_arrow_rounded),
              homeWidgets.botaoHomeScreen(" Loja", () {
                NavigatorController().navigatorToReturn(context, LojaScreen());
              }, Icons.store),
              homeWidgets.botaoHomeScreen(" Sair", () {}, Icons.exit_to_app),
              homeWidgets.acaoIconsButton()
            ],
          ),
        ),
      ),
    );
  }
}
