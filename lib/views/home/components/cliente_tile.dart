import 'package:dartt_voyage/models/model_cliente.dart';
import 'package:dartt_voyage/routes/app_routes.dart';
import 'package:dartt_voyage/views/common/home/alerts.dart';
import 'package:dartt_voyage/views/home/components/modal_options.dart';
import 'package:dartt_voyage/views/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserListTile extends StatelessWidget {
  const UserListTile({Key? key, required this.userReceived}) : super(key: key);

  final ClienteModel userReceived;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              userReceived.nome!,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              userReceived.email!,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              userReceived.cpf!,
                              style: const TextStyle(fontSize: 12),
                            ),
                            Text(
                              userReceived.typeUser!,
                              style: const TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.find<HomeController>().setCliente(userReceived);
                          showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                    height: 300,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 24.0),
                                                child: Text(
                                                  "Cliente: ${userReceived.nome}",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: IconButton(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      icon: const Icon(
                                                          Icons.close),
                                                    )),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16.0,
                                                top: 8,
                                                right: 16,
                                                bottom: 8),
                                            child: ElevatedButton.icon(
                                                onPressed: () async {
                                                  showModalBottomSheet<void>(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return const ModelOptions();
                                                      });
                                                },
                                                icon: const Icon(
                                                    Icons.attach_money),
                                                label: const Text(
                                                    "Alterar saldo")),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16.0,
                                                top: 8,
                                                right: 16,
                                                bottom: 8),
                                            child: ElevatedButton.icon(
                                                onPressed: () async {
                                                  // final buscaContratos = await controller.getAllContratos(
                                                  // cliente: controller.cliente);
                                                  // if (buscaContratos) {
                                                  Get.toNamed(
                                                      PageRoutes.listcontratos,
                                                      arguments:
                                                          controller.cliente);
                                                  // }
                                                },
                                                icon: const Icon(Icons.list),
                                                label: const Text(
                                                    "Gerar contrato")),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16.0,
                                                top: 8,
                                                right: 16,
                                                bottom: 16),
                                            child: ElevatedButton.icon(
                                                onPressed: () async {
                                                  final buscaMovimento =
                                                      await controller
                                                          .getAllMove(
                                                              cliente:
                                                                  controller
                                                                      .cliente);
                                                  if (buscaMovimento) {
                                                    Get.toNamed(
                                                        PageRoutes.movimentos,
                                                        arguments:
                                                            controller.cliente);
                                                  }
                                                },
                                                icon:
                                                    const Icon(Icons.swap_vert),
                                                label: const Text(
                                                    "Movimentações")),
                                          ),
                                        ],
                                      ),
                                    ));
                              });
                        },
                        child: Container(
                          padding: const EdgeInsets.only(left: 4, right: 6),
                          child: Icon(Icons.add_circle,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                      Switch(
                          value: userReceived.active,
                          activeColor: Colors.blue,
                          onChanged: (bool value) async {
                            final confirm = await Get.dialog<bool>(AlertFetch(
                                title: 'Tem certeza?',
                                body: userReceived.active
                                    ? 'Deseja inativar o usuário: ${userReceived.nome}?'
                                    : 'Deseja ativar o usuário: ${userReceived.nome}?'));
                            if (confirm == true) {
                              controller.setIsActive(userReceived);
                              Get.snackbar(
                                  userReceived.active ? 'Ativo:' : 'Inativo:',
                                  userReceived.active
                                      ? 'Cliente ${userReceived.nome} foi ativado com sucesso!'
                                      : 'Cliente ${userReceived.nome} foi inativado com sucesso!',
                                  snackPosition: SnackPosition.BOTTOM,
                                  colorText: Colors.black,
                                  duration: const Duration(seconds: 4),
                                  margin: const EdgeInsets.only(bottom: 8));
                            }
                          }),
                    ],
                  )),
            ],
          ),
        ));
  }
}
