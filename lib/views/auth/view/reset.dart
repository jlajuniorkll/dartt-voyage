import 'package:dartt_voyage/services/validators.dart';
import 'package:dartt_voyage/views/auth/controllers/controller_signin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetForm extends StatelessWidget {
  final emailController = TextEditingController();
  ResetForm({required String email, Key? key}) : super(key: key) {
    emailController.text = email;
  }

  final _formFieldKey = GlobalKey<FormFieldState>();
  final userResult = Get.find<SignInController>();

  @override
  Widget build(BuildContext context) {
    final sizeWidth = MediaQuery.of(context).size.width;
    final sizeWidthWeb = MediaQuery.of(context).size.width * 0.5;
    final isMobile = (sizeWidth <= 800.0);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Conteúdo
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              width: isMobile ? sizeWidth : sizeWidthWeb,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Titulo
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Recuperação de senha',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),

                  // Descrição
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 10,
                      bottom: 20,
                    ),
                    child: Text(
                      'Digite seu email para recuperar sua senha',
                      textAlign: TextAlign.center,
                      style: TextStyle(),
                    ),
                  ),

                  // Campo de email
                  TextFormField(
                      validator: emailAndPhoneValidator,
                      onSaved: ((newValue) => emailController.text = newValue!),
                      decoration:
                          const InputDecoration(hintText: 'CPF ou Email')),

                  // Confirmar
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formFieldKey.currentState!.validate()) {
                          userResult
                              .resetUser(emailController.text.toLowerCase());
                          Get.back(result: true);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18))),
                      child: const Text(
                        'Recuperar',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Botão para fechar
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () {
                Get.back(result: false);
              },
              icon: const Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
}
