import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'decoded_data.freezed.dart';
part 'decoded_data.g.dart';

/// Data recieved from a device scan; response from device scan will be a capture event containing decoded data.
@freezed
class DecodedData with _$DecodedData {
  const factory DecodedData({
    required int id,
    required String name,
    required List<int> data,
    required String? tagId,
  }) = _DecodedData;
  const DecodedData._();

  factory DecodedData.fromJson(Map<String, Object?> json) =>
      _$DecodedDataFromJson(json);

  String dataAsString({Encoding codec = const Utf8Codec()}) =>
      codec.decode(data);
}
