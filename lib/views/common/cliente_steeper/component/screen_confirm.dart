import 'package:dartt_voyage/config/consts.dart';
import 'package:dartt_voyage/services/util_services.dart';
import 'package:dartt_voyage/services/validators.dart';
import 'package:dartt_voyage/views/common/cliente_steeper/controller/controller_steeper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ConfirmScreen extends StatelessWidget {
  ConfirmScreen({super.key, required this.formAdm});

  bool formAdm;

  @override
  Widget build(BuildContext context) {
    final utilServices = UtilsServices();
    return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: GetBuilder<ControllerSteeper>(
          builder: (controller) {
            return Form(
              key: controller.formKeyConfirm,
              child: Column(
                children: [
                  if (formAdm)
                    DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          decoration: InputDecoration(
                            isDense: true,
                            labelText: 'Tipo Usuário',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18)),
                          ),
                          borderRadius: BorderRadius.circular(18),
                          value: controller.cliente.typeUser,
                          onChanged: (String? newValue) {
                            controller.setTypeUser(newValue!);
                          },
                          onSaved: (newValue) {
                            controller.setTypeUser(newValue!);
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Escolha uma opção';
                            }
                            return null;
                          },
                          items: listTypeUser
                              .map<DropdownMenuItem<String>>((String e) {
                            return DropdownMenuItem<String>(
                              value: e,
                              child: Text(e),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  if (formAdm)
                    const SizedBox(
                      height: 12,
                    ),
                  TextFormField(
                    controller: controller.foneController,
                    onSaved: ((newValue) =>
                        controller.cliente.fone = newValue!),
                    decoration: const InputDecoration(hintText: 'Fone/Whats'),
                    validator: phoneValidator,
                    inputFormatters: [utilServices.foneFormatter],
                  ),
                  TextFormField(
                    controller: controller.emailController,
                    onSaved: ((newValue) =>
                        controller.cliente.email = newValue!),
                    decoration: const InputDecoration(hintText: 'E-mail'),
                    validator: emailValidator,
                  ),
                  TextFormField(
                    controller: controller.senhaController,
                    onSaved: ((newValue) =>
                        controller.cliente.senha = newValue!),
                    obscureText: true,
                    decoration: const InputDecoration(hintText: 'Senha'),
                    validator: senhaValidator,
                  ),
                  TextFormField(
                    controller: controller.confirmController,
                    obscureText: true,
                    decoration:
                        const InputDecoration(hintText: 'Repita a senha'),
                    onSaved: ((newValue) =>
                        controller.cliente.senhaConfirm = newValue),
                    validator: senhaValidator,
                  ),
                ],
              ),
            );
          },
        ));
  }
}
