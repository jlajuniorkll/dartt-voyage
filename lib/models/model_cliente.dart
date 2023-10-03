import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartt_voyage/models/model_contrato.dart';
import 'package:dartt_voyage/models/model_movimento.dart';

class ClienteModel {
  String? id;
  String? nome;
  String? rg;
  String? cpf;
  String? nasc;
  String? civil;
  String? pai;
  String? mae;
  String? endereco;
  String? complemento;
  String? numero;
  String? cep;
  String? bairro;
  String? cidade;
  String? uf;
  String? fone;
  String? email;
  String? senha;
  String? senhaConfirm;
  String? obs;
  String? typeUser;
  bool active;
  double saldoAtual;
  List<MovimentoModel>? movimentos;
  List<ContratoModel>? contratos;

  ClienteModel(
      {this.id,
      this.nome,
      this.rg,
      this.cpf,
      this.nasc,
      this.civil,
      this.pai,
      this.mae,
      this.endereco,
      this.complemento,
      this.cep,
      this.bairro,
      this.cidade,
      this.uf,
      this.fone,
      this.email,
      this.obs,
      this.numero,
      this.senha,
      this.senhaConfirm,
      this.typeUser,
      this.active = true,
      this.saldoAtual = 0,
      this.movimentos,
      this.contratos});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      'id': id,
      'nome': nome,
      'rg': rg,
      'cpf': cpf,
      'nasc': nasc,
      'civil': civil,
      'pai': pai,
      'mae': mae,
      'endereco': endereco,
      'complemento': complemento,
      'cep': cep,
      'bairro': bairro,
      'cidade': cidade,
      'uf': uf,
      'fone': fone,
      'email': email,
      'obs': obs,
      'numero': numero,
      'senha': senha,
      'senhaConfirm': senhaConfirm,
      'typeUser': typeUser,
      'active': active,
      'saldoAtual': saldoAtual,
      'movimentos': movimentos?.map((e) => e.toJson()).toList(),
      'contratos': contratos?.map((e) => e.toJson()).toList(),
    };

    data.removeWhere((_, value) => value == null);

    return data;
  }

  Map<String, dynamic> toJson2() {
    final Map<String, dynamic> data = <String, dynamic>{
      'id': id,
      'nome': nome,
      'rg': rg,
      'cpf': cpf,
      'nasc': nasc,
      'civil': civil,
      'pai': pai,
      'mae': mae,
      'endereco': endereco,
      'complemento': complemento,
      'cep': cep,
      'bairro': bairro,
      'cidade': cidade,
      'uf': uf,
      'fone': fone,
      'email': email,
      'obs': obs,
      'numero': numero,
      'typeUser': typeUser,
      'active': active,
      'saldoAtual': saldoAtual,
    };

    data.removeWhere((_, value) => value == null);

    return data;
  }

  factory ClienteModel.fromJson(Map<String, dynamic> json) {
    return ClienteModel(
      id: json['id'],
      nome: json['nome'],
      rg: json['rg'],
      cpf: json['cpf'],
      nasc: json['nasc'],
      civil: json['civil'],
      pai: json['pai'],
      mae: json['mae'],
      endereco: json['endereco'],
      complemento: json['complemento'],
      cep: json['cep'],
      bairro: json['bairro'],
      cidade: json['cidade'],
      uf: json['uf'],
      fone: json['fone'],
      email: json['email'],
      obs: json['obs'],
      numero: json['numero'],
      senha: json['senha'],
      senhaConfirm: json['senhaConfirm'],
      active: json['active'] ?? true,
      saldoAtual: json['saldoAtual'] ?? 0,
      typeUser: json['typeUser'],
      movimentos: (json['movimentos'] as List<dynamic>?)
          ?.map((e) => MovimentoModel.fromJson(e))
          .toList(),
      contratos: (json['contratos'] as List<dynamic>?)
          ?.map((e) => ContratoModel.fromJson(e))
          .toList(),
    );
  }

  factory ClienteModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    data.putIfAbsent('id', () => doc.id);
    return ClienteModel.fromJson(data);
  }
}
