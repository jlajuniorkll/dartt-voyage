import 'package:dartt_voyage/models/model_cliente.dart';
import 'package:dartt_voyage/models/model_modelo.dart';
import 'package:dartt_voyage/views/contratos/repository/repository_contrato.dart';
import 'package:dartt_voyage/views/contratos/result/results_contrato.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContratoController extends GetxController {
  final modeloRepository = ContratoRepository();

  ModeloModel dropdownModelo = ModeloModel();
  List<ModeloModel> allModelos = [];
  String idContrato = "";

  @override
  void onInit() {
    super.onInit();
    getAllModelo();
  }

  void setModeloModel(ModeloModel value) {
    dropdownModelo = value;
    update();
  }

  void setIdContrato(String value) {
    idContrato = value;
    update();
  }

  Future<String> addContrato(ClienteModel cliente, ModeloModel modelo) async {
    final opOK =
        await modeloRepository.addContrato(cliente: cliente, modelo: modelo);
    if (opOK == "ERROR") {
      return "ERRO AO GERAR CONTRATO";
    } else {
      return opOK;
    }
  }

  Future<void> getAllModelo() async {
    ContratoResult<List<ModeloModel>> modeloResult =
        await modeloRepository.getAllModelo();

    modeloResult.when(success: (data) {
      allModelos.assignAll(data);
      setModeloModel(allModelos.first);
    }, error: (message) {
      Get.snackbar(
        "Tente novamente",
        "Erro ao buscar lista de modelos",
        backgroundColor: Colors.grey,
        snackPosition: SnackPosition.BOTTOM,
        borderColor: Colors.indigo,
        borderRadius: 0,
        borderWidth: 2,
        barBlur: 0,
      );
    });
  }
}
