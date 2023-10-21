import 'package:dartt_voyage/models/model_cliente.dart';
import 'package:dartt_voyage/routes/app_routes.dart';
import 'package:dartt_voyage/services/validators.dart';
import 'package:dartt_voyage/views/auth/controllers/controller_signin.dart';
import 'package:dartt_voyage/views/auth/view/reset.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SignInController>();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final senhaController = TextEditingController();
    return Scaffold(
        body: Align(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45),
                  bottomRight: Radius.circular(45))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Image.asset(
                      'assets/images/logo.jpg',
                      width: 150,
                      height: 150,
                    ),
                    TextFormField(
                        validator: emailAndPhoneValidator,
                        onSaved: ((newValue) =>
                            emailController.text = newValue!),
                        decoration:
                            const InputDecoration(hintText: 'CPF ou Email')),
                    TextFormField(
                        validator: senhaValidator,
                        onSaved: ((newValue) =>
                            senhaController.text = newValue!),
                        obscureText: true,
                        decoration: const InputDecoration(
                            hintText: 'Senha', suffixIcon: Icon(Icons.lock))),
                    const SizedBox(
                      height: 32,
                    ),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            await controller.signIn(
                                cliente: ClienteModel(
                                    email: emailController.text.toLowerCase(),
                                    senha: senhaController.text));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18))),
                        child: const Text(
                          'Entrar',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    // Esqueceu a senha
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () async {
                            controller.setSendUser(await showDialog(
                                context: context,
                                builder: (_) => ResetForm(
                                      email: emailController.text,
                                    )));
                            if (controller.sendUser) {
                              Get.snackbar('Sucesso!',
                                  "Link de recuperação enviado para o seu email!",
                                  snackPosition: SnackPosition.BOTTOM,
                                  colorText: Colors.black,
                                  backgroundColor: Colors.green,
                                  duration: const Duration(seconds: 3),
                                  margin: const EdgeInsets.only(bottom: 8));
                            }
                          },
                          child: const Text(
                            'Esqueceu a senha?',
                            style: TextStyle(),
                          )),
                    ),
                    // Divisor
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.grey.withAlpha(90),
                              thickness: 2,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text('Ou'),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.grey.withAlpha(90),
                              thickness: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Botão novo usuário
                    SizedBox(
                      height: 50,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18)),
                            side: const BorderSide(
                              width: 2,
                            )),
                        onPressed: () {
                          Get.toNamed(PageRoutes.signup);
                        },
                        child: const Text(
                          'Primeiro Acesso',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
