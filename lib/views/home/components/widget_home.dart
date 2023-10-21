import 'package:dartt_voyage/views/auth/controllers/controller_signin.dart';
import 'package:dartt_voyage/views/auth/view/screen_signup.dart';
import 'package:dartt_voyage/views/home/components/cliente_tile.dart';
import 'package:dartt_voyage/views/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class WidgetHome extends StatelessWidget {
  const WidgetHome({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<SignInController>();
    return SafeArea(
        child: Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(60))),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        "Olá, ${userController.clienteLogado!.nome}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          userController.signOut();
                        },
                        icon: const Icon(Icons.logout))
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(
                left: 24.0, right: 24, top: 16, bottom: 0),
            child: GetBuilder<HomeController>(builder: (controller) {
              return TextFormField(
                controller: controller.searchController,
                onChanged: (value) {
                  controller.searchTitle.value = value;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  isDense: true,
                  hintText: 'Localizar cliente...',
                  hintStyle:
                      TextStyle(color: Colors.grey.shade400, fontSize: 14.0),
                  suffixIcon: controller.searchTitle.value.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            controller.searchController.clear();
                            controller.searchTitle.value = '';
                            FocusScope.of(context).unfocus();
                          },
                          icon: const Icon(
                            Icons.close,
                            size: 21,
                          ),
                        )
                      : null,
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 21,
                  ),
                  border: const OutlineInputBorder(),
                ),
              );
            })),
        const SizedBox(
          height: 4,
        ),
        GetBuilder<HomeController>(
          builder: (controller) {
            return !controller.isLoadingAllUsers
                ? Expanded(
                    child: ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: controller.allUserFiltered.length,
                        itemBuilder: (_, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(SignUpScreen(
                                title: 'Cadastre-se',
                                formAdm: false,
                                clienteModel: controller.allUserFiltered[index],
                              ));
                            },
                            child: UserListTile(
                                userReceived:
                                    controller.allUserFiltered[index]),
                          );
                        }),
                  )
                : Expanded(
                    child: ListView.builder(
                        itemCount: 100,
                        itemBuilder: (_, index) => SizedBox(
                            width: 200.0,
                            height: 100.0,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                              child: Shimmer.fromColors(
                                baseColor: Colors.red,
                                highlightColor: Colors.yellow,
                                child: Container(
                                    decoration: BoxDecoration(
                                  color: Colors.white.withAlpha(50),
                                  borderRadius: BorderRadius.circular(30),
                                )),
                              ),
                            ))));
          },
        ),
      ]),
    ));
  }
}
