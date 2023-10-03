// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_movimento.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovimentoModel _$MovimentoModelFromJson(Map<String, dynamic> json) =>
    MovimentoModel(
      id: json['id'] as String?,
      valor: (json['valor'] as num?)?.toDouble(),
      dataMovimento: json['dataMovimento'] as String?,
      usuarioMovimento: json['usuarioMovimento'] as String?,
      idUsuarioMovimento: json['idUsuarioMovimento'] as String?,
      tipo: json['tipo'] as String?,
    );

Map<String, dynamic> _$MovimentoModelToJson(MovimentoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'valor': instance.valor,
      'dataMovimento': instance.dataMovimento,
      'idUsuarioMovimento': instance.idUsuarioMovimento,
      'usuarioMovimento': instance.usuarioMovimento,
      'tipo': instance.tipo,
    };
