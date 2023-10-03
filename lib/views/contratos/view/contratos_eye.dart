import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartt_voyage/models/model_cliente.dart';
import 'package:dartt_voyage/models/model_contrato.dart';
import 'package:dartt_voyage/models/model_modelo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class EyeContratoScreen extends StatefulWidget {
  EyeContratoScreen({super.key});

  final cliente = Get.parameters['c'];
  final contrato = Get.parameters['t'];
  final fireRef = FirebaseFirestore.instance;

  @override
  State<EyeContratoScreen> createState() => _EyeContratoScreenState();
}

class _EyeContratoScreenState extends State<EyeContratoScreen> {
  String? corpoModificado;
  String idCliente = "";
  String idContrato = "";
  ClienteModel? clienteReceived;
  ModeloModel? modeloReceived;
  ContratoModel? contratoReceived;

  @override
  void initState() {
    idCliente = widget.cliente!;
    idContrato = widget.contrato!;
    clienteReceived = ClienteModel();
    modeloReceived = ModeloModel();
    contratoReceived = ContratoModel();
    corpoModificado = "Não foi possível carregar o contrato!";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: getClienteContrato(
          idCliente, idContrato), // Chama sua função assíncrona aqui
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Exibe um indicador de carregamento enquanto os dados estão sendo buscados
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Exibe um erro caso ocorra
          return Text('Erro: ${snapshot.error}');
        } else {
          // Exibe seus dados após a conclusão da operação assíncrona
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Center(
                  child: Text(
                    modeloReceived!.titulo!,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              Html(
                data: modeloReceived!.corpo != null
                    ? """ $corpoModificado """
                    : "Erro ao gerar contrato!",
              ),
            ],
          );
        }
      },
    ));
  }

  Future<void> getClienteContrato(String idCliente, String idContrato) async {
// Obtém o documento pelo id
    DocumentSnapshot documento =
        await widget.fireRef.collection("cliente").doc(idCliente).get();

// Verifica se o documento existe
    if (documento.exists) {
      clienteReceived = ClienteModel.fromDocument(documento);
      final QuerySnapshot snapContratos = await widget.fireRef
          .collection("cliente")
          .doc(documento.id)
          .collection('contratos')
          .get();
      clienteReceived!.contratos =
          snapContratos.docs.map((d) => ContratoModel.fromDocument(d)).toList();
      if (clienteReceived!.contratos != null) {
        for (var element in clienteReceived!.contratos!) {
          if (element.id == idContrato) {
            contratoReceived = element;
            modeloReceived = element.modelo!;
            corpoModificado =
                substituirMarcadores(element.modelo!.corpo!, clienteReceived!);
          }
        }
      }
    } else {
      // Trata o caso do documento não existir
      Get.snackbar(
        "Tente novamente",
        "Erro ao buscar lista de contratos",
        backgroundColor: Colors.grey,
        snackPosition: SnackPosition.BOTTOM,
        borderColor: Colors.indigo,
        borderRadius: 0,
        borderWidth: 2,
        barBlur: 0,
      );
    }
  }

  String substituirMarcadores(String texto, ClienteModel cliente) {
    String novoTexto = texto
        .replaceAll('{nome}', cliente.nome ?? "ND")
        .replaceAll('{rg}', cliente.rg ?? "ND")
        .replaceAll('{cpf}', cliente.cpf ?? "ND")
        .replaceAll('{nasc}', cliente.nasc ?? "ND")
        .replaceAll('{civil}', cliente.civil ?? "ND")
        .replaceAll('{pai}', cliente.pai ?? "ND")
        .replaceAll('{mae}', cliente.mae ?? "ND")
        .replaceAll('{endereco}', cliente.endereco ?? "ND")
        .replaceAll('{cep}', cliente.cep ?? "ND")
        .replaceAll('{bairro}', cliente.bairro ?? "ND")
        .replaceAll('{cidade}', cliente.cidade ?? "ND")
        .replaceAll('{uf}', cliente.uf ?? "ND")
        .replaceAll('{fone}', cliente.fone ?? "ND")
        .replaceAll('{email}', cliente.email ?? "ND")
        .replaceAll('{numero}', cliente.numero ?? "ND");
    return novoTexto;
  }
}
