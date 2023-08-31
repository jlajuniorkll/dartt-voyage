import 'package:json_annotation/json_annotation.dart';

part 'model_modelo.g.dart';

@JsonSerializable()
class ModeloModel {
  String? id;
  String? titulo;
  String? corpo;

  ModeloModel({
    this.id,
    this.titulo,
    this.corpo,
  });

  factory ModeloModel.fromJson(Map<String, dynamic> json) =>
      _$ModeloModelFromJson(json);

  Map<String, dynamic> toJson() => _$ModeloModelToJson(this);
}
