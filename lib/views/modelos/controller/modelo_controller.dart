import 'package:dartt_voyage/models/model_modelo.dart';
import 'package:dartt_voyage/views/modelos/repository/modelo_repository.dart';
import 'package:dartt_voyage/views/modelos/result/modelo_result.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

class ModeloController extends GetxController {
  final modeloRepository = ModeloRepository();
  ModeloModel modelo = ModeloModel();
  List<ModeloModel> allModelos = [];
  ModeloModel modeloDropValue = ModeloModel();
  final QuillEditorController controllerQuill = QuillEditorController();
  final TextEditingController controllerTitle = TextEditingController();
  final FocusNode textFormFieldFocusNode = FocusNode();
  bool hasFocus = false;

  @override
  void onInit() {
    super.onInit();
    // função do getx
    getAllModelo();
  }

  void setModeloModel(ModeloModel value) {
    modeloDropValue = value;
    update();
  }

  Future<bool> setModelo() async {
    String? htmlText = await controllerQuill.getText();
    String? titleText = controllerTitle.text;
    if (htmlText.isNotEmpty && titleText.isNotEmpty) {
      modelo.titulo = titleText;
      modelo.corpo = htmlText;
    }
    update();
    return addModelo();
  }

  Future<bool> addModelo() async {
    final opOK = await modeloRepository.addModelo(modelo: modelo);
    if (opOK) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> getAllModelo() async {
    ModeloResult<List<ModeloModel>> modeloResult =
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

  Future<void> deleteModel(String id) async {
    await modeloRepository.deleteModelo(modeloId: id);
    getAllModelo();
  }

  Future<bool> updateModelo(String value) async {
    String? htmlText = await controllerQuill.getText();
    ModeloModel modeloUpdate =
        ModeloModel(id: value, titulo: controllerTitle.text, corpo: htmlText);
    final result = await modeloRepository.updateModelo(modelo: modeloUpdate);
    getAllModelo();
    return result;
  }

  void setOpcaoSelecionada(int value) {
    if (value == 1) {
      insertHtmlText('{nome}');
    } else if (value == 2) {
      insertHtmlText('{rg}');
    } else if (value == 3) {
      insertHtmlText('{cpf}');
    } else if (value == 4) {
      insertHtmlText('{nasc}');
    } else if (value == 5) {
      insertHtmlText('{civil}');
    } else if (value == 6) {
      insertHtmlText('{pai}');
    } else if (value == 7) {
      insertHtmlText('{mae}');
    } else if (value == 8) {
      insertHtmlText('{endereco}');
    } else if (value == 9) {
      insertHtmlText('{fone}');
    } else if (value == 10) {
      insertHtmlText('{email}');
    }
    update();
  }

  void setHasFocus(bool value) {
    hasFocus = value;
    update();
  }

  /// method to un focus editor
  void unFocusEditor() => controllerQuill.unFocus();

  void insertHtmlText(String text, {int? index}) async {
    await controllerQuill.insertText(text, index: index);
  }

  final editorTextStyle = const TextStyle(
    fontSize: 18,
    color: Colors.black,
    fontWeight: FontWeight.normal,
    fontFamily: 'Roboto',
  );

  final hintTextStyle = const TextStyle(
    fontSize: 18,
    color: Colors.grey,
    fontWeight: FontWeight.normal,
    fontFamily: 'Roboto',
  );

  Future<void> setControllers(ModeloModel value) async {
    if (value.id != null) {
      controllerTitle.text = value.titulo!;
      controllerQuill.setText(value.corpo!);
      String? htmlText = await controllerQuill.getText();
      String? titleText = controllerTitle.text;
      if (htmlText.isNotEmpty && titleText.isNotEmpty) {
        modelo.titulo = titleText;
        modelo.corpo = htmlText;
      }
    } else {
      controllerTitle.clear();
      controllerQuill.clear();
    }
  }
}
