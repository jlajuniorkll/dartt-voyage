import 'package:dartt_voyage/models/model_cliente.dart';
import 'package:dartt_voyage/models/model_movimento.dart';
import 'package:dartt_voyage/views/auth/controllers/controller_signin.dart';
import 'package:dartt_voyage/views/home/repository/home_repository.dart';
import 'package:dartt_voyage/views/home/result/home_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ClienteModel cliente = ClienteModel();
  final searchController = TextEditingController();
  final saldoController = TextEditingController();
  RxString searchTitle = ''.obs;
  List<ClienteModel> allUser = [];
  List<ClienteModel> allUserFiltered = [];
  String _searchUser = '';
  String get searchUser => _searchUser;
  final homeRepository = HomeRepository();
  int currentPageIndex = 0;
  List<MovimentoModel> allMove = [];

  @override
  void onInit() {
    super.onInit();
    // função do getx
    debounce(searchTitle, (_) => filterByTitle(),
        time: const Duration(milliseconds: 600));
    getAllUser();
  }

  Future<bool> getAllMove({required ClienteModel cliente}) async {
    HomeResult<List<MovimentoModel>> moveResult =
        await homeRepository.getAllMove(cliente: cliente);

    moveResult.when(success: (data) {
      allMove.assignAll(data);
      filterByTitle();
    }, error: (message) {
      allMove.clear();
      Get.snackbar(
        "Tente novamente",
        "Você não possui movimentações",
        backgroundColor: Colors.grey,
        snackPosition: SnackPosition.BOTTOM,
        borderColor: Colors.indigo,
        borderRadius: 0,
        borderWidth: 2,
        barBlur: 0,
      );
    });
    return true;
  }

  final saldoFormatter = MoneyMaskedTextController(
      leftSymbol: 'R\$ ', decimalSeparator: ',', thousandSeparator: '.');

  void setCurrentPageIndex(int value) {
    currentPageIndex = value;
    update();
  }

  void setCliente(ClienteModel value) {
    cliente = value;
    update();
  }

  set searchUser(String value) {
    _searchUser = value;
    update();
  }

  void filterByTitle() {
    allUserFiltered.clear();
    if (searchTitle.value.isNotEmpty) {
      /* allUserFiltered.addAll(allUser.where((e) =>
          e.nome!.toUpperCase().contains(searchTitle.value.toUpperCase())));*/
      allUserFiltered.addAll(allUser.where((cliente) =>
          cliente.nome!
              .toUpperCase()
              .contains(searchTitle.value.toUpperCase()) ||
          cliente.cpf!.contains(searchTitle.value) ||
          cliente.fone!.contains(searchTitle.value)));
    } else {
      allUserFiltered.addAll(allUser);
    }
    update();
  }

  void setIsActive(ClienteModel value) {
    cliente = value;
    cliente.active = !value.active;
    updateActive();
    update();
  }

  Future<void> updateActive() async {
    await homeRepository.updateActive(cliente: cliente);
    getAllUser();
  }

  Future<void> getAllUser() async {
    HomeResult<List<ClienteModel>> homeResult =
        await homeRepository.getAllUser();
    homeResult.when(success: (data) {
      allUser.assignAll(data);
      filterByTitle();
    }, error: (message) {
      Get.snackbar(
        "Tente novamente",
        "Erro ao buscar lista de usuários",
        backgroundColor: Colors.grey,
        snackPosition: SnackPosition.BOTTOM,
        borderColor: Colors.indigo,
        borderRadius: 0,
        borderWidth: 2,
        barBlur: 0,
      );
    });
  }

  Future<void> updateSaldo() async {
    await homeRepository.updateSaldo(cliente: cliente);
    getAllUser();
  }

  void setSaldoTotal(double value, String tipo) {
    cliente.saldoAtual = value;
    setSaldo(tipo);
  }

  void setSaldo(String tipo) {
    var agora = DateTime.now();
    var formatador = DateFormat("dd/MM/yyyy HH:mm:ss");
    var dataMovimento = formatador.format(agora);
    double valor = saldoFormatter.numberValue;

    MovimentoModel movimento = MovimentoModel(
        idUsuarioMovimento: Get.find<SignInController>().clienteLogado!.id,
        usuarioMovimento: Get.find<SignInController>().clienteLogado!.nome,
        dataMovimento: dataMovimento,
        valor: valor,
        tipo: tipo);
    cliente.movimentos = [];
    cliente.movimentos!.add(movimento);
    saldoController.clear();
    saldoFormatter.clear();
    updateSaldo();
    update();
  }

  Future<void> deleteContrato(String contratoId, String clienteId) async {
    await homeRepository.deleteContrato(
        contratoId: contratoId, clienteId: clienteId);
    getAllUser();
  }
}
