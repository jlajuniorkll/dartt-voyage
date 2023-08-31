import 'package:dartt_voyage/views/common/cliente_steeper/controller/controller_steeper.dart';
import 'package:get/get.dart';

class SteeperBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ControllerSteeper(), permanent: true);
  }
}
