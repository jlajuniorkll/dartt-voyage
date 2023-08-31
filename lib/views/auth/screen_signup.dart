import 'package:dartt_voyage/views/common/cliente_steeper/cliente_steeper.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastre-se'),
          centerTitle: true,
        ),
        body: const Padding(
            padding: EdgeInsets.only(top: 16.0), child: ClienteSteeper()));
  }
}
