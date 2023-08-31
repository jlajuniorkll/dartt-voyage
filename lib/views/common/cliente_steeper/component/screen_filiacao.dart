import 'package:dartt_voyage/config/consts.dart';
import 'package:dartt_voyage/services/validators.dart';
import 'package:dartt_voyage/views/common/cliente_steeper/controller/controller_steeper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenFiliacao extends StatelessWidget {
  const ScreenFiliacao({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: GetBuilder<ControllerSteeper>(builder: (controller) {
        return Form(
            key: controller.formKeyFiliacao,
            child: Column(
              children: [
                DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: 'Estado Civil',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18)),
                      ),
                      borderRadius: BorderRadius.circular(18),
                      value: controller.cliente.civil,
                      onChanged: (String? newValue) {
                        controller.setCivilOcurrency(newValue!);
                      },
                      onSaved: (newValue) {
                        controller.setCivilOcurrency(newValue!);
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Escolha uma opção';
                        }
                        return null;
                      },
                      items:
                          listCivil.map<DropdownMenuItem<String>>((String e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  onSaved: ((newValue) => controller.cliente.pai = newValue!),
                  decoration: const InputDecoration(hintText: 'Nome do Pai'),
                  validator: nameValidator,
                ),
                TextFormField(
                  onSaved: ((newValue) => controller.cliente.mae = newValue!),
                  decoration: const InputDecoration(hintText: 'Nome da Mãe'),
                  validator: nameValidator,
                ),
              ],
            ));
      }),
    );
  }
}
