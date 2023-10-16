import 'package:json_annotation/json_annotation.dart';

class IdConverter implements JsonConverter<String?, dynamic> {
  const IdConverter();

  @override
  String? fromJson(dynamic input) => input?.toString();

  @override
  dynamic toJson(String? input) {
    if (input == null) {
      return null;
    }
    return int.tryParse(input) ?? input;
  }
}
