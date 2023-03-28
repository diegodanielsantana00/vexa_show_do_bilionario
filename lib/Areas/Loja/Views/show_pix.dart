// ignore_for_file: must_be_immutable, non_constant_identifier_names, use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:vexa_show_do_bilionario/Areas/Home/Views/home_screen.dart';
import 'package:vexa_show_do_bilionario/Areas/Loja/Controller/loja_controller.dart';
import 'package:vexa_show_do_bilionario/Areas/Loja/Models/Produto.dart';
import 'package:vexa_show_do_bilionario/Areas/Splash/splash_screen.dart';
import 'package:vexa_show_do_bilionario/Common/GlobalFunctions.dart';
import 'package:vexa_show_do_bilionario/Common/MercadoPagoAPI/MercadoPago.dart';
import 'package:vexa_show_do_bilionario/Common/MercadoPagoAPI/MercadoPagoPayments.dart';
import 'package:vexa_show_do_bilionario/Common/Navigator.dart';
import 'package:vexa_show_do_bilionario/routes_private.dart';

class ShowPixScreen extends StatefulWidget {
  DateTime pixDate;
  MercadoPagoPayment payment;
  Produto produto;
  ShowPixScreen(this.pixDate, this.produto, this.payment, {super.key});

  @override
  State<ShowPixScreen> createState() => _ShowPixScreenState();
}

class _ShowPixScreenState extends State<ShowPixScreen> {
  String dateDuration = DateFormat('Hm').format(DateTime.now().add(const Duration(minutes: 60)));

  DelayRefresg(context) async {
    Future.delayed(const Duration(seconds: 15), () async {
      MercadoPago repMercadoPagoAPI = MercadoPago(MercadoPagoAPI);
      MercadoPagoPayment paymentComplete = await repMercadoPagoAPI.ConsultPayments(idPayments: widget.payment.id.toString());
      if (paymentComplete.status == "approved") {
        DialogShowAwait(context);
        await LojaController().comprarPremium(context, widget.produto);
        //await PremiumContext().InsertToken(widget.token, await getImei(), widget.payment.email!, widget.payment.qrCode ?? "123");
        NavigatorController().navigatorToNoReturn(context, const SplashScreen());
      }
      DelayRefresg(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    DelayRefresg(context);
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              NavigatorController().navigatorToNoReturn(context, const HomeScreen());
            },
            icon: Icon(Icons.arrow_back_ios)),
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        title: const Text(
          "PAGAMENTO PIX",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: QrImage(
                  data: widget.payment.qrCode ?? "123",
                  version: QrVersions.auto,
                  size: 200.0,
                  backgroundColor: Colors.white,
                ),
              ),
              InkWell(
                onTap: () async {
                  await Clipboard.setData(ClipboardData(text: widget.payment.qrCode));
                  AwesomeDialog(
                    context: context,
                    animType: AnimType.scale,
                    dialogType: DialogType.success,
                    autoHide: const Duration(seconds: 1),
                    body: const Center(
                      child: Text(
                        'Código copiado com sucesso',
                        style: TextStyle(fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    btnOkOnPress: () {},
                  ).show();
                },
                child: Container(
                  width: getSize(context).width * 0.4,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Icon(Icons.copy, color: Colors.white),
                        SizedBox(width: 8.0),
                        Text("Copiar código", style: TextStyle(color: Colors.white, fontSize: 13.0)),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Text(
                  "Você tem até ${DateFormat('Hm').format(widget.pixDate.add(const Duration(hours: 19)))} do dia ${DateFormat('d/MM').format(widget.pixDate.add(const Duration(hours: 19)))} para efetuar o pagamento do pix",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: InkWell(
                  onTap: () async {
                    DialogShowAwait(context);
                    MercadoPago repMercadoPagoAPI = MercadoPago(MercadoPagoAPI);
                    MercadoPagoPayment paymentComplete = await repMercadoPagoAPI.ConsultPayments(idPayments: widget.payment.id.toString());
                    if (paymentComplete.status == "approved") {
                      // await PremiumContext().InsertToken(await GenerateToken(), (await UniqueIdentifier.serial).toString(), widget.payment.email!, widget.payment.qrCode ?? "123");
                      // NavigatorController().navigatorToNoReturn(context, SplashScreen());
                    } else {
                      Future.delayed(new Duration(seconds: 1), () {
                        Navigator.pop(context);
                        AwesomeDialog(
                          context: context,
                          animType: AnimType.scale,
                          dialogType: DialogType.error,
                          body: Center(
                            child: Text(
                              'Se você já fez o pagamento aguarde. No máximo 1 minuto estamos validando seu pedido',
                              style: TextStyle(fontStyle: FontStyle.italic),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          btnOkOnPress: () {},
                        )..show();
                      });
                    }
                  },
                  child: Container(
                    width: getSize(context).width * 0.7,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.check, color: Colors.white),
                          SizedBox(width: 8.0),
                          Text("Já efetuei o pagamento", style: TextStyle(color: Colors.white, fontSize: 18.0)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
