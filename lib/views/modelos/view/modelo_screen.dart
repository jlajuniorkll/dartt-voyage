import 'package:dartt_voyage/models/model_modelo.dart';
import 'package:dartt_voyage/routes/app_routes.dart';
import 'package:dartt_voyage/views/common/home/alerts.dart';
import 'package:dartt_voyage/views/modelos/controller/modelo_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ModeloScreen extends StatelessWidget {
  const ModeloScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Lista de Modelos"),
      ),
      body: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: GetBuilder<ModeloController>(
            builder: (controller) {
              return controller.allModelos.isNotEmpty
                  ? ListView.separated(
                      itemCount: controller.allModelos.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          trailing: InkWell(
                              onTap: () async {
                                final confirm = await Get.dialog<bool>(AlertFetch(
                                    title: 'Tem certeza?',
                                    body:
                                        'Deseja deletar o seguinte modelo: ${controller.allModelos[index].titulo!}?'));
                                if (confirm == true) {
                                  await controller.deleteModel(
                                      controller.allModelos[index].id!);
                                  Get.snackbar('Exclusão:',
                                      'Modelo ${controller.allModelos[index].titulo!} deletado com sucesso!',
                                      snackPosition: SnackPosition.BOTTOM,
                                      colorText: Colors.black,
                                      backgroundColor: Colors.green,
                                      duration: const Duration(seconds: 4),
                                      margin: const EdgeInsets.only(bottom: 8));
                                }
                              },
                              child: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              )),
                          title: Text(controller.allModelos[index].titulo!),
                          onTap: () => Get.toNamed(PageRoutes.cadmodelo,
                              arguments: controller.allModelos[index]),
                        );
                      },
                    )
                  : const Text("Não possui nenhum modelo cadastrado!");
            },
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(PageRoutes.cadmodelo, arguments: ModeloModel());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
