import 'package:dartt_voyage/views/modelos/controller/modelo_controller.dart';
import 'package:get/get.dart';

class ModeloBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ModeloController(), permanent: true);
  }
}
