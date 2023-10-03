import 'package:dartt_voyage/models/model_contrato.dart';
import 'package:dartt_voyage/views/common/home/alerts.dart';
import 'package:dartt_voyage/views/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:get/get.dart';

class ContratoListTile extends StatelessWidget {
  const ContratoListTile(
      {super.key, this.contratoReceived, required this.userCliente});

  final ContratoModel? contratoReceived;
  final bool? userCliente;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Card(
        elevation: 5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Contrato: ${contratoReceived!.modelo!.titulo}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  Text("Cliente: ${contratoReceived!.cliente!.nome}",
                      style: const TextStyle(fontSize: 12)),
                  Text("Data Validade: ${contratoReceived!.dataValidade}",
                      style: const TextStyle(fontSize: 12)),
                  if (contratoReceived!.status == "C")
                    Text("Data Assinatura: ${contratoReceived!.dataAssinatura}",
                        style: const TextStyle(fontSize: 12)),
                  if (contratoReceived!.status == "C")
                    Text("Ip: ${contratoReceived!.ip}",
                        style: const TextStyle(fontSize: 10)),
                  if (contratoReceived!.status == "C")
                    Text("Sistema: ${contratoReceived!.browser}",
                        style: const TextStyle(fontSize: 10)),
                  if (contratoReceived!.status == "C")
                    Text(
                        "Local: lat.${contratoReceived!.latitude} long.${contratoReceived!.longitude}",
                        style: const TextStyle(fontSize: 10)),
                  getBadges(contratoReceived!.status),
                ],
              ),
            ),
            if (userCliente == true && contratoReceived!.status == "A")
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextButton.icon(
                    onPressed: () {
                      Get.toNamed(
                          '/viewcontrato?c=${contratoReceived!.cliente!.id}&m=${contratoReceived!.modelo!.id}&t=${contratoReceived!.id}');
                    },
                    icon: const Icon(Icons.edit_document),
                    label: const Text("Assinar")),
              ),
            if (userCliente == true && contratoReceived!.status != "A")
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextButton.icon(
                    onPressed: () {
                      Get.toNamed(
                          '/eyecontrato?c=${contratoReceived!.cliente!.id}&m=${contratoReceived!.modelo!.id}&t=${contratoReceived!.id}');
                    },
                    icon: const Icon(Icons.visibility),
                    label: const Text("Visualizar")),
              ),
            if (userCliente == false)
              GestureDetector(
                onTap: () async {
                  final confirm = await Get.dialog<bool>(AlertFetch(
                      title: 'Tem certeza?',
                      body:
                          'Deseja deletar o contrato: ${contratoReceived!.modelo!.titulo} do usuário ${contratoReceived!.cliente!.nome}?'));
                  if (confirm == true) {
                    controller.deleteContrato(
                        contratoReceived!.id!, contratoReceived!.cliente!.id!);
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              )
          ],
        ),
      );
    });
  }

  Widget getBadges(String status) {
    String textBadge = "Aguardando Assinatura";
    MaterialColor corBadge = Colors.yellow;
    Color corTextBadge = Colors.black;
    IconData iconBadge = Icons.alarm;

    switch (status) {
      case "A":
        textBadge = "Aguardando Assinatura";
        corBadge = Colors.yellow;
        corTextBadge = Colors.black;
        iconBadge = Icons.alarm;
        break;

      case "C":
        textBadge = "Contrato Assinado";
        corBadge = Colors.green;
        corTextBadge = Colors.black;
        iconBadge = Icons.check;
        break;

      case "V":
        textBadge = "Prazo Vencido";
        corBadge = Colors.blue;
        corTextBadge = Colors.black;
        iconBadge = Icons.alarm_off;
        break;

      case "R":
        textBadge = "Contrato Vencido";
        corBadge = Colors.red;
        corTextBadge = Colors.white;
        iconBadge = Icons.alarm_on;
        break;

      case "X":
        textBadge = "Contrato Cancelado";
        corBadge = Colors.grey;
        corTextBadge = Colors.black;
        iconBadge = Icons.alarm_on;
        break;
    }
    return badges.Badge(
        badgeContent: Row(
          children: [
            Icon(iconBadge),
            Text(
              textBadge,
              style: TextStyle(color: corTextBadge),
            ),
          ],
        ),
        badgeStyle: badges.BadgeStyle(
          shape: badges.BadgeShape.square,
          badgeColor: corBadge,
          borderRadius: BorderRadius.circular(8),
        ));
  }
}
