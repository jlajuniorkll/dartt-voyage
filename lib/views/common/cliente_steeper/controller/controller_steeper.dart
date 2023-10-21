import 'dart:convert';

import 'package:dartt_voyage/models/model_cliente.dart';
import 'package:dartt_voyage/views/auth/controllers/controller_signup.dart';
import 'package:dartt_voyage/views/common/cliente_steeper/component/screen_confirm.dart';
import 'package:dartt_voyage/views/common/cliente_steeper/component/screen_dados.dart';
import 'package:dartt_voyage/views/common/cliente_steeper/component/screen_endereco.dart';
import 'package:dartt_voyage/views/common/cliente_steeper/component/screen_filiacao.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ControllerSteeper extends GetxController {
  int currentStep = 0;
  bool formAdm = false;

  ClienteModel cliente = ClienteModel();
  final GlobalKey<FormState> formKeyDados = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyEndereco = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyFiliacao = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyConfirm = GlobalKey<FormState>();
  TextEditingController nomeController = TextEditingController();
  TextEditingController rgController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  TextEditingController nascimentoController = TextEditingController();
  TextEditingController cepController = TextEditingController();
  TextEditingController logradouroController = TextEditingController();
  TextEditingController bairroController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  TextEditingController estadoController = TextEditingController();
  TextEditingController paiController = TextEditingController();
  TextEditingController maeController = TextEditingController();
  TextEditingController foneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController complementoController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController numeroController = TextEditingController();

  void setCivilOcurrency(String value) {
    cliente.civil = value;
    update();
  }

  void setTypeUser(String value) {
    cliente.typeUser = value;
    update();
  }

  void nextPage(int? index) {
    if (index != null) {
      currentStep = index;
    } else {
      currentStep++;
    }
    update();
  }

  void zeraPage() {
    formKeyDados.currentState!.reset();
    formKeyEndereco.currentState!.reset();
    formKeyFiliacao.currentState!.reset();
    formKeyConfirm.currentState!.reset();
    currentStep = 0;
    update();
  }

  void setFormAdm(bool value) {
    formAdm = value;
    update();
  }

  void previewPage() {
    currentStep--;
    update();
  }

  void validaForms(
      {int? index, required bool formAdm, ClienteModel? clienteModel}) {
    switch (currentStep) {
      case 0:
        if (formKeyDados.currentState!.validate()) {
          formKeyDados.currentState!.save();
          nextPage(index);
        }
        break;
      case 1:
        if (formKeyEndereco.currentState!.validate()) {
          formKeyEndereco.currentState!.save();
          currentStep++;
          update();
        }
        break;
      case 2:
        if (formKeyFiliacao.currentState!.validate()) {
          formKeyFiliacao.currentState!.save();
          nextPage(index);
        }
        break;
      case 3:
        if (formKeyConfirm.currentState!.validate()) {
          formKeyConfirm.currentState!.save();
          if (clienteModel != null) {
            Get.find<SignUpController>().updateCliente(clienteModel: cliente);
          } else {
            Get.find<SignUpController>()
                .addCliente(cliente: cliente, formAdm: formAdm);
          }
          limpaTudo();
        }
        break;
    }
  }

  List<Step> buildStep() {
    return <Step>[
      Step(
          title: const Text('Dados Pessoais'),
          content: const DadosScreen(),
          isActive: currentStep >= 0,
          state: currentStep > 0 ? StepState.complete : StepState.indexed),
      Step(
          title: const Text('Endereco'),
          content: const EnderecoScreen(),
          isActive: currentStep >= 1,
          state: currentStep > 1 ? StepState.complete : StepState.indexed),
      Step(
          title: const Text('Filiação'),
          content: const ScreenFiliacao(),
          isActive: currentStep >= 2,
          state: currentStep > 2 ? StepState.complete : StepState.indexed),
      Step(
          title: const Text('Confirmação'),
          content: ConfirmScreen(formAdm: formAdm),
          isActive: currentStep >= 3),
    ];
  }

  Future<Map<String, dynamic>> fecthCep({required String cep}) async {
    try {
      final response =
          await http.get(Uri.parse('https://viacep.com.br/ws/$cep/json/'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        final notCNPJ = jsonEncode({"erro": true});
        return json.decode(notCNPJ);
        // throw Exception('Não foi possível buscar o Cep!');
      }
    } catch (e) {
      final notCNPJ = jsonEncode({"erro": true});
      return json.decode(notCNPJ);
    }
  }

  void setEnderecoCEP(Map<String, dynamic> endereco) {
    logradouroController.text = endereco['logradouro'] as String;
    bairroController.text = endereco['bairro'] as String;
    cidadeController.text = endereco['localidade'] as String;
    estadoController.text = endereco['uf'] as String;
    update();
  }

  void limpaEnderecoCEP() {
    logradouroController.text = '';
    bairroController.text = '';
    cidadeController.text = '';
    estadoController.text = '';
    update();
  }

  void setClientEdit(ClienteModel cliente) {
    if (cliente.id != null) {
      cliente.id = cliente.id!;
    }
    nomeController.text = cliente.nome!;
    rgController.text = cliente.rg!;
    cpfController.text = cliente.cpf!;
    nascimentoController.text = cliente.nasc!;
    cepController.text = cliente.cep!;
    logradouroController.text = cliente.endereco!;
    complementoController.text = cliente.complemento!;
    bairroController.text = cliente.bairro!;
    cidadeController.text = cliente.cidade!;
    estadoController.text = cliente.uf!;
    paiController.text = cliente.pai!;
    maeController.text = cliente.mae!;
    foneController.text = cliente.fone!;
    emailController.text = cliente.email!;
    senhaController.text = cliente.senha!;
    confirmController.text = cliente.senhaConfirm!;
    numeroController.text = cliente.numero!;
    setCivilOcurrency(cliente.civil!);
  }

  void limpaTudo() {
    nomeController.text = "";
    rgController.text = "";
    cpfController.text = "";
    nascimentoController.text = "";
    cepController.text = "";
    logradouroController.text = "";
    bairroController.text = "";
    cidadeController.text = "";
    estadoController.text = "";
    paiController.text = "";
    maeController.text = "";
    foneController.text = "";
    emailController.text = "";
    senhaController.text = "";
    complementoController.text = "";
    confirmController.text = "";
    numeroController.text = "";
    zeraPage();
  }
}
