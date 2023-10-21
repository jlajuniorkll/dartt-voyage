import 'package:dartt_voyage/routes/app_routes.dart';
import 'package:dartt_voyage/views/auth/controllers/controller_signin.dart';
import 'package:dartt_voyage/views/contratos/components/contratos_listtile.dart';
import 'package:dartt_voyage/views/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeClienteScreen extends StatelessWidget {
  const HomeClienteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final clienteLogado = Get.find<SignInController>().clienteLogado;
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Olá, ${clienteLogado!.nome}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Colors.black),
                ),
                IconButton(
                    onPressed: () {
                      Get.find<SignInController>().signOut();
                    },
                    icon: const Icon(Icons.logout))
              ],
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(60))),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Poupança: ",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                    clienteLogado.saldoAtual > 0
                                        ? "R\$ ${clienteLogado.saldoAtual}"
                                        : "R\$ 0,00",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                              ]),
                          const SizedBox(
                            height: 8,
                          ),
                          TextButton(
                              onPressed: () async {
                                final mov = await Get.find<HomeController>()
                                    .getAllMove(cliente: clienteLogado);
                                if (mov) {
                                  Get.toNamed(PageRoutes.movimentos);
                                } else {
                                  Get.snackbar(
                                    "Tente novamente",
                                    "Você não possui movimentações",
                                    backgroundColor: Colors.grey,
                                    snackPosition: SnackPosition.BOTTOM,
                                    borderColor: Colors.indigo,
                                    borderRadius: 0,
                                    borderWidth: 2,
                                    barBlur: 0,
                                  );
                                }
                              },
                              child: const Text(
                                "Extrato",
                                style: TextStyle(fontSize: 14),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: clienteLogado.contratos!.isNotEmpty &&
                            clienteLogado.contratos != null
                        ? ListView.builder(
                            padding: const EdgeInsets.all(16.0),
                            itemCount: clienteLogado.contratos!.length,
                            itemBuilder: (_, index) {
                              return GestureDetector(
                                child: ContratoListTile(
                                    contratoReceived:
                                        clienteLogado.contratos![index],
                                    userCliente: true),
                              );
                            })
                        : const Align(
                            alignment: Alignment.center,
                            child: Text(
                                "Você ainda não possui contratos para assinar!")),
                  ),
                ),
              ]),
            ),
          ),
        ],
      )),
    );
  }
}
