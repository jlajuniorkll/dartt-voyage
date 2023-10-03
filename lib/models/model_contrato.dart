import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartt_voyage/models/model_cliente.dart';
import 'package:dartt_voyage/models/model_modelo.dart';

class ContratoModel {
  String? id;
  ClienteModel? cliente;
  ModeloModel? modelo;
  String? dataAssinatura;
  String? dataValidade;
  String? ip;
  String? browser;
  String? latitude;
  String? longitude;
  String? imagemAssinatura;
  String status;

  ContratoModel(
      {this.id,
      this.cliente,
      this.modelo,
      this.dataAssinatura,
      this.dataValidade,
      this.ip,
      this.browser,
      this.latitude,
      this.longitude,
      this.imagemAssinatura,
      this.status = "A"});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      'id': id,
      'cliente': cliente?.toJson2(),
      'modelo': modelo?.toJson(),
      'dataAssinatura': dataAssinatura,
      'dataValidade': dataValidade,
      'ip': ip,
      'browser': browser,
      'latitude': latitude,
      'longitude': longitude,
      'imagemAssinatura': imagemAssinatura,
      'status': status,
    };

    data.removeWhere((_, value) => value == null);

    return data;
  }

  factory ContratoModel.fromJson(Map<String, dynamic> json) {
    return ContratoModel(
        id: json['id'],
        cliente: json['cliente'] != null
            ? ClienteModel.fromJson(json['cliente'])
            : null,
        modelo: json['modelo'] != null
            ? ModeloModel.fromJson(json['modelo'])
            : null,
        dataAssinatura: json['dataAssinatura'],
        dataValidade: json['dataValidade'],
        ip: json['ip'],
        browser: json['browser'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        imagemAssinatura: json['imagemAssinatura'],
        status: json['status']);
  }

  factory ContratoModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    data.putIfAbsent('id', () => doc.id);
    return ContratoModel.fromJson(data);
  }
}
