import 'package:dartt_voyage/models/model_cliente.dart';
import 'package:dartt_voyage/views/auth/controllers/controller_signin.dart';
import 'package:dartt_voyage/views/auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final authRepository = AuthRepository();

  Future<void> addCliente(
      {required ClienteModel cliente, bool signinForm = false}) async {
    if (signinForm) {
      cliente.typeUser = "Cliente";
    } else {
      cliente.typeUser = "Administrador";
    }

    final resultSignup = await authRepository.signUp(cliente: cliente);
    resultSignup.when(
      success: (data) {
        Get.snackbar(
            'Cadastrado', 'Usuário ${data.nome} cadastrado com sucesso!',
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.black,
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
            margin: const EdgeInsets.only(bottom: 8));
        if (signinForm) {
          Get.find<SignInController>().signIn(cliente: cliente);
        }
      },
      error: (message) {
        Get.snackbar(
          "Tente novamente",
          "Erro ao cadastrar usuário - $message",
          colorText: Colors.black,
          backgroundColor: Colors.yellow,
          duration: const Duration(seconds: 3),
          snackPosition: SnackPosition.BOTTOM,
          borderRadius: 0,
          borderWidth: 2,
          barBlur: 0,
        );
      },
    );
  }
}
