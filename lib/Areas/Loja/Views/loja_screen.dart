import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:vexa_show_do_bilionario/Areas/Home/Widgets/home_widgets.dart';
import 'package:vexa_show_do_bilionario/Areas/Loja/Widgets/loja_widgets.dart';
import 'package:vexa_show_do_bilionario/Common/Navigator.dart';

class LojaScreen extends StatefulWidget {
  const LojaScreen({super.key});

  @override
  State<LojaScreen> createState() => _LojaScreenState();
}

class _LojaScreenState extends State<LojaScreen> {
  @override
  Widget build(BuildContext context) {
    HomeWidgets homeWidgets = HomeWidgets();
    LojaWidgets lojaWidgets = LojaWidgets();
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        actions: [homeWidgets.actionMoedasQuantidades()],
        automaticallyImplyLeading: false,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => NavigatorController().navigatorBack(context),
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              lojaWidgets.titulo("Produtos"),
              lojaWidgets.containerProdutosLoja(context, "Vida Extra", 450),
              lojaWidgets.titulo("Assista e ganhe"),
              lojaWidgets.dinheiroGratis(context),
              ],
          ),
        ),
      ),
    );
  }
}
