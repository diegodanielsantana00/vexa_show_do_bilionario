import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:vexa_show_do_bilionario/Areas/Home/Widgets/home_widgets.dart';
import 'package:vexa_show_do_bilionario/Areas/Loja/Controller/loja_controller.dart';
import 'package:vexa_show_do_bilionario/Areas/Loja/Widgets/loja_widgets.dart';
import 'package:vexa_show_do_bilionario/Common/Navigator.dart';
import 'package:vexa_show_do_bilionario/Common/ProdutosGlobal.dart';

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
        actions: [homeWidgets.actionMoedasQuantidades(true)],
        automaticallyImplyLeading: false,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => NavigatorController().navigatorBack(context),
          icon: const Icon(
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
              lojaWidgets.containerProdutosLoja(context, "Vida Extra", 1500),
              lojaWidgets.titulo("Assista e ganhe"),
              lojaWidgets.dinheiroGratis(context),
              lojaWidgets.pagamentosPendentes(),
              lojaWidgets.titulo("Compre e ganhe"),
              for(int i = 0; i < produtosGlobais.length; i++)
              lojaWidgets.containerProdutosLojaDinheiroReal(context, produtosGlobais[i])
              ],
          ),
        ),
      ),
    );
  }
}
