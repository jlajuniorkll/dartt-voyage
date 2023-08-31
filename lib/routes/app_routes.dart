import 'package:dartt_voyage/views/auth/binding/binding_signin.dart';
import 'package:dartt_voyage/views/auth/binding/binding_signup.dart';
import 'package:dartt_voyage/views/auth/screen_signin.dart';
import 'package:dartt_voyage/views/auth/screen_signup.dart';
import 'package:dartt_voyage/views/common/cliente_steeper/binding/binding_steeper.dart';
import 'package:dartt_voyage/views/home/screen_home.dart';
import 'package:get/get.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: PageRoutes.signin,
      page: () => const SigninScreen(),
      bindings: [SteeperBinding(), SignInBinding(), SignUpBinding()],
    ),
    GetPage(
      name: PageRoutes.signup,
      page: () => const SignUpScreen(),
      // binding: SigninBinding(),
    ),
    GetPage(
      name: PageRoutes.home,
      page: () => const HomeScreen(),
      // binding: SigninBinding(),
    ),
  ];
}

abstract class PageRoutes {
  static const String home = '/';
  static const String signin = '/signin';
  static const String signup = '/signup';
}
