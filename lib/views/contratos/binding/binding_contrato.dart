import 'package:dartt_voyage/views/contratos/controller/controller_contrato.dart';
import 'package:get/get.dart';

class ContratoBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ContratoController(), permanent: true);
  }
}
