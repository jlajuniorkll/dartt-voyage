import 'package:dartt_voyage/models/model_cliente.dart';
import 'package:dartt_voyage/routes/app_routes.dart';
import 'package:dartt_voyage/views/contratos/components/contratos_listtile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ContratosList extends StatelessWidget {
  ContratosList({super.key});

  ClienteModel? clienteReceived = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contratos"),
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 6,
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(60))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: clienteReceived!.contratos!.isNotEmpty &&
                        clienteReceived!.contratos != null
                    ? ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: clienteReceived!.contratos!.length,
                        itemBuilder: (_, index) {
                          return GestureDetector(
                            child: ContratoListTile(
                                contratoReceived:
                                    clienteReceived!.contratos![index],
                                userCliente: false),
                          );
                        })
                    : Align(
                        alignment: Alignment.center,
                        child: Text(
                            "O cliente ${clienteReceived!.nome} ainda não possui contratos para assinar!")),
              ),
            ),
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(PageRoutes.contratos, arguments: clienteReceived);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
