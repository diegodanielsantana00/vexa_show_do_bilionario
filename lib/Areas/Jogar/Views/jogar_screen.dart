import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:vexa_show_do_bilionario/Areas/Home/Views/home_screen.dart';
import 'package:vexa_show_do_bilionario/Areas/Home/Widgets/home_widgets.dart';
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
//

  @override
  void initState() {
    StartAudio();
    super.initState();
  }

  StartAudio() async {
    widget.audioPlayer.stop();
    widget.audioPlayer = await player.loop("espera_pergunta.mp3");
  }

  @override
  Widget build(BuildContext context) {
    HomeWidgets homeWidgets = HomeWidgets();
    LojaWidgets lojaWidgets = LojaWidgets();
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        //actions: [homeWidgets.actionMoedasQuantidades()],
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
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: getSize(context).width * 0.9,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: getSize(context).width * 0.3,
                        height: 50,
                        color: Colors.amber,
                      ),
                    ],
                  )
                ],
              ),
              //
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: getSize(context).width * 0.2,
                      height: 50,
                      decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: Icon(
                        Icons.unarchive_sharp,
                        color: Colors.white,
                      )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: getSize(context).width * 0.2,
                      height: 50,
                      decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: Icon(
                        Icons.unarchive_sharp,
                        color: Colors.white,
                      )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: getSize(context).width * 0.2,
                      height: 50,
                      decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: Icon(
                        Icons.unarchive_sharp,
                        color: Colors.white,
                      )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: getSize(context).width * 0.2,
                      height: 50,
                      decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: Icon(
                        Icons.unarchive_sharp,
                        color: Colors.white,
                      )),
                    ),
                  ),
                ],
              ),
              Text("Start")
            ],
          ),
        ),
      ),
    );
  }
}
