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
                  controller: controller.cepController,
                  onSaved: ((newValue) => controller.cliente.cep = newValue!),
                  decoration: const InputDecoration(hintText: 'CEP'),
                  validator: cepValidator,
                  inputFormatters: [utilServices.cepFormatter],
                  onChanged: (value) async {
                    if (value.length == 9) {
                      final cepUnmasked =
                          utilServices.cepFormatter.getUnmaskedText();
                      var cepEncontrado =
                          await controller.fecthCep(cep: cepUnmasked);
                      if (cepEncontrado['erro'] == true) {
                        controller.limpaEnderecoCEP();
                        Get.snackbar(
                            'Erro!', "Erro ao localizar o CEP informado!",
                            snackPosition: SnackPosition.BOTTOM,
                            colorText: Colors.white,
                            backgroundColor: Colors.red,
                            duration: const Duration(seconds: 3),
                            margin: const EdgeInsets.only(bottom: 8));
                      } else {
                        controller.setEnderecoCEP(cepEncontrado);
                      }
                    }
                  },
                ),
                TextFormField(
                  controller: controller.logradouroController,
                  onSaved: ((newValue) =>
                      controller.cliente.endereco = newValue!),
                  decoration: const InputDecoration(hintText: 'Endereco'),
                  validator: logradouroValidator,
                ),
                TextFormField(
                  controller: controller.numeroController,
                  onSaved: ((newValue) =>
                      controller.cliente.numero = newValue!),
                  decoration: const InputDecoration(hintText: 'Número'),
                  validator: logradouroValidator,
                ),
                TextFormField(
                  controller: controller.complementoController,
                  onSaved: ((newValue) =>
                      controller.cliente.complemento = newValue!),
                  decoration: const InputDecoration(hintText: 'Complemento'),
                ),
                TextFormField(
                  controller: controller.bairroController,
                  onSaved: ((newValue) =>
                      controller.cliente.bairro = newValue!),
                  decoration: const InputDecoration(hintText: 'Bairro'),
                  validator: bairroValidator,
                ),
                TextFormField(
                  controller: controller.cidadeController,
                  onSaved: ((newValue) =>
                      controller.cliente.cidade = newValue!),
                  decoration: const InputDecoration(hintText: 'Cidade'),
                  validator: cidadeValidator,
                ),
                TextFormField(
                  controller: controller.estadoController,
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
