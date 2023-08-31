import 'package:dartt_voyage/views/auth/controllers/controller_signup.dart';
import 'package:get/get.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SignUpController(), permanent: true);
  }
}
