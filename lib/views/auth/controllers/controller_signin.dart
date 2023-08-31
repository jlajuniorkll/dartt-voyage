import 'package:dartt_voyage/models/model_cliente.dart';
import 'package:dartt_voyage/routes/app_routes.dart';
import 'package:dartt_voyage/views/auth/repository/auth_repository.dart';
import 'package:dartt_voyage/views/auth/result/result_signin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final authRepository = AuthRepository();
  ClienteModel? clienteLogado;

  void setClienteLogado(ClienteModel value) {
    clienteLogado = value;
    update();
  }

  Future<bool> signIn({required ClienteModel cliente}) async {
    bool loginSucesso = false;

    AuthResult<ClienteModel> result =
        await authRepository.signIn(cliente: cliente);

    result.when(success: (data) {
      setClienteLogado(data);
      Get.offNamed(PageRoutes.home);
    }, error: (message) {
      Get.snackbar(
        "Tente novamente",
        "Erro: $message",
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        borderColor: Colors.white,
        borderRadius: 0,
        borderWidth: 2,
        barBlur: 0,
      );
    });
    return loginSucesso;
  }
}
