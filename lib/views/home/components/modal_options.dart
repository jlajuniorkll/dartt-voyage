import 'package:dartt_voyage/views/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ModelOptions extends StatelessWidget {
  const ModelOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 300,
        child: Center(
          child: GetBuilder<HomeController>(builder: (controller) {
            return Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(Icons.close),
                        )),
                  ),
                  Text("Saldo Atual: R\$: ${controller.cliente.saldoAtual}"),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      controller: controller.saldoFormatter,
                      onSaved: ((newValue) =>
                          controller.saldoController.text = newValue!),
                      decoration:
                          const InputDecoration(hintText: 'Digite o Valor'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, top: 8, right: 16, bottom: 8),
                    child: Row(
                      children: [
                        ElevatedButton.icon(
                            onPressed: () {
                              if (controller.cliente.saldoAtual >=
                                  controller.saldoFormatter.numberValue) {
                                var saldoTotal = controller.cliente.saldoAtual =
                                    controller.cliente.saldoAtual -
                                        controller.saldoFormatter.numberValue;
                                controller.setSaldoTotal(
                                    double.parse(saldoTotal.toStringAsFixed(2)),
                                    "D");
                              } else {
                                Get.snackbar(
                                  "Saldo insuficiente!",
                                  "Nâo foi possível fazer a operação pois o saldo é insuficiente!",
                                  colorText: Colors.black,
                                  backgroundColor: Colors.red,
                                  duration: const Duration(seconds: 3),
                                  snackPosition: SnackPosition.BOTTOM,
                                  borderRadius: 0,
                                  borderWidth: 2,
                                  barBlur: 0,
                                );
                              }
                            },
                            icon: const Icon(Icons.remove_circle_rounded),
                            label: const Text("Débito")),
                        const SizedBox(width: 16),
                        ElevatedButton.icon(
                            onPressed: () {
                              var saldoTotal = controller.cliente.saldoAtual +
                                  controller.saldoFormatter.numberValue;
                              controller.setSaldoTotal(
                                  double.parse(saldoTotal.toStringAsFixed(2)),
                                  "C");
                            },
                            icon: const Icon(Icons.add_circle_rounded),
                            label: const Text("Crédito")),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
        ));
  }
}
