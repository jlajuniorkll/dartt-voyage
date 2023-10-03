import 'package:freezed_annotation/freezed_annotation.dart';

part 'modelo_result.freezed.dart';

@freezed
class ModeloResult<T> with _$ModeloResult<T> {
  factory ModeloResult.success(T obj) = Success;
  factory ModeloResult.error(String message) = Error;
}
