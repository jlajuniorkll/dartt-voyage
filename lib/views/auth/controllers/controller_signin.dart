import 'package:dartt_voyage/models/model_cliente.dart';
import 'package:dartt_voyage/routes/app_routes.dart';
import 'package:dartt_voyage/views/auth/repository/auth_repository.dart';
import 'package:dartt_voyage/views/auth/result/result_signin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final authRepository = AuthRepository();
  ClienteModel? clienteLogado;
  bool sendUser = false;

  void setClienteLogado(ClienteModel value) {
    clienteLogado = value;
    update();
  }

  void setSendUser(bool sendUserSet) {
    sendUser = sendUserSet;
    update();
  }

  Future<void> signIn({required ClienteModel cliente}) async {
    AuthResult<ClienteModel> result =
        await authRepository.signIn(cliente: cliente);

    result.when(success: (data) {
      setClienteLogado(data);
      if (data.typeUser == "Administrador") {
        Get.offNamed(PageRoutes.home);
      } else {
        Get.offNamed(PageRoutes.homeCliente);
      }
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
  }

  Future<void> resetUser(email) async {
    await authRepository.sendPasswordResetEmail(email);
  }

  Future<void> signOut() async {
    await authRepository.signOut();
    clienteLogado = null;
    Get.offNamed(PageRoutes.signin);
    update();
  }
}
