import 'package:dartt_voyage/models/model_cliente.dart';
import 'package:dartt_voyage/models/model_modelo.dart';
import 'package:dartt_voyage/views/auth/binding/binding_signin.dart';
import 'package:dartt_voyage/views/auth/binding/binding_signup.dart';
import 'package:dartt_voyage/views/auth/view/screen_signin.dart';
import 'package:dartt_voyage/views/auth/view/screen_signup.dart';
import 'package:dartt_voyage/views/common/cliente_steeper/binding/binding_steeper.dart';
import 'package:dartt_voyage/views/contratos/binding/binding_contrato.dart';
import 'package:dartt_voyage/views/contratos/view/contratos_assinatura.dart';
import 'package:dartt_voyage/views/contratos/view/contratos_eye.dart';
import 'package:dartt_voyage/views/contratos/view/contratos_list.dart';
import 'package:dartt_voyage/views/contratos/view/contratos_view.dart';
import 'package:dartt_voyage/views/home/bindings/biding_home.dart';
import 'package:dartt_voyage/views/home/components/movimentos_view.dart';
import 'package:dartt_voyage/views/home/view/screen_home.dart';
import 'package:dartt_voyage/views/home/view/screen_homecliente.dart';
import 'package:dartt_voyage/views/modelos/binding/binding_modelo.dart';
import 'package:dartt_voyage/views/modelos/view/cadastro_modelo.dart';
import 'package:dartt_voyage/views/modelos/view/modelo_screen.dart';
import 'package:get/get.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(name: PageRoutes.viewcontrato, page: () => ViewContratoScreen()),
    GetPage(name: PageRoutes.eyecontrato, page: () => EyeContratoScreen()),
    GetPage(
      name: PageRoutes.signin,
      page: () => const SigninScreen(),
      bindings: [SteeperBinding(), SignInBinding(), SignUpBinding()],
    ),
    GetPage(
      name: PageRoutes.signup,
      page: () => SignUpScreen(title: 'Cadastre-se', formAdm: false),
      // binding: SigninBinding(),
    ),
    GetPage(
        name: PageRoutes.home,
        page: () => const HomeScreen(),
        bindings: homeBindings),
    GetPage(
        name: PageRoutes.homeCliente,
        page: () => const HomeClienteScreen(),
        bindings: homeBindings),
    GetPage(
      name: PageRoutes.modelo,
      page: () => const ModeloScreen(),
    ),
    GetPage(
        name: PageRoutes.cadmodelo,
        page: () => ModeloCadastro(),
        arguments: ModeloModel),
    GetPage(name: PageRoutes.movimentos, page: () => const MovimentosScreen()),
    GetPage(
        name: PageRoutes.contratos,
        page: () => ContratosScreen(),
        arguments: ClienteModel),
    GetPage(
        name: PageRoutes.listcontratos,
        page: () => ContratosList(),
        arguments: ClienteModel),
  ];
}

abstract class PageRoutes {
  static const String home = '/';
  static const String homeCliente = '/home-cliente';
  static const String signin = '/signin';
  static const String signup = '/signup';
  static const String modelo = '/modelo';
  static const String cadmodelo = '/cadmodelo';
  static const String movimentos = '/movimentos';
  static const String contratos = '/contratos';
  static const String listcontratos = '/list-contratos';
  static const String viewcontrato = '/viewcontrato';
  static const String eyecontrato = '/eyecontrato';
}

final List<Bindings> homeBindings = [
  HomeBinding(),
  ModeloBinding(),
  ContratoBinding()
];
