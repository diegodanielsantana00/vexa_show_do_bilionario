// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:vexa_show_do_bilionario/Areas/Loja/Controller/loja_controller.dart';
import 'package:vexa_show_do_bilionario/Areas/Loja/Models/Pix.dart';
import 'package:vexa_show_do_bilionario/Areas/Loja/Models/Produto.dart';
import 'package:vexa_show_do_bilionario/Common/GlobalFunctions.dart';
import 'package:vexa_show_do_bilionario/Common/SQLiteHelper.dart';

class LojaWidgets {
  TextEditingController emailController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  LojaController lojaController = LojaController();

  Widget containerProdutosLoja(BuildContext context, String produto, int preco) {
    return GestureDetector(
      onTap: () async {
        await lojaController.comprarVidaExtra(context);
        RestartScreenHotRestart(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: getSize(context).width * 0.9,
          height: 50,
          decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(20)), color: Colors.blue.withOpacity(0.1)),
          child: Padding(
            padding: const EdgeInsets.all(9.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.heart_broken,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        produto,
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.money,
                      color: Colors.amber,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        preco.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget pagamentosPendentes() {
    return FutureBuilder<List<Pix>>(
      future: DatabaseHelper().getPix(),
      builder: (BuildContext context, AsyncSnapshot<List<Pix>> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          if (snapshot.data!.isNotEmpty) {
            return Column(
              children: [
                titulo("Pix pendentes"),
                for(int i = 0; i < snapshot.data!.length; i++)
                GestureDetector(
      onTap: () async {
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: getSize(context).width * 0.9,
          height: 50,
          decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(20)), color: Colors.blue.withOpacity(0.1)),
          child: Padding(
            padding: const EdgeInsets.all(9.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.lock_clock_outlined,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        snapshot.data![i].status.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "PIX 1",
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    )
              ],
            );
          }

          return SizedBox();
        } else if (snapshot.hasError) {
          children = <Widget>[
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Error: ${snapshot.error}'),
            )
          ];
        } else {
          children = const <Widget>[
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(),
            ),
          ];
        }
        return Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          ),
        );
      },
    );
  }

  Widget containerProdutosLojaDinheiroReal(BuildContext context, Produto produto) {
    return GestureDetector(
      onTap: () async {
        DadosModal(context, produto);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: getSize(context).width * 0.9,
          height: 50,
          decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(20)), color: Colors.blue.withOpacity(0.1)),
          child: Padding(
            padding: const EdgeInsets.all(9.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        produto.nome,
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "R\$ " + produto.preco.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dinheiroGratis(BuildContext context) {
    return GestureDetector(
      onTap: () {
        lojaController.loadAd(context);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
          width: getSize(context).width * 0.7,
          height: 50,
          decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(20)), color: Colors.blue.withOpacity(0.1)),
          child: Padding(
            padding: const EdgeInsets.all(9.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Obtenha 250 moedas grátis",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget titulo(String titulo) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            titulo,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  DadosModal(BuildContext context, Produto produto) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Stack(
              // overflow: Overflow.visible,
              children: <Widget>[
                Positioned(
                  right: -30.0,
                  top: -40.0,
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.close),
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
                Form(
                  //key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          autofocus: true,
                          keyboardType: TextInputType.text,
                          autocorrect: true,
                          textCapitalization: TextCapitalization.none,
                          cursorColor: const Color.fromARGB(255, 1, 2, 85),
                          decoration: const InputDecoration(border: InputBorder.none, hintText: "Seu nome"),
                          controller: nomeController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            textAlign: TextAlign.start,
                            autofocus: true,
                            keyboardType: TextInputType.text,
                            autocorrect: true,
                            textCapitalization: TextCapitalization.none,
                            cursorColor: const Color.fromARGB(255, 1, 2, 85),
                            decoration: const InputDecoration(border: InputBorder.none, hintText: "Seu email"),
                            controller: emailController,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            textAlign: TextAlign.start,
                            autofocus: true,
                            keyboardType: TextInputType.text,
                            autocorrect: true,
                            textCapitalization: TextCapitalization.none,
                            cursorColor: Color.fromARGB(255, 1, 2, 85),
                            decoration: const InputDecoration(border: InputBorder.none, hintText: "Seu CPF"),
                            controller: cpfController,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () async {
                            DialogShowAwait(context);
                            try {
                              //String token = await GenerateToken();
                              // MercadoPago repMercadoPagoAPI = MercadoPago(MercadoPagoAPI);
                              // MercadoPagoPayment paymentComplete = await repMercadoPagoAPI.PaymentPix(
                              //     amount: produto.preco,
                              //     name: nomeController.text,
                              //     email: emailController.text,
                              //     docNumber: cpfController.text,
                              //     description: 'SWB SHOW DO BILHÃO ${produto.nome} - ${emailController.text.replaceAll('@', '').replaceAll('.', '').replaceAll('com', '')} ');
                              Pix newUser =
                                  Pix(email: emailController.text, pix_date: DateTime.now().add(const Duration(minutes: 65)), pix_qrcode: "paymentComplete.qrCode", paymentID: "123", status: "P");
                              await DatabaseHelper().insertDatabase('pix', newUser);
                              //NavigatorController().navigatorToNoReturn(context, ShowPixScreen(DateTime.now().add(Duration(minutes: 60)), token, paymentComplete));
                            } catch (e) {
                              throw e;
                              Future.delayed(const Duration(seconds: 1), () {
                                Navigator.pop(context);
                                AwesomeDialog(
                                  context: context,
                                  animType: AnimType.scale,
                                  dialogType: DialogType.error,
                                  body: const Center(
                                    child: Text(
                                      'Verifique seus dados e tente novamente',
                                      style: TextStyle(fontStyle: FontStyle.italic),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  btnOkOnPress: () {},
                                ).show();
                              });
                            }
                          },
                          child: Container(
                            width: getSize(context).width * 0.5,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey[900],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Pagar pix", style: TextStyle(color: Colors.white, fontSize: 18.0)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
