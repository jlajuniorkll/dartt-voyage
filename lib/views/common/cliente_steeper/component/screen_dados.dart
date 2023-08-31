import 'package:dartt_voyage/services/util_services.dart';
import 'package:dartt_voyage/services/validators.dart';
import 'package:dartt_voyage/views/common/cliente_steeper/controller/controller_steeper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DadosScreen extends StatelessWidget {
  const DadosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final utilServices = UtilsServices();
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: GetBuilder<ControllerSteeper>(builder: (controller) {
        return Form(
            key: controller.formKeyDados,
            child: Column(
              children: [
                TextFormField(
                  onSaved: ((newValue) => controller.cliente.nome = newValue!),
                  decoration: const InputDecoration(hintText: 'Nome'),
                  validator: nameValidator,
                ),
                TextFormField(
                  onSaved: ((newValue) => controller.cliente.rg = newValue!),
                  decoration: const InputDecoration(hintText: 'RG'),
                  validator: rgValidator,
                  inputFormatters: [utilServices.rgFormatter],
                ),
                TextFormField(
                  onSaved: ((newValue) => controller.cliente.cpf = newValue!),
                  decoration: const InputDecoration(hintText: 'CPF'),
                  validator: cpfValidator,
                  inputFormatters: [utilServices.cpfFormatter],
                ),
                TextFormField(
                  onSaved: ((newValue) => controller.cliente.nasc = newValue!),
                  decoration:
                      const InputDecoration(hintText: 'Data Nascimento'),
                  validator: dataValidator,
                  inputFormatters: [utilServices.dataFormatter],
                ),
              ],
            ));
      }),
    );
  }
}
