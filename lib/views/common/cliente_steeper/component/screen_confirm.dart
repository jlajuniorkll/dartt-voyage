import 'package:dartt_voyage/services/util_services.dart';
import 'package:dartt_voyage/services/validators.dart';
import 'package:dartt_voyage/views/common/cliente_steeper/controller/controller_steeper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmScreen extends StatelessWidget {
  const ConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final utilServices = UtilsServices();
    return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: GetBuilder<ControllerSteeper>(
          builder: (controller) {
            return Form(
              key: controller.formKeyConfirm,
              child: Column(
                children: [
                  TextFormField(
                    onSaved: ((newValue) =>
                        controller.cliente.fone = newValue!),
                    decoration: const InputDecoration(hintText: 'Fone/Whats'),
                    validator: phoneValidator,
                    inputFormatters: [utilServices.foneFormatter],
                  ),
                  TextFormField(
                    onSaved: ((newValue) =>
                        controller.cliente.email = newValue!),
                    decoration: const InputDecoration(hintText: 'E-mail'),
                    validator: emailValidator,
                  ),
                  TextFormField(
                    onSaved: ((newValue) =>
                        controller.cliente.senha = newValue!),
                    obscureText: true,
                    decoration: const InputDecoration(hintText: 'Senha'),
                    validator: senhaValidator,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration:
                        const InputDecoration(hintText: 'Repita a senha'),
                    onSaved: ((newValue) =>
                        controller.cliente.senhaConfirm = newValue),
                    validator: senhaValidator,
                  ),
                ],
              ),
            );
          },
        ));
  }
}
