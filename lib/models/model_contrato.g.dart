// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_contrato.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContratoModel _$ContratoModelFromJson(Map<String, dynamic> json) =>
    ContratoModel(
      id: json['id'] as String?,
      cliente: json['cliente'] == null
          ? null
          : ClienteModel.fromJson(json['cliente'] as Map<String, dynamic>),
      modelo: json['modelo'] == null
          ? null
          : ModeloModel.fromJson(json['modelo'] as Map<String, dynamic>),
      dataAssinatura: json['dataAssinatura'] as String?,
      dataValidade: json['dataValidade'] as String?,
      ip: json['ip'] as String?,
      browser: json['browser'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      imagemAssinatura: json['imagemAssinatura'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$ContratoModelToJson(ContratoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cliente': instance.cliente,
      'modelo': instance.modelo,
      'dataAssinatura': instance.dataAssinatura,
      'dataValidade': instance.dataValidade,
      'ip': instance.ip,
      'browser': instance.browser,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'imagemAssinatura': instance.imagemAssinatura,
      'status': instance.status,
    };
