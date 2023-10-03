import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartt_voyage/models/model_cliente.dart';
import 'package:dartt_voyage/models/model_contrato.dart';
import 'package:dartt_voyage/models/model_modelo.dart';
import 'package:dartt_voyage/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class ViewContratoScreen extends StatefulWidget {
  ViewContratoScreen({super.key});

  final cliente = Get.parameters['c'];
  final contrato = Get.parameters['t'];
  final fireRef = FirebaseFirestore.instance;

  @override
  State<ViewContratoScreen> createState() => _ViewContratoScreenState();
}

class _ViewContratoScreenState extends State<ViewContratoScreen> {
  String? corpoModificado;
  String idCliente = "";
  String idContrato = "";
  ClienteModel? clienteReceived;
  ModeloModel? modeloReceived;
  ContratoModel? contratoReceived;
  bool? checkBoxValue;
  bool? habilitaBox;
  SignatureController? _controller;
  String? imageEncoded;
  bool? boolUpdate;
  num? lat;
  num? long;
  String? browser;
  String? ip;

  @override
  void initState() {
    idCliente = widget.cliente!;
    idContrato = widget.contrato!;
    lat = 0;
    long = 0;
    browser = "";
    ip = "";
    clienteReceived = ClienteModel();
    modeloReceived = ModeloModel();
    contratoReceived = ContratoModel();
    corpoModificado = "Não foi possível carregar o contrato!";
    checkBoxValue = false;
    habilitaBox = true;
    boolUpdate = false;
    imageEncoded = "";
    _controller = SignatureController(
      penStrokeWidth: 5,
      penColor: Colors.black,
      exportBackgroundColor: Colors.blue,
    );
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
              const Center(
                child: Text(
                    "Use o touch ou o mouse para assinar no quadro abaixo!"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Signature(
                  controller: _controller!,
                  width: double.infinity,
                  height: 300,
                  backgroundColor: const Color.fromARGB(255, 250, 218, 171),
                ),
              ),
              habilitaBox == true
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                              onPressed: () {
                                _controller!.clear();
                                habilitaBox = true;
                              },
                              icon: const Icon(Icons.clear),
                              label: const Text("Limpar")),
                          ElevatedButton.icon(
                              onPressed: () async {
                                final imageData =
                                    await _controller!.toPngBytes();
                                setState(() {
                                  imageEncoded = base64.encode(imageData!);
                                  habilitaBox = false;
                                });
                              },
                              icon: const Icon(Icons.check),
                              label: const Text("Salvar")),
                        ],
                      ),
                    )
                  : Container(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                        value: checkBoxValue,
                        onChanged: (newValue) {
                          setState(() {
                            checkBoxValue = newValue;
                          });
                        }),
                    const Text(
                        'Declaro, que li e concordo com todos os termos deste contrato digital, e reconheço a validade jurídica deste documento.')
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: ElevatedButton(
                    onPressed: checkBoxValue == true
                        ? _controller!.isNotEmpty
                            ? () async {
                                // Obtém a data e hora atuais
                                DateTime now = DateTime.now();
                                DateTime nowValidate =
                                    now.add(const Duration(days: 30));
                                // Converte em uma string formatada
                                String date = now.toString();
                                String dateValidate = nowValidate.toString();
                                // Verifica se está na web
                                // if (kIsWeb) {
                                // Obtém o nome do navegador
                                contratoReceived!.browser = browser;
                                contratoReceived!.ip = ip;
                                contratoReceived!.latitude = lat!.toString();
                                contratoReceived!.longitude = long.toString();
                                contratoReceived!.dataAssinatura = date;
                                contratoReceived!.dataValidade = dateValidate;
                                contratoReceived!.imagemAssinatura =
                                    imageEncoded;
                                contratoReceived!.status = "C";

                                final boolUpdateNew = await updateContrato(
                                    contrato: contratoReceived!);
                                setState(() {
                                  boolUpdate = boolUpdateNew;
                                });

                                boolUpdate == true
                                    ? Get.dialog(AlertDialog(
                                        title: const Text(
                                            'Contrato assinado com sucesso!'),
                                        content: Text(
                                            'Navegador: $browser\nIP: $ip\nLocalização: $lat, $long\nData: $date Data de Validade: $dateValidate'),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Get.toNamed(PageRoutes.signin);
                                              },
                                              child: const Text("OK"))
                                        ],
                                      ))
                                    : Get.dialog(const AlertDialog(
                                        title:
                                            Text('Erro ao assinar o contrato!'),
                                        content: Text(
                                            'Ocorreu um erro ao assinal o contrato. Contate o administrador do sistema'),
                                      ));
                                /*} else {
                              // Obtém o nome da plataforma
                              String platform = Platform.operatingSystem;
                              // Obtém a versão da plataforma
                              String version = Platform.operatingSystemVersion;
                              // Verifica se pode abrir uma URL para obter o ip do usuário
                              if (await canLaunch('https://api.ipify.org')) {
                                // Abre a URL no navegador ou no aplicativo correspondente
                                await launch('https://api.ipify.org');
                              }
                              // Mostra as informações na tela
                              // ignore: use_build_context_synchronously
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Informações do dispositivo'),
                                  content: Text(
                                      'Plataforma: $platform\nVersão: $version \nData: $date Data de Validade: $dateValidate'),
                                ),
                              );
                            }*/
                              }
                            : () {
                                showDialog(
                                  context: context,
                                  builder: (context) => const AlertDialog(
                                    title: Text('Ooooooops...'),
                                    content: Text(
                                        'Você precisa usar o touch ou o mouse para assinar seu documento e após clique novamente em assinar contrato!'),
                                  ),
                                );
                              }
                        : null,
                    child: const Text("Assinar contrato")),
              )
            ],
          );
        }
      },
    ));
  }

  Future<bool> updateContrato({required ContratoModel contrato}) async {
    try {
      await widget.fireRef
          .collection("cliente")
          .doc(idCliente)
          .collection("contratos")
          .doc(idContrato)
          .update(contrato.toJson());
      return true;
    } catch (e) {
      return false;
    }
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
            getDataAssinatura();
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

  void getDataAssinatura() async {
    browser = html.window.navigator.userAgent;
    // Obtém o ip do usuário
    ip = await html.HttpRequest.getString('https://api.ipify.org');
    // Obtém a localização do usuário
    html.window.navigator.geolocation.getCurrentPosition().then(
      (position) {
        lat = position.coords!.latitude;
        long = position.coords!.longitude;
        // Mostra as informações na tela
      },
    );
  }
}
