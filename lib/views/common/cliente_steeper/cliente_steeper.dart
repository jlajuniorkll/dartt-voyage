import 'package:dartt_voyage/views/common/cliente_steeper/controller/controller_steeper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClienteSteeper extends StatelessWidget {
  const ClienteSteeper({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControllerSteeper>(builder: (controller) {
      return Stepper(
          currentStep: controller.currentStep,
          onStepContinue: () {
            controller.validaForms();
          },
          onStepCancel: () =>
              controller.currentStep <= 0 ? null : controller.previewPage(),
          onStepTapped: (index) {
            controller.validaForms(index: index);
          },
          controlsBuilder: (BuildContext context, ControlsDetails details) {
            return Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (controller.currentStep != 0)
                      Expanded(
                          child: SizedBox(
                        height: 32,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 32),
                          child: ElevatedButton(
                            onPressed: details.onStepCancel,
                            child: const Text("Voltar"),
                          ),
                        ),
                      )),
                    Expanded(
                        child: SizedBox(
                      height: 32,
                      child: ElevatedButton(
                        onPressed: details.onStepContinue,
                        child: Text(controller.currentStep ==
                                controller.buildStep().length - 1
                            ? "Finalizar"
                            : "Próximo"),
                      ),
                    ))
                  ]),
            );
          },
          type: StepperType.vertical,
          steps: controller.buildStep());
    });
  }
}
