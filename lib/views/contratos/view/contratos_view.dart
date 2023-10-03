import 'package:clipboard/clipboard.dart';
import 'package:dartt_voyage/models/model_cliente.dart';
import 'package:dartt_voyage/models/model_modelo.dart';
import 'package:dartt_voyage/views/common/home/alerts.dart';
import 'package:dartt_voyage/views/contratos/controller/controller_contrato.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class ContratosScreen extends StatelessWidget {
  ContratosScreen({super.key});

  ClienteModel? clienteReceived = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Gerar Contrato"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: GetBuilder<ContratoController>(builder: (controller) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "Cliente: ${clienteReceived!.nome}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButton<ModeloModel>(
                  value: controller.dropdownModelo,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (ModeloModel? value) {
                    // This is called when the user selects an item.
                    controller.setModeloModel(value!);
                  },
                  items: controller.allModelos
                      .map<DropdownMenuItem<ModeloModel>>((ModeloModel value) {
                    return DropdownMenuItem<ModeloModel>(
                      value: value,
                      child: Text(value.titulo!),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                    onPressed: () async {
                      final idContrato = await controller.addContrato(
                          clienteReceived!, controller.dropdownModelo);
                      controller.setIdContrato(idContrato);
                      if (idContrato == "ERROR") {
                        Get.dialog<bool>(const AlertFetch(
                            title: "Erro!",
                            body:
                                "Erro ao gerar o contrato! Tente novamente ou contate o administrador do sistema!"));
                      } else {
                        Get.dialog<bool>(const AlertFetch(
                            title: "Sucesso!",
                            body:
                                "Contrato gerado com sucesso! Clique abaixo para compartilhar ou copiar o link."));
                      }
                    },
                    icon: const Icon(Icons.construction),
                    label: const Text("Gerar contrato")),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                    onPressed: controller.idContrato != ""
                        ? () {
                            Share.share(
                                'Link para assinar seu contrato: https://dartt-voyage.web.app/viewcontrato?c=${clienteReceived!.id}&m=${controller.dropdownModelo.id}&t=${controller.idContrato}',
                                subject: 'Contrato GDS');
                          }
                        : null,
                    icon: const Icon(Icons.share),
                    label: const Text("Compartilhar contrato")),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                    onPressed: controller.idContrato != ""
                        ? () {
                            // ignore: avoid_print
                            FlutterClipboard.copy(
                                    'https://dartt-voyage.web.app/#/viewcontrato?c=${clienteReceived!.id}&m=${controller.dropdownModelo.id}&t=${controller.idContrato}')
                                .then((value) => Get.dialog<bool>(const AlertFetch(
                                    title: "Copiado!",
                                    body:
                                        "Link do contato copiado para área de tranferência!")));
                          }
                        : null,
                    icon: const Icon(Icons.copy),
                    label: const Text("Copiar Link contrato"))
              ],
            );
          })),
    );
  }
}
