import 'package:dartt_voyage/services/util_services.dart';
import 'package:dartt_voyage/services/validators.dart';
import 'package:dartt_voyage/views/common/cliente_steeper/controller/controller_steeper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnderecoScreen extends StatelessWidget {
  const EnderecoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final utilServices = UtilsServices();
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: GetBuilder<ControllerSteeper>(builder: (controller) {
        return Form(
            key: controller.formKeyEndereco,
            child: Column(
              children: [
                TextFormField(
                  onSaved: ((newValue) => controller.cliente.cep = newValue!),
                  decoration: const InputDecoration(hintText: 'CEP'),
                  validator: cepValidator,
                  inputFormatters: [utilServices.cepFormatter],
                ),
                TextFormField(
                  onSaved: ((newValue) =>
                      controller.cliente.endereco = newValue!),
                  decoration: const InputDecoration(hintText: 'Endereco'),
                  validator: logradouroValidator,
                ),
                TextFormField(
                  onSaved: ((newValue) =>
                      controller.cliente.numero = newValue!),
                  decoration: const InputDecoration(hintText: 'Número'),
                  validator: logradouroValidator,
                ),
                TextFormField(
                  onSaved: ((newValue) =>
                      controller.cliente.bairro = newValue!),
                  decoration: const InputDecoration(hintText: 'Bairro'),
                  validator: bairroValidator,
                ),
                TextFormField(
                  onSaved: ((newValue) =>
                      controller.cliente.cidade = newValue!),
                  decoration: const InputDecoration(hintText: 'Cidade'),
                  validator: cidadeValidator,
                ),
                TextFormField(
                  onSaved: ((newValue) => controller.cliente.uf = newValue!),
                  decoration: const InputDecoration(hintText: 'UF'),
                  validator: estadoValidator,
                ),
              ],
            ));
      }),
    );
  }
}
