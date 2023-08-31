import 'package:dartt_voyage/views/auth/controllers/controller_signin.dart';
import 'package:get/get.dart';

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SignInController(), permanent: true);
  }
}
