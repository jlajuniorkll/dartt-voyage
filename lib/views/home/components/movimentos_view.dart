import 'package:dartt_voyage/views/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MovimentosScreen extends StatelessWidget {
  const MovimentosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Movimentos"),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        reverse: true,
        itemCount: controller.allMove.length,
        itemBuilder: (context, index) {
          String numeroFormatado = controller.allMove[index].valor!
              .toStringAsFixed(2)
              .replaceAll('.', ',');
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        children: [
                          controller.allMove[index].tipo == "D"
                              ? const Icon(
                                  Icons.remove,
                                  color: Colors.red,
                                )
                              : const Icon(
                                  Icons.add,
                                  color: Colors.green,
                                )
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "R\$ $numeroFormatado",
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        Text(controller.allMove[index].tipo == "D"
                            ? "Débito"
                            : "Crédito"),
                        Text(
                            "Data: ${controller.allMove[index].dataMovimento}"),
                        Text(
                            "Usuário: ${controller.allMove[index].usuarioMovimento}"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
