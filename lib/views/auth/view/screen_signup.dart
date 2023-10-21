import 'package:dartt_voyage/models/model_cliente.dart';
import 'package:dartt_voyage/views/common/cliente_steeper/view/cliente_steeper.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SignUpScreen extends StatelessWidget {
  SignUpScreen(
      {super.key,
      required this.title,
      required this.formAdm,
      this.clienteModel});

  String title;
  bool formAdm;
  ClienteModel? clienteModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
        ),
        body: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: ClienteSteeper(
              formAdm: formAdm,
              clienteModel: clienteModel,
            )));
  }
}
