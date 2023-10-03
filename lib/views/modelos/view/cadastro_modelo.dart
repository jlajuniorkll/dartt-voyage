import 'package:dartt_voyage/models/model_modelo.dart';
import 'package:dartt_voyage/views/modelos/controller/modelo_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

// ignore: must_be_immutable
class ModeloCadastro extends StatelessWidget {
  ModeloCadastro({super.key});

  ModeloModel? modeloReceived = Get.arguments;
  final GlobalKey<FormState> formKeyModel = GlobalKey<FormState>();
  final modeloController = Get.find<ModeloController>();

  @override
  Widget build(BuildContext context) {
    verificaReceived();
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Modelo"),
        ),
        body: GetBuilder<ModeloController>(builder: (modeloController) {
          return Form(
              key: formKeyModel,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 12.0, bottom: 12.0, right: 8, left: 8),
                    child: TextFormField(
                      focusNode: modeloController.textFormFieldFocusNode,
                      controller: modeloController.controllerTitle,
                      decoration: const InputDecoration(
                          labelText: "Digíte o título do contrato..."),
                    ),
                  ),
                  Container(
                    color: const Color(0xFFE0F7FA),
                    height: 42,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              onPressed: () =>
                                  modeloController.setOpcaoSelecionada(1),
                              child: const Text("Nome")),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              onPressed: () =>
                                  modeloController.setOpcaoSelecionada(2),
                              child: const Text("RG")),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              onPressed: () =>
                                  modeloController.setOpcaoSelecionada(3),
                              child: const Text("CPF")),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              onPressed: () =>
                                  modeloController.setOpcaoSelecionada(4),
                              child: const Text("Nascimento")),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              onPressed: () =>
                                  modeloController.setOpcaoSelecionada(5),
                              child: const Text("Estado Civil")),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              onPressed: () =>
                                  modeloController.setOpcaoSelecionada(6),
                              child: const Text("Pai")),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              onPressed: () =>
                                  modeloController.setOpcaoSelecionada(7),
                              child: const Text("Mãe")),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              onPressed: () =>
                                  modeloController.setOpcaoSelecionada(8),
                              child: const Text("Endereço")),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              onPressed: () =>
                                  modeloController.setOpcaoSelecionada(9),
                              child: const Text("Fone")),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              onPressed: () =>
                                  modeloController.setOpcaoSelecionada(10),
                              child: const Text("Email")),
                        ),
                      ],
                    ),
                  ),
                  ToolBar(
                    toolBarColor: Colors.cyan.shade50,
                    activeIconColor: Colors.amber,
                    padding: const EdgeInsets.all(8),
                    iconSize: 20,
                    controller: modeloController.controllerQuill,
                  ),
                  Expanded(
                    child: QuillHtmlEditor(
                      text: modeloReceived!.corpo ??
                          "<h1>Olá</h1>Edite aqui o seu contrato 😊",
                      hintText: 'Hint text goes here',
                      controller: modeloController.controllerQuill,
                      isEnabled: true,
                      minHeight: 300,
                      textStyle: modeloController.editorTextStyle,
                      hintTextStyle: modeloController.hintTextStyle,
                      hintTextAlign: TextAlign.start,
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      hintTextPadding: EdgeInsets.zero,
                      backgroundColor: Colors.white,
                      onFocusChanged: (hasFocus) {
                        modeloController.textFormFieldFocusNode.unfocus();
                        modeloController.setHasFocus(hasFocus);
                      },
                      onTextChanged: (text) =>
                          debugPrint('widget text change $text'),
                      onEditorCreated: () =>
                          debugPrint('Editor has been loaded'),
                      onEditorResized: (height) =>
                          debugPrint('Editor resized $height'),
                      onSelectionChanged: (sel) =>
                          debugPrint('${sel.index},${sel.length}'),
                      loadingBuilder: (context) {
                        return const Center(
                            child: CircularProgressIndicator(
                          strokeWidth: 0.4,
                        ));
                      },
                    ),
                  ),
                  ElevatedButton(
                      onPressed: modeloReceived!.id != null
                          ? () async {
                              bool salvo = await modeloController
                                  .updateModelo(modeloReceived!.id!);
                              if (salvo) {
                                modeloController.getAllModelo();
                                modeloController.update();
                                Get.back();
                              } else {
                                Get.snackbar('Erro',
                                    'Erro ao atualizar o modelo de contrato!',
                                    snackPosition: SnackPosition.BOTTOM,
                                    colorText: Colors.white,
                                    backgroundColor: Colors.red,
                                    duration: const Duration(seconds: 3),
                                    margin: const EdgeInsets.only(bottom: 8));
                              }
                            }
                          : () async {
                              bool salvo = await modeloController.setModelo();
                              if (salvo) {
                                modeloController.getAllModelo();
                                modeloController.update();
                                Get.back();
                              } else {
                                Get.snackbar('Erro',
                                    'Erro ao cadastrar o modelo de contrato!',
                                    snackPosition: SnackPosition.BOTTOM,
                                    colorText: Colors.white,
                                    backgroundColor: Colors.red,
                                    duration: const Duration(seconds: 3),
                                    margin: const EdgeInsets.only(bottom: 8));
                              }
                            },
                      child: modeloReceived!.id != null
                          ? const Text("Atualizar Modelo")
                          : const Text("Salvar Modelo"))
                ],
              ));
        }));
  }

  void verificaReceived() {
    if (modeloReceived != null) {
      modeloController.setControllers(modeloReceived!);
    }
  }
}
