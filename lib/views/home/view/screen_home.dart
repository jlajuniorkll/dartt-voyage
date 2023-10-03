import 'package:dartt_voyage/views/auth/view/screen_signup.dart';
import 'package:dartt_voyage/views/home/components/widget_home.dart';
import 'package:dartt_voyage/views/home/controllers/home_controller.dart';
import 'package:dartt_voyage/views/modelos/view/modelo_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
            body: <Widget>[
              const WidgetHome(),
              const ModeloScreen(),
              SignUpScreen(title: 'Novo Cliente', formAdm: true),
            ][controller.currentPageIndex],
            bottomNavigationBar: NavigationBar(
              onDestinationSelected: (int index) {
                controller.setCurrentPageIndex(index);
              },
              indicatorColor: Colors.amber[800],
              selectedIndex: controller.currentPageIndex,
              destinations: const <Widget>[
                NavigationDestination(
                  selectedIcon: Icon(Icons.home),
                  icon: Icon(Icons.home_outlined),
                  label: 'Home',
                ),
                NavigationDestination(
                  selectedIcon: Icon(Icons.document_scanner),
                  icon: Icon(Icons.document_scanner_rounded),
                  label: 'Modelo',
                ),
                NavigationDestination(
                  selectedIcon: Icon(Icons.person),
                  icon: Icon(Icons.person_outline),
                  label: 'Cliente',
                ),
              ],
            ));
      },
    );
  }
}
