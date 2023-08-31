import 'package:dartt_voyage/models/model_cliente.dart';
import 'package:dartt_voyage/views/auth/controllers/controller_signup.dart';
import 'package:dartt_voyage/views/common/cliente_steeper/component/screen_confirm.dart';
import 'package:dartt_voyage/views/common/cliente_steeper/component/screen_dados.dart';
import 'package:dartt_voyage/views/common/cliente_steeper/component/screen_endereco.dart';
import 'package:dartt_voyage/views/common/cliente_steeper/component/screen_filiacao.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ControllerSteeper extends GetxController {
  int currentStep = 0;

  ClienteModel cliente = ClienteModel();
  final GlobalKey<FormState> formKeyDados = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyEndereco = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyFiliacao = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyConfirm = GlobalKey<FormState>();

  void setCivilOcurrency(String value) {
    cliente.civil = value;
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

  void previewPage() {
    currentStep--;
    update();
  }

  void validaForms({int? index}) {
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
          Get.find<SignUpController>()
              .addCliente(cliente: cliente, signinForm: true);
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
          content: const ConfirmScreen(),
          isActive: currentStep >= 3),
    ];
  }
}
